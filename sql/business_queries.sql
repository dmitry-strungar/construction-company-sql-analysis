-- =====================================================
-- CONSTRUCTION COMPANY ANALYTICS
-- Business Queries
-- =====================================================


-- =====================================================
-- 1. Project Portfolio Analysis
-- =====================================================

-- 1.1 Number of projects signed in 2023
select count(*) 
from project
where sign_date >= '2023-01-01'
  and sign_date <  '2024-01-01'


-- 1.2 Annual project revenue comparison
select year, total
from (
    select extract(year from sign_date) as year,
           sum(project_cost) as total
    from project
    group by extract(year from sign_date)
) as all_project_sum
where total < (
    select sum(avg_stap)
    from (
        select avg(amount) over (
                   order by fact_transaction_timestamp
                   rows between 2 preceding and 2 following
               ) as avg_stap
        from (
            select fact_transaction_timestamp,
                   amount,
                   row_number() over (
                       partition by extract(year from fact_transaction_timestamp)
                       order by fact_transaction_timestamp
                   ) as rn
            from project_payment
            where fact_transaction_timestamp is not null
        ) as nb
        where mod(rn, 5) = 0
    ) as avg_stap
)
order by year



-- =====================================================
-- 2. Workforce & HR Analysis
-- =====================================================

-- 2.1 Total work experience of employees hired in 2022
select to_char(
         justify_interval(
           sum(age(current_date, p.birthdate))
         ),
         'FMYYYY" years "FMMM" month "FMDD" days"'
       )
from employee e
join person p on e.person_id = p.person_id
where e.hire_date >= '2022-01-01'
  and e.hire_date <  '2023-01-01'


-- 2.2 Earliest hired employee with specific surname criteria
select fio, hire_date
from (
    select p.first_name || ' ' || p.last_name as fio,
           e.hire_date,
           min(e.hire_date) over () as min_hire_date
    from employee e
    join person p on e.person_id = p.person_id
    where p.last_name like 'М%'
      and length(p.last_name) = 8
) t
where hire_date = min_hire_date
order by random()
limit 1


-- 2.3 Average age of dismissed non-manager employees
select coalesce(
         avg(extract(year from age(current_date, p.birthdate))),
         0
       )
from employee e
join person p on e.person_id = p.person_id
where e.dismissal_date is not null
  and e.employee_id not in (
      select project_manager_id
      from project
      where project_manager_id is not null
  )



-- =====================================================
-- 3. Financial & Cash Flow Analysis
-- =====================================================

-- 3.1 Total received payments in Zhukovsky, Russia
select sum(pp.amount)
from country co
join city ci on co.country_id = ci.country_id
join address a on ci.city_id = a.city_id
join customer cu on a.address_id = cu.address_id
join project pr on cu.customer_id = pr.customer_id
join project_payment pp on pr.project_id = pp.project_id
where co.country_name = 'Россия'
  and ci.city_name = 'Жуковский'
  and pp.fact_transaction_timestamp is not null


-- 3.2 First date when cumulative advance payments exceeded 30M per month
with payments as (
    select plan_payment_date,
           sum(amount) over (
               partition by date_trunc('month', plan_payment_date)
               order by plan_payment_date
               rows between unbounded preceding and current row
           ) as cumulative_sum
    from project_payment
    where payment_type = 'Авансовый'
)
select plan_payment_date,
       cumulative_sum
from (
    select plan_payment_date,
           cumulative_sum,
           row_number() over (
               partition by date_trunc('month', plan_payment_date)
               order by plan_payment_date
           ) as rn
    from payments
    where cumulative_sum > 30000000
) t
where rn = 1
order by plan_payment_date



-- =====================================================
-- 4. Management Performance
-- =====================================================

-- 4.1 Top project manager bonus (1% of completed projects cost)
with bonus_cte as (
    select project_manager_id,
           sum(project_cost) * 0.01 as bonus
    from project
    where status = 'Завершен'
      and project_manager_id is not null
    group by project_manager_id
)
select b.project_manager_id,
       p.full_fio,
       b.bonus
from bonus_cte b
join employee e on b.project_manager_id = e.employee_id
join person p on e.person_id = p.person_id
where b.bonus = (select max(bonus) from bonus_cte)



-- =====================================================
-- 5. Organizational Structure Analysis
-- =====================================================

-- 5.1 Total payroll cost for organizational unit hierarchy
with recursive cte as (
    select unit_id
    from company_structure
    where unit_id = 17
    union all
    select cs.unit_id
    from company_structure cs
    join cte c on cs.parent_id = c.unit_id
),
cte2 as (
    select ep.employee_id,
           ep.salary * ep.rate as fact
    from employee_position ep
    join position p on ep.position_id = p.position_id
    where p.unit_id in (select unit_id from cte)
)
select sum(fact)
from cte2
