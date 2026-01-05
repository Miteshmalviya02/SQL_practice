-- 1. Find employees whose salary is above the average salary of their department.

select
e1.first_name,e1.last_name,e1.salary
from employees as e1
where salary > (select
				avg(salary) as avg_salary
				from employees as e2
                where e2.department_id = e1.department_id);

-- 2. Find employees who earn more than their manager

select
*
from employees as e
where salary > (select m.salary 
				from employees as m 
                where m.employee_id = e.manager_id);

-- 3.List departments where all employees earn more than 5000.

select d.* 
from departments as d
where not exists (
				select
				*
				from employees as e 
                where e.department_id = d.department_id 
                and salary <=5000);
                
-- what it does it first check thes dept_id 1 
-- first if there is salary less than = 5000 it will return a row or a vlaue and then not exsit becomes false 
-- then nxt 2 if there is salary less than = 5000 it will return a row or value and then not exsit becomes false 
-- then next 3 if there is no salary <=5000 it will wont return a row or a value then not exist becomes true 
-- code how it works
select
*
from employees where department_id = 3;

-- Find employees who work on projects where the average hours worked is greater than 80. 

select
employee_id
from employee_projects
where project_id in (
				select
				project_id
				from employee_projects
				group by project_id
				having avg(hours_worked) > 80);
                 


 
