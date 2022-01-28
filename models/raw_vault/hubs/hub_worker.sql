-- {{ config(materialized='incremental') }}

{%- set source_model = ["primed_vetspire_stg_providers"] -%}
{%- set src_pk = "WORKER_HK" -%}
{%- set src_nk = ["COLLISION_KEY", "WORKER_ID"] -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}