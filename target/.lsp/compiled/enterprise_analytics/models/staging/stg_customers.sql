with source as (
    select * from SALES.stage.raw_customers
),

staged as (
    select
        customer_id,
        company_name,
        industry,
        segment,
        city,
        state,
        country,
        account_owner_id,
        unit_annual_value,
        status,
        created_at::date as created_date,
        updated_at::date as updated_date,
        case
            when status = 'active' then true
            else false
        end as is_active
    from source
)

select * from staged