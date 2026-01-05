-- Customers placing more orders than average 

select
customer_id,
count(order_id) as total_orders
from orders
group by customer_id
having count(order_id) > (
				select 
				avg(count_orders) 
				from (select
						count(order_id) as count_orders
						from orders
						group by customer_id) as count_ids );
                        
--  Second highest salary in each department

select
*
from (
select
first_name,
employee_id,
department_id,
salary,
dense_rank() over(partition by department_id order by salary desc) as rnks_dept
from  employees) as t
where rnks_dept = 2;

-- Running total of sales per customer

select
customer_id,
order_date,
sum(total_amount) over(partition by customer_id order by order_date) as running_total
from orders;

-- Employee salary rank within department 
select
employee_id,
first_name,
department_id,
dense_rank() over(partition by department_id order by salary desc) as rnks
from employees;

--  Find duplicate 

select
customer_id,
count(*) as count_duplicates
from orders
group by customer_id
having count(*) > 1

 


