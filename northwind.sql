create DATABASE "Northwind"

create TABLE categories(
categoryID INT PRIMARY KEY,
categoryName VARCHAR(255),
description VARCHAR(255)

);

create Table shippers(
shipperID INT Primary Key,
companyName VARCHAR(255)

);

create table products(
productID INT Primary key,
productName VARCHAR(255),
quantityPerUnit VARCHAR(255),
unitPrice INT,
discontinued INT,
categoryID INT,
constraint fk_CategoryID foreign key(categoryID) references categories(categoryID)
)


create table orders(
orderID INT primary Key,
customerID INT,
employeeID INT,
orderDate DATE NOT NULL,
requiredDate DATE NOT NULL,
shippedDate DATE NOT NULL,
shipperID INT,
freight FLOAT
)

create table employees(
employeeID INT primary Key,
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

