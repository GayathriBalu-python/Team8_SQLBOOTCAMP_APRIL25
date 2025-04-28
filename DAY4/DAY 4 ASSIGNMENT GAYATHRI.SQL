								--DAY 4
--1.List all customers and the products they ordered with the order date. 
--(Inner join)Tables used: customers, orders, order_details, products

select c.company_name as customer,
o.order_id,
p.product_name,
od.quantity,
o.order_date
from customers c
inner join orders o on c.customer_id =o.customer_id
inner join order_details od on o.order_id= od.order_id
inner join products p on od.product_id=p.product_id

--2.2.     Show each order with customer, employee, shipper, and product info — 
--even if some parts are missing. (Left Join)
Tables used: orders, customers, employees, shippers, order_details, products
select * from employees limit 5

select 
o.order_id,
c.company_name as customer,
e.first_name||'_'||e.last_name as employees, 
s.shipper_id,
p.product_name
from orders o
left join customers c on c.customer_id =o.customer_id
left join employees e on e.employee_id=o.employee_id
left join shippers s on s.shipper_id=o.ship_via
left join order_details od on o.order_id= od.order_id
left join products p on od.product_id=p.product_id

/*3.     Show all order details and products (include all products even if they
were never ordered). (Right Join) 

Tables used: order_details, products 

Output should have below columns: 
    orderid, 
 productid, 
    quantity, 
   productname */

   select od.order_id,od.product_id,od.quantity,p.product_name
   from  products p
   right join order_details od on p.product_id=od.product_id
   
 /*4. List all product categories and their products — including categories that
  have no products,
  and products that are not assigned to any category.(Outer Join) */
  
  SELECT p.product_name,c.category_name
  from categories c
  full outer join products p on c.category_id = p.category_id
  where p.product_id is null or c.category_id is null
 
-- 5. Show all possible product and category combinations (Cross join).
 
select p.product_name,p.product_id, c.category_name
from products p 
cross join categories c 

--6.Show all employees and their manager(Self join(left join)) 
select reports_to,employee_id,first_name,last_name from employees  
select e1.first_name || '_'|| e1.last_name as manager,
	   e2.first_name ||'_'|| e2.last_name as employee
from employees e1
left join employees e2 on e1.employee_id=e2.reports_to
where e1.employee_id!=e2.employee_id

/*7. 	List all customers who have not selected a shipping method. 
Tables used: customers, orders */
select * from customers limit 5
select * from orders limit 5

select c.customer_id,c.company_name,o.ship_via
from customers c 
left join orders o on c.customer_id=o.customer_id
where o.ship_via is null
--order by o.ship_via nulls first




