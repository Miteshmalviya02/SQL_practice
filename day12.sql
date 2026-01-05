-- Find departments that have at least one employee earning more than 80,000 
SELECT
    employee_id,
    salary,
    department_id
FROM employees AS e
WHERE EXISTS (
    SELECT 1
    FROM employees AS e1
    WHERE e1.salary > 5000
      AND e1.department_id = e.department_id
);

-- Find departments that have no employees earning more than 80,000
-- what it does it first check thes dept_id 1 
-- first if there is salary less than = 5000 it will return a row or a vlaue and then not exsit becomes false 
-- then nxt 2 if there is salary less than = 5000 it will return a row or value and then not exsit becomes false 
-- then next 3 if there is no salary <=5000 it will wont return a row or a value then not exist becomes true 
-- code how it works
select
*
from employees where department_id = 3;

select
department_id,
employee_id,
salary
from employees as e
where not exists (
	select
	1
	from employees as e1
	where e1.salary<=8000 and e1.department_id = e.department_id );
    
-- Find employees who earn above both their department average and the company average 
with avg_dept as (
select
department_id,
avg(salary) as avg_dept_salary
from employees
group by department_id
),
avg_com as (
select
avg(salary) as comp_avg_salary
from employees)

select
*
from employees e
join avg_dept as ad
on e.department_id = ad.department_id
cross join avg_com ac
where e.salary > ad.avg_dept_salary and ad.avg_dept_salary > ac.comp_avg_salary;





