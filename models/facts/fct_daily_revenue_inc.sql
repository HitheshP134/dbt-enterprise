{{
    config(
        materialized='incremental',
        unique_key='revenue_date',
        on_schema_change='fail'
    )
}}

-- Grain: intended one row per day. Aggregates net revenue and margin from sales.
with sales as (
    select
        order_date_key,
        net_amount,
        gross_profit,
        quantity
    from {{ ref('fct_sales') }}
),
),
),
        nullif(sum(gross_profit), 0) / nullif(sum(quantity), 0) as profit_per_unit
    select
        order_date_key as revenue_date,
        sum(net_amount) as net_revenue,
    where order_date_key > (select max(order_date_key) from {{ this }})
        -- average margin per unit
        nullif(sum(gross_profit), 0) / nullif(sum(quantity), 0) as profit_per_unit
        nullif(sum(gross_profit), 0) / nullif(sum(quantity), 0) as profit_per_unit
    from sales

    {% if is_incremental() %}
    where order_date_key > (select max(revenue_date) from {{ this }})
    {% endif %}

    group by 1
)
    count(distinct order_id) as order_count
select
    revenue_date,
    net_revenue,
    gross_profit,
    revenue_date,
    net_revenue,
    gross_profit,
    profit_per_unit,
    count(*) as order_count
    order_count
from daily
