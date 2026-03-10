-----------------------------------------------------------
-- Purpose: Analyze sales by region and top cities
-----------------------------------------------------------

-- Total sales by region
SELECT region, SUM(sales) AS total_sales
FROM train_staging
GROUP BY region
ORDER BY total_sales DESC;

-- Top 3 cities by sales within each region
WITH city_sales AS (
    SELECT region, city, SUM(sales) AS total_sales
    FROM train_staging
    GROUP BY region, city
)
SELECT region, city, total_sales
FROM (
    SELECT *, ROW_NUMBER() OVER(PARTITION BY region ORDER BY total_sales DESC) AS rn
    FROM city_sales
) ranked
WHERE rn <= 3
ORDER BY region, total_sales DESC;