/**********************************************   DAY 05    ***************************************************************/


Select * from customers;
select * from orders;
select * from order_details;
select * from products;
select * from categories;
select * from employees;
select * from shippers;

/*1.      GROUP BY with WHERE - Orders by Year and Quarter*/

select count(1),Extract(year from order_date)as Order_year, Extract(Quarter from order_date)as Quarter,round(avg(freight)::numeric,2) as Avg_Freight from orders 
where freight>100
group by Extract(year from order_date),Extract(Quarter from order_date)
order by order_year,Quarter;

/*2.GROUP BY with HAVING - High Volume Ship Regions
Display, ship region, no of orders in each region, min and max freight cost
 Filter regions where no of orders >= 5
*/

select ship_region, count(1),max(freight) as Max_freight, min(freight) as Min_frieght from orders group by ship_region having count(1)>5;

/*3.      Get all title designations across employees and customers ( Try UNION & UNION ALL)
*/

select title,count(1) from employees group by title union 
select contact_title,count(1) from customers group by contact_title;

/*4. Find categories that have both discontinued and in-stock products
 */

 select * from products;

 select category_id,product_name from products where discontinued =1 
 intersect 
 select category_id,product_name from products where units_in_stock >0;


/*5.      Find orders that have no discounted items (Display the  order_id, EXCEPT)*/
select * from orders;
select * from order_details;
select * from products;

select * from order_details where discount=0;

(select order_id from order_details) except (select order_id from  order_details where discount > 0);


