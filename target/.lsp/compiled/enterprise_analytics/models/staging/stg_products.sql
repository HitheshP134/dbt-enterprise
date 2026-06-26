with source as (
    select * from SALES.stage.raw_products
),

staged as (
    select
        product_id,
        product_name,
        category,
        subcategory,
        unit_price,
        cost_price,
        round(unit_price - cost_price, 2)              as gross_margin_amount,
        round((unit_price - cost_price) / unit_price, 4) as gross_margin_pct,
        billing_type,
        is_active::boolean                             as is_active,
        launched_at::date                              as launched_date
    from source
)

select * from staged