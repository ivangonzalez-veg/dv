-- {{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: "primed_paycom_stg_employees"
src_pk: "WORKER_HK"
src_hashdiff: "WORKER_CITY_STATE_ZIP_HASHDIFF"
src_payload:
  - "CITY"
  - "STATE"
  - "ZIPCODE"
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