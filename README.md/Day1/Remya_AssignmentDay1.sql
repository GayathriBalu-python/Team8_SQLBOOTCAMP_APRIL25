---DAY1--
-- Create categories table
CREATE TABLE categories (
    "categoryID" SERIAL PRIMARY KEY,
    "categoryName" VARCHAR(50) NOT NULL,
    "description" TEXT
);
-- Create customers table
CREATE TABLE customers (
    "customerID" VARCHAR(10) PRIMARY KEY,
    "companyName" VARCHAR(100) NOT NULL,
    "contactName" VARCHAR(50) NOT NULL,
    "contactTitle" VARCHAR(50),
    "city" VARCHAR(50),
    "country" VARCHAR(50)
);

-- Create employees table
CREATE TABLE employees (
    "employeeID" SERIAL PRIMARY KEY,
    "employeeName" VARCHAR(50) NOT NULL,
    "title" VARCHAR(100),
    "city" VARCHAR(50),
    "country" VARCHAR(50),
    "reportsTo" INTEGER REFERENCES employees("employeeID")
);

-- Create shippers table
CREATE TABLE shippers (
    "shipperID" SERIAL PRIMARY KEY,
    "companyName" VARCHAR(100) NOT NULL
);
-- Create products table
CREATE TABLE products (
    "productID" SERIAL PRIMARY KEY,
    "productName" VARCHAR(100) NOT NULL,
    "quantityPerUnit" VARCHAR(50),
    "unitPrice" NUMERIC(10,2) NOT NULL,
    "discontinued" BOOLEAN DEFAULT FALSE,
    "categoryID" INTEGER REFERENCES categories("categoryID")
);

-- Create orders table
CREATE TABLE orders (
    "orderID" SERIAL PRIMARY KEY,
    "customerID" VARCHAR(10) REFERENCES customers("customerID"),
    "employeeID" INTEGER REFERENCES employees("employeeID"),
    "orderDate" DATE,
    "requiredDate" DATE,
    "shippedDate" DATE,
    "shipperID" INTEGER REFERENCES shippers("shipperID"),
    "freight" NUMERIC(10, 2)
);

-- Create order_details table with composite primary key
CREATE TABLE order_details (
    "orderID" INTEGER NOT NULL,
    "productID" INTEGER NOT NULL,
    "unitPrice" NUMERIC(10, 2) NOT NULL,
    "quantity" SMALLINT NOT NULL CHECK ("quantity" > 0),
    "discount" NUMERIC(4, 2) CHECK ("discount" >= 0 AND "discount" <= 1),
    PRIMARY KEY ("orderID", "productID"),
    FOREIGN KEY ("orderID") REFERENCES orders("orderID"),
    FOREIGN KEY ("productID") REFERENCES products("productID")
);

--showing the tables after creating
SELECT * FROM categories;
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM order_details;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM shippers;
---Constraint
--Primary Keys Purpose is uniquely identify each record in a table
--Composite PK for order_details (orderID + productID) 
