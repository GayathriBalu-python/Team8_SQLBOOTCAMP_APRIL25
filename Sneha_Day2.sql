/* 1. Alter Table */

ALTER TABLE employees
ADD COLUMN linkedin_profile varchar(100);

ALTER TABLE employees
ALTER COLUMN linkedin_profile SET DATA TYPE TEXT;

UPDATE employees SET linkedin_profile = 'linkedin.com/' || ' ' || employee_name;

ALTER TABLE EMPLOYEES
ALTER COLUMN linkedin_profile SET NOT NULL;

ALTER TABLE EMPLOYEES
ADD CONSTRAINT linkedin_unique UNIQUE (linkedin_profile);

ALTER TABLE EMPLOYEES
DROP COLUMN linkedin_profile;

/*2. Querying(select)*/

SELECT employee_name, title from employees;

SELECT DISTINCT unit_price from products;

SELECT customer_id,company_name FROM customers 
ORDER BY company_name;

SELECT product_name, unit_price as price_in_usd FROM products;

/* 3. Filtering*/

SELECT company_name, country FROM customers WHERE country = 'Germany' ORDER BY company_name;

SELECT company_name, country FROM customers WHERE country = 'France' or country = 'Spain' ORDER BY company_name;

SELECT * FROM orders where EXTRACT(YEAR FROM order_date) = 2014 AND (freight > 50 or shipped_date IS NOT NULL);

/*4. Filtering*/

SELECT product_id,product_name,unit_price FROM products WHERE unit_price > 15;

SELECT employee_name, country, title from employees WHERE country = 'USA' and title = 'Sales Representative';

SELECT * FROM products where discontinued = 0 and unit_price > 30 order by product_id;
 
/*5. LIMIT/FETCH */

SELECT * FROM ORDERS ORDER BY order_id 
LIMIT 10;

SELECT * FROM ORDERS ORDER BY order_id 
OFFSET 10
LIMIT 10;

/*6. Filtering (IN, BETWEEN) */

SELECT * FROM customers WHERE contact_title in ('Sales Representative', 'Owner');

SELECT * FROM orders WHERE order_date BETWEEN '2013-01-01' AND '2013-12-31';

/*7. Filtering */

SELECT * FROM products where category_id not in (1,2,3);

SELECT * FROM customers WHERE company_name like 'A%';

/*8. INSERT into orders table */

INSERT INTO orders VALUES ( 11078, 'ALFKI', 5, '2025-04-23', '2025-04-30','2025-04-25',2,45.50);

SELECT * FROM ORDERS WHERE ORDER_ID = 11078;


/* 9. Update */

UPDATE products SET unit_price = unit_price * 1.10 WHERE category_id = 2;

SELECT * FROM products where category_id = 2;