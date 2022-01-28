-- {{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: "primed_paycom_employee_extra_data"
src_pk: "WORKER_HK"
src_hashdiff: "WORKER_DETAIL_HASHDIFF"
src_payload:
  - "EMPLOYEE_NAME"
  - "DEPARTMENT"
  - "DEPARTMENT_DESC"
  - "LOCATIONS_CODE"
  - "LOCATIONS_DESC"
  - "POSITION"
  - "WORK_LOCATION"
  - "GENDER"
  - "AGE"
  - "LENGTH_OF_SERVICE_SINCE_HIRE"
  - "HIRE_DATE"
  - "REHIRE_DATE"
  - "TERMINATION_DATE"
  - "TERMINATION_REASON"
  - "TERMINATION_TYPE"
  - "SUPERVISOR_PRIMARY"
  - "SUPERVISOR_PRIMARY_CODE"
  - "BUSINESS_TITLE"
  - "JOB_DESCRIPTION_TEXT"
  - "KEY_POSITION"
  - "POSITION_CODE"
  - "POSITION_FAMILY"
  - "POSITION_LEVEL"
  - "POSITION_TITLE"
  - "SALARY_GRADE"
  - "EMPLOYEE_STATUS"
  - "WORK_EMAIL"
  - "VACCINATED"
  - "LAST_NAME"
  - "FIRST_NAME"
  - "MIDDLE_NAME"
src_eff: "CREATED_ON"
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