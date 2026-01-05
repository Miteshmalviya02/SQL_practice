--  Find customers who have not placed any orders
select
*
from  customers as c
left join orders as o
on c.customer_id = o.customer_id
where o.order_id is null;

-- Find employees and their managers' names
select
e.first_name as emp_name,
m.first_name as manager_name
from Employees as e
join employees as m
on m.employee_id = e.manager_id;


-- Total sales by category
select
p.name,
sum(p.price * oi.quantity) as total_sales
from products as p
join order_items as oi
on p.product_id = oi.product_id
group by p.name; 

select * from orders;
-- Top 3 customers by total purchase value 
select
c.customer_id,
sum(o.total_amount) as purchase_value
from customers as c
join orders as o
on c.customer_id = o.customer_id
group by c.customer_id
order by purchase_value desc
limit 3
;

-- Employees earning above their department average

select
department_id,
employee_id,
first_name,
salary
from employees as e
where salary > (
				select avg(salary) 
                from employees 
                where department_id = e.department_id);

-- Month-wise revenue for current year
select
month(order_date) as month_number,
monthname(order_date) as monthname,
sum(total_amount) as total_rev
from orders
where year(order_date) = year(curdate()) -- 2025 
group by month(order_date),
monthname(order_date)
order by month(order_date);

-- Employees with salary above overall average
select
*
from employees
where salary > (select avg(salary) from employees);

--  Products never ordered

select
p.*
from 
products as p
left join order_items as o
on p.product_id = o.product_id
where o.product_id is null;
