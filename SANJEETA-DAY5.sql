-->1.     List all customers and the products they ordered with the order date. (Inner join)
Tables used: customers, orders, order_details, products
Output should have below columns:
    companyname AS customer, orderid, productname, quantity, orderdate


SELECT 
		c.company_name as customer,
		o.order_id,
		o.order_date,
		p.product_name,
		d.quantity
FROM orders o
INNER JOIN  customers c on o.customer_id = c.customer_id
INNER JOIN order_details d on o.order_id = d.order_id
INNER JOIN products p on d.product_id = p.product_id;

--> Show each order with customer, employee, shipper, and product info — even if some parts are missing. (Left Join)
Tables used: orders, customers, employees, shippers, order_details, products


SELECT c.company_name,
	e.first_name ||''|| last_name,
	o.order_date,
	p.product_name,
	od.quantity
FROM orders o
left join customers c on o.customer_id = c.customer_id
left join employees e on o.employee_id = e.employee_id
left join order_details od on o.order_id = od.order_id
left join shippers s on o.ship_via = s.shipper_id
left join products p on od.product_id = p.product_id;

-->Show all order details and products (include all products even if they were never ordered). (Right Join)
Tables used: order_details, products
Output should have below columns:
    orderid,
    productid,
    quantity,
    productname

	
select
	od.order_id,
	p.product_id,
	od.quantity,
	p.product_name
from order_details od
right join products p on od.product_id = p.product_id;

-->4. 	List all product categories and their products — including categories that have no products, and products that are not assigned to any category.(Outer Join)
Tables used: categories, products

select 
	c.category_name,
	p.product_name
from categories c
full outer join products p on c.category_id = p.category_id;



-->5.Show all possible product and category combinations (Cross join).
select 
	c.category_name,
	p.product_name
from categories c
cross join products p;


-->6. 	Show all employees and their manager(Self join(left join))

select
	e1.first_name ||'' || e1.last_name as Employeename,
	e2.first_name ||'' || e2.last_name as Managername
from employees e1
left join employees e2 on e1.reports_to = e2.employee_id;

-->7. 	List all customers who have not selected a shipping method.
Tables used: customers, orders
(Left Join, WHERE o.shipvia IS NULL)

select 
	c.contact_name,
	c.contact_title,
	c.company_name,
	o.ship_via
from customers c
left join orders o on c.customer_id = o.customer_id
WHERE o.ship_via IS NULL;

select * from orders limit 5

-->1.GROUP BY with WHERE - Orders by Year and Quarter
Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100


select  count(*) as order_count,
		round(avg(freight)::numeric,2) as average_freight_cost,
		extract(year from order_date) as year,
	    extract(quarter from order_date) as quarter
from orders
where 
freight > 100
group by extract(year from order_date),A
	     extract(quarter from order_date)
order by  year,quarter desc;

-->2    GROUP BY with HAVING - High Volume Ship Regions
Display, ship region, no of orders in each region, min and max freight cost
Filter regions where no of orders >= 5

 select ship_region,count(*)as Num_of_orders,
        round(min(freight)::numeric,2) as minimum_freight_cost,
        round(max(freight)::numeric,2) as maximum_freight_cost
from orders

group by ship_region 
having 
	 count(*)>=5;

-->3.   Get all title designations across employees and customers ( Try UNION & UNION ALL)

select title, count(*)
from employees
group by title

union 

select contact_title, count(*)
from customers
group by contact_title;

-->4.      Find categories that have both discontinued and in-stock products
(Display category_id, instock means units_in_stock > 0, Intersect)


select distinct category_id,units_in_stock from products
where units_in_stock>0
intersect
select distinct category_id,units_in_stock from products
where discontinued =1
-->5.      Find orders that have no discounted items (Display the  order_id, EXCEPT)

select o.order_id,o.order_date,o.customer_id
from orders o
where order_id in(
			select distinct order_id 
			from order_details
			
			except
			
			select distinct order_id 
			from order_details
			where discount>0
)














