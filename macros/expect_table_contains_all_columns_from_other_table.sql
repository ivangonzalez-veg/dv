{% test expect_table_contains_all_columns_from_other_table(model, src_database, src_table_name, tgt_database, tgt_table_name) %}

WITH
src_table AS (
    SELECT COLUMN_NAME
    FROM "{{src_database}}"."INFORMATION_SCHEMA"."COLUMNS"
    WHERE TABLE_NAME = '{{src_table_name}}'
),
tgt_table AS (
    SELECT COLUMN_NAME
    FROM "{{tgt_database}}"."INFORMATION_SCHEMA"."COLUMNS"
    WHERE TABLE_NAME = '{{tgt_table_name}}'
),
combine AS (
    SELECT *
    FROM tgt_table AS t
    FULL OUTER JOIN src_table AS s
        ON t.COLUMN_NAME = s.COLUMN_NAME
    WHERE t.COLUMN_NAME IS NULL
)
SELECT * FROM combine

{% endtest %}