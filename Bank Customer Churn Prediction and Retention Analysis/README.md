# Bank Customer Churn Prediction and Retention Analysis

## Project Summary

This project analyses a bank customer churn dataset to predict whether a customer is likely to leave the bank. The main purpose of the project is to identify key churn drivers, compare different machine learning models, and provide practical recommendations that can help the bank improve customer retention.

The project was completed using Python in Jupyter Notebook. It includes data cleaning, preprocessing, exploratory data analysis, visualisation, baseline modelling, advanced classification models, model comparison, and business recommendations.

## Project Objectives

The analysis focuses on the following objectives:

1. **Build a churn prediction model**  
   Predict whether a customer will exit the bank using customer profile, account, product, complaint, and engagement data.

2. **Identify key churn drivers**  
   Understand which customer features are most strongly linked to churn.

3. **Compare modelling approaches**  
   Compare a baseline Logistic Regression model with more advanced machine learning models such as K-Nearest Neighbours, Decision Tree, and Random Forest.

4. **Support business decision-making**  
   Translate the model results into practical customer retention strategies for the bank.

## Business Problem

Customer churn is a major issue for banks because losing existing customers can reduce revenue and increase the cost of acquiring new customers. If the bank can predict which customers are most likely to leave, it can take early action through targeted retention campaigns, complaint resolution, loyalty offers, and personalised engagement.

This project helps answer the following questions:

- Which customers are most likely to leave the bank?
- What are the strongest indicators of customer churn?
- How does a baseline Logistic Regression model compare with advanced machine learning models?
- Which model performs best for churn prediction?
- What actions can the bank take to reduce customer churn?

## Dataset Used

The dataset used in this project is `Customer-Churn-Records.csv`.

The dataset contains 10,000 customer records and includes demographic, account, product, complaint, satisfaction, and churn-related information.

Dataset source:

https://www.kaggle.com/datasets/radheshyamkollipara/bank-customer-churn/data

## Dataset Columns

- **RowNumber**: Record index number. This column is mainly used as an identifier and is not useful for prediction.

- **CustomerId**: Unique customer identification number. This column identifies each customer but does not directly support churn prediction.

- **Surname**: Customer surname. This is a text variable and was removed because it does not provide useful predictive value.

- **CreditScore**: Numeric variable representing the customer’s credit score.

- **Geography**: Categorical variable showing the customer’s country, such as France, Spain, or Germany.

- **Gender**: Categorical variable showing whether the customer is male or female.

- **Age**: Numeric variable representing the age of the customer.

- **Tenure**: Numeric variable showing the number of years the customer has been with the bank.

- **Balance**: Numeric variable representing the customer’s bank account balance.

- **NumOfProducts**: Numeric variable showing the number of bank products used by the customer.

- **HasCrCard**: Binary variable where 1 means the customer has a credit card and 0 means the customer does not.

- **IsActiveMember**: Binary variable where 1 means the customer is an active member and 0 means the customer is inactive.

- **EstimatedSalary**: Numeric variable representing the estimated annual salary of the customer.

- **Exited**: Target variable. 1 means the customer churned, and 0 means the customer stayed.

- **Complain**: Binary variable where 1 means the customer has made a complaint and 0 means no complaint was recorded.

- **Satisfaction Score**: Numeric variable representing the customer’s satisfaction score.

- **Card Type**: Categorical variable showing the type of card held by the customer, such as DIAMOND, GOLD, SILVER, or PLATINUM.

- **Point Earned**: Numeric variable representing loyalty or reward points earned by the customer.

## Tools and Technologies Used

- **Python**
- **Pandas** – Data loading, cleaning, preprocessing, and analysis
- **NumPy** – Numerical operations
- **Matplotlib** – Data visualisation
- **Seaborn** – Statistical visualisation
- **Scikit-learn** – Machine learning models and evaluation metrics
- **Jupyter Notebook** – Code development and analysis documentation

## Data Cleaning and Preprocessing

The following data preparation steps were completed before modelling:

1. **Loaded the dataset**
   - Imported the CSV file into Jupyter Notebook using Pandas.
   - Reviewed the structure of the dataset using functions such as `head()`, `info()`, `describe()`, and column inspection.

2. **Checked dataset quality**
   - Checked for missing values, duplicates, and general data structure.
   - Confirmed that the dataset was suitable for machine learning analysis.

3. **Removed unnecessary columns**
   - Removed columns such as `RowNumber`, `CustomerId`, and `Surname`.
   - These columns are identifiers or text labels and do not provide useful predictive value for churn modelling.

4. **Encoded categorical variables**
   - Converted categorical variables such as `Geography`, `Gender`, and `Card Type` into numerical format using encoding techniques.

5. **Prepared numerical variables**
   - Numerical features such as `CreditScore`, `Age`, `Balance`, `Tenure`, `EstimatedSalary`, and `Point Earned` were prepared for modelling.
   - Feature scaling was applied where required, especially for distance-based models such as K-Nearest Neighbours.

6. **Defined features and target**
   - The target variable was `Exited`.
   - The feature variables included customer demographics, account details, engagement indicators, complaint status, satisfaction score, card type, and loyalty points.

7. **Split the data**
   - The dataset was split into training and testing sets.
   - Stratified sampling was used to maintain the same churn proportion across the training and testing data.

## Exploratory Data Analysis

## 1. Churn Distribution

The churn distribution showed that most customers stayed with the bank, while a smaller proportion exited.

Approximate distribution:

| Customer Status | Percentage |
|---|---:|
| Stayed | 79.6% |
| Churned | 20.4% |

This shows a moderate class imbalance. Because of this, model evaluation should consider not only accuracy, but also precision, recall, F1-score, and ROC-AUC.

## 2. Numerical Feature Distributions

Histograms were used to examine key numerical variables such as:

- Credit score
- Age
- Balance
- Estimated salary
- Points earned

The analysis showed that different numerical variables had different distributions. For example, balance had a mixed distribution with many low or zero balances, while estimated salary was more evenly distributed.

## 3. Churn by Customer Features

Customer churn was compared across important features such as:

- Complaint history
- Active membership status
- Credit card ownership
- Gender
- Geography

The analysis showed that complaint history was the strongest churn indicator. Customers who had complained were much more likely to churn. Active members were less likely to leave, suggesting that customer engagement plays an important role in retention.

## 4. Correlation Analysis

A correlation analysis was used to identify which variables had the strongest relationship with churn.

The strongest relationship was between:

- **Complain** and **Exited**

Other useful churn-related variables included:

- Age
- IsActiveMember
- Balance
- Point Earned

## Models Used

## 1. Logistic Regression

Logistic Regression was used as the baseline model because it is simple, fast, and easy to interpret. It helps identify whether a linear combination of customer features can predict churn.

### Logistic Regression Results

| Metric | Score |
|---|---:|
| Accuracy | 0.999 |
| ROC-AUC | 0.999 |
| Churn Precision | 0.998 |
| Churn Recall | 0.995 |
| Churn F1-Score | 0.996 |

The Logistic Regression model performed extremely well and provided a strong baseline for comparison.

## 2. K-Nearest Neighbours

K-Nearest Neighbours was used as a non-linear classification model. It classifies customers based on similarity to nearby customers.

A range of k-values was tested, and the best value was:

| Parameter | Value |
|---|---:|
| Best k | 5 |

### KNN Results

| Metric | Score |
|---|---:|
| Accuracy | 0.932 |
| ROC-AUC | 0.956 |
| Churn Precision | 0.979 |
| Churn Recall | 0.684 |
| Churn F1-Score | 0.805 |

KNN performed well overall, but it had lower recall for churned customers. This means it missed more actual churners compared with the other models.

## 3. Decision Tree

A Decision Tree model was used because it provides clear decision rules and is useful for explaining how customer features separate churners from non-churners.

### Decision Tree Results

| Metric | Score |
|---|---:|
| Accuracy | 0.997 |
| ROC-AUC | 0.994 |
| Churn Precision | 0.995 |
| Churn Recall | 0.990 |
| Churn F1-Score | 0.993 |

The Decision Tree performed very well and provided useful interpretability through rule-based splits.

## 4. Random Forest

Random Forest was used as an advanced ensemble model. It combines multiple decision trees to improve prediction accuracy, reduce overfitting, and capture non-linear relationships.

### Random Forest Results

| Metric | Score |
|---|---:|
| Accuracy | 0.999 |
| ROC-AUC | 0.998 |
| Churn Precision | 0.998 |
| Churn Recall | 0.995 |
| Churn F1-Score | 0.996 |

Random Forest achieved very strong performance and was selected as the preferred advanced model.

## Model Comparison

| Model | Accuracy | ROC-AUC | Churn Precision | Churn Recall | Churn F1-Score |
|---|---:|---:|---:|---:|---:|
| Logistic Regression | 0.999 | 0.999 | 0.998 | 0.995 | 0.996 |
| KNN | 0.932 | 0.956 | 0.979 | 0.684 | 0.805 |
| Decision Tree | 0.997 | 0.994 | 0.995 | 0.990 | 0.993 |
| Random Forest | 0.999 | 0.998 | 0.998 | 0.995 | 0.996 |

Logistic Regression and Random Forest achieved the strongest overall performance. KNN performed well but was weaker in identifying actual churners. Decision Tree also performed strongly and provided useful interpretability.

## Model Rationale, Advantages, and Disadvantages

## Logistic Regression

**Why it was used:**  
Logistic Regression was used as the baseline model because it is simple, interpretable, and suitable for binary classification problems such as churn prediction.

**Advantages:**
- Easy to interpret
- Fast to train
- Useful baseline model
- Provides clear coefficients for understanding feature impact

**Disadvantages:**
- Assumes a linear relationship between features and the target
- May not capture complex non-linear relationships

## K-Nearest Neighbours

**Why it was used:**  
KNN was used to test whether customer similarity could help predict churn.

**Advantages:**
- Simple to understand
- Can capture local customer similarity patterns
- No strong assumptions about data distribution

**Disadvantages:**
- Sensitive to feature scaling
- Slower with larger datasets
- Weaker churn recall in this project

## Decision Tree

**Why it was used:**  
Decision Tree was used because it can capture non-linear relationships and provide clear decision rules.

**Advantages:**
- Easy to visualise and explain
- Captures non-linear patterns
- Useful for business interpretation

**Disadvantages:**
- Can overfit training data
- Small changes in data can change the tree structure

## Random Forest

**Why it was used:**  
Random Forest was used as an advanced model to improve performance and reduce the overfitting risk of a single decision tree.

**Advantages:**
- Strong predictive performance
- Handles non-linear relationships well
- More robust than a single decision tree
- Useful for feature importance analysis

**Disadvantages:**
- Less interpretable than Logistic Regression or a single Decision Tree
- Requires more computing power
- Harder to explain to non-technical stakeholders

## Key Findings

- Around 20.4% of customers in the dataset churned.
- Complaint history was the strongest churn indicator.
- Active members were less likely to churn.
- Age, balance, and points earned had some relationship with churn.
- Logistic Regression and Random Forest achieved the strongest overall performance.
- KNN had high precision but lower recall, meaning it missed more churned customers.
- Decision Tree provided strong performance and clear decision rules.
- The very high model performance was strongly influenced by the `Complain` variable.

## Business Recommendations

Based on the analysis, the bank should focus on the following actions:

1. **Improve complaint management**
   - Customers who complain are highly likely to churn.
   - The bank should improve complaint handling, response time, follow-up communication, and service recovery.

2. **Increase customer engagement**
   - Active members are less likely to leave.
   - The bank should encourage inactive customers to engage through personalised offers, digital banking support, loyalty campaigns, and product education.

3. **Use churn prediction for early intervention**
   - The model can help identify customers who are at high risk of leaving.
   - Retention teams can prioritise high-risk customers before they churn.

4. **Create targeted retention campaigns**
   - Instead of using one general retention strategy, the bank should design campaigns based on risk factors such as complaint history, inactivity, age, balance, and loyalty points.

5. **Monitor high-risk customer groups**
   - Customers with complaints, inactive accounts, and higher churn probability should be monitored more closely.

6. **Validate complaint data before deployment**
   - Since the `Complain` variable is strongly linked to churn, the bank should check whether complaint information is available before the customer exits.
   - If complaints are recorded after the customer leaves, it may cause data leakage.

## Model Limitation

The models achieved extremely high performance, mainly because the `Complain` variable was strongly linked with the target variable `Exited`.

This is useful for identifying churn risk, but it should be treated carefully. In a real business environment, the bank should confirm whether complaint data is recorded before the customer leaves. If the complaint is recorded after or at the same time as churn, the model may appear more accurate than it would be in real-world use.

## Files Included

- `48085847_assignment 2_jeebak.ipynb` – Jupyter Notebook containing the full analysis and machine learning models
- `Customer-Churn-Records.csv` – Dataset used for the project
- `README.md` – Project documentation

## Skills Demonstrated

- Data cleaning and preprocessing
- Exploratory data analysis
- Data visualisation
- Feature preparation
- One-hot encoding
- Feature scaling
- Train-test splitting
- Logistic Regression
- K-Nearest Neighbours
- Decision Tree Classification
- Random Forest Classification
- Model comparison
- Confusion matrix analysis
- ROC curve analysis
- Precision, recall, F1-score, accuracy, and ROC-AUC evaluation
- Business interpretation of machine learning results
- Customer retention strategy development

## Conclusion

This project demonstrates how machine learning can be used to predict bank customer churn and support customer retention strategy. The analysis found that complaint history, active membership status, age, balance, and loyalty points were important factors linked to churn.

Logistic Regression and Random Forest achieved the strongest overall performance, while Decision Tree provided useful interpretability. KNN performed reasonably well but had weaker recall for churned customers.

Overall, the project highlights the value of combining predictive modelling with business interpretation to support data-driven customer retention decisions.
