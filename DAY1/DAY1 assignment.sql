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
ALTER TABLE employees
RENAME COLUMN employee_ID TO employeeID;
select * from employees

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

CREATE TABLE orders (
    orderID SERIAL PRIMARY KEY,
    customerID VARCHAR,
    employeeID INT ,
    orderDate DATE,
    requiredDate DATE,
    shippedDate DATE,
    shipperID INT ,
    freight DECIMAL,
	FOREIGN KEY (shipperID) REFERENCES shippers(shipperid),
	FOREIGN KEY (customerID) REFERENCES customers(customerID),
	FOREIGN KEY (employeeid) REFERENCES employees(employeeid)
);


select * from orders

create table products(
productID serial PRIMARY KEY,
productname varchar(100) unique,
quantityperunit varchar(100) not null,
unitprice decimal(10,2) not null,
discontinued integer default 0,
categoryID integer,
fOREIGN KEY (categoryID) REFERENCES categories(categoryID)
);