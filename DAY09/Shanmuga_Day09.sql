/*1.      Create AFTER UPDATE trigger to track product price changes
*/



create table product_price_audit ( 
audit_id serial Primary key, product_id int, product_name varchar(40),
old_price decimal(10,2), new_price decimal(10,2),
change_date timestamp default current_timestamp,
user_name varchar(50) default current_user
) ;

drop function trigger_function();


create function trigger_function()
	returns Trigger 
	language plpgsql
as $$
Begin 
  insert into product_price_audit(
	product_id,product_name,old_price,new_price)
  values(old.product_id,old.product_name, old.unit_price,new.unit_price);
  return new;
End
$$
	
insert into product_price_audit(product_id,product_name,old_price,new_price)
  values(1002,'Test product2',8.99, 7.99);
select * from product_price_audit;

truncate product_price_audit;
select * from product_price_audit;

select * from products;


drop trigger after_update_product_price on products;
---Create Trigger
create trigger after_update_product_price
After update of unit_price on products
for each row
execute function trigger_function();

update products set unit_price = (unit_price*.1)+unit_price where product_id =4


/*2.      Create stored procedure  using IN and INOUT parameters to assign tasks to employees*/
create or replace procedure assigntasks(empid int, taskname varchar(50), taskcount int)
language plpgsql
As $$

Begin 
  create table if not exists employee_tasks(
	task_id serial primary key,
	employee_id int,
	task_name varchar(50),
	taskcount int,
	assigned_date date default current_date
	);

	insert into employee_tasks(employee_id, task_name, taskcount) values(empid,taskname,taskcount);
	Raise notice 'Task % assigned to employee % Total tasks %',taskname, empid, taskcount;
End
$$;

call assigntasks(5, 'Create Dashboards',3);

select * from employee_tasks;