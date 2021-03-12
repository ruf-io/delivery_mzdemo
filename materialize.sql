CREATE SOURCE orders 

CREATE SOURCE drivers

CREATE MATERIALIZED VIEW nearby_orders AS 
    SELECT
        *
    FROM
        (SELECT DISTINCT id FROM drivers) driver_grp,
        LATERAL (
            SELECT
                order.id,
                order.name,
                order.status,
                (ABS(order.lat - driver.lat) + ABS(order.lon - driver.lon)) as order_dist
            FROM orders
            WHERE order.status IN (1,2)
            ORDER BY order_dist ASC LIMIT 5
        )