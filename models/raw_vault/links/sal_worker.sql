{{ config(materialized='incremental') }}

{%- set source_model = "primed_vetspire_stg_providers" -%}
{%- set src_pk = "SAL_WORKER_HK" -%}
{%- set src_fk = ["PAYROLL_HK", "VETSPIRE_HK"] -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}