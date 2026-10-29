select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select region_name
from ANALYTICS.MARTS.dim_regions
where region_name is null



      
    ) dbt_internal_test