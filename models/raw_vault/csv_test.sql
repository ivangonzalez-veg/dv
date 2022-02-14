with
mx as (
    select * from {{ ref('my_csv')}}
)
select * from mx