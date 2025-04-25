/* Day 03 Assignment */
/* 1. Update the categoryName From “Beverages” to "Drinks" in the categories table. */

select * from categories;

update categories set category_name = 'Drinks' where category_name = 'Beverages';

---------------------------------------------------------------------
/* 2. Insert into shipper new record (give any values) Delete that new record from shippers table. */

insert into shippers (shipper_id,company_name,phone) 
VALUES (11,'AES',1234567);

select * FROM shippers;

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
/* 4. Delete the customer = “VINET” from customers.Corresponding customers in orders table should be set to null 
(HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)









      
