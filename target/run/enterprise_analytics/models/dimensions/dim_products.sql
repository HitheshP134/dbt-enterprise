
  
    



create or replace transient  table SALES.STAGE_dimensions.dim_products
    
    
    
    
    as (with products as (
    select * from SALES.STAGE_stage.stg_products
),

final as (
    select
        -- surrogate key
        md5(cast(coalesce(cast(product_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as product_key,

        -- natural key
        product_id,

        -- descriptive attributes
        product_name,
        category,
        subcategory,
        billing_type,

        -- pricing
        unit_price,
        cost_price,
        gross_margin_amount,
        gross_margin_pct,
        case
            when gross_margin_pct >= 0.70 then 'High Margin'
            when gross_margin_pct >= 0.50 then 'Medium Margin'
            else 'Low Margin'
        end as margin_band,

        -- lifecycle
        is_active,
        launched_date,
        case
            when not is_active then 'Discontinued'
            when billing_type = 'annual_license'       then 'Recurring'
            when billing_type = 'monthly_subscription' then 'Recurring'
            when billing_type = 'annual_contract'      then 'Recurring'
            else 'Non-Recurring'
        end as revenue_type
    from products
)

select * from final
    )
;



  