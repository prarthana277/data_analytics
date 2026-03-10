------------------------------------------------------
-- Purpose: Showcase advanced SQL with window functions
-------------------------------------------------------

-- Running average of monthly sales per customer
SELECT *, AVG(total_sales) OVER(PARTITION BY customer_id ORDER BY year, month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS avg_order_value
FROM (
    SELECT customer_id, YEAR(order_date) AS year, MONTH(order_date) AS month, SUM(sales) AS total_sales
    FROM train_staging
    GROUP BY customer_id, YEAR(order_date), MONTH(order_date)
) t;

-- Days between consecutive orders per customer
SELECT customer_id, order_id, order_date,
       LAG(order_date) OVER(PARTITION BY customer_id ORDER BY order_date) AS previous_order_date,
       DATEDIFF(order_date, LAG(order_date) OVER(PARTITION BY customer_id ORDER BY order_date)) AS days_between_orders
FROM train_staging;

-- Top 3 customers by total sales in each region
WITH customers AS (
    SELECT region, customer_name, SUM(sales) AS total_sales,
           DENSE_RANK() OVER(PARTITION BY region ORDER BY SUM(sales) DESC) AS rank
    FROM train_staging
    GROUP BY region, customer_name
)
SELECT *
FROM customers
WHERE rank <= 3;