
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select ACCOUNT_OWNER_ID
from SALES.STAGE_stage.stg_customers
where ACCOUNT_OWNER_ID is null



  
  
      
    ) dbt_internal_test