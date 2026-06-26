-- Grain: one row per sales order line.
-- Enterprise metrics: bookings, revenue, discount analysis, rep performance.
with orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select customer_key, customer_id, segment, industry, revenue_tier, country
    from {{ ref('dim_customers') }}
),

products as (
    select product_key, product_id, category, subcategory, revenue_type, cost_price, gross_margin_pct
    from {{ ref('dim_products') }}
),

employees as (
    select employee_key, employee_id, region, seniority_band
    from {{ ref('dim_employees') }}
),

order_date as (
    select date_key, date_day, year, quarter_number, month_number, year_month
    from {{ ref('dim_date') }}
),

close_date as (
    select date_key as close_date_key, date_day as close_date_day
    from {{ ref('dim_date') }}
),

final as (
    select
        -- surrogate key
        {{ dbt_utils.generate_surrogate_key(['o.order_id']) }} as sales_key,

        -- natural key
        o.order_id,

        -- foreign keys to dimensions
        c.customer_key,
        p.product_key,
        e.employee_key,
        od.date_key                     as order_date_key,
        cd.close_date_key,

        -- degenerate dimensions
        o.status,
        o.payment_method,
        o.is_won,

        -- additive measures — bookings
        o.quantity,
        o.unit_price,
        o.discount_pct,
        o.discount_amount,
        o.gross_amount,
        o.net_amount,

        -- derived measures — profitability
        round(p.cost_price * o.quantity, 2)                          as total_cost,
        round(o.net_amount - (p.cost_price * o.quantity), 2)         as gross_profit,
        round(
            (o.net_amount - (p.cost_price * o.quantity)) / nullif(o.net_amount, 0),
            4
        )                                                             as gross_profit_pct,

        -- semi-additive context (for slicing)
        c.segment                        as customer_segment,
        c.industry,
        c.revenue_tier,
        c.country,
        p.category                       as product_category,
        p.subcategory                    as product_subcategory,
        p.revenue_type,
        e.region                         as sales_region,
        od.year                          as order_year,
        od.quarter_number                as order_quarter,
        od.month_number                  as order_month,
    
        od.year_month

    from orders o
    inner join customers  c  on o.customer_id  = c.customer_id
    inner join products   p  on o.product_id   = p.product_id
    inner join employees  e  on o.employee_id  = e.employee_id
    inner join order_date od on o.order_date   = od.date_day
    inner join close_date cd on o.close_date   = cd.close_date_day
)

select * from final
