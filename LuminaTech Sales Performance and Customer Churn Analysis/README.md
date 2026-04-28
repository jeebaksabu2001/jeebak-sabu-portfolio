# LuminaTech Sales Performance and Customer Churn Analysis

## Project Summary

This project analyses sales and customer data for LuminaTech Lighting, an Australian lighting company. The aim of the project was to clean and prepare a large business dataset, identify key patterns in sales performance, profitability, customer behaviour, pricing, and customer churn, and develop data-driven recommendations to support management decision-making.

The project was completed as a group business analytics project using Python in Jupyter Notebook. The analysis includes exploratory data analysis, data visualisation, two-sample hypothesis testing, multiple regression analysis, sales forecasting, and customer churn analysis.

## Business Problem

LuminaTech Lighting wanted to better understand its sales performance, customer retention patterns, operational efficiency, and future sales trends. The company needed insights that could help management make better decisions about pricing, inventory planning, staffing, customer retention, and business growth.

This project addresses the following business questions:

- What sales and profitability patterns can be identified from the data?
- How do price adjustments affect sales performance?
- Are there differences in profit margins between fiscal years?
- Do new and returning customers show different order quantity behaviour?
- Can 2014 sales be forecasted using historical sales data?
- Which features may indicate a higher likelihood of customer churn?
- How can LuminaTech improve customer retention and operational planning?

## Dataset Used

The project used LuminaTech sales and customer transaction data from 2012 and 2013, supported by a metadata file. The dataset includes accounting dates, fiscal and calendar year information, customer and product codes, pricing adjustments, currency information, order details, invoice details, sales values, cost values, and quantity values.

### Dataset Columns

- **accounting_date**: The date when the financial transaction is recorded in the accounting system.

- **fiscal_year**: The year in which the transaction occurs, based on the company's fiscal calendar.

- **fiscal_month**: The month of the fiscal year during which the transaction takes place.

- **calendar_year**: The year in which the transaction occurs, based on the standard calendar.

- **calendar_month**: The month of the year during which the transaction takes place, based on the standard calendar.

- **calendar_day**: The specific day of the month on which the transaction occurs.

- **company_code**: A unique identifier for the company conducting the transaction.

- **customer_code**: A unique identifier for the customer involved in the transaction.

- **customer_district_code**: A code representing the geographical district of the customer.

- **item_code**: A unique identifier for the item being sold.

- **business_area_code**: A code representing the specific area of business related to the transaction.

- **item_group_code**: A code indicating the group to which the item belongs.

- **item_class_code**: A code categorising the item based on its characteristics or type.

- **item_type**: A descriptor indicating the nature or category of the item.

- **bonus_group_code**: A code identifying the group related to bonuses or incentives for sales.

- **environment_group_code**: A code denoting the environmental category related to the product.

- **technology_group_code**: A code representing the technology category associated with the item or service.

- **commission_group_code**: A code identifying the group that determines commission structures for sales.

- **reporting_classification**: A classification used for reporting purposes, indicating how the transaction should be categorised.

- **light_source**: A code indicating the source of lighting related to the item, if applicable.

- **warehouse_code**: A code identifying the warehouse where the item is stored or shipped from.

- **abc_class_code**: A classification code used in inventory management to indicate the importance of an item, such as A, B, or C categories.

- **abc_class_volume**: The volume of goods associated with the ABC classification.

- **business_chain_l1_code**: A code representing the first level of the business chain for tracking and analysis.

- **business_chain_l1_name**: The name corresponding to the business chain level 1 code.

- **contact_method_code**: A code indicating the contact method used.

- **salesperson_code**: A unique identifier for the salesperson associated with the transaction.

- **order_type_code**: A code that categorises the type of order.

- **market_segment**: A descriptor of the specific market segment targeted by the transaction.

- **value_sales**: The monetary value of sales generated from the transaction.

- **value_cost**: The cost associated with the transaction.

- **value_quantity**: The quantity of items sold or transacted.

- **value_price_adjustment**: Any adjustments made to the price during the transaction, such as discounts or surcharges.

- **currency**: The currency in which the transaction is conducted.

- **item_source_class**: A classification indicating the source or origin of the item.

- **invoice_number**: A unique identifier for the invoice related to the transaction.

- **line_number**: The line item number on the invoice, indicating specific items.

- **invoice_date**: The date the invoice is issued.

- **customer_order_number**: A unique identifier for the customer's order.

- **order_date**: The date when the order was placed.

- **dss_update_time**: The timestamp indicating when the data was last updated in the system.

## Tools and Technologies Used

- **Python**
- **Pandas** – Data importing, cleaning, manipulation, and aggregation
- **NumPy** – Numerical operations
- **Matplotlib** – Data visualisation
- **Seaborn** – Statistical visualisation
- **SciPy** – Statistical testing
- **Statsmodels** – Regression analysis and SARIMA forecasting
- **Jupyter Notebook** – Code development and analysis documentation
- **Microsoft Excel** – Metadata and source data reference

## Data Cleaning Process

The dataset was cleaned and prepared before analysis to improve accuracy and reliability.

1. **Imported and combined data**
   - Sales data from 2012 and 2013 was imported and merged into one dataset.
   - Initial exploration was performed using functions such as `head()`, `info()`, `shape()`, and `describe()`.

2. **Standardised categorical values**
   - Inconsistent values were corrected in key columns.
   - For example, currency values were standardised, and business area codes were converted into consistent company-standard labels.

3. **Converted data types**
   - Date columns such as `accounting_date`, `order_date`, and `invoice_date` were converted into proper datetime format.
   - This allowed time-based analysis, sales trend analysis, and lead-time calculations.

4. **Removed duplicate records**
   - Duplicate rows were identified and removed to prevent repeated transactions from affecting results.

5. **Handled missing values**
   - Columns with small numbers of missing values were handled by removing affected rows where appropriate.
   - Columns with no useful information were removed.
   - Columns with meaningful missing values were retained where they still supported analysis.

6. **Handled outliers**
   - Boxplots and the interquartile range method were used to identify outliers in key numerical columns such as `value_sales`, `value_cost`, and `value_quantity`.
   - Positive and negative values were considered separately because negative values may represent returns or refunds.

7. **Checked and reduced skewness**
   - Histograms and skewness values were used to check the distribution of numerical variables.
   - A cube root transformation was applied to reduce skewness while preserving both positive and negative values.

## Analysis Performed

## 1. Exploratory Data Analysis

The initial analysis focused on understanding the structure of the dataset, identifying missing values, reviewing data types, detecting duplicates, checking outliers, and preparing the data for further analysis.

Key variables such as `value_sales`, `value_cost`, and `value_quantity` were selected as important measures for business performance analysis.

## 2. Exploratory Business Insights

Five exploratory insights were developed to support management decision-making.

### Dynamic Pricing Impact Analysis

The relationship between price adjustments and sales volume was analysed over time. This helped assess how pricing strategies may influence sales performance.

### Supply Chain Optimisation Analysis

Lead times and fulfilment rates were compared to understand operational efficiency. This analysis helped identify how fulfilment performance and delivery timing may affect business operations.

### Sales Performance by Day and Time

Sales performance was analysed by hour of day and day of week. The analysis showed stronger sales activity during weekdays, particularly around midweek periods.

### Average Profitability by Customer District

Average profit was compared across customer district codes. This helped identify high-performing and low-performing districts, supporting more targeted regional strategies.

### Sales Performance Across Top Salespeople

Sales performance was compared across top salespeople over multiple years. This helped identify strong performers and areas where sales strategies or training may be improved.

## 3. Two-Sample Hypothesis Testing

Two hypothesis tests were conducted to compare differences between sub-samples.

### Profit Margins Between 2012 and 2013

A two-sample t-test was used to test whether there was a significant difference in profit margins between fiscal years 2012 and 2013.

The result showed no statistically significant difference, suggesting that profit margins remained stable across the two years.

### New Customers vs Returning Customers

A two-sample t-test was used to compare average order quantities between new and returning customers.

The result showed a statistically significant difference, with new customers placing larger orders on average than returning customers. This finding suggests that LuminaTech may need different strategies for acquiring new customers and increasing repeat purchase value from returning customers.

## 4. Regression Analysis

Multiple regression analysis was used to examine relationships between independent variables and business performance measures.

### Price Adjustments and Sales Value

An OLS regression model was used to examine how price adjustments, fiscal year, customer district code, and item group code influenced sales value.

The model showed that price adjustments had a meaningful relationship with sales value, suggesting that customers may be sensitive to pricing decisions.

### Factors Influencing Sales Quantity

Another regression model examined the influence of fiscal month, business area code, and item group code on sales quantity.

The results showed that sales quantity was relatively stable across months, suggesting that LuminaTech may not need large seasonal changes in inventory for all products.

## 5. Sales Forecasting for 2014

A SARIMA forecasting model was developed to predict monthly sales for 2014 using historical data from 2012 and 2013.

The model identified seasonal sales patterns, with higher forecasted sales around the middle of the year and lower sales at the beginning and end of the year.

This forecast can help LuminaTech improve:

- Inventory planning
- Staffing decisions
- Marketing campaign timing
- Budget planning
- Resource allocation

## 6. Customer Churn Analysis

Customer churn analysis was performed to identify features associated with a higher likelihood of losing customers.

The analysis found that churned customers showed a decline in sales during the middle of the year, especially around months 5 to 8. Regional churn differences were also identified, with some districts showing higher churn rates than others.

The analysis also showed that retained customers had slightly higher average profit margins than churned customers, highlighting the financial value of customer retention.

## Key Findings

- Data cleaning was essential due to missing values, duplicate rows, inconsistent category codes, outliers, and skewed variables.
- Sales activity was stronger during weekdays, especially around midweek periods.
- Customer profitability varied across districts, showing the importance of regional analysis.
- Profit margins were stable between 2012 and 2013.
- New customers placed larger average orders than returning customers.
- Price adjustments had an impact on sales value, suggesting pricing sensitivity.
- Sales quantity was relatively stable across months.
- SARIMA forecasting predicted stronger sales in mid-2014 and weaker sales at the start and end of the year.
- Customer churn risk was higher where mid-year sales declined.
- Regional churn differences suggest the need for district-specific retention strategies.

## Business Recommendations

Based on the analysis, the following recommendations are suggested:

1. **Use targeted regional strategies**
   - Districts with higher profitability should receive focused marketing and sales support.
   - High-churn districts should be reviewed to identify possible service, pricing, or competition-related issues.

2. **Improve customer retention**
   - LuminaTech should introduce targeted re-engagement campaigns for customers whose sales decline during months 5 to 8.
   - Loyalty rewards, personalised discounts, and follow-up communication can help reduce churn.

3. **Increase repeat purchase value**
   - Since new customers placed larger orders on average than returning customers, LuminaTech should focus on converting high-value new customers into repeat customers.
   - Returning customers can be encouraged to purchase more through product bundles, loyalty points, and tailored offers.

4. **Use sales forecasts for planning**
   - The 2014 SARIMA forecast can support better inventory, staffing, and marketing planning.
   - Inventory and staffing should be increased before expected mid-year sales peaks.

5. **Review pricing strategies carefully**
   - Since price adjustments can influence sales value, LuminaTech should test pricing changes carefully and consider customer sensitivity before applying major adjustments.

6. **Collect more customer-level data**
   - To improve churn prediction, the company should collect additional information such as customer satisfaction, engagement frequency, service interactions, and complaint history.

## Files Included

- `lumina_sales_churn_analysis.ipynb` – Jupyter Notebook containing the Python analysis
- `Metadata.xlsx` – Metadata file explaining dataset columns and codes
- `Group Report.pdf` – Final group report with analysis, visualisations, results, and recommendations
- `README.md` – Project documentation

## Skills Demonstrated

- Data cleaning and preprocessing
- Handling missing values
- Data type conversion
- Duplicate removal
- Outlier detection and treatment
- Skewness reduction
- Exploratory data analysis
- Data visualisation
- Two-sample t-tests
- Multiple regression analysis
- SARIMA time series forecasting
- Customer churn analysis
- Business insight generation
- Strategic recommendation development

## Conclusion

This project demonstrates how business analytics can support sales strategy, customer retention, inventory planning, and operational decision-making. By combining exploratory analysis, statistical testing, regression modelling, forecasting, and churn analysis, the project provides LuminaTech with practical insights that can help improve profitability, customer loyalty, and long-term business performance.
