# Analyzing Koala Physical Traits and Conservation Outcomes

## Project Summary

This project analyses a koala physical characteristics dataset to explore patterns in koala body measurements and understand how different biological and environmental factors relate to koala size. The project was completed using Python in Jupyter Notebook and includes data cleaning, exploratory data analysis, data visualisation, statistical hypothesis testing, regression modelling, and conservation-focused recommendations.

The main purpose of this project was to identify important relationships between koala characteristics such as head length, skull width, foot length, paw size, and total body length, and to explain how these findings may support broader koala conservation strategies.

## Business and Research Context

Koala conservation research often depends on understanding physical and biological differences across koala populations. This analysis focuses on identifying whether traits such as head length, foot length, paw size, and total length vary across gender, region, and habitat groups.

The insights from this project can help support conservation planning by identifying physical differences across populations, understanding environmental variation, and highlighting traits that may be useful for monitoring koala health and development.

## Dataset Used

The dataset used in this project is `koalas_dataset.xlsx`. It contains physical, biological, and environmental measurements of koalas. The measurement values in the dataset are recorded in centimetres.

### Dataset Columns

- **koala_id**: Unique identification number assigned to each koala in the dataset.

- **region**: Numeric variable representing the region where the koala was recorded.

- **habitat**: Categorical variable representing the habitat or state group of the koala, such as VIC or QLD.

- **gender**: Categorical variable representing the gender of the koala, recorded as male or female.

- **age_in_years**: Numeric variable representing the age of the koala in years.

- **Paw Size**: Numeric variable representing the paw size of the koala in centimetres.

- **total_length**: Numeric variable representing the total body length of the koala in centimetres.

- **head_length**: Numeric variable representing the head length of the koala in centimetres.

- **ear_size**: Numeric variable representing the ear size of the koala in centimetres.

- **foot_length**: Numeric variable representing the foot length of the koala in centimetres.

- **skull_width**: Numeric variable representing the skull width of the koala in centimetres.

- **eye_diameter**: Numeric variable representing the eye diameter of the koala in centimetres.

- **chest_circumference**: Numeric variable representing the chest circumference of the koala in centimetres.

- **belly_circumference**: Numeric variable representing the belly circumference of the koala in centimetres.

## Tools and Technologies Used

- **Python**
- **Pandas** – Data importing, cleaning, and transformation
- **NumPy** – Numerical operations
- **Matplotlib** – Data visualisation
- **Seaborn** – Statistical visualisation
- **SciPy** – Hypothesis testing and ANOVA
- **Statsmodels** – Linear regression and multiple regression modelling
- **Jupyter Notebook** – Code development and analysis documentation
- **Microsoft Excel** – Source dataset format

## Data Cleaning Process

The following data cleaning steps were completed before analysis:

1. **Imported the dataset**
   - Loaded the Excel dataset into Jupyter Notebook using Pandas.
   - Reviewed the structure of the dataset using functions such as `head()`, `tail()`, `info()`, and `describe()`.

2. **Checked unique values**
   - Reviewed unique values in key categorical columns such as `region`, `habitat`, and `gender`.

3. **Standardised inconsistent values**
   - Cleaned inconsistent habitat values such as `VICtoria`, `Vic`, `Queensland`, `Queenstown`, `qld`, and `q`.
   - Standardised gender values such as `m` and `f` into `male` and `female`.

4. **Handled missing values**
   - Checked missing values across the dataset.
   - Missing values in columns such as `age_in_years`, `foot_length`, `skull_width`, and `belly_circumference` were handled using median values within gender groups.

5. **Checked duplicate records**
   - The dataset was checked for duplicate rows to ensure that repeated records did not affect the analysis.

6. **Handled outliers**
   - Boxplots were used to identify potential outliers in numerical variables.
   - Outliers were treated using median replacement within gender groups to reduce the effect of extreme values.

7. **Checked data distribution**
   - Histograms and skewness values were used to understand the distribution of numerical variables after cleaning.

## Analysis Performed

## 1. Exploratory Data Analysis

Exploratory data analysis was conducted to understand the structure of the dataset, identify missing values, check inconsistent entries, examine numerical distributions, and prepare the data for statistical analysis.

The cleaned dataset was then used to compare koala physical characteristics across gender, habitat, and region groups.

## 2. Data Visualisation

Two main types of visualisations were used to identify patterns in koala physical and biological characteristics.

### Total Length vs Age by Habitat

A scatter plot was created to compare koala total length against age, grouped by habitat. This helped explore whether older koalas showed clear differences in body length and whether these patterns varied between habitat groups.

### Physical Trait Comparison by Region and Gender

Visualisations such as grouped bar charts, pairplots, and radar charts were used to compare physical traits such as paw size, foot length, head length, chest circumference, and belly circumference. These helped identify differences in koala characteristics across regions and gender groups.

## 3. Hypothesis Testing and Statistical Analysis

### Mean Head Length Compared to 92.0 mm

A one-sample t-test was conducted to determine whether the mean koala head length was significantly different from 92.0 mm. Since the dataset measurements were in centimetres, 92.0 mm was converted to 9.2 cm before testing.

The result showed that the mean head length was significantly different from 9.2 cm.

### Male and Female Head Length Comparison

An independent two-sample t-test was conducted to compare the mean head length of male and female koalas.

The result showed that there was no statistically significant difference between male and female koalas in terms of mean head length.

### Predicting Total Length from Head Length

A simple linear regression model was used to test whether total koala length could be predicted using head length.

The model showed that head length was a statistically significant predictor of total length. However, the model explained only part of the variation, suggesting that total length is influenced by other physical traits as well.

### Predicting Total Length from Multiple Factors

A multiple linear regression model was created using head length, skull width, and foot length as predictors of total length.

The model performed better than the simple regression model, showing that using multiple physical traits provides a stronger prediction of total koala length.

### Effect of Region on Physical Characteristics

ANOVA tests were performed to examine whether environmental factors such as region affected koala physical characteristics.

The results showed that region had a statistically significant effect on traits such as head length, foot length, and paw size. This suggests that environmental or regional factors may contribute to differences in koala physical characteristics.

### Factors Correlated with Total Length

An extended regression model was used to identify which physical traits were associated with total length.

The analysis showed that paw size, head length, and foot length were important predictors of total body length. Other variables such as skull width, eye diameter, belly circumference, chest circumference, and ear size showed weaker relationships in the extended model.

## Key Findings

- The dataset contained inconsistent values in `habitat` and `gender`, which were cleaned and standardised.
- Missing values were handled using median values within gender groups.
- The mean koala head length was significantly different from 92.0 mm after converting the comparison value into centimetres.
- Male and female koalas did not show a statistically significant difference in mean head length.
- Head length was a useful predictor of total koala length.
- A multiple regression model using head length, skull width, and foot length provided a stronger prediction of total length than head length alone.
- Region had a statistically significant effect on selected physical traits such as head length, foot length, and paw size.
- Paw size, head length, and foot length were among the strongest predictors of total koala length.

## Recommendations

Based on the analysis, conservation researchers should consider both biological and environmental factors when studying koala populations. Since region appears to influence physical traits, conservation strategies should avoid treating all koala populations as identical. Instead, monitoring programs should compare koalas across different regions and habitats to identify population-specific patterns.

Physical traits such as paw size, head length, and foot length may be useful indicators for understanding koala growth, body condition, and population variation. These traits can support conservation planning by helping researchers identify differences in koala health and development across habitats.

Future research should use larger datasets and include additional environmental variables such as food availability, habitat quality, climate conditions, and disease status. This would provide a more complete understanding of the factors affecting koala physical characteristics and long-term conservation outcomes.

## Files Included

- `koala_physical_traits_analysis.ipynb` – Jupyter Notebook containing the full Python analysis
- `koalas_dataset.xlsx` – Excel dataset used for the analysis
- `README.md` – Project documentation

## Skills Demonstrated

- Data importing from Excel
- Data cleaning and preprocessing
- Handling missing values
- Standardising inconsistent categorical values
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

## Conclusion

This project demonstrates how Python can be used to clean, analyse, and interpret biological data for conservation research. The analysis showed that koala physical characteristics are influenced by multiple factors, including body measurements and regional differences. These insights can help support data-driven conservation strategies by improving understanding of koala population variation and physical development.
