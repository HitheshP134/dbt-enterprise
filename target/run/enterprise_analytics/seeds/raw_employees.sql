 -- noqa: Should accept a string instead of a integer
    
    
    ;
    -- dbt seed --
    
            insert overwrite into SALES.STAGE.raw_employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, DEPARTMENT, TITLE, REGION, MANAGER_ID, HIRE_DATE, IS_ACTIVE) values
            (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s),(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
        

;
  