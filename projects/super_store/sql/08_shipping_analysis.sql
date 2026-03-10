----------------------------------------------------
-- Purpose: Analyze shipping performance and delays
----------------------------------------------------

-- Average shipping time by ship mode
SELECT ship_mode, AVG(ship_date - order_date) AS avg_duration
FROM train_staging
GROUP BY ship_mode;

-- Orders delayed more than 2 days above average
WITH shipping_time_cte AS (
    SELECT order_id, customer_id, ship_mode,
           (ship_date - order_date) AS shipping_time,
           AVG(ship_date - order_date) OVER() AS avg_shipping_time
    FROM train_staging
)
SELECT order_id, customer_id, ship_mode, shipping_time AS days_delayed
FROM shipping_time_cte
WHERE shipping_time > avg_shipping_time + 2;