----------------------------------------------------------------
-- Purpose: Analyze products, top/bottom products, product pairs
---------------------------------------------------------------

-- Top product per category
WITH cte AS (
    SELECT category, product_name, SUM(sales) AS product_sales,
           ROW_NUMBER() OVER(PARTITION BY category ORDER BY SUM(sales) DESC) AS rn
    FROM train_staging
    GROUP BY category, product_name
)
SELECT *
FROM cte
WHERE rn = 1;

-- Most frequently purchased product per sub-category
WITH cte AS (
    SELECT sub_category, product_name, COUNT(*) AS count
    FROM train_staging
    GROUP BY sub_category, product_name
),
ranked AS (
    SELECT *, DENSE_RANK() OVER(PARTITION BY sub_category ORDER BY count DESC) AS rank
    FROM cte
)
SELECT *
FROM ranked
WHERE rank = 1;

-- Frequently bought together products
SELECT product_1, product_2, COUNT(*) AS times_bought_together
FROM (
    SELECT a.order_id, a.product_id AS product_1, b.product_id AS product_2
    FROM train_staging a
    JOIN train_staging b ON a.order_id = b.order_id
    WHERE a.product_id < b.product_id
) product_pairs
GROUP BY product_1, product_2
ORDER BY times_bought_together DESC;