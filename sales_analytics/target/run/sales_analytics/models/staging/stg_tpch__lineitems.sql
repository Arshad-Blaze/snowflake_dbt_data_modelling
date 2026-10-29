
  create or replace   view ANALYTICS.STAGING.stg_tpch__lineitems
  
   as (
    select
    l_orderkey as order_key,
    l_partkey as part_key,
    l_suppkey as supplier_key,
    l_linenumber as line_number,
    l_quantity as quantity,
    l_extendedprice as extended_price,
    l_discount as discount,
    l_tax as tax,
    l_returnflag as return_flag,
    l_linestatus as line_status,
    to_date(l_shipdate) as ship_date,
    to_date(l_commitdate) as commit_date,
    to_date(l_receiptdate) as receipt_date
from snowflake_sample_data.tpch_sf1.lineitem
  );

