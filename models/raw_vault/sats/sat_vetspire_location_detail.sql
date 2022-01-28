-- {{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: "primed_vetspire_stage_locations"
src_pk: "LOCATION_HK"
src_hashdiff: "LOCATION_DETAIL_HASHDIFF"
src_payload:
  - "ADDRESS"
  - "ID"
  - "INTACCT_CASH_ACCOUNT"
  - "INTACCT_ENTITY_ID"
  - "INTACCT_LOCATION_ID"
  - "IS_ACTIVE"
  - "IS_TEST"
  - "OPEN_DATE"
  - "TIME_ZONE"
  - "UPDATED_AT"
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