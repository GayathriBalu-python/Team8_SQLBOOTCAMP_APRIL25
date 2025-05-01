/**********************************************   DAY 07    ***************************************************************/


Select * from customers;
select * from orders;
select * from order_details;
select * from products;
select * from categories;
select * from employees;
select * from shippers;


/*1.     Rank employees by their total sales
(Total sales = Total no of orders handled, JOIN employees and orders table)
*/

select employee_id,count(1) as Order_count from orders group by employee_id order by order_count desc;


select employee_id,first_name,order_count, Rank() over( order by order_count desc) as Rnk from (
select o.employee_id, e.first_name, count(1) as order_count
from orders o inner join employees e on o.employee_id=e.employee_id  
group by o.employee_id,e.first_name
)


/*2.Compare current order's freight with previous and next order for each customer.
(Display order_id,  customer_id,  order_date,  freight,
Use lead(freight) and lag(freight).*/


select count(order_id), customer_id from orders group by customer_id;

select order_id, customer_id, order_date,freight, 
lag(freight,1) over(partition by customer_id  order by order_date) as previous_freigth,
lead(freight,1) over (partition by customer_id order by order_date) as next_friegth
from orders ;

/*3.Show products and their price categories, product count in each category, avg price:*/

with CTE_pricecategory as(
select product_id,product_name,unit_price,
case 
 when unit_price < 20 then 'Low Price'
 when unit_price < 50 then 'Medium Price'
 else 'High Price'
end 
as Price_category from products
)
select c.price_category,sum(p.units_in_stock) as product_count
from CTE_pricecategory c 
INNER JOIN products p on c.product_id= p.product_id  group by c.price_category;



