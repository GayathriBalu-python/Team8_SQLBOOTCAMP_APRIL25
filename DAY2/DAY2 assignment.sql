--1)Alter Table:
/*Add a new column linkedin_profile to employees table to store LinkedIn 
URLs as varchar*/
select * from employees
alter table employees 
add column linkedin_profile varchar(100);

/*Change the linkedin_profile column data type from VARCHAR to TEXT*/
alter table employees 
alter column linkedin_profile 
set data type text;

--Add unique, not null constraint to linkedin_profile

UPDATE employees
SET linkedin_profile = ('https://linkedin.com/placeholder/'|| ' '|| employeeid)
WHERE linkedin_profile IS NULL;

select * from employees

ALTER TABLE employees
ADD CONSTRAINT unique_linkedin_profile UNIQUE (linkedin_profile);


ALTER TABLE employees
ALTER COLUMN linkedin_profile SET NOT NULL;

--Drop column linkedin_profile
alter table employees
drop column linkedin_profile;



 select linkedin_profile from employees 


--      Querying (Select)
 --Retrieve the employee name and title of all employees
 
 select employee_name,title 
 from employees;
 
-- Find all unique unit prices of products
select * from products

select distinct unitprice from products 

 --List all customers sorted by company name in ascending order

 select contactname,companyname
 from customers 
order by companyname;
 --Display product name and unit price, but rename the unit_price column as price_in_usd
SELECT productname, unitprice as price_in_usd
from products
--Get all customers from Germany.
select * from customers where country='Germany'


--Find all customers from France or Spain
select * from customers where country = 'France' or country='Spain'

--Retrieve all orders placed in 2014(based on order_date), and either have 
--freight greater than 50 or the shipped date available (i.e., non-NULL)  
--(Hint: EXTRACT(YEAR FROM order_date))
select* from products

select * from orders where (date_part ('year', orderDate) = 2014) and (freight > 50 or shippedDate is not null)
4)      Filtering
-- Retrieve the product_id, product_name, and unit_price of products where 
--the unit_price is greater than 15.
select productid,productname,unitprice 
from products
where unitprice >15

--List all employees who are located in the USA and have the title "Sales 
--Representative".
select employee_name from employees where country='USA' and title='Sales Representative'

--Retrieve all products that are not discontinued and priced greater than 30.
select * from products
where discontinued='1' and unitprice >30
5)      LIMIT/FETCH
-- Retrieve the first 10 orders from the orders table.
select * from orders limit 10

-- Retrieve orders starting from the 11th order, fetching 10 rows 
--(i.e., fetch rows 11-20).
select * from orders 
offset 10
fetch next 10 rows only;
 
 /*Filtering (IN, BETWEEN)
List all customers who are either Sales Representative, Owner*/
select * from customers 
where contacttitle='Sales Representative' OR contacttitle='Owner'


--Retrieve orders placed between January 1, 2013, and December 31, 2013
select * from orders 
where orderdate between '2013-01-01' and '2013-12-31'

--7)      Filtering
--List all products whose category_id is not 1, 2, or 3.
select * from products 
where categoryid not in (1,2,3)

--Find customers whose company name starts with "A".
select * from customers where companyname like 'A%'
/* 8)       INSERT into orders table:
 Task: Add a new order to the orders table with the following details:
Order ID: 11078
Customer ID: ALFKI
Employee ID: 5
Order Date: 2025-04-23
Required Date: 2025-04-30
Shipped Date: 2025-04-25
shipperID:2
Freight: 45.50*/
insert into orders (orderid,customerid,Employeeid,orderdate,requireddate,shippeddate,shipperid,freight)
values (11078,'ALFKI',5,'2025-04-23','2025-04-30','2025-04-25',2,45.50)
SELECT * FROM ORDERS
where orderid= 11078
/*9)      Increase(Update)  the unit price of all products in category_id =2 
by 10%(HINT: unit_price =unit_price * 1.10)*/
update products
set unitprice =unitprice*1.10
where categoryid=2

select * from products 
where categoryid=2








