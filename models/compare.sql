create or replace view VEG.REPORTING.BUXTON_LOCATIONS(
	MASTER_LOCATION_ID,
	NAME,
	CODE,
	ORIGINATION,
	OPEN_DATE,
	TRANSITION_DATE,
	SWITCH_24_HR_DATE,
	SQ_FOOTAGE,
	SF_CLINICAL,
	REGION,
	ADDRESS1,
	ADDRESS2,
	CITY,
	STATE,
	ZIP_CODE,
	PHONE,
	ACTIVE,
	CAGES,
	TX_TABLES,
	STANDALONE,
	NEW_CONSTRUCTION,
	UPDATED_AT,
	FILE_LOAD_DATE
) as
with l as (
    SELECT a.location_master_id MASTER_LOCATION_ID,
       a.location_agg_name name,
       a.code,
       b.origination,
       a.open_date,
       c.transition_date,
       a.switch_24_hr_date,
       a.total_sq_ft SQ_FOOTAGE,
       c.sf_clinical,
       a.region,
       b.address ADDRESS1,
       b.suite ADDRESS2,
       b.CITY,
       b.STATE,
       b.ZIP_CODE,
            trim( replace(
        replace(
             replace(
                replace(b.PHONE,'(','')
             ,')','') 
            ,'-','') 
            ,' ','')
             )PHONE,
       a.ACTIVE,
       b.CAGES,
       b.TX_TABLES,
       b.STANDALONE,
       b.NEW_CONSTRUCTION
FROM   veg_dwh.information_mart_Stage.dim_location_master_stage a
       LEFT JOIN VEG.REF.MASTER_LOCATION_ADDRESS b
              ON a.location_master_id = b.master_location_id
       LEFT JOIN VEG.stage_prep.buxton_location_one_time_20230110 c
              ON a.location_master_id = c.master_location_id
 )
 , ll as 
 (select distinct  master_location_id from VEG.REPORTING.BUXTON_CASES_REV
 ---*** start commented out as per request from buxton.. only locations in w/ sales
   	-- union
	--  select location_master_id from veg_dwh.information_mart_Stage.dim_location_master_stage where active and not test_location
 ---*** end commented out as per request from buxton.. only locations in w/ sales
 )
 , source_data as (
 select l.* from l 
 inner join ll
    on ll.MASTER_LOCATION_ID = l.MASTER_LOCATION_ID)
   -- select * from source_data;
    SELECT 
        nvl(nullif(MASTER_LOCATION_ID::text  ,''), ' ')|| ' '::text MASTER_LOCATION_ID  , 
        nvl(nullif(NAME  ,''), ' ')|| ' '::text NAME  , 
        nvl(nullif(CODE  ,''), ' ')|| ' '::text CODE  , 
        nvl(nullif(ORIGINATION  ,''), ' ')|| ' '::text ORIGINATION  , 
        nvl(nullif(OPEN_DATE::text  ,''), ' ')|| ' '::text OPEN_DATE  , 
        nvl(nullif(TRANSITION_DATE::text  ,''), ' ')|| ' '::text TRANSITION_DATE  , 
        nvl(nullif(SWITCH_24_HR_DATE::text  ,''), ' ')|| ' '::text SWITCH_24_HR_DATE  , 
        nvl(nullif(SQ_FOOTAGE::text  ,''), ' ')|| ' '::text SQ_FOOTAGE  , 
        nvl(nullif(SF_CLINICAL::text  ,''), ' ')|| ' '::text SF_CLINICAL  , 
        nvl(nullif(REGION  ,''), ' ')|| ' '::text REGION  , 
        nvl(nullif(ADDRESS1  ,''), ' ')|| ' '::text ADDRESS1  , 
        nvl(nullif(ADDRESS2  ,''), ' ')|| ' '::text ADDRESS2  , 
        nvl(nullif(CITY  ,''), ' ')|| ' '::text CITY  , 
        nvl(nullif(STATE  ,''), ' ')|| ' '::text STATE  ,  
    
         nvl(nullif(ZIP_CODE  ,''), ' ')|| ' '::text   ZIP_CODE  , 
    
        nvl(nullif(PHONE  ,''), ' ')|| ' '::text PHONE  , 
        nvl(nullif(ACTIVE::text  ,''), ' ')|| ' '::text ACTIVE  , 
        nvl(nullif(CAGES  ,''), ' ')|| ' '::text CAGES  , 
        nvl(nullif(TX_TABLES  ,''), ' ')|| ' '::text TX_TABLES  , 
        nvl(nullif(STANDALONE  ,''), ' ')|| ' '::text STANDALONE  , 
        nvl(nullif(NEW_CONSTRUCTION,''), ' ')|| ' '::text NEW_CONSTRUCTION, 
        convert_timezone('UTC','America/New_York', sysdate()) Updated_at,
        convert_timezone('UTC','America/New_York', sysdate())  file_load_date 
    FROM source_data
 
    ;