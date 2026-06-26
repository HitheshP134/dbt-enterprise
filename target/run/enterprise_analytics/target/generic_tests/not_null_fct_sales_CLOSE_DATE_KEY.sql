
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select CLOSE_DATE_KEY
from SALES.STAGE_stage.fct_sales
where CLOSE_DATE_KEY is null



  
  
      
    ) dbt_internal_test