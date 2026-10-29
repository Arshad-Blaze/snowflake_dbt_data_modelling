select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with all_values as (

    select
        order_status as value_field,
        count(*) as n_records

    from ANALYTICS.RAW_marts.fct_order_lines
    group by order_status

)

select *
from all_values
where value_field not in (
    'O','F','P'
)



      
    ) dbt_internal_test