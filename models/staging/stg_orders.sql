with source as (
    select * from {{ source('raw', 'raw_orders') }}
),

staged as (
    select
        order_id,
        order_date::date                                        as order_date,
        close_date::date                                        as close_date,
        customer_id,
        employee_id,
        product_id,
        quantity,
        unit_price,
        discount_pct,
        round(unit_price * (1 - discount_pct), 2)              as net_unit_price,
        round(unit_price * quantity, 2)                         as gross_amount,
        round(unit_price * quantity * (1 - discount_pct), 2)   as net_amount,
        round(unit_price * quantity * discount_pct, 2)          as discount_amount,
        status,
        payment_method,
        case when status = 'won' then true else false end        as is_won
    from source
)

select * from staged
