/***************************************************	DAY 03 **************************************************************/

/*1. Update the categoryName From “Beverages” to "Drinks" in the categories table.*/

select * from categories;

update categories set categoryname = 'Drinks' where categoryname='Beverages';

/*2.  Insert into shipper new record (give any values) Delete that new record from shippers table.*/

select * from shippers;

insert into shippers(shipperid, companyname) values(4,'UPS shipping');

delete from shippers where shipperid=4;


/* 3.    Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both category and products table to show the cascade.
 Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.
*/

alter table products drop constraint Fk_products_categoryid;

alter table products
add constraint Fk_products_categoryid
foreign key (categoryid)
references categories(categoryid)
on update cascade
on delete cascade;

select * from categories;
select * from products where categoryid=3;
update categories set categoryid=1001 where categoryid=1;

select * from order_details order by productid asc;
select * from categories;
select * from products where categoryid=3;
delete from categories where categoryid=3



/*4) Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null */

alter table orders drop constraint Fk_orders_customerid;

alter table orders
add constraint Fk_orders_customerid
foreign key (customerid)
references customers(customerid)
on delete SET NULL;

select * from customers where customerid='VINET';
delete from customers


/*5.Insert the following data to Products using UPSERT:*/

select * from products WHERE productid=100;

insert into products(productid,productname,quantityperunit,unitprice,discontinued,categoryid)
values (100,'Wheat Bread',1,13,0,5)
on conflict(productid)
do update 
set  productname = EXCLUDED.productname,
	 quantityperunit = EXCLUDED.quantityperunit,
	 unitprice = EXCLUDED.unitprice,
	 discontinued = EXCLUDED.discontinued,
	 categoryid = EXCLUDED.categoryid;


select * from products WHERE productid=101;

insert into products(productid,productname,quantityperunit,unitprice,discontinued,categoryid)
values (101,'Wheat Bread',5,13,0,5)
on conflict(productid)
do update 
set  productname = EXCLUDED.productname,
	 quantityperunit = EXCLUDED.quantityperunit,
	 unitprice = EXCLUDED.unitprice,
	 discontinued = EXCLUDED.discontinued,
	 categoryid = EXCLUDED.categoryid;

select * from products WHERE productid=100;

insert into products(productid,productname,quantityperunit,unitprice,discontinued,categoryid)
values (100,'Wheat Bread',5,13,0,5)
on conflict(productid)
do update 
set  productname = EXCLUDED.productname,
	 quantityperunit = EXCLUDED.quantityperunit,
	 unitprice = EXCLUDED.unitprice,
	 discontinued = EXCLUDED.discontinued,
	 categoryid = EXCLUDED.categoryid;

/*6.Write a MERGE query:Create temp table with name:  ‘updated_products’ and insert values */

drop table updated_products;
create temporary table updated_products(productid int,productname varchar(20),quantityperunit varchar(50),unitprice int, discontinued int,categoryid int);

insert into updated_products  values(100,'Wheat bread','10',20,1,5);
insert into updated_products  values(101,'Wheat bread','5 boxes',19.99,0,5);
insert into updated_products  values(102,'Midnight Mango Fizz','24 - 12 oz bottles',19,0,1);
insert into updated_products  values(103,'Savory Fire Sauce','12 - 550 ml bottles',10,0,2);

select * from products

select categoryid from updated_products where categoryid not in (
select categoryid from categories
)

select * from categories;

update updated_products set categoryid = 1001 where categoryid = 1;

update products set categoryid = 1001 where categoryid = 1;

Merge into products   using (select * from updated_products) as up
on products.productid = up.productid
when matched and up.discontinued =0 then
 update set unitprice = up.unitprice,
            discontinued = up.discontinued
when matched and up.discontinued =1 then
	delete
when not matched and up.discontinued =0 then
insert (productid,productname,quantityperunit,unitprice,discontinued,categoryid)
values (up.productid,up.productname,up.quantityperunit,up.unitprice,up.discontinued,up.categoryid)

select * from products where productid in (100,101,102,103);
    