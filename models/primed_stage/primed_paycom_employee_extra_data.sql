-- {{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: 
  raw_staging: "paycom_employee_extra_data"
derived_columns:
  LAST_NAME: 'LEGAL_LAST_NAME'
  FIRST_NAME: 'LEGAL_FIRST_NAME'
  MIDDLE_NAME: 'LEGAL_MIDDLE_NAME'
  WORKER_ID: 'EMPLOYEE_CODE'
  MASKED_UID: 'UID'
  LOAD_DATE: 'TO_TIMESTAMP_NTZ(CURRENT_TIMESTAMP())'
  EFFECTIVE_FROM: 'TO_TIMESTAMP_NTZ(CURRENT_TIMESTAMP())'
  RECORD_SOURCE: '!PAYCOM_EMPLOYEE_EXTRA_DATA'
  COLLISION_KEY: '!PAYCOM'
hashed_columns:
  WORKER_HK: 
    - 'COLLISION_KEY'
    - 'WORKER_ID'
  WORKER_PII_DETAIL_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'LAST_NAME'
      - 'FIRST_NAME'
      - 'MIDDLE_NAME'
      - 'EMPLOYEE_NAME'
      - 'UID'
      - 'DOB'
  WORKER_POSITION_DETAIL_HASHDIFF:
    is_hashdiff: true
    exclude_columns: true
    columns:
      - 'WORKER_ID'
      - 'EMPLOYEE_CODE'
      - 'LOAD_DATE'
      - 'LAST_NAME'
      - 'FIRST_NAME'
      - 'MIDDLE_NAME'
      - 'LEGAL_LAST_NAME'
      - 'LEGAL_FIRST_NAME'
      - 'LEGAL_MIDDLE_NAME'
      - 'EMPLOYEE_NAME'
      - 'UID'
      - 'DOB'
      - 'EFFECTIVE_FROM'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.stage(include_source_columns=true,
                  source_model=metadata_dict['source_model'],
                  derived_columns=metadata_dict['derived_columns'],
                  hashed_columns=metadata_dict['hashed_columns'],
                  ranked_columns=none) }}
