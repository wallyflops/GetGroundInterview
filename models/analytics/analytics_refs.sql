with final as (
select
    referral_id
,   created_at
,   updated_at
,   status
,   created_at - updated_at as calc_time
from
    {{ref('base_referrals_core')}} rc
where
    status <> 'pending'
)
select  *
,   extract(hour from calc_time) as calc_time
from    final
where   calc_time > '0-0 0 0 0:0:0'