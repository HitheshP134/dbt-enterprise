-- Grain: one row per (order_date, customer_segment, product_category, sales_region).
-- Pre-aggregated for BI dashboard performance on enterprise revenue KPIs.
with sales as (
    select * from SALES.STAGE_stage.fct_sales
    where is_won = true
),

aggregated as (
    select
        -- grain keys
        order_date_key,
        customer_segment,
        product_category,
        revenue_type,
        sales_region,
        order_year,
        order_quarter,
        order_month,
        year_month,

        -- volume metrics
        count(distinct order_id) as deal_count,
        count(distinct customer_key) as unique_customers,
        sum(quantity) as total_units_sold,

        -- revenue metrics
        round(sum(gross_amount), 2) as total_gross_revenue,
        round(sum(discount_amount), 2) as total_discounts,
        round(sum(net_amount), 2) as total_net_revenue,
        round(avg(net_amount), 2) as avg_deal_size,

        -- profitability metrics
        round(sum(gross_profit), 2) as total_gross_profit,
        round(avg(gross_profit_pct), 4) as avg_gross_margin_pct,

        -- discount metrics
        round(avg(discount_pct), 4) as avg_discount_pct,
        round(sum(discount_amount) / nullif(sum(gross_amount), 0), 4) as effective_discount_rate

    from sales
    group by
        order_date_key,
        customer_segment,
        product_category,
        revenue_type,
        sales_region,
        order_year,
        order_quarter,
        order_month,
        year_month
),

with_running_totals as (
    select
        *,
        round(
            sum(total_net_revenue) over (
                partition by customer_segment, product_category, order_year
                order by order_date_key
                rows between unbounded preceding and current row
            ),
            2
        ) as ytd_net_revenue,

        round(
            sum(total_net_revenue) over (
                partition by customer_segment, product_category, order_year, order_quarter
                order by order_date_key
                rows between unbounded preceding and current row
            ),
            2
        ) as qtd_net_revenue
    from aggregated
)

select * from with_running_totals