--Q1) Create view vw_updatable_products (use same query whatever I used in the training)
--Try updating view with below query and see if the product table also gets updated.
--Update query:
--UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;
 CREATE OR REPLACE VIEW vw_updatable_products AS
SELECT product_id,product_name,supplier_id,category_id,quantity_per_unit,unit_price,units_in_stock,units_on_order,reorder_level,discontinued 
FROM 
    products
WHERE 
    discontinued = 0;
	
SELECT product_id, product_name, unit_price, units_in_stock FROM vw_updatable_products WHERE units_in_stock < 10;

UPDATE vw_updatable_products 
SET unit_price = unit_price * 1.1 
WHERE units_in_stock < 10;      
    
    
    
    


--2. Transaction:--Update the product price for products by 10% in category id=1.--Try COMMIT and ROLLBACK and observe what happens. -- Start transaction
BEGIN;
SELECT product_id, product_name, unit_price AS original_price FROM products 
WHERE category_id = 1;

UPDATE products 
SET limit_price = unit_price * 1.10
WHERE category_id = 1;

SELECT product_id, product_name, unit_price AS updated_price FROM products 
WHERE category_id = 1;

COMMIT;

SELECT product_id, product_name, unit_price AS final_price FROM products 
WHERE category_id = 1;

BEGIN;

SELECT product_id, product_name, unit_price AS original_price FROM products 
WHERE category_id = 1;

UPDATE products 
SET unit_price = unit_price * 1.10
WHERE category_id = 1;

SELECT product_id, product_name, unit_price AS updated_price FROM products 
WHERE category_id = 1;

ROLLBACK;

SELECT product_id, product_name, unit_price AS final_price FROM products 
WHERE category_id = 1;


-- Start fresh transaction
BEGIN;


--3. Create a regular view which will have below details (Need to do joins):--Employee_id,
--Employee_full_name,
--Title,
--Territory_id,
--territory_description,
--region_description

CREATE OR REPLACE VIEW vw_employee_territories AS
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_full_name,
    e.title,
    t.territory_id,
    t.territory_description,
    r.region_description
FROM
    employees e JOIN
    employee_territories et ON e.employee_id = et.employee_id
JOIN
    territories t ON et.territory_id = t.territory_id
JOIN
    region r ON t.region_id = r.region_id ORDER BY
						 r.region_description,
						 t.territory_description,
						 employee_full_name;
	
--4.Create a recursive CTE based on Employee Hierarchy
 
 WITH RECURSIVE cte_employeehierarchy AS (
    SELECT 
        employee_id,
        first_name,
	    last_name,
        reports_to,
        0 AS level
    FROM 
        employees
    WHERE 
        reports_to IS NULL 
    
    UNION ALL
    
    SELECT 
        e.employee_id,
        e.first_name,
        e.last_name,
        e.reports_to,
        eh.level + 1
    FROM 
        employees e
    JOIN 
        cte_employeehierarchy eh 
	 ON
	 e.reports_to = eh.employee_id
)
SELECT 
level,
    employee_id,
   first_name || ' ' || last_name AS employee_name
FROM 
  cte_employeehierarchy
ORDER BY 
   level,employee_id;
   
   SELECT employee_id, first_name, reports_to FROM employees;