# -----------------------------------------------------------------------------
# task1_2.py
# Goal: Using mrjob to sort observations.txt by date (ascending) *within* each
#       location.
# -----------------------------------------------------------------------------
from mrjob.job import MRJob
from mrjob.step import MRStep
from mrjob.protocol import RawValueProtocol

DELIM = ","  # observations.txt is comma-delimited

class SortByDate(MRJob):
    # Raw text out, so the final lines look precisely like the input lines. 
    OUTPUT_PROTOCOL = RawValueProtocol

    def mapper(self, _, line):
        # I keep the whole original line so I can re-emit it unchanged after sorting
        parts = line.rstrip("\n").split(DELIM)
        if len(parts) < 6:
            return
        location = parts[0].strip()
        date     = parts[1].strip() 
        yield location, (date, line.rstrip("\n"))

    def reducer(self, location, values):
        # Sort by data and emit the raw line only
        for _, raw_line in sorted(values, key=lambda x: x[0]):
            yield None, raw_line  

    def steps(self):
        return [MRStep(mapper=self.mapper, reducer=self.reducer)]


if __name__ == "__main__":
    SortByDate.run()
