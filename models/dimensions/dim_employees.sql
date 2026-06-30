with employees as (
    select * from {{ ref('stg_employees') }}
),

-- self-join to resolve manager name
with_manager as (
    select
        e.employee_id,
        e.full_name,
        e.email,
        e.department,
        e.title,
        e.region,
        e.hire_date,
        e.is_active,
        e.manager_id,
        m.full_name as manager_name,
        case
            when e.title like '%VP%' then 'Leadership'
            when e.title like '%Chief%' then 'Executive'
            when e.title like 'Senior%' then 'Senior IC'
            else 'IC'
        end as seniority_band
    from employees as e
    left join employees as m on e.manager_id = m.employee_id
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['employee_id']) }} as employee_key,
        employee_id,
        full_name,
        email,
        department,
        title,
        seniority_band,
        region,
        manager_id,
        manager_name,
        hire_date,
        is_active
    from with_manager
)

select * from final
