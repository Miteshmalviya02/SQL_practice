-- Find all employees who earn more than the average salary

select
employee_id,first_name,salary
from employees
where salary > (
				select
				avg(salary) as avg_salary
				from employees);
                
-- List departments with more than 2 employees

select
department_id,
count(*) as total_emp_dept
from employees
group by department_id
having count(*) > 2;

-- Find the department name and average salary of its employees 

select
d.department_name,
round(avg(e.salary),2) as avg_salary_dept
from employees as e
join departments as d
on e.department_id = d.department_id
group by d.department_name;

-- Retrieve employees who have not been assigned to any project 
select
*
from employees as e
left join employee_projects as ep
on e.employee_id = ep.employee_id
where ep.project_id is null;

-- Find the highest paid employee in each department

select
department_id,
max(salary) as highest_salary
from employees
group by department_id; 

-- corelated subquery for same question
select
e1.*
from employees as e1
where salary = (
				select
				max(salary)
				from employees as e
                where e.department_id = e1.department_id);

--  Find employees who work on more than one project                
select
employee_id,
count(project_id) as count_emp
from employee_projects
group by employee_id
having count(project_id) >1;

-- Show employee name, project name, and total hours worked (via multiple joins).
 select
 e.first_name,
 p.project_name,
 ep.hours_worked
 from employees as e
 join employee_projects as ep
 on e.employee_id = ep.employee_id
 left join projects as p
 on ep.project_id = p.project_id;
 