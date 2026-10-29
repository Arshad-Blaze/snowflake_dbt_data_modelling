-- 1. Top 10 customers by revenue
SELECT 
    customer_key,
    customer_name,
    nation_name,
    region_name,
    total_revenue
FROM (
    SELECT 
        f.customer_key,
        c.customer_name,
        c.nation_name,
        c.region_name,
        SUM(f.net_revenue) AS total_revenue
    FROM ANALYTICS.MARTS.FCT_ORDER_LINES f
    JOIN ANALYTICS.MARTS.DIM_CUSTOMERS c ON f.customer_key = c.customer_key
    GROUP BY 1, 2, 3, 4
)
ORDER BY total_revenue DESC
LIMIT 10;

-- 2. Revenue by region by year
SELECT 
    region_name,
    EXTRACT(YEAR FROM order_date) AS order_year,
    SUM(net_revenue) AS total_revenue
FROM ANALYTICS.MARTS.FCT_ORDER_LINES
GROUP BY 1, 2
ORDER BY order_year, total_revenue DESC;

-- 3. Region sales vs. target variance report
SELECT * 
FROM ANALYTICS.MARTS.RPT_REGION_SALES_VS_TARGET
ORDER BY year, region;

-- 4. Top parts by revenue / margin
SELECT 
    p.part_name,
    p.brand,
    p.type,
    SUM(f.net_revenue) AS total_revenue
FROM ANALYTICS.MARTS.FCT_ORDER_LINES f
JOIN ANALYTICS.MARTS.DIM_PARTS p ON f.part_key = p.part_key
GROUP BY 1, 2, 3
ORDER BY total_revenue DESC
LIMIT 10;

-- 5. Cost check: Warehouse credit usage
SELECT 
    warehouse_name,
    SUM(credits_used) AS total_credits_used,
    MIN(start_time) AS start_time,
    MAX(end_time) AS end_time
FROM SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY
WHERE warehouse_name = 'DBT_WH'
GROUP BY 1;