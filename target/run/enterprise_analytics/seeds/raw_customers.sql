 -- noqa: Should accept a string instead of a integer
    
    
    ;
    -- dbt seed --
    
            insert overwrite into SALES.STAGE.raw_customers (CUSTOMER_ID, COMPANY_NAME, INDUSTRY, SEGMENT, CITY, STATE, COUNTRY, ACCOUNT_OWNER_ID, UNIT_ANNUAL_VALUE, STATUS, CREATED_AT, UPDATED_AT) values
            (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
        

;
  