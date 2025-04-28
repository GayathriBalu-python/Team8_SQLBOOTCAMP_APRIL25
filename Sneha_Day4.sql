/* 1.     List all customers and the products they ordered with the order date. (Inner join) */

SELECT
	C.COMPANY_NAME AS CUSTOMER,
	O.ORDER_ID,
	P.PRODUCT_NAME,
	OD.QUANTITY,
	O.ORDER_DATE
FROM
	CUSTOMERS C
	INNER JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
	INNER JOIN ORDER_DETAILS OD ON O.ORDER_ID = OD.ORDER_ID
	INNER JOIN PRODUCTS P ON OD.PRODUCT_ID = P.PRODUCT_ID;

/*2. Show each order with customer, employee, shipper, and product info — even if some parts are missing. (Left Join) */

SELECT
	O.ORDER_ID,
	C.COMPANY_NAME,
	CONCAT(E.FIRST_NAME, ' ', E.LAST_NAME) AS EMPLOYEE_NAME,
	S.COMPANY_NAME AS SHIPPER,
	P.PRODUCT_NAME
FROM
	ORDERS O
	LEFT JOIN CUSTOMERS C ON O.CUSTOMER_ID = C.CUSTOMER_ID
	LEFT JOIN EMPLOYEES E ON O.EMPLOYEE_ID = E.EMPLOYEE_ID
	LEFT JOIN SHIPPERS S ON O.SHIP_VIA = S.SHIPPER_ID
	LEFT JOIN ORDER_DETAILS OD ON O.ORDER_ID = OD.ORDER_ID
	LEFT JOIN PRODUCTS P ON OD.PRODUCT_ID = P.PRODUCT_ID;

/* 3.   Show all order details and products (include all products even if they were never ordered). (Right Join) */

SELECT
	OD.ORDER_ID,
	P.PRODUCT_ID,
	P.PRODUCT_NAME
FROM
	ORDER_DETAILS OD
	RIGHT JOIN PRODUCTS P ON OD.PRODUCT_ID = P.PRODUCT_ID
	ORDER BY OD.ORDER_ID
	NULLS FIRST;

/* 4. List all product categories and their products — including categories that have no products, and products 
      that are not assigned to any category.(Outer Join) */

SELECT * FROM 
    CATEGORIES C 
	FULL OUTER JOIN
	PRODUCTS P
	on c.category_id = p.category_id
	ORDER BY C.CATEGORY_ID;
	
/* 5. 	Show all possible product and category combinations (Cross join).*/


SELECT
	P.PRODUCT_ID,
	P.PRODUCT_NAME, C.CATEGORY_ID,
	C.CATEGORY_NAME
FROM
	PRODUCTS P
	CROSS JOIN CATEGORIES C;

/* 6. 	Show all employees who have the same manager(Self join)*/


SELECT
	E1.FIRST_NAME || ' ' || E1.LAST_NAME AS EMPLOYEE_NAME,
	E2.FIRST_NAME || ' ' || E2.LAST_NAME AS MANAGER_NAME
FROM
	EMPLOYEES E1
	INNER JOIN EMPLOYEES E2 ON E1.REPORTS_TO = E2.EMPLOYEE_ID
WHERE
	E1.EMPLOYEE_ID != E2.EMPLOYEE_ID;

 /* 7. LIST ALL CUSTOMERS WHO HAVE NOT SELECTED A SHIPPING METHOD. */    
 
SELECT
	C.CUSTOMER_ID,
	C.COMPANY_NAME
FROM
	CUSTOMERS C
	LEFT JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
WHERE
	O.SHIP_VIA IS NULL;

