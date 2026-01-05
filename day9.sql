-- Find the second highest salary using a window function
select
*
from (
	select
	employee_id,
	salary,
	dense_rank() over(order by salary desc) as rnk_salary
	from employees
    ) as rank_salary
    where rnk_salary = 2;
    
    
-- Find the top 2 highest-paid employees in each department 
select
*
from (
	select
	employee_id,
    department_id,
	salary,
	dense_rank() over(partition by department_id order by salary desc) as rnk_salary
	from employees
    ) as rank_salary 
    where rnk_salary <= 2;
    
    
-- Find each employee’s salary and their department’s average salary

select
employee_id,
department_id,
salary,
avg(salary) over(partition by department_id) as avg_salary_dep,
rank() over(partition by department_id order by salary desc) as rnk_salary
from employees;


-- Write a query to calculate, for each salesperson, a running total of sales ordered by sale_date.

select
salesperson,
sale_date,
amount,
sum(amount) over(partition by salesperson order by sale_date) as total_sales
from sales
;

-- Find employees who earn more than the average salary of all employees 

select
*
from employees 
where salary >=(select avg(salary) as avg_salary from employees) 
order by salary desc;

-- Employees earning more than their department’s average salary

-- Employees earning more than their department average

select
*
from employees 
where salary < (select
				avg(salary) as avg_salary
				from employees as e
                where e.department_id = department_id);
                
-- Top 2 highest-paid employees per department

 
                

