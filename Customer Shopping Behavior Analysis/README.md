# Customer Shopping Behaviour and Sales Analysis using Python

## Project Summary

This project analyses customer shopping behaviour for Dibs, a retail company operating across shopping malls and online channels. The main objective of the project is to understand customer purchase patterns, identify spending behaviour across different customer segments, analyse sales trends, and provide business recommendations to improve sales performance and customer loyalty.

The analysis was completed using Python in Jupyter Notebook, with a focus on data cleaning, exploratory data analysis, visualisation, and business interpretation.

## Business Problem

Dibs has collected customer purchase data from different shopping malls but is unsure how to use this data to improve its sales and marketing strategies. The business wants to better understand customer behaviour, identify patterns in spending, and develop targeted marketing campaigns based on customer preferences.

This project addresses the following business questions:

- Which product categories should Dibs target for marketing campaigns?
- Is there a difference in spending behaviour between male and female customers?
- Is there a relationship between customer age and spending behaviour?
- How does spending vary across different age groups?
- Which payment methods are most preferred by customers?
- What sales trends can be observed over time?

## Dataset Used

The dataset used in this project is `customer_shopping_data.csv`. It contains customer transaction records from different shopping malls.

### Dataset Columns

- **invoice_no**: Invoice number. Nominal. A combination of the letter `I` and a 6-digit integer uniquely assigned to each transaction.

- **customer_id**: Customer number. Nominal. A combination of the letter `C` and a 6-digit integer uniquely assigned to each customer.

- **gender**: String variable representing the customer's gender.

- **age**: Positive integer variable representing the customer's age.

- **category**: String variable representing the category of the purchased product, such as clothing, shoes, cosmetics, food and beverages, toys, books, technology, and souvenirs.

- **quantity**: Numeric variable representing the quantity of products purchased in each transaction.

- **price**: Numeric variable representing the unit price of the product in Turkish Liras (TL).

- **payment_method**: String variable representing the payment method used for the transaction, such as cash, credit card, or debit card.

- **invoice_date**: Date variable representing the day the transaction was generated.

- **shopping_mall**: String variable representing the name of the shopping mall where the transaction was made.

## Tools and Technologies Used

- **Python**
- **Pandas** – Data importing, cleaning, transformation, and analysis
- **NumPy** – Numerical operations
- **Matplotlib** – Data visualisation
- **Seaborn** – Statistical visualisation
- **SciPy** – Box-Cox transformation and skewness handling
- **Jupyter Notebook** – Code development and analysis documentation

## Data Cleaning Process

Several data cleaning steps were performed to prepare the dataset for analysis:

1. **Imported the dataset**
   - Loaded the CSV file into Jupyter Notebook using Pandas.
   - Used functions such as `head()`, `info()`, `describe()`, and `shape()` to understand the dataset structure.

2. **Created a total price column**
   - Since the `price` column represented unit price, a new column called `total_price` was created by multiplying `price` by `quantity`.

3. **Converted date values**
   - Some values in the `invoice_date` column were in Excel date format.
   - These were converted into a proper datetime format for easier time-based analysis.
   - Additional columns such as `year` and `month` were created for trend analysis.

4. **Fixed inconsistent values**
   - Inconsistent category names and spelling errors were corrected.
   - Examples include correcting values such as `Tech`, `Toy`, `Boks`, and inconsistent payment method entries.

5. **Handled missing and error values**
   - Error values such as `##error##` were replaced with missing values.
   - Missing values were handled using appropriate methods such as dropping invalid records or replacing values using median or mode where suitable.

6. **Removed duplicate records**
   - Duplicate invoice records were identified and removed to avoid inaccurate analysis.

7. **Checked outliers and skewness**
   - Histograms and boxplots were used to check data distribution and outliers.
   - The `total_price` column was found to be skewed.
   - A Box-Cox transformation was applied to reduce skewness and improve the distribution.

## Analysis Performed

## 1. Product Category Spending Analysis

A spending score was calculated for customers to understand which product categories generated stronger customer interest and spending behaviour.

The analysis showed that technology-related purchases had the highest spending score, suggesting strong customer interest and potential for high-value purchases. Fashion-related categories such as clothing and shoes also showed strong performance, indicating that these categories are important for targeted marketing campaigns.

## 2. Gender-Based Spending Behaviour

A boxplot was created to compare spending scores between male and female customers across different product categories.

The analysis showed that spending patterns between male and female customers were quite similar. There were no major differences or strong outliers between genders, suggesting that gender alone may not be the strongest factor for predicting customer spending behaviour.

## 3. Age and Spending Relationship

A scatter plot was created to examine the relationship between customer age and spending score.

The correlation between age and spending score was close to zero, indicating no strong linear relationship between the two variables. This suggests that age alone may not be a reliable factor for predicting customer spending.

## 4. Age Group Spending Analysis

Customers were grouped into different age categories to analyse spending behaviour across age segments.

The results showed that spending patterns were fairly consistent across different age groups. This suggests that Dibs should avoid relying only on age-based segmentation and should consider other factors such as product category, purchase behaviour, and customer preferences.

## 5. Sales by Payment Method

A visualisation was created to compare total sales by payment method.

The analysis showed that cash was the most preferred payment method, followed by credit card and debit card. This suggests that customers have different payment preferences, and Dibs should continue supporting multiple payment options to improve customer convenience.

## 6. Monthly Sales Trend Analysis

A line chart was created to analyse total monthly sales over time.

The sales trend was relatively stable between January 2021 and January 2023. A drop was observed after January 2023, but this appeared to be caused by lower data availability for February 2023 rather than an actual business decline.

## Key Findings

- Technology products showed the highest spending score, making them a strong category for targeted campaigns.
- Clothing and shoes also performed well, highlighting the importance of fashion-related products.
- Male and female customers showed similar spending behaviour across most categories.
- Age did not show a strong relationship with spending score.
- Cash was the most preferred payment method, followed by credit card and debit card.
- Monthly sales were generally stable, with the February 2023 decline likely linked to incomplete data.
- Customer segmentation should be based more on purchase behaviour and product preference rather than only age or gender.

## Business Recommendations

Based on the analysis, the following recommendations are suggested:

1. **Focus marketing campaigns on high-performing categories**
   - Dibs should prioritise marketing campaigns for technology, clothing, and shoes, as these categories showed strong customer interest and spending potential.

2. **Use behaviour-based customer segmentation**
   - Since age and gender did not show major differences in spending behaviour, Dibs should segment customers based on product preferences, purchase frequency, and spending value.

3. **Support multiple payment options**
   - Cash, credit card, and debit card options should all be maintained because customers show different payment preferences.

4. **Introduce loyalty programs and targeted promotions**
   - Dibs can offer discounts, rewards, and limited-time promotions to encourage repeat purchases and improve customer loyalty.

5. **Improve customer engagement**
   - Customer feedback through surveys, social media, and in-store interactions can help Dibs better understand customer needs and improve the shopping experience.

6. **Use sales trend analysis for planning**
   - Monthly sales patterns should be monitored regularly to support better inventory planning, seasonal promotions, and marketing decisions.

## Files Included

- `48085847_jeebak_assesment1.ipynb` – Jupyter Notebook containing the full analysis
- `customer_shopping_data.csv` – Dataset used for the analysis
- `README.md` – Project documentation

## Skills Demonstrated

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

## Conclusion

This project demonstrates how customer transaction data can be cleaned, analysed, and visualised to generate meaningful business insights. The findings show that Dibs can improve its marketing and sales strategies by focusing on high-performing product categories, supporting different payment preferences, and using customer behaviour insights to design targeted promotions.
