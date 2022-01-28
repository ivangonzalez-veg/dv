{{ config(materialized='incremental') }}

{%- set source_model = "calpro_staging_calpronps" -%}
{%- set src_pk = "SURVEY_LOCATION_HK" -%}
{%- set src_fk = ["SURVEY_HK", "LOCATION_HK"] -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}