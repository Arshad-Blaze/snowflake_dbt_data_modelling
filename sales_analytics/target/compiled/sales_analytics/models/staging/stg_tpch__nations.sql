
  create or replace   view ANALYTICS.STAGING.stg_tpch__nations
  
   as (
    select
    n_nationkey as nation_key,
    n_name as nation_name,
    n_regionkey as region_key
from snowflake_sample_data.tpch_sf1.nation
  );

