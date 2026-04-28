# -----------------------------------------------------------------------------
# task2_3.py
# Goal: Find the top-5 Global weather chains** (by severity) across all
#        locations/years 
# -----------------------------------------------------------------------------
from mrjob.job import MRJob
from mrjob.step import MRStep
from mrjob.protocol import RawValueProtocol
from datetime import datetime, timedelta

DELIM = ","

class MRChains(MRJob):
    # print only final string values and skip broken rows
    OUTPUT_PROTOCOL = RawValueProtocol

    def mapper(self, _, line):
        # maintain the input line shape and skip any row that broken 
        parts = line.rstrip("\n").split(DELIM)
        if len(parts) < 6:
            return

        loc = parts[0].strip()
        date_str = parts[1].strip()

        # Parse date (YYYY-MM-DD) and skip bad dates
        try:
            d = datetime.strptime(date_str, "%Y-%m-%d").date()
        except Exception:
            return

        # Coerce MaxTemp and Rainfall to floats and blanks/non-numeric to 0.0
        def to_float(s):
            try:
                return float(s.strip())
            except Exception:
                return 0.0

        max_t = to_float(parts[3])
        rain  = to_float(parts[4])

        qualifies = (max_t > 35.0) or (rain > 20.0)
        contrib = (max(0.0, max_t - 35.0) + max(0.0, rain - 20.0)) if qualifies else 0.0

        # Key within single year to avoid spanning across years
        yield (loc, d.year), f"{d.isoformat()}|{1 if qualifies else 0}|{contrib:.6f}"

    def reducer(self, key, values):
        # Choose the best chain for this (Location, Year)
        rows = []
        for s in values:
            try:
                ds, qs, cs = s.split("|")
                rows.append((datetime.strptime(ds, "%Y-%m-%d").date(), qs == "1", float(cs)))
            except Exception:
                continue
        if not rows:
            return

        rows.sort(key=lambda x: x[0])

        best_len, best_sev = 0, 0.0
        best_start = best_end = None

        cur_len, cur_sev = 0, 0.0
        cur_start = cur_prev = None

        for d, qualifies, c in rows:
            if qualifies:
                if cur_len == 0:
                    #staring a new chain
                    cur_len, cur_sev, cur_start = 1, c, d
                else:
                    # extend if a consecutive chain , else finalise previous chain and start new 
                    if cur_prev and d == cur_prev + timedelta(days=1):
                        cur_len += 1
                        cur_sev += c
                    else:
                        # finalize the previous chain, compare with the best
                        if (cur_len > best_len) or (cur_len == best_len and cur_sev > best_sev):
                            best_len, best_sev, best_start, best_end = cur_len, cur_sev, cur_start, cur_prev
                        # start a new chain
                        cur_len, cur_sev, cur_start = 1, c, d
                cur_prev = d
            else:
                # day breaks the chain, finalize the current chain if there is any 
                if cur_len > 0:
                    if (cur_len > best_len) or (cur_len == best_len and cur_sev > best_sev):
                        best_len, best_sev, best_start, best_end = cur_len, cur_sev, cur_start, cur_prev
                    cur_len, cur_sev, cur_start, cur_prev = 0, 0.0, None, None

        # flush any tail chain
        if cur_len > 0 and ((cur_len > best_len) or (cur_len == best_len and cur_sev > best_sev)):
            best_len, best_sev, best_start, best_end = cur_len, cur_sev, cur_start, cur_prev

        if best_len > 0:
            loc, year = key
            # Emit (severity, loc, year, start, end) to make global ranking easier
            yield None, (round(best_sev, 2), loc, str(year),
                         best_start.isoformat(), best_end.isoformat())

    def reducer_top5(self, _, records):
        # Pick global top-5 by severity (descending) and give final lines
        top = sorted(records, key=lambda x: x[0], reverse=True)[:5]
        for sev, loc, year, start, end in top:
            yield "", f"{loc},{year},{start},{end},{sev:.2f}"

    def steps(self):
        return [
            MRStep(mapper=self.mapper, reducer=self.reducer),
            MRStep(reducer=self.reducer_top5)
        ]

if __name__ == "__main__":
    MRChains.run()
