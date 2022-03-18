-- {{ config(materialized='incremental') }}

{%- set source_model = "primed_deputy_schedule_report"   -%}
{%- set src_pk = "SCHEDULE_HK" -%}
{%- set src_nk = ["LOCATION_CODE","SCHEDULE_DATE","SCHEDULE_START_TIME","SCHEDULE_END_TIME","DISPLAY_NAME","AREA_NAME","ROSTER_SORT_ORDER"] -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}