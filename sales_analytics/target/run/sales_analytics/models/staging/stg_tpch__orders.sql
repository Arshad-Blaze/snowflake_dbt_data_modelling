
  create or replace   view ANALYTICS.STAGING.stg_tpch__orders
  
   as (
    select
    o_orderkey as order_key,
    o_custkey as customer_key,
    o_orderstatus as order_status,
    o_totalprice as total_price,
    to_date(o_orderdate) as order_date,
    o_orderpriority as order_priority,
    o_clerk as clerk,
    o_shippriority as ship_priority
from snowflake_sample_data.tpch_sf1.orders
  );

