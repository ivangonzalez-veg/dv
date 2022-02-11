{{ config(enable=false)}}


--{{ config(materialized='pit_incremental') }}

{%- set yaml_metadata -%}
source_model: hub_worker
src_pk: WORKER_HK
src_ldts: LOAD_DATE
as_of_dates_table: AS_OF_DATE
satellites: 
  SAT_PAYCOM_WORKER_CITY_STATE_ZIP:
    pk:
      PK: WORKER_HK
    ldts:
      LDTS: LOAD_DATE
  SAT_PAYCOM_WORKER_POSITION_DETAIL:
    pk:
      PK: WORKER_HK
    ldts:
      LDTS: LOAD_DATE
  SAT_PAYCOM_VETSPIRE_WORKER_DETAIL:
    pk:
      PK: WORKER_HK
    ldts:
      LDTS: LOAD_DATE
  SAT_PAYCOM_WORKER:
    pk:
      PK: WORKER_HK
    ldts:
      LDTS: LOAD_DATE
stage_tables: 
  PRIMED_PAYCOM_STG_EMPLOYEES: LOAD_DATE
  PRIMED_PAYCOM_EMPLOYEE_EXTRA_DATA: LOAD_DATE
  PRIMED_VETSPIRE_STG_PROVIDERS: LOAD_DATE
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{% set source_model = metadata_dict['source_model'] %}
{% set src_pk = metadata_dict['src_pk'] %}
{% set as_of_dates_table = metadata_dict['as_of_dates_table'] %}
{% set satellites = metadata_dict['satellites'] %}
{% set stage_tables = metadata_dict['stage_tables'] %}
{% set src_ldts = metadata_dict['src_ldts'] %}

{{ dbtvault.pit(source_model=source_model, src_pk=src_pk,
                as_of_dates_table=as_of_dates_table,
                satellites=satellites,
                stage_tables=stage_tables,
                src_ldts=src_ldts) }}

                */