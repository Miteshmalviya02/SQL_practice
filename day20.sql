-- Customers Who Ordered All Products
SELECT
    c.customer_id,
    c.name
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
JOIN order_items AS oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.name
HAVING COUNT(DISTINCT oi.product_id) = (
    SELECT COUNT(*) FROM products
);


-- Find the highest salary from the Employee table.
select
*
from employees 
where salary = (
			select
			max(salary)
			from employees);

-- Find the second highest salary. 
with emp_salary as (
select
*,
dense_rank() over(order by salary desc) as rnk
from employees
)
select 
*
from emp_salary
where rnk = 2;

-- Count how many employees are in each department.

select 
d.department_id,
d.department_name,
count(*) as count_employees 
from employees as e
join departments as d
on e.department_id = d.department_id
group by department_id,d.department_name;

-- List all employees whose name starts with ‘A’.

select
*
from employees
where first_name like 'a%'; 


-- . Find the total salary paid in each department

select
d.department_id,
d.department_name,
round(sum(salary),2) as total_salary
from employees as e
join departments as d
on e.department_id = d.department_id
group by d.department_id,
d.department_name;

-- Find employees who don’t belong to any department.
select
*
from employees as e
left join departments as d 
on e.department_id = d.department_id;
