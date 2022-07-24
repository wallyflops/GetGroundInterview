select
--    *,
    r.referral_id
,   r.created_at
,   r.updated_at
,   r.company_id
,   r.partner_id
,   r.consultant_id
,   r.status
,   r.is_outbound
,   p.partner_type
,   p.lead_sales_contact
,   sp.country as sales_contact_country
from
    {{ref('landing_referrals')}} r
    inner join {{ref('landing_partners')}} p on p.partner_id = r.partner_id
    inner join {{ref('landing_sales_people')}} sp on p.lead_sales_contact = sp.name