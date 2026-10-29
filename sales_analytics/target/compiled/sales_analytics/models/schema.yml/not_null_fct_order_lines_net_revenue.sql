select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select net_revenue
from ANALYTICS.MARTS.fct_order_lines
where net_revenue is null



      
    ) dbt_internal_test