/* 1. ALTER TABLE */

SELECT * FROM employees;

ALTER TABLE employees 
ADD COLUMN linkedin_profile VARCHAR (100);

ALTER TABLE employees 
ALTER COLUMN linkedin_profile TYPE text;

ALTER TABLE employees
ADD CONSTRAINT linkedin_profile_unq UNIQUE(linkedin_profile);

ALTER TABLE employees
ALTER COLUMN linkedin_profile SET NOT NULL;

ALTER TABLE employees
DROP COLUMN linkedin_profile;

---------------------------------------------------------------------

/* 2. QUERYING (SELECT) */

SELECT first_name,last_name,title from employees;

SELECT DISTINCT price_in_usd FROM products;

SELECT * FROM customers ORDER BY company_name ASC;

SELECT * from products;

ALTER TABLE products
RENAME unit_price TO price_in_usd;

SELECT product_name,price_in_usd FROM products;

---------------------------------------------------------------------

/* 3. FILTERING */

SELECT * FROM customers;

SELECT * FROM customers WHERE country='Germany';

SELECT * FROM customers WHERE country IN ('Germany','Spain');

SELECT * FROM orders;

SELECT * FROM orders WHERE EXTRACT (YEAR FROM order_date)= 2014 AND freight > 50 ;

---------------------------------------------------------------------

/* 4. FILTERING */

