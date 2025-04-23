create table categories(
categoryid serial primary key,
categoryname varchar(100) unique not null,
description varchar(100) unique not null
);


create table customers(
cutomerID varchar(100) primary key,
companyName varchar(100) unique not null,
contactName varchar(100) unique not null,
contactTitle varchar(100) not null,
city varchar(100) not null,
country varchar(100) not null
);

ALTER TABLE customers
RENAME COLUMN cutomerID TO customerID;
select * from customers



CREATE TABLE employees (
    employee_id serial PRIMARY KEY,
    employee_name VARCHAR(100) unique,
    title VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100),
    report INTEGER  
);


CREATE TABLE order_details (
    orderID INTEGER NOT NULL,
    productID INTEGER NOT NULL,
    PRIMARY KEY (orderID, productID),
    unitprice DECIMAL(10, 2),
    quantity INTEGER,
    discount DECIMAL(5, 2) DEFAULT 0.00
);
select * from order_details

create  table shippers(
	shipperid integer primary key,
	companyname varchar(50) unique not null
);


create table orders(
  orderID serial primary key,
  customerid varchar(100) not null,
  orderDate date not null,
  requiredDate date not null,
  shippedDate date not null,
  shipperID integer not null,
  freight decimal(10,2) not null,
   FOREIGN KEY (customerid) REFERENCES customers(customerid),
   FOREIGN KEY (shipperID) REFERENCES shippers(shipperID)
);
select * from categories

create table products(
productID serial PRIMARY KEY,
productname varchar(100) unique,
quantityperunit varchar(100) not null,
unitprice decimal(10,2) not null,
discontinued integer default 0,
categoryID integer,
fOREIGN KEY (categoryID) REFERENCES categories(categoryID)
);