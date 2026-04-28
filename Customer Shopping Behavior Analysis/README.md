# 🛍️ Customer Shopping Behaviour and Sales Analysis using Python

## 📌 Project Summary

This project analyses customer shopping behaviour for Dibs, a retail company operating across shopping malls and online channels. The aim is to understand customer purchase patterns, identify spending behaviour, analyse sales trends, and provide recommendations to improve sales performance and customer loyalty.

The analysis was completed using Python in Jupyter Notebook and includes data cleaning, exploratory data analysis, visualisation, and business interpretation.

## 🎯 Project Objectives

- Clean and prepare customer shopping transaction data.
- Analyse customer spending patterns by category, age, and gender.
- Explore sales performance by payment method and time period.
- Identify key customer behaviour insights.
- Provide business recommendations for marketing and customer retention.

## 📊 Dataset Used

The dataset used in this project is `customer_shopping_data.csv`.

It contains customer transaction records from different shopping malls.

## 🧾 Dataset Columns

| Column | Description |
|---|---|
| `invoice_no` | Invoice number. A unique transaction ID starting with `I` followed by 6 digits |
| `customer_id` | Customer number. A unique customer ID starting with `C` followed by 6 digits |
| `gender` | Customer gender |
| `age` | Customer age |
| `category` | Product category purchased, such as clothing, shoes, cosmetics, food, toys, books, technology, and souvenirs |
| `quantity` | Quantity of products purchased in each transaction |
| `price` | Unit price of the product in Turkish Liras (TL) |
| `payment_method` | Payment method used, such as cash, credit card, or debit card |
| `invoice_date` | Date when the transaction was generated |
| `shopping_mall` | Name of the shopping mall where the transaction was made |

## 🛠️ Tools and Technologies Used

- **Python**
- **Pandas** – Data cleaning, transformation, and analysis
- **NumPy** – Numerical operations
- **Matplotlib** – Data visualisation
- **Seaborn** – Statistical visualisation
- **SciPy** – Box-Cox transformation and skewness handling
- **Jupyter Notebook**

## 🧹 Data Cleaning Process

The dataset was cleaned and prepared before analysis. The main steps included:

- Imported the CSV dataset into Jupyter Notebook.
- Checked the dataset structure using `head()`, `info()`, `describe()`, and `shape()`.
- Created a new `total_price` column by multiplying `price` by `quantity`.
- Converted `invoice_date` into proper datetime format.
- Created `year` and `month` columns for trend analysis.
- Fixed inconsistent category names and spelling errors such as `Tech`, `Toy`, and `Boks`.
- Replaced error values such as `##error##` with missing values.
- Handled missing values using suitable methods such as median, mode, or row removal.
- Removed duplicate records.
- Checked outliers and skewness using histograms and boxplots.
- Applied Box-Cox transformation to reduce skewness in `total_price`.

## 📈 Analysis Performed

### 1. Product Category Spending Analysis

A spending score was calculated to understand which product categories generated stronger customer interest and spending behaviour.

Technology had the highest spending score, while clothing and shoes also showed strong performance.

### 2. Gender-Based Spending Behaviour

A boxplot was used to compare spending behaviour between male and female customers.

The analysis showed that male and female spending patterns were quite similar, suggesting that gender alone may not strongly predict customer spending.

### 3. Age and Spending Relationship

A scatter plot was created to examine the relationship between age and spending score.

The correlation was close to zero, showing that age alone is not a strong predictor of spending behaviour.

### 4. Age Group Spending Analysis

Customers were grouped into age categories to compare spending behaviour.

The results showed that spending was fairly consistent across age groups, meaning customer segmentation should not rely only on age.

### 5. Sales by Payment Method

Sales were compared across different payment methods.

Cash was the most preferred payment method, followed by credit card and debit card.

### 6. Monthly Sales Trend Analysis

A line chart was used to analyse monthly sales over time.

Sales were generally stable from January 2021 to January 2023. A drop after January 2023 appeared to be caused by incomplete February 2023 data rather than an actual business decline.

## 🔍 Key Findings

- Technology products had the highest spending score.
- Clothing and shoes were also strong-performing categories.
- Male and female customers showed similar spending patterns.
- Age did not show a strong relationship with spending score.
- Cash was the most preferred payment method.
- Monthly sales were generally stable.
- The February 2023 sales drop was likely due to incomplete data.
- Customer segmentation should focus more on purchase behaviour and product preference than only age or gender.

## 💡 Business Recommendations

- Focus marketing campaigns on high-performing categories such as technology, clothing, and shoes.
- Use behaviour-based customer segmentation instead of relying only on age or gender.
- Continue supporting multiple payment options to improve customer convenience.
- Introduce loyalty programs, targeted discounts, and limited-time promotions.
- Collect customer feedback through surveys, social media, and in-store interactions.
- Monitor monthly sales trends regularly for inventory planning and seasonal promotions.

## 🧠 Skills Demonstrated

- Data cleaning and preprocessing
- Handling missing values and duplicates
- Data type conversion
- Outlier and skewness analysis
- Exploratory data analysis
- Data visualisation
- Customer segmentation
- Sales trend analysis
- Business recommendation development
- Python-based business analytics

## ✅ Conclusion

This project demonstrates how customer transaction data can be cleaned, analysed, and visualised to generate meaningful business insights.

The findings show that Dibs can improve its marketing and sales strategies by focusing on high-performing product categories, supporting different payment preferences, and using customer behaviour insights to design targeted promotions.
