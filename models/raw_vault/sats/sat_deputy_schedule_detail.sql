-- {{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: "primed_deputy_schedule_report"
src_pk: "SCHEDULE_HK"
src_hashdiff: "SCHEDULE_DETAIL_HASHDIFF"
src_payload:
  - "LOCATION_NAME"
  - "FIRST_NAME"
  - "LAST_NAME"
  - "POSITION"
  - "AREA_EXPORT_CODE"
  - "CODE"
  - "EMPLOYED"
  - "SCHEDULE_COST"
  - "SCHEDULE_CREATED"
  - "SCHEDULE_MEAL_BREAK_TOTAL"
  - "SCHEDULE_MEAL_BREAK_DURATION_ONLY"
  - "SCHEDULE_MODIFIED"
  - "SCHEDULE_NOTES"
  - "SCHEDULE_OPEN"
  - "SCHEDULE_PUBLISHED"
  - "SCHEDULE_TOTAL_TIME"
  - "EMPLOYEE_MODIFIED"
  - "START_DATE"
  - "GENDER"
  - "DATE_OF_BIRTH"
  - "TERMINATION_DATE"
  - "SHOW_ON_ROSTER"
  - "AREA_MODIFIED"
  - "AREA_CREATED"
  - "ACCESS_LEVEL_NAME"
  - "STRESS_PROFILE_NAME"
  - "EMAIL"
  - "PHONE"
  - "ACTIVE"
  - "IS_WORKPLACE"
  - "IS_PAY_CENTER"
  - "COMPANY_CREATED"
  - "COMPANY_MODIFIED"
  - "SCHEDULE_REST_BREAK_TOTAL"
  - "SCHEDULE_REST_BREAK_SCHEDULED"
  - "SCHEDULE_MEAL_BREAK_SCHEDULED"
  - "SCHEDULE_REST_BREAK_DURATION_ONLY"
  - "SCHEDULE_WARNING"
  - "EMPLOYEE_LOCATION_NAME"
  - "LOADED_ON"
src_eff: "EFFECTIVE_FROM"
src_ldts: "LOAD_DATE"
src_source: "RECORD_SOURCE"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.sat(src_pk=metadata_dict["src_pk"],
                src_hashdiff=metadata_dict["src_hashdiff"],
                src_payload=metadata_dict["src_payload"],
                src_eff=metadata_dict["src_eff"],
                src_ldts=metadata_dict["src_ldts"],
                src_source=metadata_dict["src_source"],
                source_model=metadata_dict["source_model"]) }}