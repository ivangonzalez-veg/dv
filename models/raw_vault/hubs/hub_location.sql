-- {{ config(materialized='incremental') }}

{%- set source_model = ["primed_calpro_staging_calpronps", "primed_seed_locations", "primed_vetspire_stg_locations"] -%}
{%- set src_pk = "LOCATION_HK" -%}
{%- set src_nk = "LOCATION_NAME" -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}