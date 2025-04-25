--1)Update the categoryName From “Beverages” to "Drinks" in the categories table.
select* from shippers

update categories
set category_name = 'Drinks'
where category_name = 'Beverages'

--2)Insert into shipper new record (give any values) Delete that new 
--record from shippers table.

insert into shippers (shipper_id,company_name,phone)
values(7,'Garudavega','1-604-987-0432')
select * 
from shippers
where shipper_id=7

/* Update categoryID=1 to categoryID=1001.Make sure related products update their categoryID too. 
Display the both category and products table to show the cascade.
Delete the categoryID= “3”  from categories. Verify that the 
corresponding records are deleted automatically from products*/
 (HINT: Alter the foreign key on products(categoryID) to add
 ON UPDATE CASCADE, ON DELETE CASCADE)

 ALTER table products
 drop constraint IF EXISTS fk_products_categories;

ALTER TABLE products
add constraint fk_products_categories
foreign key(category_id)
references categories(category_id)
on update cascade
on delete cascade;

select * from products

SELECT * FROM categories WHERE category_id = 1002;
select * from products WHERE category_id = 1002;

INSERT INTO categories (category_id, category_name,description)
VALUES (99, 'Drinks','cold coffees,icecream');

insert into products (product_id,product_name,category_id,discontinued)  
values(201,'test product',99,0)

update categories 
set category_id=1002
where category_id=99

/*Delete the categoryID= “3”  from categories. Verify that the 
corresponding records are deleted automatically from products*/
SELECT * FROM products WHERE category_id = 3;
delete from categories
where  category_id=3




/*
 ON DELETE CASCADE, add ON DELETE CASCADE for order_details(productid) )
add ON DELETE CASCADE for order_details(productid))*/

ALTER table order_details
 drop constraint IF EXISTS fk_order_details_products;
 
 ALTER TABLE order_details
add constraint fk_order_details_products
foreign key(product_id)
references products(product_id)
on update cascade
on delete cascade;
select * from order_details 

delete  from products  
where product_id =11

/*4)Delete the customer = “VINET”  from customers. Corresponding customers
in orders table should be set to null (HINT: Alter the foreign key on orders
(customerID) to use ON DELETE SET NULL)*/
 fk_orders_customers
ALTER table orders
drop constraint IF EXISTS fk_orders_customers
 
 ALTER TABLE orders
add constraint fk_orders_customers
foreign key(customer_id)
references customers(customer_id)
on delete set null;
select * from orders 

delete  from customers 
where customer_id='VINET'
--5) Upsert
INSERT INTO products (product_id,product_name,quantity_per_unit,unit_price,discontinued,category_id)
values(100, 'Wheat bread', '1 boxes',13, 0, 5),
       (101,'whitebread','5 boxes',13,0,5)
	   
ON conflict (product_id)   
do update 
set product_name= EXCLUDED.product_name,
	unit_price=EXCLUDED.unit_price;
	   

select * from products where product_id= 100
/*6)Write a MERGE query: 

Create temp table with name: ‘updated_products’ and insert values as below: */
create temporary table  updated_products(
    product_id INT PRIMARY KEY,
    product_name TEXT,
    quantity_per_unit TEXT,
    unit_price NUMERIC(10,2),
    discontinued int,
    category_id INT
);

drop table  updated_products;



insert into updated_products(product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
VALUES
	(100, 'Wheat bread', '10', 20.00, 1 , 5),
    (101, 'White bread', '5 boxes', 19.99, 0, 5),
    (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19.00, 0, 1),
    (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10.00, 0, 2);

select * from  updated_products

/* Update the price and discontinued status for from below table ‘updated_products’ only if 
there are matching products and updated_products .discontinued =0 

If there are matching products and updated_products .discontinued =1 then delete 
 
 Insert any new products from updated_products that don’t exist in products only if 
 updated_products .discontinued =0.*/
 
merge into products as p
using updated_products as u
on p.product_id=u.product_id

when matched and u.discontinued=0 then 
	update set 
	unit_price=u.unit_price,
	discontinued=u.discontinued
	
when matched and u.discontinued=1 then 
delete

when not matched and u.discontinued=0 then
 insert (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
 VALUES (u.product_id, u.product_name, u.quantity_per_unit,u. unit_price,u.discontinued,u.category_id)


SELECT * from PRODUCTS 


-- 7) List all orders with employee full names. (Inner join)

select O.ORDER_ID,o.order_date,

e.first_name||'_'|| e.last_name as Employee_fullname

from orders as o 
inner join 
employees as e 
on o.employee_id=e.employee_id





 




