-- {{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: 
  raw_staging: "calpro_staging_calpronps"
derived_columns:
  LOCATION_NAME: 'SITE_NAME'
  DOCTOR_FIRST_NAME: '!TO_BE_CHANGED'
  DOCTOR_LAST_NAME: '!TO_BE_CHANGED'
  SURVEY_ID: 'RESPONSE_ID'
  LOAD_DATE: 'TO_TIMESTAMP_NTZ(CURRENT_TIMESTAMP())'
  EFFECTIVE_FROM: 'DATE_COMPLETED'
  RECORD_SOURCE: '!CALPRO'
  COLLISION_KEY: '!CALPRO'
hashed_columns:
  SURVEY_HK: 
    - 'COLLISION_KEY'
    - 'SURVEY_ID'
  LOCATION_HK: 
    - 'LOCATION_NAME'
  SURVEY_DETAIL_HASHDIFF:
    is_hashdiff: true
    exclude_columns: true
    columns:
      - 'RESPONSE_ID'
      - 'SITE_NAME'
  LOCATION_DETAIL_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'SITE_NAME'
  SURVEY_LOCATION_HK:
    - 'COLLISION_KEY'
    - 'SURVEY_ID'
    - 'LOCATION_NAME'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.stage(include_source_columns=true,
                  source_model=metadata_dict['source_model'],
                  derived_columns=metadata_dict['derived_columns'],
                  hashed_columns=metadata_dict['hashed_columns'],
                  ranked_columns=none) }}

                  