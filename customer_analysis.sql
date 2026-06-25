/* ===================================================
CUSTOMER PURCHASE BEHAVIOR ANALYSIS
SQL PORTFOLIO PROJECT
Author: Matthew Schneider
Tools: SQLite, SQL, Tableau
=================================================== */

/*

Project Objective:
Analyze customer purchasing behavior, customer demographics,
and sales performance to identify high-value customer segments
and key drivers of revenue.

Key Concepts Demonstrated:
- JOINs
- Aggregations
- CASE Statements
- CTEs
- Window Functions
- Customer Segmentation

*/

/* ===================================================
SECTION 1: CUSTOMER ANALYSIS BASE DATA
=================================================== */

-- Query 1: Create analytical customer-order dataset

SELECT
    u.user_id,
    u.name,
    u.age,
    u.gender,
    u.income,
    u.family_size,
    o.order_date,
    o.sales_amount,

    CASE
        WHEN u.age BETWEEN 18 AND 21 THEN '18-21'
        WHEN u.age BETWEEN 22 AND 25 THEN '22-25'
        WHEN u.age BETWEEN 26 AND 29 THEN '26-29'
        ELSE '30+'
    END AS age_group,

    CASE
        WHEN u.income IS NULL OR u.income = 0 THEN 'No Income'
        WHEN u.income < 30000 THEN 'Low Income'
        WHEN u.income BETWEEN 30000 AND 70000 THEN 'Middle Income'
        ELSE 'High Income'
    END AS income_group

FROM users u
INNER JOIN orders o
    ON u.user_id = o.user_id;

/* ===================================================
SECTION 2: BASIC KPI
=================================================== */

-- Query 2: Core Business KPIs

SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT user_id) AS total_customers,
    ROUND(AVG(sales_amount), 2) AS avg_order_value,
    ROUND(SUM(sales_amount), 2) AS total_revenue
FROM orders;

/* ===================================================
SECTION 3: INCOME vs. SPENDING
=================================================== */

WITH customer_orders AS (

    SELECT
        u.user_id,
        u.income,
        o.sales_amount,

        CASE
            WHEN u.income IS NULL OR u.income = 0 THEN 'No Income'
            WHEN u.income < 30000 THEN 'Low Income'
            WHEN u.income BETWEEN 30000 AND 70000 THEN 'Middle Income'
            ELSE 'High Income'
        END AS income_group

    FROM users u
    INNER JOIN orders o
        ON u.user_id = o.user_id
)

SELECT
    income_group,
    COUNT(DISTINCT user_id) AS customers,
    ROUND(AVG(sales_amount), 2) AS avg_order_value,
    ROUND(SUM(sales_amount), 2) AS total_revenue
FROM customer_orders
GROUP BY income_group
ORDER BY avg_order_value DESC;

/* ===================================================
SECTION 4: AGE GROUP ANALYSIS
=================================================== */

WITH customer_orders AS (

    SELECT
        u.user_id,
        o.sales_amount,

        CASE
            WHEN u.age BETWEEN 18 AND 21 THEN '18-21'
            WHEN u.age BETWEEN 22 AND 25 THEN '22-25'
            WHEN u.age BETWEEN 26 AND 29 THEN '26-29'
            ELSE '30+'
        END AS age_group

    FROM users u
    INNER JOIN orders o
        ON u.user_id = o.user_id
)

SELECT
    age_group,
    COUNT(DISTINCT user_id) AS customers,
    ROUND(AVG(sales_amount), 2) AS avg_order_value,
    ROUND(SUM(sales_amount), 2) AS total_revenue
FROM customer_orders
GROUP BY age_group
ORDER BY avg_order_value DESC;

/* ===================================================
SECTION 5: FAMILY SIZE IMPACT
=================================================== */

SELECT
    u.family_size,
    COUNT(DISTINCT u.user_id) AS customers,
    ROUND(AVG(o.sales_amount), 2) AS avg_order_value,
    ROUND(SUM(o.sales_amount), 2) AS total_revenue
FROM users u
INNER JOIN orders o
    ON u.user_id = o.user_id
GROUP BY u.family_size
ORDER BY avg_order_value DESC;

/* ===================================================
SECTION 6: GENDER ANALYSIS
=================================================== */

SELECT
    u.gender,
    COUNT(DISTINCT u.user_id) AS customers,
    ROUND(AVG(o.sales_amount), 2) AS avg_order_value,
    ROUND(SUM(o.sales_amount), 2) AS total_revenue
FROM users u
INNER JOIN orders o
    ON u.user_id = o.user_id
GROUP BY u.gender
ORDER BY avg_order_value DESC;

/* ===================================================
SECTION 7: HIGH VALUE SEGMENT IDENTIFICATION
=================================================== */

WITH customer_segments AS (

    SELECT
        u.user_id,
        u.gender,
        o.sales_amount,

        CASE
            WHEN u.age BETWEEN 18 AND 21 THEN '18-21'
            WHEN u.age BETWEEN 22 AND 25 THEN '22-25'
            WHEN u.age BETWEEN 26 AND 29 THEN '26-29'
            ELSE '30+'
        END AS age_group,

        CASE
            WHEN u.income IS NULL OR u.income = 0 THEN 'No Income'
            WHEN u.income < 30000 THEN 'Low Income'
            WHEN u.income BETWEEN 30000 AND 70000 THEN 'Middle Income'
            ELSE 'High Income'
        END AS income_group

    FROM users u
    INNER JOIN orders o
        ON u.user_id = o.user_id
)

SELECT
    age_group,
    gender,
    income_group,

    COUNT(DISTINCT user_id) AS customers,

    ROUND(AVG(sales_amount), 2) AS avg_order_value,

    ROUND(SUM(sales_amount), 2) AS total_revenue,

    RANK() OVER (
        ORDER BY AVG(sales_amount) DESC
    ) AS spending_rank

FROM customer_segments

GROUP BY
    age_group,
    gender,
    income_group

HAVING COUNT(DISTINCT user_id) >= 5

ORDER BY spending_rank;
