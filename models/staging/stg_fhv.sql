{{ config(materialized='view') }}

with fhvdata as 
(
select
    dispatching_base_num as dispatching_base_num,
    -- timestamps
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropoff_datetime as timestamp) as dropoff_datetime,
    
    cast(PULocationID as integer) as PULocationID,
    cast(DOLocationID as integer) as DOLocationID,
    SR_Flag as SR_Flag
   
from {{ source('staging','external_table_fhv') }}
)

select * from fhvdata

-- dbt build --m <model.sql> --var 'is_test_run: false'
{% if var('is_test_run', default=false) %}

  limit 100

{% endif %}