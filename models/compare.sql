create or replace view VEG.REPORTING.BUXTON_CLIENTS_DOGBYTE_TEST(
	CLIENT_ID,
	ADDR_LINE1,
	ADDR_LINE2,
	CITY,
	STATE,
	ZIP_CODE,
	FIRST_NAME,
	LAST_NAME,
	PHONE_NUMBER,
	EMAIL_ADDRESS,
	DECLINE_RDVM,
	REFERRAL_SOURCE,
	RDVM_ID,
	RDVM,
	UPDATED_AT,
	FILE_LOAD_DATE
) as
WITH clients AS
(select     distinct 
	CUSTOMER_ID CLIENT_ID,
	ADDRESS_LINE1 ADDR_LINE1,
	ADDRESS_LINE2 ADDR_LINE2,
	CITY,
	STATE,
	ZIPCODE ZIP_CODE,
    
	FIRST_NAME,
	LAST_NAME,
	PHONE_NUMBER,
	EMAIL EMAIL_ADDRESS,
	DECLINE_RDVM,
    
	REFERRAL_SOURCE
from VEG.REPORTING.V_DWH_ORDER_ITEMS) --select c1.* from c1;
-- client and count rdvm records
,R_LIST AS
(
select distinct       CUSTOMER_ID   CLIENT_ID,
            COUNT(RDVM_ID) over (partition by CUSTOMER_ID) RDVM_CNT2
    ,   CASE
                    WHEN NVL(RDVM_CNT2,0) = 0 THEN 'NONE'
                    WHEN NVL(RDVM_CNT2,0) = 1 THEN RDVM_ID::text
                    WHEN NVL(RDVM_CNT2,0) > 1 THEN 'MULTIPLE'
          END RDVM_ID2,
          CASE
                    WHEN NVL(RDVM_CNT2,0) = 0 THEN 'NONE'
                    WHEN NVL(RDVM_CNT2,0) = 1 THEN RDVM_NAME
                    WHEN NVL(RDVM_CNT2,0) > 1 THEN 'MULTIPLE'
          END RDVM2
         FROM     VEG_DWH.RAW_VAULT.SAT_VETSPIRE_CLIENTS_RDVM_DETAILS
) 
--select c1.* from   c1 where c1.client_id in(72116450,80002101,    3037539);
--select * from r_list  where client_id in(72116450,80002101,    3037539);
, output as (
select distinct
          NVL(RDVM_ID2,'NONE') RDVM_id ,
          NVL(RDVM2,'NONE') RDVM ,c1.*
FROM      clients C1
LEFT JOIN R_LIST
ON        C1.CLIENT_ID = R_LIST.CLIENT_ID
) --select rdvm,* from output;
    , unmask as (
    select   nvl(CLIENT_ID::text, ' ')|| ' ' CLIENT_ID, 
                nvl(ADDR_LINE1::text, ' ')|| ' ' ADDR_LINE1, 
                nvl(ADDR_LINE2::text, ' ')|| ' ' ADDR_LINE2, 
                nvl(CITY::text, ' ')|| ' ' CITY, 
                nvl(STATE::text, ' ')|| ' ' STATE, 
                nvl(ZIP_CODE::text, ' ')|| ' ' ZIP_CODE, 
                nvl(FIRST_NAME::text, ' ')|| ' ' FIRST_NAME, 
                nvl(LAST_NAME::text, ' ')|| ' ' LAST_NAME, 
                nvl(PHONE_NUMBER::text, ' ')|| ' ' PHONE_NUMBER, 
                nvl(EMAIL_ADDRESS::text, ' ')|| ' ' EMAIL_ADDRESS, 
                nvl(DECLINE_RDVM::text, ' ')|| ' ' DECLINE_RDVM, 
                nvl(REFERRAL_SOURCE::text, ' ')|| ' ' REFERRAL_SOURCE, 
                nvl(RDVM_ID::text, ' ')|| ' ' RDVM_ID, 
                nvl(RDVM::text, ' ')|| ' ' RDVM, 
            convert_timezone('UTC','America/New_York', sysdate()) Updated_at,
            convert_timezone('UTC','America/New_York', sysdate()) file_load_date
        from output
        union
         select   	nvl(CLIENT_ID::text, ' ')|| ' ' CLIENT_ID, 
                nvl(ADDR_LINE1::text, ' ')|| ' ' ADDR_LINE1, 
                nvl(ADDR_LINE2::text, ' ')|| ' ' ADDR_LINE2, 
                nvl(CITY::text, ' ')|| ' ' CITY, 
                nvl(STATE::text, ' ')|| ' ' STATE, 
                nvl(ZIP_CODE::text, ' ')|| ' ' ZIP_CODE, 
                nvl(FIRST_NAME::text, ' ')|| ' ' FIRST_NAME, 
                nvl(LAST_NAME::text, ' ')|| ' ' LAST_NAME, 
                nvl(PHONE_NUMBER::text, ' ')|| ' ' PHONE_NUMBER, 
                nvl(EMAIL_ADDRESS::text, ' ')|| ' ' EMAIL_ADDRESS, 
                nvl(DECLINE_RDVM::text, ' ')|| ' ' DECLINE_RDVM, 
                nvl(REFERRAL_SOURCE::text, ' ')|| ' ' REFERRAL_SOURCE, 
                nvl(RDVM_ID::text, ' ')|| ' ' RDVM_ID, 
                nvl(RDVM::text, ' ')|| ' ' RDVM, 
                	UPDATED_AT,
                	FILE_LOAD_DATE
        from veg_dwh.bv.dogbyte_buxton_clients

        
        )
        select * from unmask;