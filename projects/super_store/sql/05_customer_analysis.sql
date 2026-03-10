-------------------------------------------------------------
-- Purpose: Analyze customers, top buyers, CLV, repeat orders
-------------------------------------------------------------

-- Top 5 customers by total sales
SELECT customer_name, SUM(sales) AS total_sales
FROM train_staging
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 5;

-- Repeat customers (>3 orders)
SELECT customer_name, COUNT(DISTINCT order_id) AS total_orders
FROM train_staging
GROUP BY customer_name
HAVING COUNT(DISTINCT order_id) > 3;

-- Customer Lifetime Value (CLV)
SELECT customer_id,
       MIN(order_date) AS first_order,
       MAX(order_date) AS last_order,
       SUM(sales) AS total_sales,
       AVG(sales) AS avg_order_value,
       MAX(order_date)-MIN(order_date) AS lifetime_days
FROM train_staging
GROUP BY customer_id;

-- Customer retention by cohort
WITH first_order AS (
    SELECT customer_id, YEAR(MIN(order_date)) AS first_order_year
    FROM train_staging
    GROUP BY customer_id
)
SELECT f.first_order_year, YEAR(o.order_date) AS order_year, COUNT(DISTINCT o.customer_id) AS returning_customers
FROM first_order f
JOIN train_staging o ON f.customer_id = o.customer_id
GROUP BY f.first_order_year, YEAR(o.order_date)
ORDER BY f.first_order_year, YEAR(o.order_date);