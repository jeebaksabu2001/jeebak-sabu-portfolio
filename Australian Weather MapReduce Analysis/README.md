# Australian Weather MapReduce Analysis

## Project Summary

This project analyses historical Australian weather observations using Python, MongoDB, PyMongo, and MrJob MapReduce. The aim of the project is to extract complete yearly weather records for each Australian location, organise the data, and perform distributed-style analysis using MapReduce programs.

The project focuses on data curation, data organisation, weather trend analysis, and MapReduce-based processing of large weather records.

## Project Context

The dataset used in this project is the historical Australian weather dataset provided for COMP6210 Big Data Assignment 1. The original dataset contains daily weather observations collected by the Australian Bureau of Meteorology.

The main tasks involved:

- Importing weather data into MongoDB
- Extracting complete-year daily observations for each location
- Writing cleaned observations to a text file
- Sorting weather observations by location and date using MapReduce
- Finding the top 3 hottest days for each location
- Finding the top 3 locations with the highest average annual rainfall
- Identifying the top 5 severe weather chains across all locations and years

## Dataset Used

The original dataset was provided as:

```text
Weather_AUS.zip
```

The zip file contains:

```text
data.csv
field_descriptors.txt
```

The original dataset is not included in this repository because of file size and course data restrictions. Instead, this repository includes the extracted and processed files generated from the dataset.

## Extracted Dataset

The extracted dataset used for MapReduce analysis is:

```text
observations.txt
```

Each line contains one daily weather observation from a complete year for a specific location.

## Extracted Fields

The extracted fields are:

- **Location**: Weather station or city where the observation was recorded.
- **Date**: Observation date in `YYYY-MM-DD` format.
- **MinTemp**: Minimum temperature recorded for the day.
- **MaxTemp**: Maximum temperature recorded for the day.
- **Rainfall**: Rainfall amount recorded for the day.
- **RainToday**: Indicates whether it rained on that day, usually `Yes` or `No`.

Example format:

```text
Adelaide,2009-01-01,16.9,22.9,0.0,No
```

## Tools and Technologies Used

- **Python**
- **MongoDB**
- **PyMongo**
- **MrJob**
- **Pandas**
- **MapReduce**
- **Command-line execution**
- **Text file processing**

## Project Tasks

## Task 1.1: Data Extraction from MongoDB

File:

```text
task1_1.py
```

### Purpose

The purpose of this task was to connect Python to MongoDB, access the weather dataset, identify complete years for each location, and extract only valid daily observations from complete years.

### Process

The script performs the following steps:

1. Connects to MongoDB using PyMongo.
2. Accesses the database and weather collection.
3. Reads location and date information.
4. Identifies complete years for each location.
5. A complete year must include every day from January 1 to December 31.
6. Regular years require 365 records.
7. Leap years require 366 records.
8. Excludes incomplete years, even if only one day is missing.
9. Extracts selected fields from qualifying records.
10. Writes the final extracted data to `observations.txt`.

### Output

```text
observations.txt
```

This file contains cleaned daily weather observations for complete years only.

## Task 1.2: Data Organisation using MapReduce

File:

```text
task1_2.py
```

### Purpose

The purpose of this task was to sort the extracted weather observations in ascending order by date for each location.

### Method

This task uses MrJob to implement a MapReduce program.

### Mapper

The mapper reads each line from `observations.txt` and emits:

```text
Key: Location
Value: Date and full observation line
```

### Reducer

The reducer groups records by location, sorts each location’s records by date, and outputs the sorted observations.

### Output

```text
output1_2.txt
```

This file contains weather observations sorted by date within each location.

## Task 2.1: Top 3 Hottest Days per Location

File:

```text
task2_1.py
```

### Purpose

The purpose of this task was to find the top 3 hottest days for each location based on maximum temperature.

### Method

This task uses a MapReduce approach to group records by location and rank daily observations by `MaxTemp`.

### Mapper

The mapper reads each observation and emits:

```text
Key: Location
Value: MaxTemp and Date
```

### Reducer

The reducer receives all temperature records for a location, removes duplicate records, sorts by maximum temperature, and returns the top 3 hottest days.

### Output

```text
output2_1.txt
```

Example output format:

```text
Adelaide,2009-01-28,45.7
```

### Key Insight

This analysis identifies extreme heat events for each location and helps compare maximum temperature patterns across Australian weather stations.

## Task 2.2: Top 3 Locations by Average Annual Rainfall

File:

```text
task2_2.py
```

### Purpose

The purpose of this task was to find the top 3 locations with the highest average annual rainfall.

### Method

Only days where `RainToday` is equal to `Yes` are included in the rainfall calculation.

### MapReduce Steps

1. The mapper reads each observation and filters rainy days.
2. Rainfall values are grouped by location and year.
3. Annual rainfall totals are calculated.
4. Average annual rainfall is calculated for each location.
5. The final reducer selects the top 3 locations.

### Output

```text
output2_2.txt
```

Example output format:

```text
Cairns,1975.16
Darwin,1718.36
CoffsHarbour,1660.16
```

### Key Insight

This task identifies the wettest locations based on average annual rainfall across complete years.

## Task 2.3: Top 5 Severe Weather Chains

File:

```text
task2_3.py
```

### Purpose

The purpose of this task was to identify the top 5 severe weather chains across all locations and years.

A severe weather chain refers to a consecutive sequence of days where weather conditions meet the defined severity criteria.

### Severity Criteria

A day qualifies as severe if:

```text
MaxTemp > 35.0
```

or

```text
Rainfall > 20.0
```

### Severity Contribution

For each qualifying day, severity is calculated using:

```text
max(0, MaxTemp - 35.0) + max(0, Rainfall - 20.0)
```

### Method

The MapReduce program groups observations by location and year, identifies consecutive severe days, calculates chain severity, and returns the strongest chains.

### Output

```text
output2_3.txt
```

Example output format:

```text
Townsville,2009,2009-01-29,2009-02-04,407.80
```

### Key Insight

This analysis helps identify extended periods of extreme heat or heavy rainfall, which may be important for understanding weather risk patterns.

## Flowchart

File:

```text
Flowchart task 3.pdf
```

The flowchart illustrates the MapReduce workflow used in the assignment. It shows how input data is split, mapped, shuffled, reduced, and converted into final output.

The flowchart helps explain the logic behind the MapReduce process in a visual and easy-to-understand way.

## Output Files

This repository includes the following output files:

## observations.txt

Generated from `task1_1.py`.

Contains extracted weather observations for complete years only.

## output1_2.txt

Generated from `task1_2.py`.

Contains observations sorted by date for each location.

## output2_1.txt

Generated from `task2_1.py`.

Contains the top 3 hottest days for each location.

## output2_2.txt

Generated from `task2_2.py`.

Contains the top 3 locations with the highest average annual rainfall.

## output2_3.txt

Generated from `task2_3.py`.

Contains the top 5 severe weather chains across all locations and years.

## How to Run the Project

## Step 1: Start MongoDB

Make sure MongoDB is installed and running locally.

Default connection used:

```text
mongodb://localhost:27017/
```

## Step 2: Import the Weather Dataset

Import the original weather dataset into MongoDB.

Database name used:

```text
Assignment_1
```

Collection name used:

```text
AUS_weather
```

## Step 3: Run Task 1.1

```bash
python task1_1.py
```

This generates:

```text
observations.txt
```

## Step 4: Run Task 1.2

```bash
python task1_2.py observations.txt > output1_2.txt
```

## Step 5: Run Task 2.1

```bash
python task2_1.py observations.txt > output2_1.txt
```

## Step 6: Run Task 2.2

```bash
python task2_2.py observations.txt > output2_2.txt
```

## Step 7: Run Task 2.3

```bash
python task2_3.py observations.txt > output2_3.txt
```

## Key Findings

- Complete-year filtering ensures that weather analysis is fair and consistent across locations.
- Adelaide, Albury, Bendigo, Cobar, and other inland or southern locations recorded very high maximum temperature days.
- Cairns, Darwin, and Coffs Harbour were among the locations with the highest average annual rainfall.
- Townsville and Cairns appeared in severe weather chain outputs, showing periods of extreme rainfall or heat.
- MapReduce is useful for processing large weather datasets by grouping records by location, year, or weather condition.

## Skills Demonstrated

- Python programming
- MongoDB database connection
- PyMongo querying
- Data extraction
- Complete-year validation
- File writing and text processing
- MrJob MapReduce implementation
- Mapper and reducer design
- Sorting using MapReduce
- Weather data analysis
- Extreme temperature analysis
- Rainfall analysis
- Severe weather chain detection
- Command-line program execution
- Big data processing concepts

## Files Included

- `task1_1.py` – Extracts complete-year weather observations from MongoDB and writes `observations.txt`
- `task1_2.py` – Sorts observations by date for each location using MapReduce
- `task2_1.py` – Finds top 3 hottest days per location
- `task2_2.py` – Finds top 3 locations by average annual rainfall
- `task2_3.py` – Finds top 5 severe weather chains
- `observations.txt` – Extracted complete-year weather observations
- `output1_2.txt` – Sorted observations output
- `output2_1.txt` – Top 3 hottest days output
- `output2_2.txt` – Top 3 rainfall locations output
- `output2_3.txt` – Severe weather chains output
- `Flowchart task 3.pdf` – Flowchart explaining the MapReduce process
- `README.md` – Project documentation

## Note About Original Dataset

The original `Weather_AUS.zip` file is not included in this repository due to size and course data restrictions.

To fully reproduce the project, download the dataset from the course source, import it into MongoDB, and then run the Python scripts in order.

## Conclusion

This project demonstrates how MongoDB, Python, PyMongo, and MrJob can be used to process and analyse a large historical weather dataset. By filtering for complete years and applying MapReduce programs, the project produces meaningful outputs related to temperature extremes, rainfall patterns, and severe weather chains.

The project highlights how big data techniques can transform raw weather observations into organised, queryable, and analysis-ready outputs.
