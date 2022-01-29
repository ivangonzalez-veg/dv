-- {{ config(materialized='incremental') }}

{%- set source_model = "primed_vetspire_orders"   -%}
{%- set src_pk = "SALE_HK" -%}
{%- set src_nk = ["COLLISION_KEY", "SALE_ID"] -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}