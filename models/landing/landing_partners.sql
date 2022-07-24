with partners as (
select
  id as partner_id
, created_at
, updated_at
, partner_type
, lead_sales_contact
from {{ source('getground', 'partners')}}
)
select * from partners