/**********************************************   DAY 08    ***************************************************************/


Select * from customers;
select * from orders;
select * from order_details;
select * from products;
select * from categories;
select * from employees;
select * from shippers;
select * from territories;
select * from region;

/*1.     Create view vw_updatable_products (use same query whatever I used in the training)
Try updating view with below query and see if the product table also gets updated.
Update query:
UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;*/

create view vw_updateable_products as
select product_id,product_name,unit_price,units_in_stock,discontinued 
from products 
where discontinued =0 
with check option;

select * from vw_updateable_products ;

UPDATE vw_updateable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;

select * from vw_updateable_products order by units_in_stock < 10 desc;

select * from products  order by units_in_stock < 10 desc;

/*2.     Transaction:
Update the product price for products by 10% in category id=1
Try COMMIT and ROLLBACK and observe what happens.
*/
/* Automatically Rollback and commit and Rollback*/
DO $$
Begin
	update products set unit_price = unit_price * 1.10 
	where category_id =1;

	if Exists(
		select 1 from products where category_id =1 and unit_price > 50
		) then
			Raise exception  'Some Prices exceeded $50';
		 else
		   Raise Notice 'Price Update Successful.';
	End if;
End $$;

---------------------------------------------------------------------------

Begin;

update products set unit_price = unit_price * 1.10 
	where category_id =1;

DO $$
Begin
	if Exists(
		select 1 from products where category_id =1 and unit_price >500
		) then
			Raise exception  'Some Prices exceeded $500';
		 else
		   Raise Notice 'Price Update Successful.';
	End if;
End $$;

commit;

Rollback;
select * from products where category_id =1;

/*3.     Create a regular view which will have below details (Need to do joins):
Employee_id,Employee_full_name,Title,Territory_id,territory_description,region_description*/


create view vw_Employee as 
(
select e.Employee_id, e.first_name || ' ' e.last_name as Employee_full_name,e.Title,t.Territory_id,t.territory_description,r.region_description
from employee e


)
