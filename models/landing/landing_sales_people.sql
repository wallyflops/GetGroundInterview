with people as (
select
  name
, country
from {{ source('getground', 'sales_people')}}
)
select * from people