with final as (
select
    referral_id
,   created_at
,   updated_at
,   status
,   updated_at - created_at  as calc_time
from
    {{ref('base_referrals_core')}} rc
where
    status <> 'pending'
)
select  
    referral_id
,   extract(hour from calc_time) as calc_time_hours
from    final

where extract(hour from calc_time) > 0
order by 2 desc
