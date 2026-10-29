select
    order_key,
    line_number,
    net_revenue
from {{ ref('fct_order_lines') }}
where net_revenue < 0