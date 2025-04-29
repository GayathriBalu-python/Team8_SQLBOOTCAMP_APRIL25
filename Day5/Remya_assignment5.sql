--Day 5
 
--1.GROUP BY with WHERE - Orders by Year and Quarter. Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100

 SELECT EXTRACT(YEAR FROM order_date) AS order_year,
 EXTRACT(QUARTER FROM order_date) AS order_quarter,
 COUNT(*)AS order_count,
 ROUND(AVG(freight)::numeric, 2) AS avg_freight_cost
 FROM
    orders
	WHERE
    freight > 100
GROUP BY   EXTRACT(YEAR FROM order_date),
  EXTRACT(QUARTER FROM order_date)
ORDER BY EXTRACT(YEAR FROM order_date),
EXTRACT(QUARTER FROM order_date);
 
 --2.GROUP BY with HAVING - High Volume Ship Regions Display, ship region, no of orders in each region, min and max freight cost
 --Filter regions where no of orders >= 5
 
 SELECT ship_region, COUNT(*)AS order_count,MIN(freight) AS Min_freight_cost,MAX(freight) AS Max_freight_cost
 FROM orders
 GROUP BY ship_region
 HAVING 
 COUNT(*) >= 5
 ORDER BY ship_region
 
 --3.Get all title designations across employees and customers ( Try UNION & UNION ALL)
 
SELECT title FROM employees
UNION
SELECT contact_title FROM customers
ORDER BY title;

SELECT title FROM employees
UNION ALL
SELECT contact_title FROM customers
ORDER BY title;

--4.Find categories that have both discontinued and in-stock products
--(Display category_id, instock means units_in_stock > 0, Intersect)
SELECT CATEGORY_ID
FROM PRODUCTS
WHERE DISCONTINUED = 1 INTERSECT
	SELECT CATEGORY_ID
	FROM PRODUCTS WHERE UNITS_IN_STOCK > 0
ORDER BY CATEGORY_ID;

--5.Find orders that have no discounted items (Display the  order_id, EXCEPT)

SELECT DISTINCT order_id
FROM order_details

EXCEPT

SELECT DISTINCT order_id
FROM order_details
WHERE discount > 0
ORDER BY order_id;
