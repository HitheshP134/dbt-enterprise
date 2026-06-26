
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select PRODUCT_ID
from SALES.STAGE_dimensions.dim_products
where PRODUCT_ID is null



  
  
      
    ) dbt_internal_test