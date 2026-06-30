# enterprise_analytics — dbt project standards

Snowflake dbt project, layered: **staging → dimensions / facts**. These are the
repository standards used for both local development and automated PR review.

## Modeling & structure
- **Naming:** staging = `stg_`, dimensions = `dim_`, facts = `fct_`.
- **Layering:** staging is the *only* layer that may select from `source()`.
  Every downstream model must use `ref()`. Never hardcode database/schema/table names.
- **Materialization** must match the layer config in `dbt_project.yml`
  (staging = `view`, dimensions = `table`, facts = `table`). Flag overrides that look wrong.
- **Incremental models:** require a correct `unique_key`, a sound `is_incremental()`
  filter, and an appropriate `on_schema_change`.

## SQL correctness
- Watch for join fan-out / grain changes that could duplicate rows.
- Build surrogate keys with `dbt_utils.generate_surrogate_key`, not ad-hoc concatenation.
- No `SELECT *` in persisted models.
- Date logic should respect the vars `date_spine_start` / `date_spine_end` where relevant.

## Tests & docs
- Every new or changed model has a matching `.yml` with a `description` and at least
  `not_null` + `unique` (or a valid composite key) on the grain column.
- Sources and refs used in tests must actually exist.

## SQL style (enforced by `.sqlfluff`, Snowflake dialect)
- lowercase keywords, functions, and identifiers
- explicit table and column aliases
- trailing commas
- CTEs instead of subqueries
- max line length 140
