---1.      GROUP BY with WHERE - Orders by Year and Quarter
---Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100

select * from orders ---#order_id, order_date, avg_freight
select * from order_details -- #quantity,order_id

select extract(year from orders.order_date) as order_year, extract(quarter from orders.order_date), avg(orders.freight) as avg_freight, count(*) as order_count  from orders
inner join order_details on orders.order_id = order_details.order_id where freight> 100 group by 2,1 order by 1,2
 
---2.      GROUP BY with HAVING - High Volume Ship Regions
---Display, ship region, no of orders in each region, min and max freight cost
---Filter regions where no of orders >= 5
select * from orders -- #ship_via, ship_region

SELECT ship_region, COUNT(*)AS No_of_orders,MIN(freight) AS freight_min_cost, MAX(freight) AS freight_max_cost
FROM orders
GROUP BY ship_region
HAVING 
COUNT(*) >= 5
ORDER BY ship_region

---3.      Get all title designations across employees and customers ( Try UNION & UNION ALL)
SELECT title FROM employees
UNION
SELECT contact_title FROM customers
ORDER BY title;

SELECT title FROM employees
UNION ALL
SELECT contact_title FROM customers
ORDER BY title;

---4.      Find categories that have both discontinued and in-stock products
---(Display category_id, instock means units_in_stock > 0, Intersect)
SELECT CATEGORY_ID FROM PRODUCTS WHERE DISCONTINUED = 1 
INTERSECT
	SELECT CATEGORY_ID 	FROM PRODUCTS WHERE UNITS_IN_STOCK > 0
ORDER BY CATEGORY_ID;

---5.      Find orders that have no discounted items (Display the  order_id, EXCEPT)

SELECT DISTINCT order_id FROM order_details
EXCEPT SELECT DISTINCT order_id FROM order_details WHERE discount > 0
ORDER BY order_id;
