
  create or replace   view ANALYTICS.STAGING.stg_tpch__regions
  
   as (
    select
    r_regionkey as region_key,
    r_name as region_name
from snowflake_sample_data.tpch_sf1.region
  );

