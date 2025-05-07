/**********************************************   DAY 10    ***************************************************************/


Select * from customers;
select * from orders;
select * from order_details;
select * from products;
select * from categories;
select * from employees;
select * from shippers;
select * from territories;
select * from region;

/*1.	Write  a function to Calculate the total stock value for a given category:
(Stock value=ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)Return data type is DECIMAL(10,2)*/
create or replace function calculate_category_stock(in categoryid int)
returns decimal(10,2)
language plpgsql
AS $$
declare 
	totalstock decimal(10,2);
Begin
	if  not exists ( select 1 from products where category_id=categoryid) then
		raise exception 'Category id % does not exists',categoryid;
		return 0;
	end if;
    -- Calculate the total stock by catgeory
	select ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2) into totalstock 
	from products p where p.category_id = categoryid;

	return totalstock;
End;
$$;

select calculate_category_stock(2); 

select calculate_category_stock(category_id) as TotalStockValue 
from products group by category_id;

select count(category_id) from products group by category_id;


SELECT 
  category_id, 
  calculate_category_stock(category_id) AS TotalStockValue
FROM (
  SELECT DISTINCT category_id 
  FROM products
  WHERE category_id IS NOT NULL
) AS categories;


/*2.	Try writing a   cursor query which I executed in the training.*/
create or replace procedure update_prices_with_cursor()
language plpgsql
As $$
declare
	product_cursor cursor for
		select product_id,product_name, unit_price, units_in_stock
		from products
		where discontinued =0;
	product_record Record;
	v_new_price decimal(10,2);
Begin
  --open the cursor
  open product_cursor;

  loop
  --Fetch the next row
  Fetch product_cursor into product_record;

  exit when not found;

  if product_record.units_in_stock <10 then
  	v_new_price := product_record.unit_price * 1.1;
  else  
    v_new_price := product_record.unit_price * 0.95;
  end if;

  update products
  set unit_price = round(v_new_price,2)
  where product_id = product_record.product_id;

  raise notice 'update % price from % to %',
  	product_record.product_name,
	product_record.unit_price,
	v_new_price;
end loop;

close product_cursor;
end;
$$;


 call update_prices_with_cursor();
  
		
		