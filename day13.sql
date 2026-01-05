-- List all employees who work in the ‘Finance’ department. 

select
e.employee_id,
e.first_name,
d.department_name,
d.department_id
from employees as e
join departments as d
on e.department_id = d.department_id
order by employee_id;

-- How would you list employees who don’t belong to any department?
select
e.employee_id,
e.first_name,
d.department_name,
d.department_id
from employees as e
join departments as d
on e.department_id = d.department_id
where d.department_id is null
order by employee_id;

-- How can you show each department and the number of employees in it?

select 
em.employee_id,
em.first_name,
t.department_id,
t.total_emp_dept
from employees as em
join (
		select
		d.department_id,
		count(e.employee_id) as total_emp_dept
		from employees as e
		join departments as d
		on e.department_id = d.department_id
		group by d.department_id) as t
on em.department_id = t.department_id;


-- Show all department names that have no employees assigned to them.

select
d.department_id,
d.department_name,
e.employee_id
from departments as d
left join employees as e
on e.department_id = d.department_id
where e.employee_id is null; 
  
 