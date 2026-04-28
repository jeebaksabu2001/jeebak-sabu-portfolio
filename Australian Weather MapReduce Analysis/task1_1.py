# -----------------------------------------------------------------------------
# task1_1.py
# Goal: Pull the daily weather document from MongoDB and write observations.txt 
#       with only COMPLETE years per location.
#
# Why "complete years"?
#   The assignment wants full Jan 1 → Dec 31 coverage (365/366 days). Any year
#   missing even a single date is excluded to keep downstream analyses fair.
# -----------------------------------------------------------------------------

import pymongo
import pandas as pd


def need_days(year: int) -> int:
    #to match the calender rules 365 or 366 days
    return 366 if (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0) else 365


def main():
    # Connecting to MongoDB 
    client = pymongo.MongoClient("mongodb://localhost:27017/")
    db = client["Assignment_1"]
    coll = db["AUS_weather"]

    # Creating a meta view which is being used to figure out which (Location,Year) pairs
    # pairs are complete. 
    meta = pd.DataFrame(list(coll.find({}, {"_id": 0, "Location": 1, "Date": 1})))
    if meta.empty:
        print("No documents found in Assignment_1.AUS_weather")
        return
    # If a row's Location or Date is missing or invalid, it cannot contribute to "completeness" and
    # should be removed for meta calculations only
    meta["Date"] = pd.to_datetime(meta["Date"], errors="coerce")
    meta = meta.dropna(subset=["Location", "Date"]).copy()
    meta["Year"] = meta["Date"].dt.year

    day_counts = (
        meta.groupby(["Location", "Year"])["Date"]
            .nunique() #Count the disctinct calender days
            .reset_index(name="days")
    )
    day_counts["need"] = day_counts["Year"].apply(need_days)
    # This set now only includes (Location, Year) pairs with exactly 365 or 366 unique dates, corresponding to a whole year.
    complete_pairs = set(
        map(tuple, day_counts.loc[
            day_counts["days"] == day_counts["need"], ["Location", "Year"]
        ].values)
    )

    # Streaming from MongoDB and write observations.txt
    written = 0
    with open("observations.txt", "w", encoding="utf-8") as f:
        cur = coll.find({}, {
            "_id": 0, "Location": 1, "Date": 1,
            "MinTemp": 1, "MaxTemp": 1, "Rainfall": 1, "RainToday": 1
        })
        for doc in cur:
            loc = (doc.get("Location") or "").strip()
            d = pd.to_datetime(doc.get("Date"), errors="coerce")
            if pd.isna(d) or (loc, int(d.year)) not in complete_pairs:
                continue

            # Min/Max: leaving it blank if truly missing 
            min_temp = "" if doc.get("MinTemp") is None else str(doc.get("MinTemp"))
            max_temp = "" if doc.get("MaxTemp") is None else str(doc.get("MaxTemp"))

            # Rainfall: coerce to float, default to 0.0 when missing/NaN/non-numeric
            rf_raw = doc.get("Rainfall")
            try:
                rf = float(rf_raw)
                if pd.isna(rf):
                    rf = 0.0
            except Exception:
                rf = 0.0

            # RainToday: normalize to Yes/Nox   
            rt_raw = doc.get("RainToday")
            rt = "Yes" if isinstance(rt_raw, str) and rt_raw.strip().lower() == "yes" else "No"

            line = ",".join([
                loc,
                d.strftime("%Y-%m-%d"),
                min_temp,
                max_temp,
                f"{rf:.1f}",   # ensures 0.0 prints as '0.0'
                rt
            ])
            f.write(line + "\n")
            written += 1

    print(f"observations.txt created ({written} lines)")


if __name__ == "__main__":
    main()
