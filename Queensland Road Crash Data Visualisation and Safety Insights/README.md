# Queensland Road Crash Data Visualisation and Safety Insights

## Project Summary

This project analyses Queensland road crash data to identify patterns in crash trends, geographic hotspots, crash severity, time-based risk, and crash-type severity. The project uses R and Python to clean, prepare, analyse, and visualise a large real-world government crash dataset.

The main purpose of this project is to turn raw road crash records into clear visual insights that can support road safety planning, enforcement, infrastructure improvement, and public awareness.

## Business and Public Safety Context

Road crash data can help transport authorities, police, planners, and policymakers understand where and when crashes occur, which crash types are most severe, and which locations or time periods require greater intervention.

This project focuses on Queensland crash records and explores crash patterns across time, geography, severity, crash type, and hourly distribution.

The analysis helps answer the following questions:

- How have road crash counts changed over time?
- Where are the main crash hotspots across Queensland?
- How has crash severity changed by year?
- At what times of day do more severe crashes occur?
- Which crash types are associated with higher severity?
- What road safety actions can be recommended from the visual insights?

## Dataset Used

The dataset used in this project is based on Queensland road crash records.

Dataset source:

```text
Queensland Government - Crash data from Queensland roads
https://www.data.qld.gov.au/dataset/crash-data-from-queensland-roads
```

The original dataset was too large to upload directly to this GitHub repository. Instead, this repository includes the analysis scripts and documentation. The dataset can be downloaded from the Queensland Government open data portal using the link above.

## Dataset Description

The dataset contains police-reported crash records from Queensland roads. It includes crash timing, location, severity, crash nature, road conditions, weather conditions, vehicle involvement, casualty counts, and geographic information.

The report used a cleaned version of the dataset called:

```text
CrashData_clean.csv
```

## Dataset Columns

The dataset includes the following columns:

- **Crash_Ref_Number**: Unique reference number for each crash record.

- **Crash_Severity**: Severity level of the crash, such as Fatal, Hospitalisation, Medical treatment, Minor injury, or Property damage only.

- **Crash_Year**: Year in which the crash occurred.

- **Crash_Month**: Month in which the crash occurred.

- **Crash_Day_Of_Week**: Day of the week when the crash occurred.

- **Crash_Hour**: Hour of the day when the crash occurred.

- **Crash_Nature**: Nature of the crash, such as angle, rear-end, hit object, or other crash pattern.

- **Crash_Type**: Type of crash, such as single-vehicle, multi-vehicle, pedestrian, or other.

- **Crash_Longitude**: Longitude coordinate of the crash location.

- **Crash_Latitude**: Latitude coordinate of the crash location.

- **Crash_Street**: Street where the crash occurred.

- **Crash_Street_Intersecting**: Intersecting street related to the crash location.

- **State_Road_Name**: Name of the state road, where applicable.

- **Loc_Suburb**: Suburb where the crash occurred.

- **Loc_Local_Government_Area**: Local government area of the crash location.

- **Loc_Post_Code**: Postcode of the crash location.

- **Loc_Police_Division**: Police division associated with the crash location.

- **Loc_Police_District**: Police district associated with the crash location.

- **Loc_Police_Region**: Police region associated with the crash location.

- **Loc_Queensland_Transport_Region**: Queensland Transport region of the crash.

- **Loc_Main_Roads_Region**: Main Roads region of the crash.

- **Loc_ABS_Statistical_Area_2**: Australian Bureau of Statistics Statistical Area Level 2.

- **Loc_ABS_Statistical_Area_3**: Australian Bureau of Statistics Statistical Area Level 3.

- **Loc_ABS_Statistical_Area_4**: Australian Bureau of Statistics Statistical Area Level 4.

- **Loc_ABS_Remoteness**: Remoteness classification of the crash location.

- **Loc_State_Electorate**: State electorate of the crash location.

- **Loc_Federal_Electorate**: Federal electorate of the crash location.

- **Crash_Controlling_Authority**: Authority responsible for the crash location or road.

- **Crash_Roadway_Feature**: Roadway feature at the crash location, such as intersection, bridge, or no roadway feature.

- **Crash_Traffic_Control**: Traffic control present at the crash location, such as traffic lights, stop signs, or no traffic control.

- **Crash_Speed_Limit**: Speed limit at the crash location.

- **Crash_Road_Surface_Condition**: Road surface condition at the time of the crash, such as sealed dry, sealed wet, or unsealed.

- **Crash_Atmospheric_Condition**: Weather or atmospheric condition at the time of the crash, such as clear, raining, or fog.

- **Crash_Lighting_Condition**: Lighting condition at the crash time, such as daylight, darkness, or street lighting.

- **Crash_Road_Horiz_Align**: Horizontal road alignment, such as straight or curved.

- **Crash_Road_Vert_Align**: Vertical road alignment, such as level, crest, or grade.

- **Crash_DCA_Code**: Definition for Coding Accidents code used to classify crash circumstances.

- **Crash_DCA_Description**: Description of the DCA crash scenario.

- **Crash_DCA_Group_Description**: Broader DCA crash group description.

- **DCA_Key_Approach_Dir**: Key approach direction of the crash.

- **Count_Casualty_Fatality**: Number of fatalities recorded in the crash.

- **Count_Casualty_Hospitalised**: Number of people hospitalised due to the crash.

- **Count_Casualty_MedicallyTreated**: Number of people medically treated due to the crash.

- **Count_Casualty_MinorInjury**: Number of people with minor injuries.

- **Count_Casualty_Total**: Total number of casualties recorded in the crash.

- **Count_Unit_Car**: Number of cars involved in the crash.

- **Count_Unit_Motorcycle_Moped**: Number of motorcycles or mopeds involved.

- **Count_Unit_Truck**: Number of trucks involved.

- **Count_Unit_Bus**: Number of buses involved.

- **Count_Unit_Bicycle**: Number of bicycles involved.

- **Count_Unit_Pedestrian**: Number of pedestrians involved.

- **Count_Unit_Other**: Number of other units involved in the crash.

## Tools and Technologies Used

- **R**
- **RStudio**
- **Python**
- **Jupyter Notebook**
- **Pandas** – Data cleaning and preprocessing
- **Tidyverse** – Data manipulation and visualisation in R
- **ggplot2** – Chart creation
- **ggmap** – Geographic map visualisation
- **Viridis** – Colour scale for heatmap visualisation
- **Queensland Government Open Data** – Crash dataset source

## Data Preparation and Cleaning

The raw crash dataset was cleaned and prepared before creating the visualisations.

The main data preparation steps included:

1. **Loaded the raw dataset**
   - The crash dataset was imported into Python and R for exploration and visualisation.

2. **Checked dataset structure**
   - The dataset was inspected using functions such as `head()`, `info()`, and summary statistics.

3. **Checked duplicates**
   - Each crash record was checked using `Crash_Ref_Number`.
   - No duplicate crash reference records were identified.

4. **Handled missing values**
   - Missing descriptive fields were labelled as `Unknown` where appropriate.
   - Missing latitude and longitude values were not artificially created, because doing so could produce false geographic information.

5. **Converted data types**
   - Numeric-looking columns were converted into proper numeric formats.
   - Crash year and crash hour were converted into integer values.
   - Latitude and longitude values were converted into numeric values for mapping.

6. **Standardised categorical values**
   - Crash severity values were converted into ordered factors for visualisation.
   - Categorical crash fields were retained as text or factor variables.

7. **Created cleaned dataset**
   - The cleaned dataset was exported as `CrashData_clean.csv`.
   - This cleaned file was used as the source for the R visualisations.

## Visualisations Created

This project includes five key visualisations.

## 1. Annual Road Crash Counts

Script:

```text
yearly_trend.R
```

### Visualisation Type

Time-series line chart.

### Purpose

This visualisation examines annual road crash counts in Queensland over time.

### Method

The data was grouped by `Crash_Year`, and the total number of crashes was counted for each year. A line chart was created with points for each year and a LOESS smoother to show the long-term pattern.

### Key Insight

Crash counts remained relatively high and stable before 2011, dropped sharply around 2011, and then gradually increased again in later years.

The sharp decline around 2011 is likely linked to a reporting change rather than a true sudden improvement in road safety.

## 2. Geographic Crash Density Map

Script:

```text
geographic_map.R
```

### Visualisation Type

Map visualisation with crash points and density overlay.

### Purpose

This visualisation identifies geographic crash hotspots across Queensland.

### Method

Crash records were filtered to valid Queensland latitude and longitude boundaries. A map of Queensland was used as the base layer, with crash points added as faint red dots and a density surface used to highlight high-crash areas.

### Key Insight

The crash density map highlights stronger crash concentrations along coastal and south-east Queensland corridors, with additional hotspots around major regional centres.

These patterns likely reflect higher population density, traffic exposure, urban congestion, and major road corridors.

### Important Security Note

The original R script used a Google Maps API key for the map visualisation. API keys should never be uploaded publicly to GitHub.

A safer approach is to store the key as an environment variable:

```r
register_google(key = Sys.getenv("GOOGLE_MAPS_API_KEY"))
```

## 3. Annual Crash Severity Trends

Script:

```text
crash_severity_each_year.R
```

### Visualisation Type

Multi-line chart.

### Purpose

This visualisation explores how crash severity changed across different years.

### Method

The data was grouped by `Crash_Year` and `Crash_Severity`. Crash counts were calculated for each severity category and plotted as separate lines.

### Severity Categories

- Fatal
- Hospitalisation
- Medical treatment
- Minor injury
- Property damage only

### Key Insight

Property damage only crashes dropped sharply after 2011, reflecting a reporting change. Hospitalisation and medical treatment crashes continued to show important patterns after this period.

This shows why it is important to interpret crash trends carefully and avoid comparing pre-2011 and post-2011 data without context.

## 4. Crash Severity by Hour of Day

Script:

```text
crash_severity_by_hour.R
```

### Visualisation Type

100% stacked bar chart.

### Purpose

This visualisation shows how crash severity proportions vary by hour of the day.

### Method

The data was filtered to valid crash hours from 0 to 23. A proportional stacked bar chart was used so that each hour shows the percentage distribution of crash severity.

### Key Insight

More severe crashes were more visible during late-night and early-morning periods, while other severity categories were more common during high-traffic daylight or commuting periods.

This suggests that enforcement and education campaigns may need to focus on time-specific risk factors such as fatigue, speeding, alcohol, visibility, and commuter pressure.

## 5. Crash Severity Distribution by Crash Type

Script:

```text
severity_distribution_by_crash_type.R
```

### Visualisation Type

Heatmap.

### Purpose

This visualisation examines the relationship between crash type and crash severity.

### Method

The data was grouped by `Crash_Type` and `Crash_Severity`, and the number of crashes was counted for each combination. A heatmap was created to show which crash type and severity combinations were most common.

### Key Insight

Multi-vehicle crashes accounted for a large share of crash records across multiple severity categories. Single-vehicle crashes were also important, especially for more serious outcomes. Pedestrian crashes were less frequent overall but had a stronger association with severe and fatal outcomes.

## Key Findings

- Queensland crash counts showed a major drop around 2011, likely due to a reporting change rather than an immediate road safety improvement.
- Crash hotspots were concentrated along coastal and south-east Queensland corridors.
- Major regional centres also showed visible crash density.
- Property damage only crash records dropped sharply after reporting rules changed.
- Late-night and early-morning crashes showed higher proportions of severe outcomes.
- Multi-vehicle crashes contributed heavily to total crash counts.
- Pedestrian crashes were less frequent but more likely to be severe or fatal.
- Crash type, time of day, and location are important factors for road safety planning.

## Ethics in Data Visualisation

This project applied the following ethical principles.

## 1. Accuracy and Transparency

The visualisations were designed to represent the data clearly and honestly. Cleaning steps were documented, and the reporting change around 2011 was explained to avoid misleading interpretations.

## 2. Privacy Protection

Although the data is public, crash records can still relate to sensitive real-world events. The map visualisation used density and faint points rather than identifying individuals or exact personal details.

## 3. Clarity and Non-Misleading Design

The visualisations used clear titles, axis labels, legends, and appropriate chart types. Colours were selected to support interpretation without exaggerating results.

## Business and Policy Recommendations

Based on the analysis, the following recommendations are suggested:

1. **Treat pre-2011 and post-2011 crash data separately**
   - Reporting changes affected property damage only crash records, so long-term trends should be interpreted carefully.

2. **Focus enforcement on high-risk time periods**
   - Late-night and early-morning periods should receive stronger attention due to higher severity proportions.

3. **Target crash hotspots**
   - Coastal and south-east Queensland corridors should be prioritised for road safety interventions.

4. **Improve pedestrian safety**
   - Even though pedestrian crashes are less frequent, they can lead to severe outcomes. Urban design improvements, speed reduction, crossings, and visibility measures should be considered.

5. **Address multi-vehicle crash risk**
   - Multi-vehicle crashes are common and may require intersection safety improvements, congestion management, and driver awareness campaigns.

6. **Use data-driven road safety planning**
   - Regular crash data monitoring can help authorities identify emerging risk areas and evaluate the effectiveness of road safety programs.

## Files Included

- `yearly_trend.R` – R script for annual crash trend visualisation
- `geographic_map.R` – R script for geographic crash density map
- `crash_severity_each_year.R` – R script for annual crash severity trend visualisation
- `crash_severity_by_hour.R` – R script for hourly crash severity proportions
- `severity_distribution_by_crash_type.R` – R script for crash type and severity heatmap
- `queensland_crash_analysis.ipynb` – Jupyter Notebook used for data preparation and analysis
- `road_crash_visualisation_report.docx` – Written report explaining analysis, findings, ethics, and recommendations
- `README.md` – Project documentation

## Note About Dataset File

The original crash dataset is large and is not included in this repository.

To reproduce the analysis:

1. Download the dataset from the Queensland Government open data portal.
2. Save the raw file locally.
3. Run the notebook to clean and export the data as:

```text
CrashData_clean.csv
```

4. Run the R scripts using `CrashData_clean.csv`.

## Skills Demonstrated

- Data cleaning and preprocessing
- Data type conversion
- Missing value handling
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
- Public policy and road safety interpretation

## Conclusion

This project demonstrates how real-world crash data can be cleaned, analysed, and visualised to support road safety decision-making. The five visualisations reveal important patterns across time, geography, severity, hour of day, and crash type.

The findings show that crash trends must be interpreted carefully because of reporting changes, while geographic and severity patterns can help identify where road safety interventions may be most useful. Overall, the project highlights how data visualisation can turn a large crash dataset into practical insights for improving road safety in Queensland.
