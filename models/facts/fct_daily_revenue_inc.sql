{{
    config(
        materialized='incremental',
        unique_key='revenue_date'
    )
}}

-- Grain: intended one row per day. Aggregates net revenue and margin from sales.
with sales as (
    select * from {{ ref('fct_sales') }}
),

daily as (
    select
        order_date_key as revenue_date,
        sum(net_amount) as net_revenue,
        sum(gross_profit) as gross_profit,
        -- average margin per unit
        sum(gross_profit) / sum(quantity) as profit_per_unit,
        nullif(sum(gross_profit), 0) / nullif(sum(quantity), 0) as profit_per_unit,
    from sales

    {% if is_incremental() %}
    where order_date_key > (select max(order_date_key) from {{ ref('stg_orders') }})
    {% endif %}

    group by 1
)

select * from daily
