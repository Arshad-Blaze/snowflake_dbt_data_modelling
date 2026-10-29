
  
    

        create or replace transient table ANALYTICS.MARTS.dim_customers
         as
        (select
    customer_key,
    customer_name,
    address,
    phone,
    account_balance,
    market_segment,
    nation_name,
    region_name
from ANALYTICS.INTERMEDIATE.int_customers_with_region
        );
      
  