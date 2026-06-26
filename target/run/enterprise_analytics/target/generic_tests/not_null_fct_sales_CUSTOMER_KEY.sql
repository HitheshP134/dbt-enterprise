
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select CUSTOMER_KEY
from SALES.STAGE_stage.fct_sales
where CUSTOMER_KEY is null



  
  
      
    ) dbt_internal_test