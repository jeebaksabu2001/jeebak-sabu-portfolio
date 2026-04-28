# Superstore Analytics Power BI Dashboard

## Project Summary

This project presents an interactive Power BI dashboard built using Superstore sales data from 2020 to 2023. The dashboard analyses sales, profit, return rate, product performance, customer segments, and geographic profit patterns.

The main purpose of the project is to help management understand whether sales growth is translating into consistent profitability, identify underperforming products and regions, and support better business decision-making through clear visual analytics.

## Business Problem

Superstore is experiencing strong sales growth, but higher revenue does not always result in strong and consistent profitability. Profitability varies across product categories, customer segments, and geographic regions. Return rates are also a continuing concern because they can reduce profit and indicate possible customer dissatisfaction or product-related issues.

Management needs a clear view of:

- Which products and categories are driving profit
- Which products are causing losses
- Whether sales are improving compared with previous years
- Which customer segments contribute most to sales
- Which states generate the highest profit
- Whether return rates are improving or worsening

This dashboard was created to support data-driven decisions by analysing sales, profit, returns, product performance, segment contribution, and geographic profit patterns from 2020 to 2023.

## Project Objectives

The objectives of this dashboard are to:

1. Track sales, profit, and return rate performance.
2. Compare current performance with previous year results.
3. Identify the most profitable and loss-making products.
4. Analyse sales trends over time.
5. Compare sales performance by customer segment.
6. Identify geographic areas that generate the highest profit.
7. Provide clear insights for business improvement and strategic planning.

## Dataset Used

The dataset used in this project is:

```text
Superstore.xlsx
```

The dataset contains Superstore order, sales, product, customer, return, and geographic information. It was used to build the Power BI dashboard and calculate key business metrics.

## Dataset Description

The Superstore dataset includes information related to:

- Orders
- Customers
- Products
- Sales
- Profit
- Returns
- Customer segments
- Product categories and sub-categories
- Geographic locations
- Order dates

## Key Fields Used

The dashboard uses fields such as:

- **Order Date**: Date when the order was placed.
- **Sales**: Revenue generated from orders.
- **Profit**: Profit earned after costs and discounts.
- **Returned Orders**: Used to calculate the percentage of returned orders.
- **Category**: Main product category, such as Furniture, Office Supplies, and Technology.
- **Sub-Category**: Product sub-category, such as Chairs, Tables, Copiers, Phones, Binders, and Accessories.
- **Product Name**: Name of the product sold.
- **Segment**: Customer segment, such as Consumer, Corporate, and Home Office.
- **State**: U.S. state where the order was placed.
- **Region**: Geographic region used for location-based analysis.
- **Year**: Extracted from order date to support year-over-year comparison.

## Tools and Technologies Used

- **Power BI**
- **Power Query** – Data cleaning and transformation
- **DAX** – Measures and calculated KPIs
- **Microsoft Excel** – Source dataset
- **Data Modelling** – Relationship setup and measure creation
- **Data Visualisation** – Dashboard design and business insight presentation

## Dashboard Pages

This project includes two main dashboard pages:

1. **Project Overview Page**
2. **Superstore Analytics Dashboard Page**

## 1. Project Overview Page

The project overview page explains the business problem, dashboard objective, questions answered, key insights, and headline metrics.

### Screenshot

![Project Overview](images/project_overview.png)

### Key Sections

- Business Problem
- Objective
- Questions Answered
- Key Insights Discovered
- Key Metrics at a Glance

### Key Metrics Displayed

| Metric | Value |
|---|---:|
| Sales | $2.33M |
| Profit | $292.30K |
| Returned Orders | 5.79% |
| Previous Year Sales | $1.58M |
| Previous Year Profit | $196.37K |
| Previous Year Return Rate | 8.74% |

### Main Insight

Sales and profit both improved compared with the previous year, while the return rate decreased. This suggests that the business achieved stronger growth and improved return performance during the analysis period.

## 2. Superstore Analytics Dashboard Page

The main dashboard page presents interactive business performance visuals.

### Screenshot

![Superstore Dashboard](images/superstore_dashboard.png)

## Key Dashboard Metrics

## 1. Sales KPI

The dashboard shows total sales of:

```text
$2.33M
```

Previous year sales were:

```text
$1.58M
```

This represents an increase of approximately:

```text
47.16%
```

### Interpretation

Sales increased strongly compared with the previous year, showing positive revenue growth.

## 2. Profit KPI

The dashboard shows total profit of:

```text
$292.30K
```

Previous year profit was:

```text
$196.37K
```

This represents an increase of approximately:

```text
48.85%
```

### Interpretation

Profit increased at a similar rate to sales, which suggests that the sales growth was not only revenue-driven but also contributed positively to profitability.

## 3. Return Rate KPI

The dashboard shows returned orders of:

```text
5.79%
```

Previous year returned orders were:

```text
8.74%
```

This represents a decrease of approximately:

```text
-2.95%
```

### Interpretation

The return rate decreased compared with the previous year, which is a positive sign. Lower returns may indicate better product quality, improved customer satisfaction, or better order accuracy.

## Visualisations Included

## 1. Sales vs Previous Year Over Time

### Visual Type

Line chart.

### Purpose

This visual compares current sales with previous year sales over time.

### Business Value

It helps management understand whether sales are improving consistently or only during certain periods.

### Key Insight

Sales generally performed above the previous year from 2021 onward, with strong growth visible in late 2023.

## 2. Profit by Product

### Visual Type

Bar chart.

### Purpose

This visual compares profit across product sub-categories.

### Business Value

It helps identify profitable products and loss-making products.

### Key Insight

Copiers generated the highest profit, while Tables were the biggest loss-making product within the Furniture category.

This helps management focus on profitable products and review pricing, discounting, or cost issues in loss-making products.

## 3. Sales by Segment

### Visual Type

Donut chart.

### Purpose

This visual shows how sales are distributed across customer segments.

### Segment Breakdown

| Segment | Sales Share |
|---|---:|
| Consumer | 50.32% |
| Corporate | 30.77% |
| Home Office | 18.92% |

### Key Insight

The Consumer segment contributes the largest share of sales, while Home Office contributes the smallest share.

### Business Value

Management can use this insight to prioritise customer targeting, marketing campaigns, and segment-level sales strategies.

## 4. Profit by State

### Visual Type

Map visualisation.

### Purpose

This visual shows profit distribution across U.S. states.

### Business Value

It helps identify geographic locations that generate stronger profitability and areas that may require improvement.

### Key Insight

Profit is concentrated in selected states, showing that geographic profitability is uneven.

This can help management focus on high-profit regions while investigating low-profit or loss-making states.

## Questions Answered

This dashboard answers the following business questions:

1. How are sales, profit, and return rate performing compared with the previous year?
2. Are sales improving over time?
3. Which products are the most profitable?
4. Which products are generating losses?
5. Which customer segment contributes the most to sales?
6. Which states generate the highest profit?
7. Are recent sales gains sustainable?
8. Is the return rate improving or worsening?

## Key Insights

- Sales increased to approximately **$2.33M**.
- Profit increased to approximately **$292.30K**.
- Sales increased by approximately **47.16%** compared with the previous year.
- Profit increased by approximately **48.85%** compared with the previous year.
- Returned orders decreased from **8.74%** to **5.79%**.
- Copiers were the most profitable product sub-category.
- Tables were the largest loss-making product sub-category.
- Consumer segment generated the highest share of sales.
- Home Office segment generated the smallest share of sales.
- Profit was concentrated in selected U.S. states.
- Late-2023 sales showed strong growth compared with previous periods.

## Business Recommendations

Based on the dashboard insights, the following recommendations are suggested:

1. **Focus on profitable products**
   - Promote high-profit products such as Copiers.
   - Use profitable sub-categories to support targeted sales campaigns.

2. **Review loss-making products**
   - Investigate why Tables are generating losses.
   - Review pricing, discounting, shipping costs, and supplier costs for underperforming products.

3. **Strengthen Consumer segment strategy**
   - Since the Consumer segment contributes the largest sales share, targeted promotions and loyalty offers should be used to maintain growth.

4. **Grow Corporate and Home Office segments**
   - Corporate and Home Office customers can be targeted with customised bundles, business discounts, and account-based marketing.

5. **Monitor return rates**
   - Although return rates improved, returns should continue to be monitored by product and category.
   - High-return products should be reviewed for quality, delivery, or expectation mismatch issues.

6. **Use geographic profit insights**
   - High-profit states should be prioritised for expansion and marketing.
   - Low-profit states should be analysed to understand whether the issue is pricing, product mix, discounts, or logistics.

7. **Track year-over-year performance regularly**
   - Sales and profit should continue to be compared against previous year performance to monitor sustainable growth.

## Power BI Features Used

- KPI Cards
- Year-over-year comparison
- DAX measures
- Sales and profit trend analysis
- Product-level profitability analysis
- Segment-level sales analysis
- Geographic map visualisation
- Dashboard navigation and layout design
- Filter panel
- Custom formatting and visual styling

## Example Measures Used

The dashboard likely uses business measures such as:

```text
Total Sales
Total Profit
Returned Orders %
Previous Year Sales
Previous Year Profit
Previous Year Return Rate
Sales YoY %
Profit YoY %
Return Rate Change %
```

These measures support comparison between current performance and previous year performance.

## Files Included

- `Sales_analytics_dashboard.pbix` – Power BI dashboard file
- `Superstore.xlsx` – Source dataset used for the analysis
- `images/project_overview.png` – Screenshot of the project overview page
- `images/superstore_dashboard.png` – Screenshot of the main dashboard page
- `README.md` – Project documentation

## How to View the Dashboard

To view or edit the dashboard:

1. Download the `.pbix` file from this repository.
2. Open it using Microsoft Power BI Desktop.
3. Ensure that `Superstore.xlsx` is available in the same folder or reconnect the data source if required.
4. Refresh the data.
5. Explore the dashboard visuals and filters.

## Skills Demonstrated

- Power BI dashboard development
- Data cleaning and transformation
- DAX measure creation
- KPI reporting
- Year-over-year analysis
- Sales performance analysis
- Profitability analysis
- Return rate analysis
- Product-level analysis
- Customer segment analysis
- Geographic profit analysis
- Business intelligence storytelling
- Dashboard layout and visual design
- Data-driven recommendation development

## Conclusion

This project demonstrates how Power BI can be used to transform Superstore sales data into meaningful business insights. The dashboard shows that sales and profit increased strongly compared with the previous year, while return rates improved.

The analysis also highlights important business risks, including product-level losses and uneven profitability across states. By using this dashboard, management can make more informed decisions about product strategy, customer segmentation, regional performance, and return management.
