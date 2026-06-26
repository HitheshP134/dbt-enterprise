with customers as (
    select * from {{ ref('stg_customers') }}
),

final as (
    select
        -- surrogate key
        {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_key,

        -- natural key
        customer_id,

        -- descriptive attributes
        company_name,
        industry,
        segment,
        city,
        state,
        country,
        city || ', ' || state as location,

        -- account health
        status,
        is_active,
        unit_annual_value,
        case
            when unit_annual_value >= 200000 then 'Tier 1'
            when unit_annual_value >= 75000  then 'Tier 2'
            else 'Tier 3'
        end as revenue_tier,

        -- foreign key to employee dim
        account_owner_id,

        -- audit
        created_date,
        updated_date
    from customers
)

select * from final
