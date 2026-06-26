 -- noqa: Should accept a string instead of a integer
    
    
    ;
    -- dbt seed --
    
            insert overwrite into SALES.STAGE.raw_products (PRODUCT_ID, PRODUCT_NAME, CATEGORY, SUBCATEGORY, UNIT_PRICE, COST_PRICE, BILLING_TYPE, IS_ACTIVE, LAUNCHED_AT) values
            (%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s)
        

;
  