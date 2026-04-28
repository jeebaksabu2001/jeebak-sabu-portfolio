# -----------------------------------------------------------------------------
# task2_2.py
# Goal: Find the **Top 3 locations** with the highest *average annual rainfall*.
# Condition: only consider days where RainToday == "Yes".
# -----------------------------------------------------------------------------
from mrjob.job import MRJob
from mrjob.step import MRStep
from mrjob.protocol import RawValueProtocol
import heapq

DELIM = ","  # observations.txt is comma-delimited

class Top3AvgAnnualRain(MRJob):
    # write only the value string
    OUTPUT_PROTOCOL = RawValueProtocol

    def mapper_daily(self, _, line):
        # Each line should look like
        # Location,Date,MinTemp,MaxTemp,Rainfall,RainToday
        parts = line.rstrip("\n").split(DELIM)
        if len(parts) < 6:
            return #skipping broken rows
        loc = parts[0].strip()
        date = parts[1].strip()
        rainfall_str = parts[4].strip()
        rain_today = parts[5].strip()

        if not date or len(date) < 4:
            return

        # Only include days where RainToday == "Yes"
        if rain_today.lower() != "yes":
            return

        # Coerce rainfall, if blank/non-numeric then     0.0
        try:
            rf = float(rainfall_str)
        except ValueError:
            rf = 0.0

        year = date[:4]
        yield (loc, year), rf

    def reducer_year_total(self, key, values):
        # here key is location, year and value is rain1,rain2,...
        loc, year = key
        total = sum(values)
        # emit one loaction as key so that we can group all the years together
        yield loc, total

    def reducer_avg_by_loc(self, loc, annual_totals):
        # Now we get all annual totals for one location
        # then compute avg annual rainfall
        total_sum = 0.0
        year_count = 0
        for t in annual_totals:
            total_sum += float(t)
            year_count += 1
        if year_count == 0:
            return
        avg = total_sum / year_count  # average annual rainfall
        # pass to final top-3 selection
        yield None, (avg, loc)

    def reducer_top3(self, _, avg_loc_pairs):
        # input avgerage,location pairs and take top 3 by average rainfall
        top3 = heapq.nlargest(3, avg_loc_pairs, key=lambda x: x[0])
        for avg, loc in top3:
            yield None, f"{loc},{avg:.2f}"

    def steps(self):
        return [
            MRStep(mapper=self.mapper_daily, reducer=self.reducer_year_total),
            MRStep(reducer=self.reducer_avg_by_loc),
            MRStep(reducer=self.reducer_top3),
        ]


if __name__ == "__main__":
    Top3AvgAnnualRain.run()
