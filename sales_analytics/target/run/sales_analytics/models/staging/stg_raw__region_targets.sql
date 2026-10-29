
  create or replace   view ANALYTICS.STAGING.stg_raw__region_targets
  
   as (
    select
    region,
    year,
    sales_target
from analytics.raw.region_targets
  );

