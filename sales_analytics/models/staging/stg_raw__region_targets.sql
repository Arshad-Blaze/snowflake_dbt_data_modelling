select
    region,
    year,
    sales_target
from {{ source('raw', 'region_targets') }}