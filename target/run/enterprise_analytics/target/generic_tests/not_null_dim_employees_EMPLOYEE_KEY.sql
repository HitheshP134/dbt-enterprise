
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select EMPLOYEE_KEY
from SALES.STAGE_dimensions.dim_employees
where EMPLOYEE_KEY is null



  
  
      
    ) dbt_internal_test