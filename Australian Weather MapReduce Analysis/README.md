# 🌦️ Australian Weather MapReduce Analysis

## 📌 Project Summary

This project analyses historical Australian weather observations using Python, MongoDB, PyMongo, and MrJob MapReduce. The aim is to extract complete-year weather records, organise the data, and run MapReduce programs to identify weather patterns across Australian locations.

The project focuses on data extraction, data organisation, extreme temperature analysis, rainfall analysis, and severe weather chain detection.

## 🎯 Project Objectives

- Import and query weather data using MongoDB.
- Extract complete-year daily observations for each location.
- Sort observations by location and date using MapReduce.
- Find the top 3 hottest days for each location.
- Identify the top 3 locations with the highest average annual rainfall.
- Detect the top 5 severe weather chains across locations and years.

## 📊 Dataset Used

The original dataset was provided as `Weather_AUS.zip`.

The zip file contains:

- `data.csv` – Historical Australian weather records
- `field_descriptors.txt` – Field definitions and descriptions

The original dataset is not included in this repository due to file size and course data restrictions. Instead, the repository includes extracted and processed output files.

## 🧾 Extracted Dataset

The main extracted dataset is `observations.txt`.

Each line contains one daily weather observation from a complete year for a specific location.

Format:

Location, Date, MinTemp, MaxTemp, Rainfall, RainToday

Example:

Adelaide,2009-01-01,16.9,22.9,0.0,No

## 🛠️ Tools and Technologies Used

- **Python**
- **MongoDB**
- **PyMongo**
- **MrJob**
- **Pandas**
- **MapReduce**
- **Command-line execution**
- **Text file processing**

## 📂 Project Tasks

### Task 1.1: Data Extraction from MongoDB

File: `task1_1.py`

This script connects to MongoDB, accesses the Australian weather collection, identifies complete years for each location, and extracts selected weather fields.

A complete year means the location has records for every day from January 1 to December 31.

The extracted fields are:

- Location
- Date
- MinTemp
- MaxTemp
- Rainfall
- RainToday

Output file:

- `observations.txt`

### Task 1.2: Data Organisation using MapReduce

File: `task1_2.py`

This MapReduce program sorts the extracted observations by date within each location.

Output file:

- `output1_2.txt`

### Task 2.1: Top 3 Hottest Days per Location

File: `task2_1.py`

This MapReduce program finds the top 3 hottest days for each location based on `MaxTemp`.

Output file:

- `output2_1.txt`

Example output:

Adelaide,2009-01-28,45.7

### Task 2.2: Top 3 Locations by Average Annual Rainfall

File: `task2_2.py`

This MapReduce program identifies the top 3 locations with the highest average annual rainfall. Only days where `RainToday` is `Yes` are included in the rainfall calculation.

Output file:

- `output2_2.txt`

Example output:

Cairns,1975.16  
Darwin,1718.36  
CoffsHarbour,1660.16

### Task 2.3: Top 5 Severe Weather Chains

File: `task2_3.py`

This MapReduce program identifies the top 5 severe weather chains across all locations and years.

A day is considered severe if:

- `MaxTemp > 35.0`, or
- `Rainfall > 20.0`

The severity score is based on how much the temperature or rainfall exceeds the threshold.

Output file:

- `output2_3.txt`

Example output:

Townsville,2009,2009-01-29,2009-02-04,407.80

## 🔁 Flowchart

File: `Flowchart task 3.pdf`

The flowchart explains the MapReduce workflow, including input splitting, mapping, shuffling, reducing, and final output generation.

## 🔍 Key Findings

- Complete-year filtering ensured fair and consistent weather analysis across locations.
- Some locations such as Adelaide, Albury, Bendigo, and Cobar recorded very high maximum temperatures.
- Cairns, Darwin, and Coffs Harbour appeared among the wettest locations based on average annual rainfall.
- Townsville and Cairns appeared in severe weather chain outputs, showing extended periods of extreme rainfall or heat.
- MapReduce was useful for grouping and analysing large weather records by location, year, and weather condition.

## 🧠 Skills Demonstrated

- Python programming
- MongoDB database connection
- PyMongo querying
- Data extraction and filtering
- Complete-year validation
- MrJob MapReduce implementation
- Mapper and reducer design
- Sorting using MapReduce
- Extreme temperature analysis
- Rainfall analysis
- Severe weather chain detection
- Command-line execution
- Big data processing concepts

## 📝 Note About Original Dataset

The original `Weather_AUS.zip` file is not included in this repository due to file size and course data restrictions.

## ✅ Conclusion

This project demonstrates how MongoDB, Python, PyMongo, and MrJob can be used to process and analyse a large historical weather dataset. By filtering for complete years and applying MapReduce programs, the project produces useful outputs related to temperature extremes, rainfall patterns, and severe weather chains.

Overall, the project highlights how big data techniques can transform raw weather observations into organised and analysis-ready results.
