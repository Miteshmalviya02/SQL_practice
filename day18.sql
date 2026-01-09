--  List customers orders before 2016

select
customer_id
from orders
where order_date  = year(order_date);

-- Find department(s) where the total salary exceeds 150000.
select
department_id,
sum(salary) as total_dept_salary
from employees
group by department_id
having sum(salary) > 150000;

-- Display the department and number of projects managed by it.
select
e.department_id,
count(ep.project_id) as number_projects
from employees as e
left join employee_projects as ep
on e.employee_id = ep.employee_id
group by e.department_id;
 
-- Find employees who work on the project 'A AND B'
select
ep.employee_id,
p.project_id,
p.project_name
from projects as p
left join employee_projects as ep
on p.project_id = ep.project_id
where p.project_name = 'Project A'
;

-- Find department(s) with no employees.

select
*
from employees 
where department_id is null;

--  Rank employees by salary within each department.
select 
employee_id,
first_name,
department_id,
salary,
dense_rank() over(partition by department_id order by salary desc) as rank_salary
from employees;

-- find duplicates in employees table by there id

select
employee_id,
count(*) as duplicates_count
from employees
group by employee_id
having count(*) >1;

-- Top 2 products by revenue per category
with rev_cte as (
select
p.category,
sum(o.total_amount) as total_rev,
rank() over(order by sum(o.total_amount) desc) as rnks
from orders as o 
left join order_items as oi
on o.order_id = oi.order_id
left join products as p
on oi.product_id = p.product_id
group by p.category)

select
*
from rev_cte
where rnks <=2;


 
