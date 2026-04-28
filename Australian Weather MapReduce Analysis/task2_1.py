# -----------------------------------------------------------------------------
# task2_1.py
# Goal: For each location, find the **top 3 hottest days** by MaxTemp.
# Output format = Location, Date, MaxTemp
# -----------------------------------------------------------------------------
from mrjob.job import MRJob
from mrjob.step import MRStep
from mrjob.protocol import RawValueProtocol
import heapq

DELIM = ","  # observations.txt is comma-delimited

class Top3MaxTempPerLocation(MRJob):
    # Output only the value string
    OUTPUT_PROTOCOL = RawValueProtocol

    def mapper(self, _, line):
        # split the line - Location,Date,MinTemp,MaxTemp,Rainfall,RainToday
        parts = line.rstrip("\n").split(DELIM)
        if len(parts) < 4:
            return #ignore incomplete lines
        loc  = parts[0].strip()
        date = parts[1].strip()
        max_str = parts[3].strip()
        if not max_str:
            return #skip incomplete maxtemp
        try:
            max_temp = float(max_str)
        except ValueError:
            return #ignore non numeric temp

        # emit by location and carry (max_temp, date)
        yield loc, (max_temp, date)

    def reducer(self, loc, values):
        # Deduplicate exact repeats, then take top 3 by temp (desc),
        seen = set()
        items = []
        for t, d in values:
            key = (d, t)
            if key in seen:
                continue
            seen.add(key)
            items.append((t, d))

        top3 = heapq.nlargest(3, items, key=lambda x: (x[0], -int(x[1].replace('-', ''))))

        for t, d in top3:
            yield None, f"{loc},{d},{t:.1f}"

    def steps(self):
        return [MRStep(mapper=self.mapper, reducer=self.reducer)]


if __name__ == "__main__":
    Top3MaxTempPerLocation.run()
