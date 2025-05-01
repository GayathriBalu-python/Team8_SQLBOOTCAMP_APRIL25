------------------------------------Day 7----------------------------------------
/*1.     Rank employees by their total sales
(Total sales = Total no of orders handled, JOIN employees and orders table)*/

select
    e.employee_id,
    e.first_name || '_' || e.last_name AS employee_name,
    Count(o.order_id) as total_orders,
    Rank() Over (Order  by count(o.order_id) desc) as sales_rank
from employees e
join orders o ON e.employee_id = o.employee_id
group by e.employee_id, e.first_name, e.last_name
order by sales_rank

   
 
/*2. Compare current order's freight with previous and next order for each customer.
(Display order_id,  customer_id,  order_date,  freight,
Use lead(freight) and lag(freight)*/


select o.order_id,c.customer_id,o.order_date,o.freight,
lag(o.freight)over(partition by c.customer_id order by o.order_date) as previous_order,
lead(o.freight) over(partition by c.customer_id order by o.order_date) as next_order
from customers c
join orders o ON c.customer_id = o.customer_id
order by c.customer_id,o.order_id


 
/*3. Show products and their price categories, product count in each category, avg price:
        	(HINT:
·  	Create a CTE which should have price_category definition:
        	WHEN unit_price < 20 THEN 'Low Price'
            WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price'
·  	In the main query display: price_category,  product_count in each price_category,
ROUND(AVG(unit_price)::numeric, 2) as avg_price)*/

with price_category_cte as(
  select product_id,product_name,unit_price,
 
  case
     when unit_price< 20 then 'LOW Price'
	 when unit_price < 50 THEN 'Medium Price'
   Else 'High Price'
   end as Price_category
   
    from products
 
)
select price_category, count(product_id) as product_count,--product_name,
ROUND(AVG(unit_price)::numeric, 2) AS avg_price
from price_category_cte
group by price_category--,product_name
order by price_category
 

 
