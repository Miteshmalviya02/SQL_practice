-- Write a query to find all employees who earn the maximum salary in their department, using only subqueries

select
* 
from employees as e
where salary = (select
				max(salary) as max_salary
				from employees as e1
                where e.department_id = e1.department_id);
                
-- Find employees who earn more than every employee in the HR department
select
*
from employees
where salary > all(
		select
		salary
		from employees
		where department_id =1);
        
-- Find employees who earn more than at least one employee in the HR department

select
*
from (
		select
		department_id,
		avg(salary) as avg_salary_by_dept
		from employees
		group by department_id
) as avg_salary_table
where avg_salary_by_dept > 70000;


-- Show each employee along with their department’s average salary.

select
employee_id,salary,department_id,
(select avg(salary) from employees as e1 where e1.department_id  =e.department_id)
from employees e;

-- Find departments whose total salary is higher than the average total salary across all departments

select
    department_id,
    sum(salary) as total_salary
from employees
group by department_id
having sum(salary) >(
        select
		avg(total_salary)
		from (
			select
			sum(salary) as total_salary
			from employees
			group by department_id
			) as t);
