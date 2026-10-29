
  
    

        create or replace transient table ANALYTICS.MARTS.dim_parts
         as
        (select
    part_key,
    part_name,
    manufacturer,
    brand,
    type,
    size,
    container,
    retail_price
from ANALYTICS.STAGING.stg_tpch__parts
        );
      
  