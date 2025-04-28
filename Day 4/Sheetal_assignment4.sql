/* Day 04 Assignment */
/* 1. List all customers and the products they ordered with the order date. (Inner join) */

select od.order_id,od.unit_price,p.product_id,p.product_name,o.order_date,c.customer_id,c.company_name
from order_details od
inner join products p on od.product_id = p.product_id
inner join orders o on od.order_id = o.order_id
inner join customers c on c.customer_id = o.customer_id;
-----------------------------------------------------------------------------------
/* 2. Show each order with customer, employee, shipper, and product info — 
	  even if some parts are missing. (Left Join) */     

select o.order_id,o.ship_name,o.ship_address,c.customer_id,e.employee_id,e.first_name,p.product_id,p.product_name
from orders o
left join customers c on c.customer_id = o.customer_id
left join employees e on e.employee_id = o.employee_id
left join order_details od on od.order_id = o.order_id
left join products p on p.product_id = od.product_id;
-----------------------------------------------------------------------------------

/* 3. Show all order details and products (include all products even if they were never ordered).(Right Join)  */

select od.order_id,p.product_id,p.product_name,p.quantity_per_unit from products p 
right join order_details od on p.product_id = od.product_id;

-----------------------------------------------------------------------------------

/* 4.List all product categories and their products — including categories that have no products, 
	and products that are not assigned to any category.(Outer Join)  */

select c.category_name,p.product_name
from products p
full outer join categories c on p.category_id = c.category_id;

-----------------------------------------------------------------------------------

/* 5. Show all possible product and category combinations (Cross join).   */

select c.category_name,p.product_name
from products p
cross join categories c ;

-----------------------------------------------------------------------------------

/* 6. Show all employees and their manager(Self join(left join))  */

select e1.first_name ||'  '||e1.last_name as employee_name,
	   e2.first_name ||'  '||e2.last_name as manager_name
from employees e1 
left join employees e2 on e1.reports_to = e2.employee_id;

-----------------------------------------------------------------------------------

/* 7. 	List all customers who have not selected a shipping method.   */

select c.company_name,o.order_id
from orders o
left join customers c on c.customer_id  = o.customer_id
where o.ship_via is null;


-----------------------------------------------------------------------------------






















	




