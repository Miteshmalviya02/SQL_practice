select * from customers;
select * from orders;
select * from products;
-- 1.Find the total spending per customer, and categorize them based on their total amount spent on completed orders.
-- Each customer should be labeled as:
-- 'High Spender' → if total > 3000
-- 'Medium Spender' → if between 1000 and 3000
-- 'Low Spender' → if less than 1000

select 
concat(c.first_name,' ',c.last_name) as full_name,
c.country,
round(sum(o.quantity * p.price),2) as total_spent,
case 
when sum(o.quantity * p.price)>3000 then "High Spender"
when sum(o.quantity * p.price)between 1000 and 3000 then "Medium Spender"
else "Low Spender" end as category_spender
from customers as c
join orders as o
on c.customer_id = o.customer_id
join products as p
on o.product_id = p.product_id
where o.status = 'Completed'
group by full_name,c.country
order by total_spent desc;

-- 2.Find customers who:
-- Have placed more than 3 completed orders, and
-- Have a total spending above 2000 (on completed orders only).
-- Show:
-- full_name
-- country
-- total_orders
-- total_spent
-- customer_type:
-- 'VIP Customer' if spending > 5000
-- 'Loyal Customer' if spending between 2000 and 5000
-- 'Regular Customer' otherwise

select 
concat(c.first_name,' ',c.last_name) as full_name,
count(o.order_id) as number_of_orders,
round(sum(o.quantity * p.price),2) as total_spent,
case 
when sum(o.quantity * p.price) > 5000 then 	'VIP Customer'
when sum(o.quantity * p.price) between 2000 and 5000 then 'Loyal Customer'
else 'Regular Customer' end as customer_type
from customers as c
join orders as o
on c.customer_id = o.customer_id
join products as p
on o.product_id = p.product_id
where o.status = 'Completed'
group by full_name
having  count(o.order_id) > 3 AND sum(o.quantity * p.price) > 2000;

-- 3.Category Performance by Country
-- For each country and category, calculate:
-- Total revenue from completed orders
-- Number of completed orders
-- Category performance label based on total revenue
-- Label each category as:
-- 'High Performing' → total revenue > 4000
-- 'Medium Performing' → between 2000 and 4000
-- 'Low Performing' → below 2000

select 
c.country,
p.category,
count(o.order_id) as num_of_completed_orders,
round(sum(o.quantity * p.price),2) as total_rev,
case
when sum(o.quantity * p.price) > 4000 then 'High Performing'
when sum(o.quantity * p.price) between 2000 and 4000 then 'Medium performing'
else 'low performing' end as Label_each_Category
from customers as c
join orders as o
on c.customer_id = o.customer_id
join products as p
on o.product_id = p.product_id
where o.status = 'Completed'
group by c.country, p.category
having total_rev > 500
order by c.country,total_rev desc;

-- 4.For each product category, calculate:
-- Total Revenue (from completed orders)
-- Total Quantity Sold
-- Average Selling Price per Item
-- Profit Margin Category based on average price
-- Label each category as:
-- 'Premium Category' → if average price > 700
-- 'Mid-Range Category' → if between 300 and 700
-- 'Budget Category' → if below 300

select 
p.category,
sum(o.quantity) as total_quantity_sold,
round(sum(o.quantity * p.price),2) as total_rev,
round(SUM(p.price * o.quantity) / SUM(o.quantity),2) as avg_item,
case
when SUM(p.price * o.quantity) / SUM(o.quantity) > 700 then 'Premium Category'
when SUM(p.price * o.quantity) / SUM(o.quantity) between 300 and 700 then 'Mid Range Category'
else 'Budget Category' end as Label_each_Category
from customers as c
join orders as o
on c.customer_id = o.customer_id
join products as p
on o.product_id = p.product_id
where o.status = 'Completed'
group by p.category
having total_rev >1000
order by total_rev desc
;

-- 5.For each country, show:
-- Total number of orders
-- Number of completed orders
-- Number of pending orders
-- Number of cancelled orders
-- Total revenue from completed orders

select c.country,
count(o.order_id) as total_number_of_orders,
sum(case when o.status = 'Completed' then 1 else 0 end) as num_of_completed_orders,
count(case when o.status = 'Completed' then 1 end) as using_count_num_of_completed_orders,
-- same thing works in count but sum it add 1+0+1+0 = 2 when we give completed =1 or anyother give it 0
-- when it comes to count dont need to give then 1 else 0 (o.status = 'Pending' then 1 else 0) 
-- because if we assign complted as 1 and other as 0 it will count it 1,0,1,0,1,1 = 6 if we leave it null count cant count null 
-- so give  count(case when o.status = 'Completed' then 1 end) no need of then 1 else 0
sum(case when o.status = 'Pending' then 1 else 0 end) as num_of_pending_orders,
sum(case when o.status = 'Cancelled' then 1 else 0 end) as num_of_Cancelled_orders,
sum(case when o.status = 'Completed' then o.quantity * p.price else 0 end ) as total_rev 
from customers as c
join orders as o
on c.customer_id = o.customer_id
join products as p
on o.product_id = p.product_id
group by c.country
order by total_rev desc;