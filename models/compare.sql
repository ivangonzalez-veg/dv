create or replace view VEG.REPORTING.BUXTON_PATIENTS_DOGBYTE_TEST(
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

with c as
(select  trim(patient_id)::text pid
         from     veg.reporting.buxton_cases_rev
         where    patient_id is not null
         group by patient_id) 
, vetspire as
( select    patient_id            patientid,
                      customer_id client_id,
                      birth_date,
                      sex,
                      species,
                      breed,
                      weight_value weight,
                      weight_unit,
                      --EFFECTIVE_DATE UPDATED_AT,
                      convert_timezone('UTC','America/New_York', sysdate()) file_load_date
           from       veg_dwh.information_mart_stage.dim_patient_stage b
           inner join c
           on         c.pid = trim(b.patient_id)::text 
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
from   vetspire a
union
select nvl(a.PATIENTID::text, ' ')|| ' ' PATIENTID, 
        nvl(a.CLIENT_ID::text, ' ')|| ' ' CLIENT_ID, 
        nvl(a.BIRTH_DATE::text, ' ')|| ' ' BIRTH_DATE, 
        nvl(a.SEX::text, ' ')|| ' ' SEX, 
        nvl(a.SPECIES::text, ' ')|| ' ' SPECIES, 
        nvl(a.BREED::text, ' ')|| ' ' BREED, 
        nvl(a.WEIGHT::text, ' ')|| ' ' WEIGHT, 
        nvl(a.WEIGHT_UNIT::text, ' ')||' ' WEIGHT_UNIT, 
       a.updated_at,
       a.file_load_date
from   veg_dwh.bv.dogbyte_buxton_patients a
;