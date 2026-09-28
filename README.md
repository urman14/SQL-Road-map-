# SQL Practice

My journey learning SQL for data engineering, one session at a time.

## Progress

### Day 1 — SQL Basics
- `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`
- Filtering with `AND` / `OR` and parentheses
- `BETWEEN`, `IN`, `LIKE` with wildcards
- First aggregation with `COUNT(*)`

See [`day01_sql_basics.sql`](day01_sql_basics.sql).

### Day 2 — GROUP BY and Aggregations
- `GROUP BY` to summarize rows into groups
- Aggregate functions: `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- `HAVING` to filter groups (vs `WHERE`, which filters rows)
- `DISTINCT` and `ROUND`
- Clause order: `WHERE` → `GROUP BY` → `HAVING` → `ORDER BY`

See [`day02_group_by.sql`](day02_group_by.sql).

### Day 3 — JOINs
- `INNER JOIN` and `LEFT JOIN` across related tables
- Handling `NULL` and hunting orphan records with `LEFT JOIN ... IS NULL`
- `CROSS JOIN` and `SELF JOIN` (employee → manager)
- Combining JOINs with `GROUP BY` for cross-table aggregation

See [`day03_joins.sql`](day03_joins.sql).

## Tools
- SQLite (practice), with plans to move into a cloud warehouse and dbt.

## Next up
- Subqueries and window functions
- Python (pandas + running SQL from code)
