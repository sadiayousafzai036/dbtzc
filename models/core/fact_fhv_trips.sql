{{ config(materialized='table') }}

with fhvdata as (
    select *, 
        'Fhv' as service_type 
    from {{ ref('stg_fhv') }}
), 


dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select 
    dispatching_base_num, 
    pickup_datetime,
    dropoff_datetime,
    PULocationID,
    DOLocationID,
    SR_Flag
from fhvdata
inner join dim_zones as pickup_zone
on PULocationID = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on DOLocationID = dropoff_zone.locationid

{% if var('is_test_run', default=false) %}

  limit 100

{% endif %}