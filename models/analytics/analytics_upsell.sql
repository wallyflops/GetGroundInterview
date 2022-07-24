select
    format_date("%b-%Y", created_at) as formatted
,   count(referral_id) as referrals
from
    {{ref('base_referrals_core')}} rc
where
    is_outbound = 1
group by
    1