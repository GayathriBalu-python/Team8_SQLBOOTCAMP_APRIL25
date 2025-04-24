/***************************************************DAY02-Asssignment (4/24/20025) *********************************************************************************************/

/*1. Alter Table*/

Alter table employees add linkedin_profile varchar(50);
Alter table employees alter column linkedin_profile type text;
alter table employees alter column linkedin_profile set not null;
alter table employees drop column  linkedin_profile;

/*2.Quering*/
select * from employees;
select split_part(employeename,' ',1) as Firstname, split_part(employeename,' ',2) as LastName  from employees;

select * from products;
select distinct unitprice from products;

select * from customers;
select companyname,contactname from customers order by companyname asc;

select productname, unitprice as price_in_usd from products;

/*3.Filtering*/
select * from customers;
select * from customers where country='Germany';
select * from customers where country='France' or country='Spain';

select * from orders;
select * from orders where (select extract(year from orderdate) as order_year) = 2014 and (shippeddate is not null or freight > 50);


/* 4. Filtering*/
select * from products;
select productid, productname, unitprice from products where unitprice > 15;
select * from employees where country='USA' and title = 'Sales Representative';
select * from products where unitprice >30 and discontinued != 1;

/*5.Limit / Fetch*/

select * from orders limit 10;
select * from orders limit 10 offset 10;

/* 6. Filtering (IN,BETWEEN)*/

select * from customers where contacttitle = 'Sales Representative' or contacttitle = 'Owner';
select * from orders where orderdate between '01-01-2013' and '12-31-2013';

/*7. Filtering */
select * from products where categoryid not in (1,2,3);
select * from customers where companyname like 'A%';

/*8. Insert into orders table*/
select * from orders;

insert into orders(orderid,customerid,employeeid,orderdate,requireddate,shippeddate,shipperid,freight) values(11078,'ALFKI',5,'2025-04-23','2025-04-30','2025-04-25',2,45.50)

/*9.   Increase(Update)  the unit price of all products in category_id =2 by 10%.*/

select * from products where categoryid=2;

update  products set unitprice = unitprice+(unitprice*0.1) where categoryid=2;

/*10. Downloaded the Northwind from Git and execute .sql file, it created all the tables*/


