
  create or replace   view SALES.STAGE_stage.stg_products
  
    
    
(
  
    "PRODUCT_ID" COMMENT $$Unique identifier for the product.$$, 
  
    "PRODUCT_NAME" COMMENT $$Name of the product.$$, 
  
    "CATEGORY" COMMENT $$Top-level category the product belongs to.$$, 
  
    "SUBCATEGORY" COMMENT $$Subcategory within the product category.$$, 
  
    "UNIT_PRICE" COMMENT $$List price per unit of the product.$$, 
  
    "COST_PRICE" COMMENT $$Cost price per unit of the product.$$, 
  
    "GROSS_MARGIN_AMOUNT" COMMENT $$Monetary difference between unit price and cost price.$$, 
  
    "GROSS_MARGIN_PCT" COMMENT $$Gross margin as a percentage of unit price.$$, 
  
    "BILLING_TYPE" COMMENT $$Billing method used for the product.$$, 
  
    "IS_ACTIVE" COMMENT $$Boolean flag indicating whether the product is currently active.$$, 
  
    "LAUNCHED_DATE" COMMENT $$Date when the product was launched.$$
  
)

  
  
  
  as (
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
  );

