select
    c.customer_key,
    c.customer_name,
    c.address,
    c.phone,
    c.account_balance,
    c.market_segment,
    n.nation_name,
    r.region_name
from {{ ref('stg_tpch__customers') }} c
join {{ ref('stg_tpch__nations') }} n on c.nation_key = n.nation_key
join {{ ref('stg_tpch__regions') }} r on n.region_key = r.region_key 