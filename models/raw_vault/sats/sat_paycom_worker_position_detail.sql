-- {{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: "primed_paycom_employee_extra_data"
src_pk: "WORKER_HK"
src_hashdiff: "WORKER_POSITION_DETAIL_HASHDIFF"
src_payload:
  - "DEPARTMENT"
  - "DEPARTMENT_DESC"
  - "PRIMARY_PHONE"
  - "PRIMARY_PHONE_TYPE"
  - "PERSONAL_EMAIL"
  - "WORK_LOCATION"
  - "HIRE_DATE"
  - "POSITION_CODE"
  - "POSITION_FAMILY"
  - "POSITION_LEVEL"
  - "POSITION_TITLE"
  - "POSITION_TYPE"
  - "EMPLOYEE_TYPE"
  - "HOME_LOCATION"
  - "LEVEL"
  - "COVID_VACCINATED"
  - "CSV_FILE_NAME"
  - "EXTRACT_FILE_NAME"
  - "TERMINATION_DATE"
  - "TERMINATION_REASON"
  - "TERMINATION_TYPE"
  - "RATE_1"
  - "STATUS"
  - "EMPLOYEE_STATUS"
  - "CREATED_BY"
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