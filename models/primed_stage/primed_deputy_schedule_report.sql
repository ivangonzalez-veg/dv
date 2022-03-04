-- {{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: 
  raw_staging: "deputy_schedule_report"
derived_columns:
  LOAD_DATE: 'TO_TIMESTAMP_NTZ(CURRENT_TIMESTAMP())'
  EFFECTIVE_FROM: 'LOADED_ON'
  RECORD_SOURCE: '!DEPUTY_SCHEDULE_REPORT'
  COLLISION_KEY: '!DEPUTY'
hashed_columns:
  SCHEDULE_HK: 
    - 'LOCATION_CODE'
    - 'SCHEDULE_DATE'
    - 'SCHEDULE_START_TIME'
    - 'SCHEDULE_END_TIME'
    - 'DISPLAY_NAME'
    - 'AREA_NAME'
    - 'ROSTER_SORT_ORDER'
  SURVEY_DETAIL_HASHDIFF:
    is_hashdiff: true
    exclude_columns: true
    columns:
      - 'LOCATION_CODE'
      - 'SCHEDULE_DATE'
      - 'SCHEDULE_START_TIME'
      - 'SCHEDULE_END_TIME'
      - 'DISPLAY_NAME'
      - 'AREA_NAME'
      - 'ROSTER_SORT_ORDER'
      - 'SCHEDULE_CREATED'
      - 'AREA_CREATED'
      - 'COMPANY_CREATED'
      - 'LOADED_ON'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.stage(include_source_columns=true,
                  source_model=metadata_dict['source_model'],
                  derived_columns=metadata_dict['derived_columns'],
                  hashed_columns=metadata_dict['hashed_columns'],
                  ranked_columns=none) }}
