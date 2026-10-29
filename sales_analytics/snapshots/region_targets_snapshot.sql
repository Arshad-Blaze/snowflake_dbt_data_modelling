{% snapshot region_targets_snapshot %}

{{
    config(
      target_database='analytics',
      target_schema='marts',
      unique_key="region || '-' || year",
      strategy='check',
      check_cols=['sales_target'],
    )
}}

select
    region,
    year,
    sales_target
from {{ ref('stg_raw__region_targets') }}

{% endsnapshot %}