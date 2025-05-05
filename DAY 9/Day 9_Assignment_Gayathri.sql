
			             	DAY -9
---1) .Create AFTER UPDATE trigger to track product price changes.
---CREATING TABLE
CREATE TABLE product_price_log (
    log_id SERIAL PRIMARY KEY,
    product_id INT,
    old_price NUMERIC,
    new_price NUMERIC,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- CREATE TRIGGER 
CREATE OR REPLACE FUNCTION log_price_change()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.unit_price <> NEW.unit_price THEN
        INSERT INTO product_price_log (product_id, old_price, new_price)
        VALUES (OLD.product_id, OLD.unit_price, NEW.unit_price);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--CREATE  TRIGGER FOR PRODUCTS

CREATE TRIGGER after_price_update
AFTER UPDATE ON products
FOR EACH ROW
EXECUTE FUNCTION log_price_change();

--Update price by 10% and verify the audit log:

UPDATE products SET unit_price = unit_price * 1.10 WHERE product_id = 1;

SELECT * FROM product_price_log  WHERE product_id = 1;

--2)Create stored procedure using IN and INOUT parameters to assign tasks to employees
CREATE TABLE IF NOT EXISTS employee_tasks (

task_id SERIAL PRIMARY KEY,

employee_id INT,

task_name VARCHAR(50),

assigned_date DATE DEFAULT CURRENT_DATE)



CREATE OR REPLACE PROCEDURE assign_task(

IN p_employee_id INT,

IN p_task_name VARCHAR(50),

INOUT p_task_count INT DEFAULT 0

)

LANGUAGE plpgsql

AS $$

BEGIN

INSERT INTO employee_tasks (employee_id, task_name)

VALUES (p_employee_id, p_task_name);


SELECT COUNT(*) INTO p_task_count

FROM employee_tasks

WHERE employee_id = p_employee_id;


RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',

p_task_name, p_employee_id, p_task_count;

END;

$$;


CALL assign_task(1, 'Review Reports', 0);


DO $$

DECLARE

task_count INT := 0;

BEGIN

CALL assign_task(1, 'Prepare Presentation', task_count);

CALL assign_task(1, 'Attend Meeting', task_count);

END;
$$


SELECT * FROM employee_tasks ORDER BY task_id;