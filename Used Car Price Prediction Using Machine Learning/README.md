# 🚗 Used Car Price Prediction Using Machine Learning

## 📌 Project Summary

This project predicts listed used car prices using structured vehicle listing data. The analysis was completed as a group machine learning project for a Kaggle-style forecasting competition.

The goal was to build predictive models that estimate car prices based on vehicle specifications, mileage, age, location, fuel type, engine details, body type, brand, and other listing attributes.

## 🎯 Project Objectives

- Understand the used car price prediction problem.
- Explore the training and test datasets.
- Clean numerical and categorical features.
- Create new useful features from existing columns.
- Handle missing values and encode categorical variables.
- Build and compare machine learning regression models.
- Generate price predictions for the test dataset.
- Create a final submission file for the competition.

## 📊 Dataset Used

This project uses three main files:

- `train.csv` – Training dataset with vehicle features and actual prices.
- `test.csv` – Test dataset with vehicle features only.
- `sample_solution.csv` – Sample submission format.

The training dataset contains 8,000 rows and 37 columns, including the target variable `price`.

The test dataset contains 4,000 rows and 36 columns, excluding the target variable.

## 🧾 Key Dataset Columns

| Column | Description |
|---|---|
| `vin` | Unique vehicle identification number |
| `price` | Target variable representing listed car price |
| `year` | Vehicle model year |
| `make_name` | Vehicle manufacturer |
| `model_name` | Vehicle model |
| `body_type` | Vehicle body type, such as sedan, SUV, or pickup |
| `mileage` | Distance already travelled by the vehicle |
| `horsepower` | Engine horsepower |
| `torque` | Engine torque information |
| `engine_type` | Engine type |
| `fuel_type` | Fuel category |
| `transmission` | Transmission type |
| `wheel_system` | Vehicle drive system |
| `city_fuel_economy` | Fuel economy in city driving |
| `highway_fuel_economy` | Fuel economy on highways |
| `daysonmarket` | Number of days the vehicle was listed |
| `is_new` | Indicates whether the vehicle is new or used |
| `franchise_dealer` | Indicates whether the seller is a franchise dealer |
| `city` | Listing city |
| `dealer_zip` | Dealer postcode |
| `latitude` | Listing latitude |
| `longitude` | Listing longitude |

## 🛠️ Tools and Technologies Used

- **Python**
- **Pandas** – Data loading, cleaning, and transformation
- **NumPy** – Numerical operations
- **Matplotlib** – Data visualisation
- **Seaborn** – Exploratory visualisation
- **Scikit-learn** – Machine learning models and evaluation
- **Jupyter Notebook**
- **Kaggle-style submission workflow**

## 🧹 Data Cleaning and Feature Engineering

The dataset required several cleaning and preparation steps before modelling.

Key steps included:

- Loaded `train.csv` and `test.csv`.
- Checked dataset shape, missing values, and column consistency.
- Parsed numeric values from text-based columns such as legroom, height, width, wheelbase, power, and torque.
- Created new features such as vehicle age and mileage per year.
- Handled missing values using training-data-based imputation.
- Encoded categorical variables using a top-category plus `Other` approach.
- Aligned train and test columns after encoding.
- Scaled numerical features before model training.
- Used log transformation on the target variable `price` to reduce skewness.

## 📈 Exploratory Data Analysis

The EDA focused on understanding price patterns and important vehicle features.

Key analysis included:

- Price distribution analysis
- Missing value checks
- Most common vehicle brands
- Median price by brand
- Body type distribution
- Vehicle age vs price
- Mileage vs price
- Horsepower vs price
- Correlation analysis with price

## 🔍 Key EDA Findings

- Car prices were highly right-skewed, with most listings in lower-to-mid price ranges and fewer expensive vehicles.
- Newer vehicles generally had higher listed prices.
- Higher mileage was strongly associated with lower prices.
- Horsepower and torque showed a positive relationship with price.
- Vehicle age and mileage were among the strongest predictors of price.
- Some high-cardinality categorical features needed careful encoding to avoid creating too many dummy variables.

## 🤖 Models Used

Three regression models were trained and compared.

### 1. Ridge Regression

Ridge Regression was used as the linear baseline model. It helped test whether a regularised linear model could predict prices effectively after encoding and scaling.

### 2. Random Forest Regressor

Random Forest was used as the main non-linear model. It was able to capture more complex relationships between vehicle features and price.

### 3. Stacking Regressor

A Stacking Regressor was used as an ensemble method that combined predictions from multiple models.

## 📊 Model Comparison

| Model | Purpose | Result |
|---|---|---|
| Ridge Regression | Linear baseline | Performed weakest due to non-linear pricing patterns |
| Random Forest Regressor | Main non-linear model | Best performing model |
| Stacking Regressor | Ensemble model | Competitive but did not outperform Random Forest |

The final selected model was the **Random Forest Regressor**, as it achieved the best cross-validation performance.

## 🏆 Final Model

The Random Forest Regressor was selected as the final model because it performed best during validation.

The final model was used to predict prices for the test dataset, and the output was saved as a submission file.

Final submission output format:

| Column | Description |
|---|---|
| `vin` | Vehicle identification number from the test dataset |
| `price` | Predicted listed vehicle price |

## 🔍 Key Findings

- Used car price prediction is strongly influenced by vehicle age, mileage, horsepower, torque, year, and brand-related features.
- Log-transforming the target variable improved model performance.
- Random Forest performed better than the linear baseline because car prices follow non-linear patterns.
- Feature engineering improved the usefulness of raw vehicle specification fields.
- Proper train-test alignment after encoding was important to avoid modelling errors.

## 💡 Business Recommendations

- Use machine learning price predictions to support fair listing price estimates.
- Use predicted price ranges to help buyers compare listed prices with market expectations.
- Dealerships can use the model to identify overpriced or underpriced vehicles.
- Vehicle age, mileage, horsepower, and brand should be prioritised in pricing decisions.
- More external data, such as accident history, service records, and local demand, could improve prediction accuracy.

## 🧠 Skills Demonstrated

- Data cleaning and preprocessing
- Feature engineering
- Missing value imputation
- Categorical encoding
- Exploratory data analysis
- Regression modelling
- Ridge Regression
- Random Forest Regression
- Stacking Regressor
- Hyperparameter tuning
- Log-transformed target modelling
- Model evaluation
- Kaggle-style prediction submission
- Business interpretation of machine learning results

## ✅ Conclusion

This project demonstrates how machine learning can be used to predict used car prices from vehicle listing data.

The analysis showed that price is influenced by a combination of vehicle age, mileage, performance features, brand, and listing characteristics. Random Forest produced the strongest results because it captured non-linear relationships better than the baseline linear model.

Overall, the project highlights how predictive analytics can support pricing decisions for buyers, sellers, dealerships, and online vehicle marketplaces.
