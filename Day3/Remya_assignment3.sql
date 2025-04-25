--Day 3
--1)Update the categoryName From “Beverages” to "Drinks" in the categories table.

SELECT * FROM categories
ORDER BY "categoryID"; 

UPDATE categories
SET "categoryName" = 'Drinks'
WHERE "categoryID" = 1 

--2) Insert into shipper new record (give any values) Delete that new record from shippers table.

INSERT INTO shippers ("shipperID","companyName")
VALUES(4,'United Express')
SELECT * FROM shippers;
DELETE FROM shippers
WHERE "shipperID"=4;

--3)Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too.Display the both category and products table to show the cascade.

-- Drop the existing foreign key constraint
ALTER TABLE products 
DROP CONSTRAINT products_categoryid_fk;

ALTER TABLE products
ADD CONSTRAINT products_categoryid_fk
FOREIGN KEY ("categoryID")
REFERENCES categories("categoryID")
ON UPDATE CASCADE;

UPDATE categories
SET "categoryID" = 1001
WHERE "categoryID"=1;

SELECT * FROM categories 
WHERE "categoryID" = 1001;
SELECT * FROM products 
WHERE "categoryID" = 1001;
-- Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products
ALTER TABLE products
DROP CONSTRAINT products_categoryid_fk;

ALTER TABLE products
ADD CONSTRAINT products_categoryid_fk
FOREIGN KEY ("categoryID")
REFERENCES categories("categoryID")
ON DELETE CASCADE;

DELETE FROM categories
WHERE "categoryID"= 3
SELECT * FROM categories 
WHERE "categoryID" = 3;

--4)Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null (HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)
ALTER TABLE orders
DROP CONSTRAINT  orders_customerid_fk;


ALTER TABLE orders
ADD CONSTRAINT orders_customerid_fk
FOREIGN KEY("customerID")
REFERENCES customers("customerID")
ON DELETE SET NULL;

DELETE FROM customers
WHERE "customerID" = 'VINET'

SELECT * FROM customers
--5)Insert the following data to Products using UPSERT:
--product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=3
--product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=3
--product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=3
--(this should update the quantityperunit for product_id = 100)
INSERT INTO products ("productID", "productName", "quantityPerUnit", "unitPrice", "discontinued", "categoryID")
VALUES (100, 'Wheat bread', '1', 13, false, 3)
ON CONFLICT ("productID") 
DO UPDATE SET
    "productName" = EXCLUDED."productName",
    "quantityPerUnit" = EXCLUDED."quantityPerUnit",
    "unitPrice" = EXCLUDED."unitPrice",
    "discontinued" = EXCLUDED."discontinued",
    "categoryID" = EXCLUDED."categoryID";

INSERT INTO products ("productID", "productName", "quantityPerUnit", "unitPrice", "discontinued", "categoryID")
VALUES (101, 'White bread', '5 boxes', 13, false, 3)
ON CONFLICT ("productID") 
DO UPDATE SET
    "productName" = EXCLUDED."productName",
    "quantityPerUnit" = EXCLUDED."quantityPerUnit",
    "unitPrice" = EXCLUDED."unitPrice",
    "discontinued" = EXCLUDED."discontinued",
    "categoryID" = EXCLUDED."categoryID";
	
INSERT INTO products ("productID", "productName", "quantityPerUnit", "unitPrice", "discontinued", "categoryID")
VALUES (100, 'Wheat bread', '10 boxes', 13, false, 3)
ON CONFLICT ("productID") 
DO UPDATE SET
    "productName" = EXCLUDED."productName",
    "quantityPerUnit" = EXCLUDED."quantityPerUnit",
    "unitPrice" = EXCLUDED."unitPrice",
    "discontinued" = EXCLUDED."discontinued",
    "categoryID" = EXCLUDED."categoryID";
SELECT * FROM products WHERE "productID" IN (100, 101);

--6) Write a MERGE query:
--Create temp table with name:  ‘updated_products’ and insert values as below:
--Update the price and discontinued status for from below table ‘updated_products’ only if there are matching products and updated_products .discontinued =0 
 CREATE TABLE updated_products(
  productID INT PRIMARY KEY,
  productName VARCHAR (100) NOT NULL,
  quantityPerUnit VARCHAR(50),
  unitPrice DECIMAL(10,2),
  discontinued BOOLEAN,
  categoryID INT
 );
INSERT INTO updated_products(productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID)
VALUES  (100, 'Wheat bread', '10', 20, true, 3),
    (101, 'White bread', '5 boxes', 19.99, false, 3),
    (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, false, 1),
    (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, false, 2) 
--MERGE
MERGE INTO products p
USING updated_products up
ON (p."productID" = up.productID)
WHEN MATCHED AND up.discontinued = false THEN
    UPDATE SET 
        "unitPrice" = up.unitPrice,
        "discontinued" = up.discontinued
WHEN MATCHED AND up.discontinued = true THEN
    DELETE
WHEN NOT MATCHED AND up.discontinued = false THEN
    INSERT ("productID", "productName", "quantityPerUnit", "unitPrice", "discontinued", "categoryID")
    VALUES (up.productID, up.productName, up.quantityPerUnit, up.unitPrice, up.discontinued, up.categoryID);
SELECT * FROM products;

--7)List all orders with employee full names. (Inner join)

SELECT 
    o.order_id,
    o.order_date,
    o.required_date,
    o.shipped_date,
    o.ship_via,
    o.freight,
    o.ship_name,
    o.ship_address,
    o.ship_city,
    o.ship_region,
    o.ship_postal_code,
    o.ship_country,
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employeefullname
FROM 
    orders o
INNER JOIN 
    employees e ON o.employee_id = e.employee_id
ORDER BY 
    o.order_id;
