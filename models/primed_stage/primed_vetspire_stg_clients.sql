-- {{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: 
  raw_staging: "vetspire_stg_clients"
derived_columns:
  CUSTOMER_ID: 'ID'
  LAST_NAME: 'FAMILY_NAME'
  FIRST_NAME: 'GIVEN_NAME'
  LOAD_DATE: 'TO_TIMESTAMP_NTZ(CURRENT_TIMESTAMP())'
  EFFECTIVE_FROM: 'INSERTED_AT'
  RECORD_SOURCE: '!VETSPIRE_STG_CLIENTS'
  COLLISION_KEY: '!VETSPIRE_CUSTOMER'
hashed_columns:
  CUSTOMER_HK: 
    - 'COLLISION_KEY'
    - 'CUSTOMER_ID'
  CUSTOMER_DETAIL_HASHDIFF:
    is_hashdiff: true
    exclude_columns: true
    columns:
      - 'COLLISION_KEY'
      - 'CUSTOMER_ID'
      - 'LOAD_DATE'
      - 'EFFECTIVE_FROM'
      - 'INSERTED_AT'
      - 'ID'
      - 'UPDATED_AT'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.stage(include_source_columns=true,
                  source_model=metadata_dict['source_model'],
                  derived_columns=metadata_dict['derived_columns'],
                  hashed_columns=metadata_dict['hashed_columns'],
                  ranked_columns=none) }}
