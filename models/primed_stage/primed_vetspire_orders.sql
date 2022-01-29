-- {{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: 
  raw_staging: "vetspire_orders"
derived_columns:
  SALE_ID: 'ID'
  CUSTOMER_ID: 'CLIENT_ID'
  WORKER_ID: 'PROVIDER_ID'
  LOAD_DATE: 'TO_TIMESTAMP_NTZ(CURRENT_TIMESTAMP())'
  EFFECTIVE_FROM: 'DW_INSERTED_AT'
  RECORD_SOURCE: '!VETSPIRE_ORDERS'
  COLLISION_KEY: '!VETSPIRE'
  COLLISION_KEY_PROVIDER: '!VETSPIRE_PROVIDER'
hashed_columns:
  SALE_HK: 
    - 'COLLISION_KEY'
    - 'SALE_ID'
  CUSTOMER_HK: 
    - 'COLLISION_KEY'
    - 'CUSTOMER_ID'
  WORKER_HK: 
    - 'COLLISION_KEY_PROVIDER'
    - 'WORKER_ID'
  LOCATION_HK: 
    - 'LOCATION_NAME'
  SALE_DETAIL_HASHDIFF:
    is_hashdiff: true
    exclude_columns: true
    columns:
      - 'COLLISION_KEY'
      - 'SALE_ID'
      - 'LOAD_DATE'
      - 'EFFECTIVE_FROM'
      - 'ID'
      - 'UPDATED_AT'
      - 'DW_INSERTED_AT'
      - 'DW_SOURCE'
      - 'PAYLINK'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.stage(include_source_columns=true,
                  source_model=metadata_dict['source_model'],
                  derived_columns=metadata_dict['derived_columns'],
                  hashed_columns=metadata_dict['hashed_columns'],
                  ranked_columns=none) }}
