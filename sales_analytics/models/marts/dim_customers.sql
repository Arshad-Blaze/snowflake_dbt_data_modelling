select
    customer_key,
    customer_name,
    address,
    phone,
    account_balance,
    market_segment,
    nation_name,
    region_name
from {{ ref('int_customers_with_region') }}