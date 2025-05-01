---1.     Rank employees by their total sales
----(Total sales = Total no of orders handled, JOIN employees and orders table)

SELECT
	O.EMPLOYEE_ID,
	CONCAT(E.LAST_NAME, ' ', E.FIRST_NAME) AS FULL_NAME,
	DENSE_RANK() OVER (
		ORDER BY
			COUNT(O.ORDER_ID) DESC
	)
FROM
	ORDERS O
	JOIN EMPLOYEES E ON O.EMPLOYEE_ID = E.EMPLOYEE_ID
GROUP BY
	O.EMPLOYEE_ID,
	FULL_NAME;
 
---2.      Compare current order's freight with previous and next order for each customer.--(Display order_id,  customer_id,  order_date,  freight,Use lead(freight) and lag(freight).
SELECT ORDER_ID,CUSTOMER_ID,ORDER_DATE,FREIGHT, 
LAG(FREIGHT)  OVER (PARTITION BY CUSTOMER_ID ORDER BY ORDER_ID) AS PREVIOUS_ORDER_FREIGHT,
LEAD(FREIGHT) OVER (PARTITION BY CUSTOMER_ID ORDER BY ORDER_ID) AS NEXT_ORDER_FREIGHT
FROM ORDERS
ORDER BY CUSTOMER_ID,ORDER_ID;
 
--3.     Show products and their price categories, product count in each category, avg price:
        	--(HINT:
--·  	Create a CTE which should have price_category definition:
--        	WHEN unit_price < 20 THEN 'Low Price'
--            WHEN unit_price < 50 THEN 'Medium Price'
--           ELSE 'High Price'
--·  	In the main query display: price_category,  product_count in each price_category,  ROUND(AVG(unit_price)::numeric, 2) as avg_price)
 WITH
	CATEGORY AS (
		SELECT
			PRODUCT_ID,
			UNIT_PRICE,
			CASE
				WHEN UNIT_PRICE < 20 THEN 'Low Price'
				WHEN UNIT_PRICE < 50 THEN 'Medium Price'
				ELSE 'high price'
			END AS PRICE_CATEGORY
		FROM
			PRODUCTS
	)
SELECT
	PRODUCT_ID,
	UNIT_PRICE,
	PRICE_CATEGORY,
	COUNT(PRODUCT_ID) OVER (
		PARTITION BY
			PRICE_CATEGORY
	) AS PRODUCT_COUNT,
	ROUND(
		AVG(UNIT_PRICE) OVER (
			PARTITION BY
				PRICE_CATEGORY
		)::NUMERIC,
		2
	) AS AVERAGE_UNIT_PRICE
FROM
	CATEGORY;


