
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select SALES_KEY
from SALES.STAGE_stage.fct_sales
where SALES_KEY is null



  
  
      
    ) dbt_internal_test