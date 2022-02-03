WITH paycom_hks AS (
    SELECT PAYROLL_HK as WORKER_HK
        ,PAYROLL_ID as WORKER_ID
        ,LOAD_DATE
        ,COLLISION_KEY_PAYCOM AS COLLISION_KEY
        ,RECORD_SOURCE
    FROM {{ ref('primed_vetspire_stg_providers') }}
),

vetspire_hks AS (
    SELECT VETSPIRE_HK as WORKER_HK
        ,ID as WORKER_ID
        ,LOAD_DATE
        ,COLLISION_KEY_VETSPIRE AS COLLISION_KEY
        ,RECORD_SOURCE
    FROM {{ ref('primed_vetspire_stg_providers') }}
)

SELECT * FROM paycom_hks

UNION 

SELECT * FROM vetspire_hks