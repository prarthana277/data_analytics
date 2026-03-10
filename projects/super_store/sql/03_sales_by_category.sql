----------------------------------------------------------
-- Purpose: Analyze sales by product category and sub-category
----------------------------------------------------------

-- Total sales by category
SELECT category, SUM(sales) AS total_sales
FROM train_staging
GROUP BY category
ORDER BY total_sales DESC;

-- Total sales by sub-category (Top 5)
SELECT sub_category, SUM(sales) AS total_sales
FROM train_staging
GROUP BY sub_category
ORDER BY total_sales DESC
LIMIT 5;

-- Category contribution percentage
SELECT category,
       SUM(sales) AS category_sales,
       ROUND(SUM(sales)*100.0/SUM(SUM(sales)) OVER(),2) AS percentage
FROM train_staging
GROUP BY category
ORDER BY percentage DESC;