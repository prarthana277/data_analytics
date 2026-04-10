--------------------------------------------------------------------------
-- Purpose: Analyze trends over time (monthly, running totals, YoY growth)
--------------------------------------------------------------------------

-- Monthly sales trend
SELECT YEAR(order_date) AS year, MONTH(order_date) AS month, SUM(sales) AS monthly_sales
FROM train_staging
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

-- Running total of sales
SELECT order_date, SUM(SUM(sales)) OVER(ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM train_staging
GROUP BY order_date
ORDER BY order_date;

-- Year-over-Year (YoY) growth
WITH year_sales AS (
    SELECT YEAR(order_date) AS year, SUM(sales) AS total_sales
    FROM train_staging
    GROUP BY YEAR(order_date)
),
prev_year AS (
    SELECT year, total_sales, LAG(total_sales) OVER(ORDER BY year) AS prev_year_sales
    FROM year_sales
)
SELECT year, total_sales, prev_year_sales, ((total_sales - prev_year_sales)/prev_year_sales)*100 AS growth_pct
FROM prev_year;