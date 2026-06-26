
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select MANAGER_ID
from SALES.STAGE_dimensions.dim_employees
where MANAGER_ID is null



  
  
      
    ) dbt_internal_test