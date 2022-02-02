-- {{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: "primed_vetspire_orders"
src_pk: "SALE_HK"
src_hashdiff: "SALE_DETAIL_HASHDIFF"
src_payload:
  - "EFFECTIVE_FROM"
  - "DW_SOURCE"
  - "APPLIEDCOUPONS"
  - "CLIENT_ID"
  - "COUPON_ID"
  - "DATETIME"
  - "DISCOUNT"
  - "DISCOUNTTYPE"
  - "ENCOUNTERS"
  - "ESTIMATE_ID"
  - "FLAGS"
  - "HISTORICALID"
  - "INSERTEDAT"
  - "INVOICEREFERENCE"
  - "INVOICED"
  - "INVOICEDAT"
  - "ISACCOUNTCREDIT"
  - "ISCREDIT"
  - "ISNOTRENDERED"
  - "ITEMS"
  - "LOCATIONID"
  - "NOTE"
  - "PATIENTS"
  - "PAYMENTDUE"
  - "PAYMENTS"
  - "POSTED"
  - "PROVIDER_ID"
  - "STATUS"
  - "STATUSCHANGEAT"
  - "SUBTOTAL"
  - "TAXRATE"
  - "TOTAL"
  - "TOTALCOUPONDISCOUNT"
  - "TOTALDISCOUNTED"
  - "TOTALMEMBERDISCOUNT"
  - "TOTALNOTRENDERED"
  - "TOTALPAID"
  - "TOTALTAX"
  - "UPDATEDAT"
  - "SALE_ID"

src_eff: "DW_INSERTED_AT"
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