-- {{ config(enable=false) }}

{{ config(materialized='pit_incremental') }}

{%- set yaml_metadata -%}
source_model: hub_worker
src_pk: WORKER_HK
src_ldts: LOAD_DATE
as_of_dates_table: "as_of_date"
satellites: 
  sat_paycom_worker_city_state_zip:
    pk:
      PK: WORKER_HK
    ldts:
      LDTS: LOAD_DATE
  sat_paycom_worker_position_detail:
    pk:
      PK: WORKER_HK
    ldts:
      LDTS: LOAD_DATE
  sat_paycom_worker:
    pk:
      PK: WORKER_HK
    ldts:
      LDTS: LOAD_DATE
  sat_vetspire_worker_detail:
    pk:
      PK: WORKER_HK
    ldts:
      LDTS: LOAD_DATE
stage_tables: 
  primed_paycom_stg_employees: LOAD_DATE
  primed_paycom_employee_extra_data: LOAD_DATE
  primed_vetspire_stg_providers: LOAD_DATE
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

                