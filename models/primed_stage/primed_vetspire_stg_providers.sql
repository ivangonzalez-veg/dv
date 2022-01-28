-- {{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: 
  raw_staging: "vetspire_stg_providers"
derived_columns:
  LAST_NAME: 'FAMILY_NAME'
  FIRST_NAME: 'GIVEN_NAME'
  WORKER_ID: 'ID'
  LOAD_DATE: 'TO_TIMESTAMP_NTZ(CURRENT_TIMESTAMP())'
  EFFECTIVE_FROM: 'INSERTED_AT'
  RECORD_SOURCE: '!VETSPIRE_STG_PROVIDERS'
  COLLISION_KEY: '!VETSPIRE_PROVIDER'
hashed_columns:
  WORKER_HK: 
    - 'COLLISION_KEY'
    - 'WORKER_ID'
  WORKER_DETAIL_HASHDIFF:
    is_hashdiff: true
    exclude_columns: true
    columns:
      - 'WORKER_ID'
      - 'LOAD_DATE'
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
