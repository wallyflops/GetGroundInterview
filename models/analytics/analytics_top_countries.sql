with referrals as (
select
    -- format_date("%b-%Y", created_at) as formatted
    rc.sales_contact_country
,   count( case when is_outbound = 1 then rc.referral_id end ) as num_of_outbound_referrals
,   count( case when is_outbound = 0 then rc.referral_id end ) as num_of_inbound_referrals
from
    {{ref('base_referrals_core')}} rc
group by
    1
)
, add_more_refs as (
select  
    sales_contact_country
 ,  num_of_outbound_referrals
 ,  num_of_inbound_referrals
 ,  num_of_outbound_referrals + num_of_inbound_referrals as total_referrals
from    referrals
)
select  sales_contact_country
,   num_of_outbound_referrals
,   num_of_inbound_referrals
,   total_referrals
,   dense_rank() over (order by total_referrals desc) as ranked
from    add_more_refs 