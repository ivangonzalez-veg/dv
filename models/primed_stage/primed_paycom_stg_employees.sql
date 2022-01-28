-- {{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: 
  raw_staging: "paycom_stg_employees"
derived_columns:
  WORKER_ID: 'EMPLOYEE_CODE'
  LAST_NAME: 'EMPLOYEE_NAME'
  FIRST_NAME: 'EMPLOYEE_NAME'
  MIDDLE_NAME: 'EMPLOYEE_NAME'
  LOAD_DATE: 'TO_TIMESTAMP_NTZ(CURRENT_TIMESTAMP())'
  EFFECTIVE_FROM: 'TO_TIMESTAMP_NTZ(CURRENT_TIMESTAMP())'
  RECORD_SOURCE: '!PAYCOM_STG_EMPLOYEES'
  COLLISION_KEY: '!PAYCOM_EMPLOYEE'
hashed_columns:
  WORKER_HK: 
    - 'COLLISION_KEY'
    - 'WORKER_ID'
  WORKER_DETAIL_HASHDIFF:
    is_hashdiff: true
    exclude_columns: true
    columns:
      - 'WORKER_ID'
      - 'EMPLOYEE_CODE'
      - 'LOAD_DATE'
      - 'CITY'
      - 'STATE'
      - 'ZIPCODE'
      - 'EFFECTIVE_FROM'
  WORKER_CITY_STATE_ZIP_HASHDIFF:
    is_hashdiff: true
    exclude_columns: false
    columns:
      - 'CITY'
      - 'STATE'
      - 'ZIPCODE'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.stage(include_source_columns=true,
                  source_model=metadata_dict['source_model'],
                  derived_columns=metadata_dict['derived_columns'],
                  hashed_columns=metadata_dict['hashed_columns'],
                  ranked_columns=none) }}
