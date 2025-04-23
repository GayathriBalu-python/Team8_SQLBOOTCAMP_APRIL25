CREATE TABLE categories(
categoryID INT PRIMARY KEY,
categoryName VARCHAR(50) NOT NULL,
description TEXT
);
select * from categories

CREATE TABLE Product(
productID INT PRIMARY KEY,
productName VARCHAR(50) ,
quantityPerUnit text,
unitPrice float,
discontinued float,
categoryID int,
FOREIGN KEY (categoryID) REFERENCES categories(categoryID)

);
 select * from Product

CREATE TABLE customers(
customerID VARCHAR(5) PRIMARY KEY,
campanyName VARCHAR(100)  ,
contactname VARCHAR(100) ,
ContactTitle VarChar(100) ,
city Varchar (50) ,
country Varchar(50)
);

select * from customers

CREATE TABLE order_details(
productID INT,
orderID INT,
unitPrice decimal(10,2),
quantity INT,
discount Real,
FOREIGN KEY (orderID) REFERENCES orders(orderID),
FOREIGN KEY (productID) REFERENCES product(productID)
);

drop table order_details
CREATE TABLE shippers(
shippersID INT PRIMARY KEY,
shippersName VARCHAR(50) 
);

select * from shippers

CREATE TABLE Employee(
employeeID INT PRIMARY KEY,
employeeName VARCHAR(50) ,
title Varchar(50) ,
city varchar (25) ,
country varchar(10) ,
reportsto int
);

select * from Employee

create table orders(
orderid int primary key,
customerid varchar(10),
employeeid int,
order_date date,
requiredate date,
shippeddate date,
shippersid int,
freight float,
foreign key (customerid) references customers(customerid),
foreign key (employeeid) references employee(employeeid),
foreign key (shippersid) references shippers(shippersid)
);

select * from orders









 