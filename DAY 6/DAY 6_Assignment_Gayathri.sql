           ------------------------Day 6-----------------------
 
/*1. Categorize products by stock status
(Display product_name, a new column stock_status whose values are based on below condition
 units_in_stock = 0  is 'Out of Stock'
       units_in_stock < 20  is 'Low Stock')*/
select * from products

select product_id,product_name,units_in_stock,
case
  when units_in_stock =0 then 'out of stock'
  when units_in_stock <20 then 'low stock'
  else 'high stock'

 end as stock_status
 from products
group by product_id


/*2. Find All Products in Beverages Category
(Subquery, Display product_name,unitprice)*/

select * from products
update categories 
set category_name ='Beverages'
where category_name='Drinks'

select product_id,product_name
from products
where product_id in (
        select product_id 
	  from products p 
	  join categories c on p.category_id=c.category_id
	  where 
      c.category_name='Beverages')

/*3.Find Orders by Employee with Most Sales
(Display order_id,   order_date,  freight, employee_id.
Employee with Most Sales=Get the total no.of of orders for
each employee then order by DESC and limit 1. Use Subquery)*/

select order_id,order_date,freight,employee_id

from orders
where employee_id = (
select employee_id
from orders
group by employee_id
 order by  count(*)desc 
 limit 1
 
)

--4.Find orders  where for country!= ‘USA’ with freight costs 
--higher than any order from USA. (Subquery, Try with ANY, ALL operators)
select* from orders
--AND---
select order_id,ship_country as country,freight
from orders
where ship_country!= 'USA'and 
freight > Any (select freight from orders where ship_country='USA' )




-----ALL---
select order_id,ship_country as country,freight
from orders
where ship_country!= 'USA'and 
freight > All (select freight from orders where ship_country='USA' )


