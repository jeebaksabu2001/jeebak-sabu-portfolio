# 🏦 Bank Customer Churn Prediction and Retention Analysis

## 📌 Project Summary

This project predicts whether bank customers are likely to leave the bank using customer profile, account, product, complaint, and engagement data. The project compares multiple machine learning models and identifies key churn drivers to support customer retention strategies.

The analysis was completed using Python in Jupyter Notebook and includes data cleaning, exploratory data analysis, visualisation, model building, model comparison, and business recommendations.

## 🎯 Project Objectives

- Predict customer churn using machine learning models.
- Identify the strongest factors linked to customer churn.
- Compare a baseline Logistic Regression model with advanced classification models.
- Recommend practical actions to improve customer retention.

## 📊 Dataset Used

The dataset used in this project is `Customer-Churn-Records.csv`.

Dataset source: https://www.kaggle.com/datasets/radheshyamkollipara/bank-customer-churn/data

The dataset contains 10,000 customer records with demographic, account, product, complaint, satisfaction, and churn-related information.

## 🧾 Dataset Columns

| Column | Description |
|---|---|
| `RowNumber` | Record index number |
| `CustomerId` | Unique customer identification number |
| `Surname` | Customer surname |
| `CreditScore` | Customer credit score |
| `Geography` | Customer country, such as France, Spain, or Germany |
| `Gender` | Customer gender |
| `Age` | Customer age |
| `Tenure` | Number of years the customer has been with the bank |
| `Balance` | Customer account balance |
| `NumOfProducts` | Number of bank products used by the customer |
| `HasCrCard` | Indicates whether the customer has a credit card |
| `IsActiveMember` | Indicates whether the customer is an active member |
| `EstimatedSalary` | Estimated annual salary of the customer |
| `Exited` | Target variable: 1 = churned, 0 = stayed |
| `Complain` | Indicates whether the customer made a complaint |
| `Satisfaction Score` | Customer satisfaction score |
| `Card Type` | Type of card held by the customer |
| `Point Earned` | Loyalty or reward points earned by the customer |

## 🛠️ Tools and Technologies Used

- **Python**
- **Pandas** – Data loading, cleaning, and preprocessing
- **NumPy** – Numerical operations
- **Matplotlib** – Data visualisation
- **Seaborn** – Statistical visualisation
- **Scikit-learn** – Machine learning models and evaluation metrics
- **Jupyter Notebook**

## 🧹 Data Cleaning and Preprocessing

The main preparation steps included:

- Loaded the dataset into Jupyter Notebook.
- Checked missing values, duplicates, and dataset structure.
- Removed unnecessary identifier columns such as `RowNumber`, `CustomerId`, and `Surname`.
- Encoded categorical variables such as `Geography`, `Gender`, and `Card Type`.
- Scaled numerical features where required.
- Defined `Exited` as the target variable.
- Split the dataset into training and testing sets using stratified sampling.

## 📈 Exploratory Data Analysis

### 1. Churn Distribution

The dataset showed a moderate class imbalance:

| Customer Status | Percentage |
|---|---:|
| Stayed | 79.6% |
| Churned | 20.4% |

Because of this imbalance, the models were evaluated using accuracy, precision, recall, F1-score, and ROC-AUC.

### 2. Feature Analysis

The analysis explored churn patterns across:

- Complaint history
- Active membership status
- Credit card ownership
- Gender
- Geography
- Age
- Balance
- Loyalty points

### 3. Correlation Analysis

The strongest relationship was found between `Complain` and `Exited`.

Other useful churn-related variables included:

- Age
- IsActiveMember
- Balance
- Point Earned

## 🤖 Models Used

### 1. Logistic Regression

Logistic Regression was used as the baseline model because it is simple, fast, and interpretable.

| Metric | Score |
|---|---:|
| Accuracy | 0.999 |
| ROC-AUC | 0.999 |
| Churn Precision | 0.998 |
| Churn Recall | 0.995 |
| Churn F1-Score | 0.996 |

### 2. K-Nearest Neighbours

KNN was used to classify customers based on similarity to nearby customers.

Best value used:

| Parameter | Value |
|---|---:|
| Best k | 5 |

| Metric | Score |
|---|---:|
| Accuracy | 0.932 |
| ROC-AUC | 0.956 |
| Churn Precision | 0.979 |
| Churn Recall | 0.684 |
| Churn F1-Score | 0.805 |

### 3. Decision Tree

Decision Tree was used because it provides clear decision rules and is easier to interpret.

| Metric | Score |
|---|---:|
| Accuracy | 0.997 |
| ROC-AUC | 0.994 |
| Churn Precision | 0.995 |
| Churn Recall | 0.990 |
| Churn F1-Score | 0.993 |

### 4. Random Forest

Random Forest was used as an advanced ensemble model to improve prediction performance and capture non-linear patterns.

| Metric | Score |
|---|---:|
| Accuracy | 0.999 |
| ROC-AUC | 0.998 |
| Churn Precision | 0.998 |
| Churn Recall | 0.995 |
| Churn F1-Score | 0.996 |

## 📊 Model Comparison

| Model | Accuracy | ROC-AUC | Churn Precision | Churn Recall | Churn F1-Score |
|---|---:|---:|---:|---:|---:|
| Logistic Regression | 0.999 | 0.999 | 0.998 | 0.995 | 0.996 |
| KNN | 0.932 | 0.956 | 0.979 | 0.684 | 0.805 |
| Decision Tree | 0.997 | 0.994 | 0.995 | 0.990 | 0.993 |
| Random Forest | 0.999 | 0.998 | 0.998 | 0.995 | 0.996 |

## 🔍 Key Findings

- Around 20.4% of customers in the dataset churned.
- Complaint history was the strongest churn indicator.
- Active members were less likely to churn.
- Age, balance, and loyalty points showed some relationship with churn.
- Logistic Regression and Random Forest achieved the strongest overall performance.
- KNN had high precision but lower recall, meaning it missed more actual churners.
- Decision Tree provided strong performance and useful interpretability.
- The very high model performance was strongly influenced by the `Complain` variable.

## 💡 Business Recommendations

- Improve complaint handling and service recovery processes.
- Prioritise customers with complaints for follow-up and retention support.
- Increase engagement with inactive customers through personalised offers and communication.
- Use churn prediction to identify high-risk customers early.
- Design targeted retention campaigns based on complaint history, inactivity, age, balance, and loyalty points.
- Validate whether complaint data is recorded before churn to avoid data leakage.

## ⚠️ Model Limitation

The models achieved extremely high performance mainly because the `Complain` variable is strongly linked with the target variable `Exited`.

In a real business setting, the bank should confirm whether complaint information is available before the customer leaves. If complaints are recorded after or at the same time as churn, the model may appear more accurate than it would be in real-world use.

## 🧠 Skills Demonstrated

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
- Accuracy, precision, recall, F1-score, and ROC-AUC evaluation
- Business interpretation of machine learning results

## ✅ Conclusion

This project demonstrates how machine learning can be used to predict bank customer churn and support customer retention strategy. The analysis found that complaint history, active membership status, age, balance, and loyalty points were important factors linked to churn.

Overall, the project highlights the value of combining predictive modelling with business interpretation to support data-driven customer retention decisions.****
