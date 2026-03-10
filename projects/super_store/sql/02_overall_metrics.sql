-------------------------------------------------------
--Purpose: Basic summary metrics of the dataset
-------------------------------------------------------

-- Total number of orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM train_staging;

-- Total sales
SELECT SUM(sales) AS total_sales
FROM train_staging;

-- Average sales per order
SELECT AVG(order_total) AS avg_sales_per_order
FROM (
    SELECT order_id, SUM(sales) AS order_total
    FROM train_staging
    GROUP BY order_id
) t;

-- Total number of customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM train_staging;