
  create or replace   view SALES.STAGE_stage.stg_employees
  
    
    
(
  
    "EMPLOYEE_ID" COMMENT $$Unique identifier for the employee.$$, 
  
    "FIRST_NAME" COMMENT $$First name of the employee.$$, 
  
    "LAST_NAME" COMMENT $$Last name of the employee.$$, 
  
    "FULL_NAME" COMMENT $$Concatenated first and last name of the employee.$$, 
  
    "EMAIL" COMMENT $$Email address of the employee in lowercase.$$, 
  
    "DEPARTMENT" COMMENT $$Department the employee belongs to.$$, 
  
    "TITLE" COMMENT $$Job title of the employee.$$, 
  
    "REGION" COMMENT $$Geographic region the employee is assigned to.$$, 
  
    "MANAGER_ID" COMMENT $$Unique identifier for the employee's manager.$$, 
  
    "HIRE_DATE" COMMENT $$Date when the employee was hired.$$, 
  
    "IS_ACTIVE" COMMENT $$Boolean flag indicating whether the employee is currently active.$$
  
)

  
  
  
  as (
    with source as (
    select * from SALES.stage.raw_employees
),

staged as (
    select
        employee_id,
        first_name,
        last_name,
        first_name || ' ' || last_name as full_name,
        lower(email)                    as email,
        department,
        title,
        region,
        manager_id,
        hire_date::date                 as hire_date,
        is_active::boolean              as is_active
    from source
)

select * from staged
  );

