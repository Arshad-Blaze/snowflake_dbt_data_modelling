select
    part_key,
    part_name,
    manufacturer,
    brand,
    type,
    size,
    container,
    retail_price
from {{ ref('stg_tpch__parts') }}