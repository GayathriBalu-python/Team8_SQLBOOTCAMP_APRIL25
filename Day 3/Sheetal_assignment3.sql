/* Day 03 Assignment */
/* 1. Update the categoryName From “Beverages” to "Drinks" in the categories table. */

select * from categories;

update categories set category_name = 'Drinks' where category_name = 'Beverages';

---------------------------------------------------------------------
/* 2. Insert into shipper new record (give any values) Delete that new record from shippers table. */

insert into shippers (shipper_id,company_name,phone) 
values (11,'AES',1234567);

select * from shippers;

delete from shippers where shipper_id=11;

---------------------------------------------------------------------
/* 3. Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. 
Display the both category and products table to show the cascade. 
Delete categoryID= “3”from categories.Verify that the corresponding records are deleted automatically from products.*/

select * from products;
select * from categories;

insert into categories (category_id,category_name,description) 
values(101,'test','testing');

insert into products (product_id,product_name,discontinued,category_id) 
values(201,'product 1',0,101);

update categories 
set category_id = 1001 
where category_id = 101;

alter table products 
drop constraint if exists fk_category_id;

Alter table products 
add constraint fk_category_id
foreign key (category_id)
references categories (category_id)
on update cascade
on delete cascade;

alter table order_details 
drop constraint if exists fk_order_details_products;

delete from categories where category_id = 3 ;

select * from products where category_id = 3;

---------------------------------------------------------------------
/* 4. Delete the customer = “VINET” from customers.
Corresponding customers in orders table should be set to null 
(HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL) */

alter table orders 
drop constraint if exists fk_orders_customers;

select * from customers where customer_id = 'VINET';

delete from customers where customer_id = 'VINET';

select * from orders;

Alter table orders
add constraint fk_customer_id
foreign key (customer_id)
references customers(customer_id)
on delete set null;

---------------------------------------------------------------------
/* 5. Insert the following data to Products using UPSERT 
product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=5 

product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=5 

product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=5 */

insert into products (product_id, product_name, quantity_per_unit, price_in_usd, discontinued,  category_id) 
values(100,'Wheat bread',1,12,0,5);

select * from products;

insert into products (product_id, product_name, quantity_per_unit, price_in_usd, discontinued,  category_id) 
values(100,'Wheat bread',10,13,0,5)
on conflict (product_id)
do update
set product_name = excluded.product_name,
	quantity_per_unit = excluded.quantity_per_unit,
	price_in_usd = excluded.price_in_usd,
	discontinued = excluded.discontinued,
	category_id = excluded.category_id;
---------------------------------------------------------------------
/* 6.Write a MERGE query: 

Create temp table with name:‘updated_products’ and insert values as below: 

Update the price and discontinued status for from below table ‘updated_products’ only if there are matching products and updated_products .discontinued =0  

If there are matching products and updated_products .discontinued =1 then delete  

Insert any new products from updated_products that don’t exist in products only if updated_products .discontinued =0. */

create table updated_products (
productID integer,
productName varchar (50),
quantityPerUnit character varying (20),
unitPrice numeric,
discontinued integer,
categoryID integer
);

merge into updated_products p
using (
	values 
		(100,'Wheat bread','10',20,1,5),
		(101,'White bread','5 boxes',19.99,0,5),
		(102,'Midnight Mango Fizz','24 - 12 oz bottles',19,0,1),
		(103,'Savory Fire Sauce','12 - 550 ml bottles',10,0,2)
) as incoming (productID,productName,quantityPerUnit,unitPrice,discontinued,categoryID)
on p.productID  = incoming.productID
when matched and incoming.discontinued = 1 then
	delete
when matched and incoming.discontinued = 0 then
	update set 
	productName = incoming.productName,
	unitPrice = incoming.unitPrice
when not matched and incoming.discontinued = 0 then
	insert (productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID)
	values (incoming.productID, incoming.productName, incoming.quantityPerUnit, incoming.unitPrice, 
	incoming.discontinued, incoming.categoryID)

select * from updated_products where productID in (100,101,102,103);

---------------------------------------------------------------------
/* 7. List all orders with employee full names. (Inner join) */

select o.order_id,o.order_date,e.employee_id,e.first_name ||'  '||e.last_name as full_Name
from orders o
inner join employees e on o.employee_id = e.employee_id;

---------------------------------------------------------------------












      
