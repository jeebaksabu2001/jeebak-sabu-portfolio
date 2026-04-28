# 💡 LuminaTech Sales Performance and Customer Churn Analysis

## 📌 Project Summary

This project analyses sales and customer transaction data for LuminaTech Lighting, an Australian lighting company. The goal is to identify patterns in sales performance, profitability, pricing, customer behaviour, forecasting, and churn.

The project was completed using Python in Jupyter Notebook and includes data cleaning, exploratory analysis, hypothesis testing, regression modelling, SARIMA forecasting, churn analysis, and business recommendations.

## 🎯 Project Objectives

- Clean and prepare LuminaTech sales data.
- Analyse sales, cost, quantity, and profit patterns.
- Compare customer behaviour across different groups.
- Test differences in profit margins and order quantities.
- Forecast future sales using time series modelling.
- Identify customer churn patterns and retention opportunities.
- Provide business recommendations for management.

## 📊 Dataset Used

The project used LuminaTech sales and customer transaction data from 2012 and 2013, supported by a metadata file.

The dataset includes information about:

- Accounting dates
- Customer and product codes
- Sales values
- Cost values
- Quantity values
- Price adjustments
- Order and invoice details
- Salesperson codes
- Customer districts
- Product groups and classifications

## 🧾 Key Dataset Columns

| Column | Description |
|---|---|
| `accounting_date` | Date when the financial transaction was recorded |
| `fiscal_year` | Fiscal year of the transaction |
| `fiscal_month` | Fiscal month of the transaction |
| `customer_code` | Unique customer identifier |
| `customer_district_code` | Customer district or region code |
| `item_code` | Unique item or product identifier |
| `business_area_code` | Business area related to the transaction |
| `item_group_code` | Product group code |
| `salesperson_code` | Salesperson linked to the transaction |
| `order_type_code` | Type of customer order |
| `market_segment` | Market segment of the transaction |
| `value_sales` | Sales value generated from the transaction |
| `value_cost` | Cost associated with the transaction |
| `value_quantity` | Quantity sold |
| `value_price_adjustment` | Price adjustment, discount, or surcharge |
| `currency` | Currency used in the transaction |
| `invoice_number` | Unique invoice identifier |
| `invoice_date` | Date when the invoice was issued |
| `customer_order_number` | Customer order reference number |
| `order_date` | Date when the order was placed |

## 🛠️ Tools and Technologies Used

- **Python**
- **Pandas** – Data importing, cleaning, manipulation, and aggregation
- **NumPy** – Numerical operations
- **Matplotlib** – Data visualisation
- **Seaborn** – Statistical visualisation
- **SciPy** – Statistical testing
- **Statsmodels** – Regression analysis and SARIMA forecasting
- **Jupyter Notebook**
- **Microsoft Excel**

## 🧹 Data Cleaning Process

The dataset was cleaned and prepared before analysis. Key steps included:

- Imported and combined sales data from 2012 and 2013.
- Reviewed structure using `head()`, `info()`, `shape()`, and `describe()`.
- Standardised inconsistent categorical values.
- Converted date columns such as `accounting_date`, `order_date`, and `invoice_date`.
- Removed duplicate records.
- Handled missing values and removed columns with limited analytical value.
- Identified outliers using boxplots and the interquartile range method.
- Reduced skewness using cube root transformation.

## 📈 Analysis Performed

### 1. Exploratory Data Analysis

Initial analysis was used to understand the structure of the dataset, identify missing values, detect duplicates, review data types, and prepare key variables such as `value_sales`, `value_cost`, and `value_quantity`.

### 2. Business Insights Analysis

Several business insights were developed, including:

- Dynamic pricing impact analysis
- Supply chain optimisation analysis
- Sales performance by day and time
- Average profitability by customer district
- Sales performance across top salespeople

### 3. Hypothesis Testing

Two-sample t-tests were used to compare business groups.

Tests included:

- Profit margin differences between 2012 and 2013
- Average order quantity differences between new and returning customers

The analysis showed that profit margins were relatively stable across the two years, while new customers placed larger average orders than returning customers.

### 4. Regression Analysis

Multiple regression models were used to examine relationships between business variables.

Regression analysis explored:

- How price adjustments affected sales value
- How fiscal month, business area, and item group influenced sales quantity

The results suggested that price adjustments had a meaningful relationship with sales value, while sales quantity was relatively stable across months.

### 5. Sales Forecasting

A SARIMA model was used to forecast monthly sales for 2014 using historical data from 2012 and 2013.

The forecast identified stronger expected sales around the middle of the year and weaker sales at the beginning and end of the year.

### 6. Customer Churn Analysis

Customer churn analysis was used to identify patterns linked to customer loss.

The analysis found that churned customers showed sales declines around months 5 to 8, and some districts had higher churn risk than others.

## 🔍 Key Findings

- Sales activity was stronger during weekdays, especially around midweek.
- Customer profitability varied across districts.
- Profit margins remained stable between 2012 and 2013.
- New customers placed larger average orders than returning customers.
- Price adjustments influenced sales value.
- Sales quantity was relatively stable across months.
- SARIMA forecasting predicted stronger mid-year sales in 2014.
- Churn risk increased where customer sales declined during months 5 to 8.
- Regional churn differences suggest the need for district-specific retention strategies.

## 💡 Business Recommendations

- Use targeted regional strategies for high-profit and high-churn districts.
- Introduce re-engagement campaigns for customers with declining sales.
- Convert high-value new customers into repeat customers through loyalty offers.
- Use sales forecasts to support inventory, staffing, and marketing planning.
- Review pricing strategies carefully before applying major price adjustments.
- Collect more customer-level data, such as satisfaction, complaints, and engagement frequency, to improve churn prediction.

## 🧠 Skills Demonstrated

- Data cleaning and preprocessing
- Handling missing values
- Data type conversion
- Duplicate removal
- Outlier detection and treatment
- Exploratory data analysis
- Data visualisation
- Two-sample hypothesis testing
- Multiple regression analysis
- SARIMA time series forecasting
- Customer churn analysis
- Business insight generation
- Strategic recommendation development

## ✅ Conclusion

This project demonstrates how business analytics can support sales strategy, customer retention, inventory planning, and operational decision-making.

By combining exploratory analysis, hypothesis testing, regression modelling, forecasting, and churn analysis, the project provides LuminaTech with practical insights to improve profitability, customer loyalty, and long-term business performance.
