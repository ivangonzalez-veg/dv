create or replace view VEG.REPORTING.BUXTON_SALES(
	MASTER_LOCATION_ID,
	LOCATION_NAME,
	DATE,
	REVENUE,
	CASES,
	ACT,
	UPDATED_AT,
	FILE_LOAD_DATE
) as
WITH DD AS (
SELECT DATE_VALUE FROM VEG_DWH.INFORMATION_MART.DIM_DATE WHERE YEAR_NUMBER >= 2020 AND DAY_OF_MONTH_NUMBER = 1
    )
, LOC AS 
( SELECT  A.master_location_id, B.LOCATION_AGG_NAME LOCATION_NAME
from VEG.REPORTING.BUXTON_CASES_REV A
 INNER JOIN VEG_DWH.INFORMATION_MART.DIM_LOCATION_MASTER B
    ON A.MASTER_LOCATION_ID = B.LOCATION_MASTER_ID
 GROUP BY A.master_location_id, B.LOCATION_AGG_NAME
 
 
)
, DD_LOC AS 
( SELECT DD.DATE_VALUE,  LOC.master_location_id, LOC.LOCATION_NAME FROM LOC cross JOIN DD 
)
,  source_data AS (
select DD_LOC.master_location_id , DD_LOC.location_name ,DD_LOC.DATE_VALUE date
    , sum (A.REVENUE) REVENUE
    , count(A.REVENUE) CASES 
    , sum (A.REVENUE) / count(A.REVENUE) ACT
from VEG.REPORTING.BUXTON_CASES_REV A
right JOIN  DD_LOC
    ON DD_LOC.DATE_VALUE = A.FOM
        AND DD_LOC.master_location_id = A.master_location_id
group by DD_LOC.DATE_VALUE, DD_LOC.master_location_id,DD_LOC.location_name
order by 1,3
) 
SELECT nvl(MASTER_LOCATION_ID::text, ' ')|| ' ' MASTER_LOCATION_ID, 
nvl(LOCATION_NAME::text, ' ')|| ' ' LOCATION_NAME, 
nvl(DATE::text, ' ')|| ' '|| ' ' DATE, 
nvl(REVENUE::text, ' ')|| ' ' REVENUE, 
nvl(CASES::text, ' ')|| ' ' CASES, 
nvl(ACT::text, ' ')|| ' ' ACT, 
            convert_timezone('UTC','America/New_York', sysdate()) Updated_at,
            convert_timezone('UTC','America/New_York', sysdate()) file_load_date
FROM SOURCE_DATA



;