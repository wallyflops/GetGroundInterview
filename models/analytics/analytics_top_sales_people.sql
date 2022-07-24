with referrals as (
select
    -- format_date("%b-%Y", created_at) as formatted
    rc.lead_sales_contact
,   count( referral_id) as num_of_referrals
from
    {{ref('base_referrals_core')}} rc
group by
    1
)
select  
    lead_sales_contact
,   num_of_referrals
,   row_number() over(order by num_of_referrals desc) as ranking
from    referrals
    