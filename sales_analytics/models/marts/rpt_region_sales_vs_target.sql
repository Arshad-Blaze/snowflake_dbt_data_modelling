with actuals as (
    select
        region_name as region,
        extract(year from order_date) as year,
        sum(net_revenue) as actual_revenue
    from {{ ref('fct_order_lines') }}
    group by 1, 2
),

targets as (
    select
        region,
        year,
        sales_target
    from {{ ref('stg_raw__region_targets') }}
)

select
    coalesce(a.region, t.region) as region,
    coalesce(a.year, t.year) as year,
    coalesce(a.actual_revenue, 0) as actual_revenue,
    coalesce(t.sales_target, 0) as sales_target,
    actual_revenue - sales_target as variance,
    case 
        when sales_target > 0 then (actual_revenue / sales_target) * 100 
        else 0 
    end as achievement_pct
from actuals a
full outer join targets t on a.region = t.region and a.year = t.year