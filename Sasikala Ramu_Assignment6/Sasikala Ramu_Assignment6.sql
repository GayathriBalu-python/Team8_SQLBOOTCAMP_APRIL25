---1.      Categorize products by stock status
---(Display product_name, a new column stock_status whose values are based on below condition units_in_stock = 0  is 'Out of Stock'  units_in_stock < 20  is 'Low Stock')
select * from products --#product_id
select product_name,
case 
	when units_in_stock = 0 then  'Out of Stock'
	when units_in_stock < 20 then 'Low Stock'
else 'High Stock'
end
from products
	
 
---2.      Find All Products in Beverages Category (Subquery, Display product_name,unitprice)
select * from products ---#product_id,#category_id, #product_name,unit_price, 
select * from categories --#category_id,category_name

select product_name,unit_price from products where category_id = ALL(select category_id  from categories where category_name = 'Beverages')
 
--3.      Find Orders by Employee with Most Sales
---(Display order_id,   order_date,  freight, employee_id. Employee with Most Sales=Get the total no.of of orders for each employee then order by DESC and limit 1. Use Subquery)

select * from orders --#order_id,#employee_id,order_date,freight,
select * from employees --#employee_id,

select o.order_id, o.order_date,o.freight, o.employee_id from orders o where o.employee_id = (select employee_id from orders group by employee_id order by count(*) DESC limit 1 ) order by o.order_date DESC 



 
--4.Find orders  where for country!= ‘USA’ with freight costs higher than any order from USA. (Subquery, Try with ANY, ALL operators)---

select * from orders--##order_id, ship_country
select * from order_details -- #
select order_id,ship_country,freight from orders where country != 'USA' and freight > 
---ANY Operator
SELECT order_id,freight FROM orders WHERE ship_country !='USA' AND freight > ANY(
 SELECT freight 
 FROM orders
 WHERE ship_country = 'USA'
)
ORDER BY freight;

--ALL Operator
SELECT order_id, freight FROM orders WHERE ship_country != 'USA'   AND freight > ALL (
    SELECT freight 
    FROM orders
    WHERE ship_country = 'USA'
)
ORDER BY freight;