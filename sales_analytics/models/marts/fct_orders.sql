select
    o.order_key,
    o.customer_key,
    o.order_date,
    o.order_status,
    o.total_price,
    o.order_priority,
    o.clerk,
    o.ship_priority,
    count(l.line_number) as total_line_items,
    sum(l.net_revenue) as order_net_revenue
from {{ ref('stg_tpch__orders') }} o
left join {{ ref('int_order_lines_enriched') }} l on o.order_key = l.order_key
group by 1, 2, 3, 4, 5, 6, 7, 8
