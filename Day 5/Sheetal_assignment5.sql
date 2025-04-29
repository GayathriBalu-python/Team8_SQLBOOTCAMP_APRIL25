/* Day 05 Assignment */
/* GROUP BY with WHERE - Orders by Year and Quarter */
/* 1. Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100 */

SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(QUARTER FROM order_date) AS order_quarter,
    COUNT(order_id) AS order_count,
    round(AVG(freight)::numeric, 2)
FROM orders
WHERE freight > 100
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(QUARTER FROM order_date)
ORDER BY
    order_year,
    order_quarter;

-------------------------------------------------------------------------------

/* GROUP BY with HAVING - High Volume Ship Regions */
/* 2. Display, ship region, no of orders in each region, min and max freight cost 
   Filter regions where no of orders >= 5  */

select ship_region,count (order_id) ,
min(freight)as min_freight ,max(freight) as max_freight
from orders
group by ship_region
having count (order_id) >= 5;

-------------------------------------------------------------------------------

/* GROUP BY with HAVING - High Volume Ship Regions */
/* 3.Get all title designations across employees and customers ( Try UNION & UNION ALL) */

select title, count (*)
from employees 
group by title

union

select contact_title, count (*)
from customers 
group by contact_title;

-------------------------------------------------------------------------------

/* 4.Find categories that have both discontinued and in-stock products
(Display category_id, instock means units_in_stock > 0, Intersect) */

select category_id from products
where discontinued = 1 
intersect 
select category_id from products
where units_in_stock > 0
order by category_id;

-------------------------------------------------------------------------------

/* 5. Find orders that have no discounted items (Display the  order_id, EXCEPT) */

select distinct order_id
from order_details
except
select distinct order_id
from order_details
where discount > 0
order by order_id;

-------------------------------------------------------------------------------




