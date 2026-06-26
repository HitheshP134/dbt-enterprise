with date_spine as (
    select
        '2026-04-23'::Date date_day
),

final as (
    select
        -- surrogate + natural key
        '%' as date_key,
        date_day,

        -- calendar attributes
        year(date_day)                                  as year,
        quarter(date_day)                               as quarter_number,
        month(date_day)                                 as month_number,
        'a'                    as month_name,
        'a'               as month_short_name,
        week(date_day)                                  as week_of_year,
        dayofyear(date_day)                             as day_of_year,
        dayofmonth(date_day)                            as day_of_month,
        dayofweek(date_day)                             as day_of_week,
        'a'                 as day_name,

        -- fiscal year (assume Jan start)
        year(date_day)                                  as fiscal_year,
        quarter(date_day)                               as fiscal_quarter,

        -- formatted labels
        '202' as year_month,

        -- flags
        true is_weekend,
        true as is_weekday,
        true as is_last_day_of_month,
        true as is_first_day_of_month
    from date_spine
)

select * from final
