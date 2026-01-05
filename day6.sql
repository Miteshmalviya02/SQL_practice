--  Write a query to find duplicate rows in a table. 
select
emp_id,
emp_name,
count(*) as duplicate_count
from employees
group by emp_id,emp_name
having count(*) >1;


-- Write a query to fetch the second-highest salary from an employee table. 
select
employee_id,
first_name,
last_name,
salary
from employees
order by salary desc
limit 1,1;

select
* 
from employees
where salary = 
	(
	select
		max(salary) as highest_salary
	from employees
	where salary < (select 
						max(salary) 
                    from employees)
	);
    
-- Write a query to find employees earning more than their managers. 

select
*
from employee as emp
join employee as mg
on emp.manager_id = mg.employee_id
where emp.salary > mg.salary;

-- Provide examples of ROW_NUMBER and RANK.
select amount,
rank() over(order by amount desc) as rnk,
dense_rank() over(order by amount desc) as rnk,
row_number() over(order by amount desc) as row_num
from orders
order by amount desc;

-- 7.Write a query to fetch the top 3 performing products based on sales. 
-- Assume table sales_data has:
-- product_id, product_name, total_sales 
select
product_id,
product_name,
total_sales
from sales_data
order by total_sales desc
limit 3;


select 
product_id,
product_name,
total_sales
from (
	select
	product_id,
	product_name,
	total_sales,
	dense_rank() over(order by total_sales desc) as rnk
	from sales_data
	) as t
where rnk <=3;









 