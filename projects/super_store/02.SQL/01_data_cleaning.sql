-------------------------------------------------------
-- Purpose: Clean and prepare the raw super_store dataset
-------------------------------------------------------

-- 1. Create schema (if not exists)
CREATE SCHEMA IF NOT EXISTS super_store;

-- 2. Check tables in schema
SHOW TABLES;

-- 3. View the raw data
SELECT *
FROM train;

-- 4. Describe the table structure
DESCRIBE train;

-- 5. List distinct cities
SELECT DISTINCT city
FROM train
ORDER BY city;

-- =====================================================
-- 6. Remove duplicates using ROW_NUMBER
-- =====================================================
WITH orders AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY
                   "Order ID",
                   "Order Date",
                   "Ship Date",
                   "Ship Mode",
                   "Customer ID",
                   "Customer Name",
                   "Segment",
                   "Country",
                   "City",
                   "State",
                   "Postal Code",
                   "Region",
                   "Product ID",
                   "Category",
                   "Sub-Category",
                   "Product Name",
                   "Sales"
               ORDER BY "Order Date"
           ) AS rn
    FROM train
)
SELECT *
FROM orders
WHERE rn > 1;  -- Returns duplicates

-- 7. Count total rows
SELECT COUNT(*)
FROM train;

-- =====================================================
-- 8. Rename columns for easier handling
-- Note: Use backticks ` for Databricks compatibility
-- =====================================================
ALTER TABLE train RENAME COLUMN "Row ID" TO row_id;
ALTER TABLE train RENAME COLUMN "Order ID" TO order_id;
ALTER TABLE train RENAME COLUMN "Order Date" TO order_date;
ALTER TABLE train RENAME COLUMN "Ship Date" TO ship_date;
ALTER TABLE train RENAME COLUMN "Ship Mode" TO ship_mode;
ALTER TABLE train RENAME COLUMN "Customer ID" TO customer_id;
ALTER TABLE train RENAME COLUMN "Customer Name" TO customer_name;
ALTER TABLE train RENAME COLUMN "Postal Code" TO postal_code;
ALTER TABLE train RENAME COLUMN "Product ID" TO product_id;
ALTER TABLE train RENAME COLUMN "Sub-Category" TO sub_category;
ALTER TABLE train RENAME COLUMN "Product Name" TO product_name;

-- =====================================================
-- 9. Create a clean table with renamed columns
-- Works in both SQL and Databricks
-- =====================================================
CREATE OR REPLACE TABLE train_clean AS
SELECT
    `Row ID`        AS row_id,
    `Order ID`      AS order_id,
    `Order Date`    AS order_date,
    `Ship Date`     AS ship_date,
    `Ship Mode`     AS ship_mode,
    `Customer ID`   AS customer_id,
    `Customer Name` AS customer_name,
    segment,
    country,
    city,
    state,
    `Postal Code`   AS postal_code,
    region,
    `Product ID`    AS product_id,
    category,
    `Sub-Category`  AS sub_category,
    `Product Name`  AS product_name,
    sales
FROM train;

-- 10. Check duplicates in clean table
WITH duplicates AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY
                   order_id,
                   order_date,
                   ship_date,
                   ship_mode,
                   customer_id,
                   customer_name,
                   segment,
                   country,
                   city,
                   state,
                   postal_code,
                   region,
                   product_id,
                   category,
                   sub_category,
                   product_name,
                   sales
               ORDER BY row_id
           ) AS rn
    FROM train_clean
)
SELECT *
FROM duplicates
WHERE rn > 1;  -- Only 1 duplicate expected

-- 11. Inspect the duplicate record
SELECT *
FROM train_clean
WHERE order_id = "US-2015-150119"
  AND product_id = "FUR-CH-10002965";

-- 12. Create staging table and remove duplicates
CREATE TABLE train_staging AS
WITH duplicates AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY
                   order_id,
                   order_date,
                   ship_date,
                   ship_mode,
                   customer_id,
                   customer_name,
                   segment,
                   country,
                   city,
                   state,
                   postal_code,
                   region,
                   product_id,
                   category,
                   sub_category,
                   product_name,
                   sales
               ORDER BY row_id
           ) AS rn
    FROM train_clean
)
SELECT *
FROM duplicates;

-- 13. Delete duplicate rows
DELETE FROM train_staging
WHERE rn > 1;

-- 14. Check for missing values
SELECT *
FROM train_staging
WHERE order_id IS NULL
   OR product_id IS NULL
   OR region IS NULL
   OR order_date IS NULL;
