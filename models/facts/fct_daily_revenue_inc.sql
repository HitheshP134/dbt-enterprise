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
    select * from {{ ref('fct_sales') }}
),

daily as (
    select
        order_date_key as revenue_date,
        sum(net_amount) as net_revenue,
        sum(gross_profit) as gross_profit,
        -- average margin per unit
        nullif(sum(gross_profit), 0) / nullif(sum(quantity), 0) as profit_per_unit,
    from sales

    {% if is_incremental() %}
    where order_date_key > (select max(order_date_key) from {{ ref('stg_orders') }})
    {% endif %}

    group by 1
)

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
