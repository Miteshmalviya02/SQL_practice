-- Find the top 3 employees with the highest salary in each department.
-- Hint: Use ROW_NUMBER() with PARTITION BY.

select
employee_id,
first_name,
department_id,
salary,
row_number() over(partition by department_id order by salary desc) as rnk_dept_salary
from employees;

-- Second Highest Salary (Without MAX or LIMIT)

select
*
from(	select
		employee_id,
		first_name,
		department_id,
		salary,
		dense_rank() over(order by salary desc) as rank_salary
		from employees) as t
where rank_salary =2;

-- Departments with Average Salary Above Company Average
select
department_id,
avg(salary) as avg_salary_by_dept
from employees
group by department_id
having avg(salary) > (select avg(salary) from employees);

-- Running Total of Sales 
select
customer_id,
sum(total_amount) over(partition by customer_id order by month(order_date) asc) as running_total
from orders;

-- Employees with Same Salary
select
salary,
count(*) as salary_count
from employees
group by salary
having count(*) > 1;

