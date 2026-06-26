
  create or replace   view SALES.STAGE_stage.stg_customers
  
    
    
(
  
    "CUSTOMER_ID" COMMENT $$Unique identifier for the customer.$$, 
  
    "COMPANY_NAME" COMMENT $$Name of the customer company.$$, 
  
    "INDUSTRY" COMMENT $$Industry vertical the customer operates in.$$, 
  
    "SEGMENT" COMMENT $$Market segment classification of the customer.$$, 
  
    "CITY" COMMENT $$City where the customer is located.$$, 
  
    "STATE" COMMENT $$State or province where the customer is located.$$, 
  
    "COUNTRY" COMMENT $$Country where the customer is located.$$, 
  
    "ACCOUNT_OWNER_ID" COMMENT $$Unique identifier for the account owner responsible for this customer.$$, 
  
    "UNIT_ANNUAL_VALUE" COMMENT $$Annual contract value for the customer account.$$, 
  
    "STATUS" COMMENT $$Current status of the customer account.$$, 
  
    "CREATED_DATE" COMMENT $$Date when the customer record was created.$$, 
  
    "UPDATED_DATE" COMMENT $$Date when the customer record was last updated.$$, 
  
    "IS_ACTIVE" COMMENT $$Boolean flag indicating whether the customer account is currently active.$$
  
)

  
  
  
  as (
    with source as (
    select * from SALES.stage.raw_customers
),

staged as (
    select
        customer_id,
        company_name,
        industry,
        segment,
        city,
        state,
        country,
        account_owner_id,
        unit_annual_value,
        status,
        created_at::date as created_date,
        updated_at::date as updated_date,
        case
            when status = 'active' then true
            else false
        end as is_active
    from source
)

select * from staged
  );

