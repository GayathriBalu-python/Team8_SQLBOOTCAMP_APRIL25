/**********************************************   DAY 04    ***************************************************************/


Select * from customers;
select * from orders;
select * from order_details;
select * from products;
select * from categories;
select * from employees;
select * from shippers;

insert into products(product_id,product_name,discontinued) values(78,'AAAAAAAAAAAAAAAAAAAAAAA', 0);

/*1.     List all customers and the products they ordered with the order date. */

select o.order_id,c.company_name as customer,p.product_name,od.quantity,o.order_date from customers c 
inner join orders o on c.customer_id = o.customer_id
inner join order_details od on o.order_id=od.order_id
inner join  products p  on p.product_id= od.product_id
where o.order_date is not null

/*2. Show each order with customer, employee, shipper, and product info — even if some parts are missing. (Left Join)*/

select o.order_id ,o.customer_id, c.company_name as customername,p.product_name, e.first_name || ' ' || e.last_name as employeename,
s.company_name as shipper_name
from orders o
left join customers c on o.customer_id = c.customer_id
left join employees e on o.employee_id = e.employee_id
left join order_details od on o.order_id = od.order_id
left join products p on od.product_id = p.product_id 
left join shippers s on o.ship_via = s.shipper_id


/*3. Show all order details and products (include all products even if they were never ordered). (Right Join)*/

select od.order_id,od.product_id,p.product_id,p.product_name from order_details od
right join products p on od.product_id = p.product_id
order by od.product_id asc nulls first ;

select * from products p where product_id not in(select product_id from order_details);

/*4.List all product categories and their products — including categories that have no products, and products that are not assigned to any category.(Outer Join)*/

select c.category_id,c.category_name,p.product_id,p.product_name 
from products p 
full outer join categories c on p.category_id=c.category_id;

/* 5. 	Show all possible product and category combinations (Cross join).*/

select p.product_id,p.product_name,c.category_id, c.category_name from products p 
cross join categories c;


/*6. 	Show all employees and their manager(Self join(left join)) */

select first_name,reports_to from employees;

select e.first_name, e.last_name, e.reports_to, e1.first_name as manager  from employees e
left join employees e1 on e.reports_to = e1.employee_id;

/*7.List all customers who have not selected a shipping method.
*/

SELECT o.order_id, c.customer_id,c.company_name as customer_name, o.ship_name from customers c
left join orders o on c.customer_id = o.customer_id
where o.ship_via is null;