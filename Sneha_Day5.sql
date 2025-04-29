/*1.      GROUP BY with WHERE - Orders by Year and Quarter
Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100 */


SELECT
	EXTRACT(
		YEAR
		FROM
			ORDER_DATE
	) AS YEAR,
	EXTRACT(
		QUARTER
		FROM
			ORDER_DATE
	) AS QUARTER,
	COUNT(ORDER_ID),
	ROUND(AVG(FREIGHT)::numeric, 2)
FROM
	ORDERS
WHERE
	FREIGHT> 100
GROUP BY
	YEAR,
	QUARTER
ORDER BY
YEAR,QUARTER;

/* freight cost > 100
2.      GROUP BY with HAVING - High Volume Ship Regions
Display, ship region, no of orders in each region, min and max freight cost
 Filter regions where no of orders >= 5 */

SELECT
	SHIP_REGION,
	COUNT(ORDER_ID) AS NUM_OF_ORDERS,
	MIN(FREIGHT),
	MAX(FREIGHT)
FROM
	ORDERS
GROUP BY
	SHIP_REGION
HAVING
	COUNT(ORDER_ID) >= 5
ORDER BY
	SHIP_REGION NULLS FIRST;

/* 3.      Get all title designations across employees and customers ( Try UNION & UNION ALL) */

SELECT
	CONTACT_TITLE
FROM
	CUSTOMERS
UNION
SELECT
	TITLE
FROM
	EMPLOYEES;
--union all
SELECT
	CONTACT_TITLE
FROM
	CUSTOMERS
UNION ALL
SELECT
	TITLE
FROM
	EMPLOYEES;

/* 4.      Find categories that have both discontinued and in-stock products
(Display category_id, instock means units_in_stock > 0, Intersect */

SELECT
	CATEGORY_ID
FROM
	PRODUCTS
WHERE
	DISCONTINUED = 1
INTERSECT
SELECT
	CATEGORY_ID
FROM
	PRODUCTS
WHERE
	UNITS_IN_STOCK > 0;

/* 5, Find orders that have no discounted items (Display the  order_id, EXCEPT)*/
SELECT
	ORDER_ID
FROM
	ORDER_DETAILS
EXCEPT
SELECT distinct
	ORDER_ID
FROM
	ORDER_DETAILS
WHERE
	DISCOUNT > 0;



