-- {{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: 
  raw_staging: "vetspire_stg_locations"
derived_columns:
  LOCATION_NAME: 'NAME'
  LOAD_DATE: 'TO_TIMESTAMP_NTZ(CURRENT_TIMESTAMP())'
  EFFECTIVE_FROM: 'INSERTED_AT'
  RECORD_SOURCE: '!VETSPIRE'
hashed_columns:
  LOCATION_HK: 
    - 'LOCATION_NAME'
  LOCATION_DETAIL_HASHDIFF:
    is_hashdiff: true
    exclude_columns: true
    columns:
      - 'LOCATION_NAME'
      - 'UPDATED_AT'
      - 'INSERTED_AT'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.stage(include_source_columns=true,
                  source_model=metadata_dict['source_model'],
                  derived_columns=metadata_dict['derived_columns'],
                  hashed_columns=metadata_dict['hashed_columns'],
                  ranked_columns=none) }}

                  