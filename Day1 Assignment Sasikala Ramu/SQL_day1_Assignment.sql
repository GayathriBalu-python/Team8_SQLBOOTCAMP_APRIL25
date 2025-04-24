create DATABASE "Northwind"

create TABLE categories(
categoryID INT PRIMARY KEY, --- set category id as primary key
categoryName VARCHAR(255), ---- 
description VARCHAR(255)

);

create Table shippers(
shipperID INT Primary Key, ----- set shipper id as shipperkey
companyName VARCHAR(255)

);

create table products(
productID INT Primary key, ------ set product id as primary key
productName VARCHAR(255),
quantityPerUnit VARCHAR(255),
unitPrice INT,
discontinued INT,
categoryID INT,
constraint fk_CategoryID foreign key(categoryID) references categories(categoryID) ---- set category id as foreign key from categories table
)


alter table products alter column unitPrice type FLOAT

create table orders(
orderID INT primary Key, -- set orderID as primary key
customerID INT,
employeeID INT,
orderDate DATE NOT NULL,
requiredDate DATE NOT NULL,
shippedDate DATE NOT NULL,
shipperID INT,
freight FLOAT
)

alter table orders alter column orderDate Drop not null;
alter table orders alter column requiredDate Drop not null;

alter table orders alter column shippedDate Drop not null;

alter table orders alter column customerID type VARCHAR(255)

create table order_details(
orderID INT references orders(orderID),
productID INT references products(productID),
unitPrice FLOAT,
quantity INT,
discount FLoat

)

select * from order_details

alter table orders add constraint fk_shipperid foreign key(shippers) references shippers(shipperID); -- set shipperid as foreignkey for order table



create table employees(
employeeID INT primary Key, ----- set employeeid as primary key
employeeName VARCHAR(255),
title VARCHAR(255),
city VARCHAR(255),
country VARCHAR(255),
reportsTo int

)

create table customers(
customerID INT,
companyName VARCHAR(255),
contactName VARCHAR(255),
contactTitle VARCHAR(255),
city VARCHAR(255),
country VARCHAR(255)

)



select * from customers
select * from shippers
select * from employees
select * from products
select * from orders
select * from order_details