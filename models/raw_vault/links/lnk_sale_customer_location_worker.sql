{{ config(materialized='incremental') }}

{%- set source_model = "primed_vetspire_orders" -%}
{%- set src_pk = "SALE_CUSTOMER_LOCATION_WORKER_HK" -%}  
{%- set src_fk = ["SALE_HK" , "CUSTOMER_HK", "LOCATION_HK", "WORKER_HK"] -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}