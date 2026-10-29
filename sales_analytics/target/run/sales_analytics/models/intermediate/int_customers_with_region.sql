
  create or replace   view ANALYTICS.INTERMEDIATE.int_customers_with_region
  
   as (
    select
    c.customer_key,
    c.customer_name,
    c.address,
    c.phone,
    c.account_balance,
    c.market_segment,
    n.nation_name,
    r.region_name
from ANALYTICS.STAGING.stg_tpch__customers c
join ANALYTICS.STAGING.stg_tpch__nations n on c.nation_key = n.nation_key
join ANALYTICS.STAGING.stg_tpch__regions r on n.region_key = r.region_key
  );

