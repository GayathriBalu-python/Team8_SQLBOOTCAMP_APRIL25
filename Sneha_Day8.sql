/*  1. Create view vw_updatable_products (use same query whatever I used in the training)
Try updating view with below query and see if the product table also gets updated.
Update query:
UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10; */

CREATE VIEW VW_UPDATABLE_PRODUCTS AS
SELECT
	PRODUCT_ID,
	PRODUCT_NAME,
	UNIT_PRICE,
	UNITS_IN_STOCK,
	DISCONTINUED
FROM
	PRODUCTS
WHERE
	DISCONTINUED = 0
WITH
	CHECK OPTION;

	
UPDATE VW_UPDATABLE_PRODUCTS
SET
	UNIT_PRICE = UNIT_PRICE * 1.1
WHERE
	UNITS_IN_STOCK < 10;

-- Only 8 rows with discontinued = 0 got updated.

SELECT
	*
FROM
	PRODUCTS
WHERE
	UNITS_IN_STOCK < 10
	AND DISCONTINUED = 0;

/* 2. Transaction:
Update the product price for products by 10% in category id=1
Try COMMIT and ROLLBACK and observe what happens. */

BEGIN;
UPDATE PRODUCTS
SET
	UNIT_PRICE = UNIT_PRICE * 1.10
WHERE
	CATEGORY_ID = 1;

DO $$
begin 

if EXISTS (
select 1 from produCTS where category_id =1 and unit_price > 50 ) then 
raise exception 'some prices exceed $50';
else raise notice 'price update successful';
end if ;
end $$;

COMMIT;

ROLLBACK;

SELECT *  FROM PRODUCTS WHERE CATEGORY_ID =1  AND UNIT_PRICE > 50;
UPDATE PRODUCTS SET UNIT_PRICE =  WHERE CATEGORY_ID = AND UNIT_PRICE 

/* 3.  Create a regular view which will have below details (Need to do joins):
Employee_id,
Employee_full_name,
Title,
Territory_id,
territory_description,
region_description */
CREATE OR REPLACE VIEW VW_EMPLOYYES_DETAILS AS
SELECT
	E.EMPLOYEE_ID,
	CONCAT(E.FIRST_NAME, ' ', E.LAST_NAME) AS FULL_NAME,
	E.TITLE,
	ET.TERRITORY_ID,
	T.TERRITORY_DESCRIPTION,
	R.REGION_DESCRIPTION
FROM
	EMPLOYEES E
	INNER JOIN EMPLOYEE_TERRITORIES ET ON E.EMPLOYEE_ID = ET.EMPLOYEE_ID
	INNER JOIN TERRITORIES T ON ET.TERRITORY_ID = T.TERRITORY_ID
	INNER JOIN REGION R ON T.REGION_ID = R.REGION_ID
  ORDER BY
	EMPLOYEE_ID;

	SELECT * FROM VW_EMPLOYYES_DETAILS;
	   
/* 4.     Create a recursive CTE based on Employee Hierarchy */

WITH RECURSIVE
	CTE_EMPLOYEEHIERARCHY AS (
		SELECT
			EMPLOYEE_ID,
			FIRST_NAME,
			LAST_NAME,
			REPORTS_TO,
			0 AS LEVEL
		FROM
			EMPLOYEES E
		WHERE
			REPORTS_TO IS NULL
		UNION ALL
		SELECT
			E.EMPLOYEE_ID,
			E.FIRST_NAME,
			E.LAST_NAME,
			E.REPORTS_TO,
			EH.LEVEL + 1
		FROM
			EMPLOYEES E
			JOIN CTE_EMPLOYEEHIERARCHY EH ON EH.EMPLOYEE_ID = E.REPORTS_TO
	)
SELECT
	LEVEL,
	EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME AS EMPLOYEE_NAME
FROM
	CTE_EMPLOYEEHIERARCHY
ORDER BY
	LEVEL,
	EMPLOYEE_ID;
 



