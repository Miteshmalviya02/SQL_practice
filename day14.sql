-- Write a query to find customers who have placed more than 3 orders.
select
c.name,
c.customer_id,
count(o.order_id) as total_orders
from customers as c
join orders as o
on c.customer_id = o.customer_id
group by c.customer_id,c.name
having total_orders >=3;

-- Retrieve the total revenue per product

select
oi.product_id,
sum(quantity * total_amount) as total_rev
from orders as o
left join order_items as oi
on o.order_id = oi.order_id
group by oi.product_id;

-- Find all employees who have not made any sales. 
Select
*
From employees  as e
Left join sales as s
On e.emp_id = s.emp_id
Where sale_id is null;

-- Get a list of customers and their most recent order date.
select
*
from customers as c
join orders as o
on c.customer_id = o.customer_id
where order_date > current_date() - interval 7 day
;
 


