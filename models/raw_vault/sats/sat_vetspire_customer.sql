-- {{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: "primed_vetspire_stg_clients"
src_pk: "CUSTOMER_HK"
src_hashdiff: "CUSTOMER_DETAIL_HASHDIFF"
src_payload:
  - "ACCOUNT_CREDIT"
  - "CLIENT_REFERRAL_SOURCE_NAME"
  - "EMAIL"
  - "EMAIL_VERIFIED_DATE"
  - "FAMILY_NAME"
  - "GIVEN_NAME"
  - "IS_ACTIVE"
  - "NAME"
  - "SENT_EMAIL_VERIFICATIONDATE"
  - "UPDATED_AT"
  - "DECLINE_RDVM"
  - "LAST_NAME"
  - "FIRST_NAME"
src_eff: "INSERTED_AT"
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