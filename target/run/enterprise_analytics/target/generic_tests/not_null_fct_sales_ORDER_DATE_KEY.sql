
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select ORDER_DATE_KEY
from SALES.STAGE_stage.fct_sales
where ORDER_DATE_KEY is null



  
  
      
    ) dbt_internal_test