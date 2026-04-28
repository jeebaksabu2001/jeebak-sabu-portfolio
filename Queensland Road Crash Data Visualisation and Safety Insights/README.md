# 🚗 Queensland Road Crash Data Visualisation and Safety Insights

## 📌 Project Summary

This project analyses Queensland road crash data to identify patterns in crash trends, geographic hotspots, crash severity, time-based risk, and crash-type severity.

The project uses R and Python to clean, prepare, analyse, and visualise a large government crash dataset. The main goal is to turn raw crash records into useful visual insights that can support road safety planning and public safety decision-making.

## 🎯 Project Objectives

- Analyse Queensland road crash trends over time.
- Identify geographic crash hotspots.
- Explore crash severity patterns by year and hour of day.
- Compare crash severity across different crash types.
- Create clear and ethical data visualisations.
- Provide road safety recommendations based on the findings.

## 📊 Dataset Used

The dataset is based on Queensland Government road crash records.

Dataset source: https://www.data.qld.gov.au/dataset/crash-data-from-queensland-roads

The original dataset is large and is not included in this repository. The cleaned dataset used for the visualisations was saved locally as `CrashData.csv`.

## 🧾 Dataset Description

The dataset contains police-reported crash records from Queensland roads. It includes crash timing, location, severity, road conditions, weather conditions, casualty counts, vehicle involvement, and geographic information.

## 🧾 Key Dataset Columns

| Column | Description |
|---|---|
| `Crash_Ref_Number` | Unique crash reference number |
| `Crash_Severity` | Severity level of the crash |
| `Crash_Year` | Year of the crash |
| `Crash_Month` | Month of the crash |
| `Crash_Day_Of_Week` | Day of the week when the crash occurred |
| `Crash_Hour` | Hour of the day when the crash occurred |
| `Crash_Nature` | Nature of the crash |
| `Crash_Type` | Type of crash, such as single-vehicle or multi-vehicle |
| `Crash_Longitude` | Longitude of the crash location |
| `Crash_Latitude` | Latitude of the crash location |
| `Loc_Suburb` | Suburb where the crash occurred |
| `Loc_Local_Government_Area` | Local government area |
| `Crash_Speed_Limit` | Speed limit at the crash location |
| `Crash_Road_Surface_Condition` | Road surface condition |
| `Crash_Atmospheric_Condition` | Weather condition |
| `Crash_Lighting_Condition` | Lighting condition |
| `Count_Casualty_Fatality` | Number of fatalities |
| `Count_Casualty_Hospitalised` | Number of hospitalised casualties |
| `Count_Casualty_MedicallyTreated` | Number of medically treated casualties |
| `Count_Casualty_MinorInjury` | Number of minor injuries |
| `Count_Casualty_Total` | Total number of casualties |
| `Count_Unit_Car` | Number of cars involved |
| `Count_Unit_Motorcycle_Moped` | Number of motorcycles or mopeds involved |
| `Count_Unit_Truck` | Number of trucks involved |
| `Count_Unit_Bus` | Number of buses involved |
| `Count_Unit_Bicycle` | Number of bicycles involved |
| `Count_Unit_Pedestrian` | Number of pedestrians involved |

## 🛠️ Tools and Technologies Used

- **R**
- **RStudio**
- **Python**
- **Jupyter Notebook**
- **Pandas** – Data cleaning and preprocessing
- **Tidyverse** – Data manipulation and visualisation
- **ggplot2** – Chart creation
- **ggmap** – Geographic map visualisation
- **Viridis** – Heatmap colour scale

## 🧹 Data Preparation and Cleaning

The main data preparation steps included:

- Imported the raw crash dataset into Python and R.
- Checked dataset structure and summary statistics.
- Checked duplicate records using `Crash_Ref_Number`.
- Labelled missing descriptive fields as `Unknown` where appropriate.
- Did not artificially create missing latitude or longitude values.
- Converted crash year, crash hour, latitude, and longitude into proper numeric formats.
- Converted crash severity into an ordered factor for visualisation.
- Exported the cleaned dataset as `CrashData_clean.csv`.

## 📈 Visualisations Created

### 1. Annual Road Crash Counts

Script: `1. yearly trend.R`

This time-series line chart shows annual road crash counts in Queensland.

Key insight:

- Crash counts were relatively high before 2011.
- A sharp drop occurred around 2011, likely due to a reporting change rather than a sudden road safety improvement.
- Crash counts gradually increased again in later years.

### 2. Geographic Crash Density Map

Script: `2. geographic map.R`

This map visualisation identifies crash hotspots across Queensland using crash points and density layers.

Key insight:

- Crash density is higher along coastal and south-east Queensland corridors.
- Major regional centres also show visible crash concentrations.
- These patterns likely reflect population density, traffic exposure, and major road corridors.

### 3. Annual Crash Severity Trends

Script: `3. Crash severity each year.R`

This multi-line chart shows how crash severity changed over time.

Key insight:

- Property damage only crashes dropped sharply after 2011 due to reporting changes.
- Hospitalisation and medical treatment crashes remained important for road safety analysis.

### 4. Crash Severity by Hour of Day

Script: `4. Crash severity by hour of the day.R`

This 100% stacked bar chart shows the proportion of crash severity by hour.

Key insight:

- Late-night and early-morning crashes showed higher proportions of severe outcomes.
- Daytime and commuting periods showed different severity patterns linked to traffic volume.

### 5. Crash Severity Distribution by Crash Type

Script: `5. Severity distribution across different crash types.R`

This heatmap compares crash severity across crash types.

Key insight:

- Multi-vehicle crashes contributed heavily to total crash counts.
- Pedestrian crashes were less frequent but more strongly linked to severe or fatal outcomes.
- Single-vehicle crashes were also important for serious crash outcomes.

## 🔐 Note About Google Maps API Key

The geographic map visualisation uses Google Maps through the `ggmap` package.

For security reasons, the Google Maps API key is not included in this repository. To run the map script, create a local environment variable called `GOOGLE_MAPS_API_KEY` and store your own API key there.

## 🔍 Key Findings

- Queensland crash counts dropped sharply around 2011, likely due to a reporting change.
- Crash hotspots were concentrated around coastal and south-east Queensland areas.
- Property damage only crash records reduced significantly after reporting rules changed.
- Late-night and early-morning crashes had higher proportions of severe outcomes.
- Multi-vehicle crashes contributed heavily to total crash counts.
- Pedestrian crashes were less frequent but more likely to be severe or fatal.
- Crash type, time of day, and location are important for road safety planning.

## 💡 Road Safety Recommendations

- Treat pre-2011 and post-2011 crash data separately because of reporting changes.
- Focus enforcement and awareness campaigns on late-night and early-morning risk periods.
- Prioritise crash hotspot areas for safety interventions.
- Improve pedestrian safety through better crossings, visibility, and speed management.
- Address multi-vehicle crash risk through intersection safety and congestion management.
- Use regular crash data monitoring to support evidence-based road safety planning.

## ⚖️ Ethics in Data Visualisation

This project considered ethical visualisation principles, including:

- Representing crash data accurately and transparently.
- Explaining reporting changes to avoid misleading interpretations.
- Protecting privacy by avoiding personal identification.
- Using clear titles, labels, legends, and appropriate chart types.
- Avoiding exaggerated or misleading visual design choices.

## 📝 Note About Dataset File

The original crash dataset is large and is not included in this repository.

## 🧠 Skills Demonstrated

- Data cleaning and preprocessing
- Missing value handling
- Data type conversion
- Exploratory data analysis
- Time-series visualisation
- Geographic mapping
- Density mapping
- Severity analysis
- 100% stacked bar charts
- Heatmap visualisation
- R programming
- ggplot2 visualisation
- ggmap mapping
- Python data preparation
- Ethical data visualisation
- Road safety interpretation

## ✅ Conclusion

This project demonstrates how real-world crash data can be cleaned, analysed, and visualised to support road safety decision-making.

The findings show that crash trends must be interpreted carefully because of reporting changes. Geographic, severity, time-based, and crash-type patterns can help identify where road safety interventions may be most useful.

Overall, the project highlights how data visualisation can turn a large crash dataset into practical insights for improving road safety in Queensland.
