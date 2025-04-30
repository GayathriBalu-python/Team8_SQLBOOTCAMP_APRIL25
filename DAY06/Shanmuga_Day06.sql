/**********************************************   DAY 06    ***************************************************************/


Select * from customers;
select * from orders;
select * from order_details;
select * from products;
select * from categories;
select * from employees;
select * from shippers;


/*1.      Categorize products by stock status*/

select product_name,units_in_stock,
case 
	when units_in_stock = 0 then 'Out of Stock'
	when units_in_stock < 20 then 'Low in Stock'
else
	'In Stock'
end as Stock_category
from products;

/*2. Find All Products in Beverages Category*/

select product_name,unit_price from products where category_id = 
(select Category_id from categories where category_id=1);

/*3.      Find Orders by Employee with Most Sales*/

select order_id,order_date,freight,employee_id from orders where employee_id= 
(select employee_id from orders group by employee_id order by count(1) desc limit 1);

/*4.Find orders  where for country!= ‘USA’ with freight costs higher than 
any order from USA. (Subquery, Try with ANY, ALL operators)*/

select order_id,customer_id,ship_country  from orders where freight >
Any(
select max(freight) from orders where ship_country ='USA'
);


