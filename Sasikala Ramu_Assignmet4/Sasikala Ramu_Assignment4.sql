---Q1.     List all customers and the products they ordered with the order date. (Inner join)
select * from customers; ---#customer_id,
select * from orders ---#order_id, #customer_id, #order_date
select * from order_details;--#order_id, #product_id
select * from products; ---#product_id, #Product_name, #

select c.customer_id, c.company_name, o.order_date, p.product_name from 
customers as c inner join orders as o on c.customer_id = o.customer_id
inner join order_details as od on o.order_id = od.order_id
inner join products as p on od.product_id = p.product_id

----Q2) Show each order with customer, employee, shipper, and product info — even if some parts are missing.

select * from products ----#product_id, product_name, supplier_id,category_id
select * from order_details  --#order_id, product_id
select * from orders ---#oredr_id, #customer_id, #employee_id

select * from employees -- employee_id, last_name, first_name, home_phone
select * from orders ---#oredr_id, #customer_id, #employee_id
select * from customers ---#customer_id,company_name,phone,fax
select * from shippers--#shipper_id, #company_name, #phone


select e.first_name, e.last_name, s.company_name, p.product_name, c.customer_id, c.company_name, o.order_id from products as p
left join order_details as od on p.product_id = od.product_id
left join orders as o on od.order_id = o.order_id
left join employees as e on o.employee_id = e.employee_id
left join orders as oa on e.employee_id = oa.order_id 
left join customers as c on oa.customer_id = c.customer_id
left join shippers as s on c.company_name= s.company_name


--Show all order details and products (include all products even if they were never ordered). (Right Join)
select * from order_details --#order_id, product_id, quanity
select * from products --#product_id, product_name

select od.order_id, od.product_id, od.quantity, p.product_name from order_details as od
right join products as p on p.product_id = od.product_id

---Q4)List all product categories and their products — including categories that have no products, and products that are not assigned to any category.(Outer Join)
select * from products---#product_id, product_name, #category_id
select * from categories -- #category_id, category_name

select  p.product_id, p.product_name, c.category_name from products as p
full outer join categories as c on c.category_id = p.category_id

--Q5) Show all possible product and category combinations 
select  p.product_id, p.product_name, c.category_name from products as p
cross join categories as c 

---Q6)Show all employees who have the same manager(Self join)
select e1.first_name ||''|| e1.last_name as employee_name,
e2.first_name ||''|| e2.last_name as manager_name
from 
employees e1
left join 
employees e2 on e1.reports_to = e2.employee_id;



select * from employees
 

---Q7) List all customers who have not selected a shipping method.
select * from customers--#customer_id, #company_name
select * from shippers --#company_name
select * from orders where ship_via = null  --#customer_id,#ship_via

select c.customer_id, c.company_name,o.ship_via from orders as o
left join customers as c on o.customer_id = c.customer_id 
left join shippers as s on c.company_name = s.company_name where o.ship_via is null