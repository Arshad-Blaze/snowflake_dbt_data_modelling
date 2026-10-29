select
    l.order_key,
    l.part_key,
    l.line_number,
    o.customer_key,
    o.order_date,
    o.order_status,
    l.quantity,
    l.extended_price,
    l.discount,
    l.extended_price * (1 - l.discount) as net_revenue,
    c.region_name,
    c.nation_name
from {{ ref('stg_tpch__lineitems') }} l
join {{ ref('stg_tpch__orders') }} o on l.order_key = o.order_key
join {{ ref('int_customers_with_region') }} c on o.customer_key = c.customer_key