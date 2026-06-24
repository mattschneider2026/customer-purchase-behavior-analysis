# Customer, Restaurant & Sales Performance Analysis (SQL)

## Project Overview

This project analyzes customer purchasing behavior to identify how demographic characteristics—including income, age, family size, and gender—influence order value and purchasing patterns. Using SQL for data analysis and Tableau for visualization, the project explores key drivers of customer spending and highlights actionable business insights that can support customer segmentation and marketing strategy.

## Business Questions

1. Do higher-income customers tend to place higher-value orders?
2. How does order value vary by customer age, family size, and gender?
3. Which customer segments drive sales volume versus transaction value?
4. What customer characteristics best explain spending behavior?

## Tools & Technologies

* SQL
* Tableau
* Excel / CSV

## SQL Techniques Used

* Data filtering and aggregation
* GROUP BY analysis
* Common Table Expressions (CTEs)
* Window Functions
* Customer segmentation
* Statistical comparisons across demographic groups

## Dataset

The dataset contains customer demographic information and purchase activity, with one recorded order per customer.

### Key Fields

* Customer ID
* Income
* Age
* Family Size
* Gender
* Order Value

## Key Findings

### Spending Behavior

* Customer spending was influenced more by life stage than income alone.
* Customers aged 26–29 recorded the highest average order values.
* Customers aged 22–25 generated the highest transaction volume.

### Family Structure

* Couples placed the highest-value orders among all family-size segments.
* Larger household size did not necessarily correspond with higher spending.

### Gender Analysis

* Male customers exhibited higher average order values across all age groups.

### Customer Mix

* Customers reporting no income generated the largest share of sales volume due to customer count rather than individual spending levels.

## Key Metrics

| Metric              | Value |
| ------------------- | ----- |
| Average Order Value | $77   |
| Average Family Size | 3     |
| Orders per Customer | 1     |

## Dashboard

View the interactive Tableau dashboard here:

[Customer Purchase Behavior Dashboard](https://public.tableau.com/views/FinalProject-MatthewSchneider/Dashboard1?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

## Business Recommendations

* Develop targeted marketing campaigns for customers aged 26–29, who demonstrate the highest average spending behavior.
* Create retention and loyalty initiatives focused on high-value customer segments.
* Evaluate demographic characteristics beyond income when designing customer acquisition strategies.
* Further investigate spending behavior using longitudinal data to better understand customer lifetime value.

## Limitations

* Each customer has only one recorded transaction.
* Analysis reflects single-purchase behavior rather than long-term customer value.
* Findings should be validated using repeat-purchase and longitudinal customer data.

## Repository Contents

* SQL Queries
* Cleaned Dataset
* Tableau Dashboard
* Project Documentation
* Supporting Visualizations
