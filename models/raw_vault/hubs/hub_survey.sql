-- {{ config(materialized='incremental') }}

{%- set source_model = "calpro_staging_calpronps"   -%}
{%- set src_pk = "SURVEY_HK" -%}
{%- set src_nk = ["SURVEY_ID", "COLLISION_KEY"] -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}