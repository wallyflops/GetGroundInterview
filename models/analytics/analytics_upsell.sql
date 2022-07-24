select
    format_date("%b-%Y", created_at) as formatted
,   rc.partner_type
,   count(referral_id) as referrals
from
    {{ref('base_referrals_core')}} rc
where
    is_outbound = 1
group by
    1, 2
order by
    1, 2