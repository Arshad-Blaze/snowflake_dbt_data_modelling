with line_sums as (
    select
        order_key,
        sum(extended_price) as calculated_gross
    from {{ ref('fct_order_lines') }}
    group by 1
),

orders as (
    select
        order_key,
        total_price
    from {{ ref('stg_tpch__orders') }}
)

select
    o.order_key,
    o.total_price,
    l.calculated_gross
from orders o
join line_sums l on o.order_key = l.order_key
-- TPC-H orders.total_price includes tax, so we allow a variance tolerance up to 20%
where abs(o.total_price - l.calculated_gross) / nullif(o.total_price, 0) > 0.20