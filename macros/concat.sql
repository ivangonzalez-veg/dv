{% macro concat(fields) -%}
  {{ return(adapter.dispatch('concat', 'dbt_utils')(fields)) }}
{%- endmacro %}

{% macro default__concat(fields) -%}
    select concat_ws('||',{{ fields}})
{%- endmacro %}


{% macro add_(fields) -%}
    select concat_ws('||',{{ fields}})
{%- endmacro %}

