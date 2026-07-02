with source as (
    select * from {{ source('raw', 'raw_employees') }}
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
