# 🐨 Analyzing Koala Physical Traits and Conservation Outcomes

## 📌 Project Summary

This project analyses koala physical characteristics to understand how biological and environmental factors relate to koala body size and variation. Using Python, the project applies data cleaning, exploratory data analysis, visualisation, hypothesis testing, regression modelling, and conservation-focused interpretation.

The main goal is to identify important relationships between traits such as head length, skull width, foot length, paw size, and total body length, and explain how these insights can support koala conservation research.

## 🎯 Project Objectives

- Clean and prepare a koala physical traits dataset.
- Explore differences in koala characteristics across gender, region, and habitat.
- Use statistical tests to compare physical traits.
- Build regression models to predict total koala length.
- Identify traits that may be useful for conservation monitoring.

## 📊 Dataset Used

The dataset used in this project is `koalas_dataset.xlsx`.

The dataset contains physical, biological, and environmental measurements of koalas. Most measurement values are recorded in centimetres.

## 🧾 Dataset Columns

| Column | Description |
|---|---|
| `koala_id` | Unique identification number for each koala |
| `region` | Numeric region where the koala was recorded |
| `habitat` | Habitat or state group, such as VIC or QLD |
| `gender` | Gender of the koala |
| `age_in_years` | Age of the koala in years |
| `Paw Size` | Paw size in centimetres |
| `total_length` | Total body length in centimetres |
| `head_length` | Head length in centimetres |
| `ear_size` | Ear size in centimetres |
| `foot_length` | Foot length in centimetres |
| `skull_width` | Skull width in centimetres |
| `eye_diameter` | Eye diameter in centimetres |
| `chest_circumference` | Chest circumference in centimetres |
| `belly_circumference` | Belly circumference in centimetres |

## 🛠️ Tools and Technologies Used

- **Python**
- **Pandas** – Data cleaning and preparation
- **NumPy** – Numerical analysis
- **Matplotlib** – Data visualisation
- **Seaborn** – Statistical visualisation
- **SciPy** – Hypothesis testing and ANOVA
- **Statsmodels** – Regression modelling
- **Jupyter Notebook**
- **Microsoft Excel**

## 🧹 Data Cleaning Process

The dataset was cleaned and prepared before analysis. The main steps included:

- Imported the Excel dataset into Jupyter Notebook.
- Checked dataset structure using `head()`, `info()`, and `describe()`.
- Reviewed unique values in `region`, `habitat`, and `gender`.
- Standardised inconsistent habitat values such as `VICtoria`, `Vic`, `Queensland`, `qld`, and `q`.
- Standardised gender values such as `m` and `f` into `male` and `female`.
- Handled missing values using median replacement within gender groups.
- Checked for duplicate records.
- Identified and treated outliers using boxplots and median replacement.
- Reviewed distributions using histograms and skewness values.

## 📈 Analysis Performed

### 1. Exploratory Data Analysis

Exploratory analysis was used to understand the dataset structure, identify missing values, check inconsistent categories, and examine numerical distributions.

### 2. Data Visualisation

Several visualisations were created to compare koala traits across habitat, region, and gender.

Visualisations included:

- Scatter plots
- Grouped bar charts
- Pairplots
- Radar charts
- Boxplots
- Histograms

### 3. Hypothesis Testing

Statistical tests were used to compare koala traits.

**One-Sample T-Test**  
A one-sample t-test was used to check whether the mean koala head length was significantly different from 92.0 mm. Since the dataset was in centimetres, 92.0 mm was converted to 9.2 cm.

**Independent Two-Sample T-Test**  
A two-sample t-test was used to compare male and female koala head lengths.

**ANOVA**  
ANOVA tests were used to examine whether region had a significant effect on selected physical traits.

### 4. Regression Modelling

Regression models were used to predict total koala length.

Models included:

- Simple linear regression using head length
- Multiple linear regression using head length, skull width, and foot length
- Extended regression using additional physical traits

## 🔍 Key Findings

- Inconsistent values in `habitat` and `gender` were cleaned and standardised.
- Missing values were handled using median values within gender groups.
- The mean koala head length was significantly different from 9.2 cm.
- Male and female koalas did not show a statistically significant difference in mean head length.
- Head length was a useful predictor of total koala length.
- A multiple regression model using head length, skull width, and foot length performed better than a simple regression model.
- Region had a significant effect on traits such as head length, foot length, and paw size.
- Paw size, head length, and foot length were among the strongest predictors of total body length.

## 💡 Recommendations

- Conservation researchers should consider both biological and regional factors when studying koala populations.
- Koalas from different regions and habitats should not be treated as identical populations.
- Physical traits such as paw size, head length, and foot length can support koala growth and health monitoring.
- Future research should include larger datasets and environmental variables such as food availability, habitat quality, climate conditions, and disease status.

## 🧠 Skills Demonstrated

- Data cleaning and preprocessing
- Handling missing values
- Standardising categorical values
- Outlier detection and treatment
- Exploratory data analysis
- Data visualisation
- Hypothesis testing
- One-sample t-test
- Independent two-sample t-test
- ANOVA
- Simple linear regression
- Multiple linear regression
- Conservation-focused data interpretation

## ✅ Conclusion

This project demonstrates how Python can be used to analyse biological data and generate insights for conservation research. The analysis showed that koala physical characteristics are influenced by multiple traits and regional differences.

Overall, the project highlights how data analysis can support a better understanding of koala population variation, physical development, and conservation planning.
