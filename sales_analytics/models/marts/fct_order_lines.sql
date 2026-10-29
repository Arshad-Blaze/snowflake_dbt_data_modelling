{{
    config(
        materialized='incremental',
        unique_key=['order_key', 'line_number']
    )
}}

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
from {{ ref('int_order_lines_enriched') }}

{% if is_incremental() %}
  where order_date >= (select max(order_date) from {{ this }})
{% endif %}