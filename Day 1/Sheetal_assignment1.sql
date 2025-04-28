create table products (
productID SERIAL PRIMARY KEY,
productName VARCHAR (50) UNIQUE NOT NULL,
quantityPerUnit VARCHAR (50),
unitPrice NUMERIC,
discontinued INTEGER,
categoryID INTEGER 
);

alter table products
add constraint fk_categories
FOREIGN KEY (categoryID)
REFERENCES categories(categoryID);

select * from products;

create table employees (
employeeID SERIAL PRIMARY KEY,
employeeName VARCHAR (50) UNIQUE NOT NULL,
title VARCHAR (50) ,
city VARCHAR (50),
country VARCHAR (50),
reportsTo INTEGER 
);

create table shippers (
shipperID SERIAL PRIMARY KEY,
companyName VARCHAR (50) UNIQUE NOT NULL
);

select * from shippers;

create table categories (
categoryID SERIAL PRIMARY KEY,
categoryName VARCHAR (50) UNIQUE NOT NULL,
description VARCHAR (50)
);

select * from categories;

create table customers (
customerID SERIAL PRIMARY KEY,
companyName VARCHAR (50) UNIQUE NOT NULL,
contactName VARCHAR (50) ,
contactTitle VARCHAR (50),
city VARCHAR (50), 
country VARCHAR (50)
);

alter table customers
alter column customerID
set data type integer;

alter table customers
drop constraint companyName;

select * from customers;

create table order_details (
orderID SERIAL PRIMARY KEY,
productID INTEGER,
unitPrice NUMERIC,
quantity INTEGER,
discount NUMERIC 
);

create table orders (
orderID SERIAL PRIMARY KEY,
customerID INTEGER ,
employeeID INTEGER ,
orderDate DATE,
requiredDate DATE, 
shippedDate DATE ,
shipperID INTEGER,
freight DATE ,
CONSTRAINT fk_customer
      FOREIGN KEY(customerID)
        REFERENCES customers(customerID)
);

alter table orders
add constraint fk_employees
FOREIGN KEY (employeeID)
REFERENCES employees(employeeID);

alter table orders
add constraint fk_shippers
FOREIGN KEY (shipperID)
REFERENCES shippers(shipperID);

select * from orders;

alter table employees
add constraint fk_reportsTo
FOREIGN KEY (reportsTo)
REFERENCES employees(reportsTo);



























