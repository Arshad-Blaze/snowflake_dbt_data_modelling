
  
    

        create or replace transient table ANALYTICS.MARTS.dim_regions
         as
        (select distinct
    region_key,
    region_name
from ANALYTICS.STAGING.stg_tpch__regions
        );
      
  