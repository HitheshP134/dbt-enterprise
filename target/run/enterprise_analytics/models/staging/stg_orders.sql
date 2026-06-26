
  create or replace   view SALES.STAGE_stage.stg_orders
  
    
    
(
  
    "ORDER_ID" COMMENT $$Unique identifier for the order.$$, 
  
    "ORDER_DATE" COMMENT $$Date when the order was placed.$$, 
  
    "CLOSE_DATE" COMMENT $$Date when the order was closed.$$, 
  
    "CUSTOMER_ID" COMMENT $$Unique identifier for the customer associated with this order.$$, 
  
    "EMPLOYEE_ID" COMMENT $$Unique identifier for the employee who handled this order.$$, 
  
    "PRODUCT_ID" COMMENT $$Unique identifier for the product sold in this order.$$, 
  
    "QUANTITY" COMMENT $$Number of units ordered.$$, 
  
    "UNIT_PRICE" COMMENT $$List price per unit before discounts.$$, 
  
    "DISCOUNT_PCT" COMMENT $$Discount percentage applied to the order.$$, 
  
    "NET_UNIT_PRICE" COMMENT $$Unit price after discount is applied.$$, 
  
    "GROSS_AMOUNT" COMMENT $$Total order amount before discounts.$$, 
  
    "NET_AMOUNT" COMMENT $$Total order amount after discounts.$$, 
  
    "DISCOUNT_AMOUNT" COMMENT $$Total monetary discount applied to the order.$$, 
  
    "STATUS" COMMENT $$Current status of the order.$$, 
  
    "PAYMENT_METHOD" COMMENT $$Payment method used for the order.$$, 
  
    "IS_WON" COMMENT $$Boolean flag indicating whether the order was won.$$
  
)

  
  
  
  as (
    with source as (
    select * from SALES.stage.raw_orders
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
  );

