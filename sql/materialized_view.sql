create materialized view project_report as
select
    p.project_id,
    p.project_name,
    lp.last_payment_date,
    lp.last_payment_amount,
    per.full_fio as project_manager_name,
    c.customer_name,
    string_agg(distinct tow.type_of_work_name, ', ') as work_types
from project p
join customer c on p.customer_id = c.customer_id
join employee e on p.project_manager_id = e.employee_id
join person per on e.person_id = per.person_id
left join lateral (
    select pp.fact_transaction_timestamp as last_payment_date,
           pp.amount as last_payment_amount
    from project_payment pp
    where pp.project_id = p.project_id
      and pp.fact_transaction_timestamp is not null
    order by pp.fact_transaction_timestamp desc
    limit 1
) lp on true
left join customer_type_of_work ctow
       on c.customer_id = ctow.customer_id
left join type_of_work tow
       on ctow.type_of_work_id = tow.type_of_work_id
group by
    p.project_id,
    p.project_name,
    lp.last_payment_date,
    lp.last_payment_amount,
    per.full_fio,
    c.customer_name
    
 select *
 from project_report
 
 drop materialized view project_report
