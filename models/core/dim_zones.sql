{{ config(materialized='table') }}


select 
    locationid, 
    borough, 
    zone, 
    replace(service_zone,'Boro','Green') as service_zone
from {{ ref('taxi_zone_lookup') }}

{% if var('is_test_run', default=false) %}

  limit 100

{% endif %}