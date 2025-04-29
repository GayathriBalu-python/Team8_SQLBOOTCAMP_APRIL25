	        					---Day 5
 
/*1. GROUP BY with WHERE - Orders by Year and Quarter
Display, order year, quarter, order count, avg freight cost only for those orders 
where freight cost > 100*/
select * from orders limit 5

select  count(*) as order_count,
		round(avg(freight)::numeric,2) as average_freight_cost,
		extract(year from order_date) as year,
	    extract(quarter from order_date) as quarter
from orders
where 
freight > 100
group by extract(year from order_date),
	     extract(quarter from order_date)
order by  year,quarter desc

/*2    GROUP BY with HAVING - High Volume Ship Regions
Display, ship region, no of orders in each region, min and max freight cost
 Filter regions where no of orders >= 5*/
 
 select ship_region,count(*)as Num_of_orders,
        round(min(freight)::numeric,2) as minimum_freight_cost,
        round(max(freight)::numeric,2) as maximum_freight_cost
from orders

group by ship_region 
having 
	 count(*)>=5
--3.Get all title designations across employees and customers ( Try UNION & UNION ALL)

select * from customers

select title, count(*)
from employees
group by title

union 

select contact_title, count(*)
from customers
group by contact_title

/*4.      Find categories that have both discontinued and in-stock products
(Display category_id, instock means units_in_stock > 0, Intersect)*/

select* from order_details
select * from categories

select distinct category_id,units_in_stock from products
where units_in_stock>0
intersect
select distinct category_id,units_in_stock from products
where discontinued =1

--5.Find orders that have no discounted items (Display the  order_id, EXCEPT)

select o.order_id,o.order_date,o.customer_id
from orders o
-- to get more detailed info from order table
where order_id in(
			select distinct order_id 
			from order_details
			
			except
			
			select distinct order_id 
			from order_details
			where discount>0
)


							