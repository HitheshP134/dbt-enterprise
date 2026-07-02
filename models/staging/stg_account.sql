with source as (
    select * from {{ source('raw', 'raw_customers') }}
),

renamed as (
    select
        customer_id as account_id,
        company_name as account_name,
        industry as account_industry,
        segment as account_segment,
        city as account_city,
        state as account_state,
        country as account_country,
        account_owner_id,
        unit_annual_value as account_unit_annual_value,
        status as account_status,
        created_at::date as account_created_date,
        updated_at::date as account_updated_date,
        coalesce(status = 'active', false) as is_active
    from source
)

select
   *
from renamed
