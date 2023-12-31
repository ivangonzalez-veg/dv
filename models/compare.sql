create or replace view VEG.REPORTING.BUXTON_PATIENTS(
	PATIENTID,
	CLIENT_ID,
	BIRTH_DATE,
	SEX,
	SPECIES,
	BREED,
	WEIGHT,
	WEIGHT_UNIT,
	UPDATED_AT,
	FILE_LOAD_DATE
) as

with c as (select trim(patient_id)::text pid from VEG.REPORTING.BUXTON_CASES_REV where patient_id is not null group by patient_id)
, source_data as (
            SELECT     PATIENT_ID  PATIENTID,
                       customer_id CLIENT_ID,
                       BIRTH_DATE,
                       SEX,
                       SPECIES,
                       BREED,
                       WEIGHT_VALUE WEIGHT,
                       WEIGHT_UNIT,
                       --EFFECTIVE_DATE UPDATED_AT,
                       convert_timezone('UTC','America/New_York', SYSDATE()) FILE_LOAD_DATE
            FROM       veg_dwh.information_mart_stage.dim_patient_stage b
            INNER JOIN c
            ON         c.pid = trim(b.PATIENT_ID)::text
)
select nvl(a.PATIENTID::text, ' ')|| ' ' PATIENTID, 
        nvl(a.CLIENT_ID::text, ' ')|| ' ' CLIENT_ID, 
        nvl(a.BIRTH_DATE::text, ' ')|| ' ' BIRTH_DATE, 
        nvl(a.SEX::text, ' ')|| ' ' SEX, 
        nvl(a.SPECIES::text, ' ')|| ' ' SPECIES, 
        nvl(a.BREED::text, ' ')|| ' ' BREED, 
        nvl(a.WEIGHT::text, ' ')|| ' ' WEIGHT, 
        nvl(a.WEIGHT_UNIT::text, ' ')||' ' WEIGHT_UNIT, 
            convert_timezone('UTC','America/New_York', sysdate()) Updated_at,
            convert_timezone('UTC','America/New_York', sysdate()) file_load_date
 from source_data a
 
/* 
WITH p1 AS
(SELECT  "Patient ID"  patient_id
         FROM     "VEG"."REPORTING"."VW_SALES_DETAIL_DWH"
         WHERE    "Date of Invoice (Local)" BETWEEN '2020-01-01 00:00:00.000' AND sysdate() and "Invoice Status" in ('Paid','Due')group by "Patient ID")
, source_data as (
SELECT     p.id patientid,
           p.client_id,
           p.birth_date,
           p.sex,
           p.species,
           p.breed,
           p.weight,
           p.weight_unit
FROM       "PRESENTATION_DB"."PRESENTATION"."TBL_PATIENTS" p
INNER JOIN p1
ON         p1.patient_id = p.id)

select nvl(a.PATIENTID::text, ' ')|| ' ' PATIENTID, 
        nvl(a.CLIENT_ID::text, ' ')|| ' ' CLIENT_ID, 
        nvl(a.BIRTH_DATE::text, ' ')|| ' ' BIRTH_DATE, 
        nvl(a.SEX::text, ' ')|| ' ' SEX, 
        nvl(a.SPECIES::text, ' ')|| ' ' SPECIES, 
        nvl(a.BREED::text, ' ')|| ' ' BREED, 
        nvl(a.WEIGHT::text, ' ')|| ' ' WEIGHT, 
        nvl(a.WEIGHT_UNIT::text, ' ')||' ' WEIGHT_UNIT, 
            convert_timezone('UTC','America/New_York', sysdate()) Updated_at,
            convert_timezone('UTC','America/New_York', sysdate()) file_load_date
 from source_data a
 inner join VEG.REPORTING.BUXTON_CLIENTS c
    on a.client_id = c.client_id
    */
    /*
where A.client_id in( 49582329, 
75287552, 
56138957, 
64660282, 
80002101, 
71299268, 
72358756, 
77470900, 
71045416, 
71145029, 
72096980, 
16694909, 
67413615, 
81027116, 
3583049)*/
;