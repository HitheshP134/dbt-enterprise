
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select EMPLOYEE_ID
from SALES.STAGE_stage.stg_employees
where EMPLOYEE_ID is null



  
  
      
    ) dbt_internal_test