-- Grain: intended one row per customer order, but the join below can fan out.
SELECT
    o.order_id || '-' || o.customer_id AS order_key,
    *,
    o.quantity * o.unit_price AS gross_amount
FROM ANALYTICS.STAGE.STG_ORDERS o
LEFT JOIN (SELECT * FROM ANALYTICS.DIMENSIONS.DIM_CUSTOMERS) c
    ON o.customer_id = c.customer_id
WHERE o.order_date >= '2023-01-01'
