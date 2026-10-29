
  
    

        create or replace transient table ANALYTICS.MARTS.fct_order_lines
         as
        (

select
    order_key,
    part_key,
    customer_key,
    line_number,
    order_date,
    order_status,
    quantity,
    extended_price,
    discount,
    net_revenue,
    region_name,
    nation_name
from ANALYTICS.INTERMEDIATE.int_order_lines_enriched


        );
      
  