/* Day 9 Assignment */

/* 1. Create AFTER UPDATE trigger to track product price changes */

--Create product_price_audit table with below columns:

CREATE TABLE product_price_audit (
audit_id SERIAL PRIMARY KEY,
product_id INT,
product_name VARCHAR (40),
old_price DECIMAL(10,2),
new_price DECIMAL(10,2),
change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
user_name VARCHAR(50) DEFAULT CURRENT_USER
);


--Create a trigger function with the below logic:
CREATE OR REPLACE FUNCTION log_new_product()
RETURNS TRIGGER AS $$ 
BEGIN 

INSERT INTO product_price_audit (
        product_id,
        product_name,
        old_price,
        new_price
    )
    VALUES (
        OLD.product_id,
        OLD.product_name,
        OLD.unit_price,
        NEW.unit_price
    );
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Create the Trigger
CREATE TRIGGER after_product_insert
AFTER INSERT ON products
FOR EACH ROW
EXECUTE FUNCTION log_new_product();


--Test the Trigger with
INSERT INTO products (product_id, product_name, supplier_id, category_id,unit_price,discontinued)
VALUES (85,'Test product_85',1,1,25.00,0);

select * from product_price_audit;

-------------------------------------------------------------------------------------

/* 2.Create stored procedure  using IN and INOUT parameters to assign tasks to employees */

--·Parameters:IN p_employee_id INT, IN p_task_name VARCHAR(50), INOUT p_task_count INT DEFAULT 0

CREATE TABLE IF NOT EXISTS employee_tasks (
        task_id SERIAL PRIMARY KEY,
        employee_id INT,
        task_name VARCHAR(50),
        assigned_date DATE DEFAULT CURRENT_DATE
);

INSERT INTO employee_tasks (task_id, employee_id, task_name )
	VALUES (1,1,'task1');

SELECT * FROM employee_tasks;


CREATE OR REPLACE PROCEDURE assign_task(
	IN p_employee_id INT , 
	IN p_task_name VARCHAR(50) ,
	INOUT p_task_count INT DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN
	IF NOT EXISTS ( SELECT 1 FROM employees WHERE employee_id = p_employee_id) THEN 
		RAISE EXCEPTION 'employee_id % does not exist', p_employee_id;
	END IF;

	SELECT COUNT(task_id)
	INTO p_task_count
	FROM employee_tasks
	WHERE employee_id = p_employee_id;

	END;
$$;

CALL assign_task(2,'task2');

select COUNT(task_id) from employee_tasks;






















