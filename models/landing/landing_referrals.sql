with referrals as (
  select
    id as referral_id
  , timestamp_micros(cast(created_at/1000 as int64)) as created_at
  , timestamp_micros(cast(updated_at/1000 as int64)) as updated_at
   , 'baseket' as t
  , company_id
  , partner_id
  , consultant_id
  , status
  , is_outbound
  from {{ source('getground','referrals') }}
)
select * from referrals
