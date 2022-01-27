-- {{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: "calpro_staging_calpronps"
src_pk: "SURVEY_HK"
src_hashdiff: "SURVEY_DETAIL_HASHDIFF"
src_payload:
  - "DOCTOR_FIRST_NAME"
  - "DOCTOR_LAST_NAME"
  - "COMPLIMENTS"
  - "EMAIL_ADDRESS"
  - "ZIP_CODE"
  - "CUSTOM_QUESTION"
  - "DOC_SEEN"
  - "ADDRESS2"
  - "CHECK_OUT"
  - "DAY_OF_WEEK"
  - "INVITE_EMAIL"
  - "SHARE_COMMENTS"
  - "ZIP_CODE_LONG"
  - "FIRST_NAME"
  - "WEEK_OF"
  - "PROGRAM_ID"
  - "ADDRESS1"
  - "COMMUNICATION_DOCTOR"
  - "COURTESY_TECHNICIAN"
  - "COMMUNICATION_STUDENT"
  - "COURTESY_RECEPTIONIST"
  - "USER_IP"
  - "CALL_BY_NAME"
  - "COURTESY_DOCTOR"
  - "MULTI_DOC"
  - "SERVICE_CATEGORY"
  - "PUNCTUALITY"
  - "CHECK_IN"
  - "NPS_CATEGORY"
  - "PRIMARY_DOC"
  - "PROFESSIONALISM_PHONE"
  - "RESPONSE_MONTH"
  - "RESPONSE_MONTH_NUM"
  - "COURTESY_STUDENT"
  - "RECEIVE_EMAILS"
  - "CLEANLINESS_TEAM"
  - "DESIRED_APPOINTMENT"
  - "FACILITY_APPEARANCE"
  - "NPS_REFER"
  - "OVERALL_VALUE"
  - "PET_TYPE"
  - "RESPONSE_QUARTER"
  - "SERVICES"
  - "SURVEY_DATE"
  - "CITY"
  - "COMMUNICATION_STAFF"
  - "LAST_NAME"
  - "REPORT_PERIOD"
  - "COMMENTS"
  - "DATE_COMPLETED"
  - "PET_NAME"
  - "STATE_TERR"
  - "CASE_ID"
  - "COMPASSION_TEAM"
  - "REF_ID"
  - "RESPONSE_YEAR"
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