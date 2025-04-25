
/*1) Update the categoryName From “Beverages” to "Drinks" in the categories table.*/

UPDATE categories SET category_name = 'Drinks' WHERE category_name = 'Beverages';

select * from categories order by category_id;

/*2) Insert into shipper new record (give any values) Delete that new record from shippers table.*/

SELECT * FROM shippers;

INSERT INTO shippers VALUES(4,'DHL');

DELETE FROM shippers where shipper_id = 4;

/* 3) Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. 
  Display the both category and products table to show the cascade.
 Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically 
 from products. */


ALTER TABLE products
DROP CONSTRAINT products_category_id_fkey;

ALTER TABLE products
ADD CONSTRAINT products_category_id_fkey
FOREIGN KEY (category_id)
REFERENCES categories (category_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

SELECT * FROM categories WHERE Category_id = 1;
SELECT * FROM PRODUCTS where category_id = 1;

UPDATE categories SET category_id = 1001 where category_id = 1;


SELECT * FROM categories WHERE Category_id = 1001;
SELECT * FROM PRODUCTS where category_id = 1001;


ALTER TABLE order_details
DROP CONSTRAINT order_details_product_id_fkey;

ALTER TABLE order_details
ADD CONSTRAINT order_details_product_id_fkey
FOREIGN KEY (product_id)
REFERENCES products (product_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

select * from categories where category_id =3 ;

select * from products where category_id = 3;

DELETE FROM categories WHERE category_id = 3;

/* 4)  Delete the customer = “VINET”  from customers. Corresponding customers
       in orders table should be set to null (HINT: Alter the foreign key on orders(customerID)
	   to use ON DELETE SET NULL) */

ALTER TABLE orders
DROP CONSTRAINT orders_customer_id_fkey;

ALTER TABLE orders
ADD CONSTRAINT orders_customer_id_fkey
FOREIGN KEY (customer_id)
REFERENCES customers (customer_id)
ON UPDATE CASCADE
ON DELETE SET NULL;

DELETE FROM customers WHERE customer_id = 'VINET';

SELECT * FROM CUSTOMERS WHERE customer_id = 'VINET';

SELECT * FROM orders WHERE customer_id = 'VINET';

/* 5)      Insert the following data to Products using UPSERT:
product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=5
product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=5
product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=5
(this should update the quantityperunit for product_id = 100) */

INSERT INTO products 
VALUES (100, 'Wheat bread', '1', 13,0,5),
       (101, 'White bread', '5 boxes', 13,0,5);


INSERT INTO products 
VALUES (100, 'Wheat bread', '10 boxes', 13,0,5)         
ON CONFLICT(product_id)
DO UPDATE SET
  quantity_per_unit = EXCLUDED.quantity_per_unit;

  SELECT * FROM PRODUCTS where product_id >=100;

/* 6)      Write a MERGE query:
Create temp table with name:  ‘updated_products’ and insert values as below:*/

CREATE TEMP TABLE updated_products

(   product_id smallint NOT NULL,
    product_name character varying(40), 
    quantity_per_unit character varying(20),
    unit_price real,
    discontinued integer NOT NULL,
    category_id smallint
);

INSERT INTO updated_products 
  VALUES  (100,'Wheat Bread','10',20,1,3),
          (101,'White Bread','5 boxes',19.99,0,3),
		  (102,'Midnight Mango Fizz','24 - 12 oz bottles',19,0,1),
		  (103,'Savory Fire Sauce','12 - 550 ml bottles',10,0,2);

UPDATE categories SET category_id = 1 where category_id = 1001;


MERGE INTO products p
USING (
    SELECT 
	 product_id, product_name, quantity_per_unit, unit_price,discontinued,category_id
	 FROM updated_products
) u
ON p.product_id = u.product_id
WHEN MATCHED AND u.discontinued = 1 THEN
    DELETE
WHEN MATCHED AND u.discontinued = 0 THEN
    UPDATE SET
        unit_price = u.unit_price
WHEN NOT MATCHED AND u.discontinued = 0 THEN
    INSERT (product_id, product_name, quantity_per_unit, unit_price,discontinued,category_id)
    VALUES (u.product_id, u.product_name, u.quantity_per_unit, u.unit_price,u.discontinued,u.category_id);


 SELECT * FROM PRODUCTS where product_id >=100;

 SELECT * FROM updated_products;

select * from categories;


/*7)      List all orders with employee full names. (Inner join) */

SELECT order_id, concat(e.first_name,' ', e.last_name) as employee_full_name FROM orders o 
INNER JOIN employees e
on o.employee_id = e.employee_id
order by order_id;


