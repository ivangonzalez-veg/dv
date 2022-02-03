-- {{ config(materialized='incremental') }}

{%- set source_model = ["primed_extra_vetspire_stg_providers", "primed_paycom_employee_extra_data", "primed_paycom_stg_employees"] -%}
{%- set src_pk = "WORKER_HK" -%}
{%- set src_nk = ["COLLISION_KEY", "WORKER_ID"] -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}