/* 1.      Create AFTER UPDATE trigger to track product price changes */

CREATE TABLE product_price_audit 
(
AUDIT_ID SERIAL PRIMARY KEY,
PRODUCT_ID INT,
PRODUCT_NAME VARCHAR(40),
OLD_PRICE DECIMAL(10,2),
NEW_PRICE DECIMAL(10,2),
CHANGE_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
USER_NAME VARCHAR(50) DEFAULT CURRENT_USER )

-- ·       Create a trigger function with the below logic:

CREATE
OR REPLACE FUNCTION LOG_PRODUCT_PRICE () RETURNS TRIGGER AS $$
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
$$ LANGUAGE PLPGSQL;

--·       Create a row level trigger for below event:
--        AFTER UPDATE OF unit_price ON products

CREATE TRIGGER after_update_price
AFTER UPDATE ON PRODUCTS 
FOR EACH ROW
EXECUTE FUNCTION LOG_PRODUCT_PRICE();

--Test the trigger by updating the product price by 10% to any one product_id.

UPDATE PRODUCTS SET UNIT_PRICE = UNIT_PRICE + UNIT_PRICE * .10 WHERE PRODUCT_ID = 4;


SELECT * FROM PRODUCTS WHERE PRODUCT_ID = 4 ;
SELECT * FROM PRODUCT_PRICE_AUDIT;

/*  Create stored procedure  using IN and INOUT parameters to assign tasks to employees */

CREATE TABLE IF NOT EXISTS EMPLOYEE_TASKS (
TASK_ID SERIAL PRIMARY KEY,
EMPLOYEE_ID INT,
TASK_NAME VARCHAR(50),
ASSIGNED_DATE DATE DEFAULT CURRENT_DATE 
);

/*·       Insert employee_id, task_name  into employee_tasks
·       Count total tasks for employee and put the total count into p_task_count .
·       Raise NOTICE message:
 RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count; */


CREATE OR REPLACE PROCEDURE ASSIGN_TASK ( 
    IN p_employee_id INT, IN p_task_name VARCHAR(50), INOUT p_task_count INT DEFAULT 0 )

LANGUAGE PLPGSQL
AS $$
BEGIN
INSERT INTO EMPLOYEE_TASKS (employee_id,task_name) VALUES (p_employee_id,p_task_name);

 SELECT COUNT(TASK_NAME) INTO P_TASK_COUNT FROM EMPLOYEE_TASKS where employee_id = p_employee_id group by employee_id;

 RAISE NOTICE 'Task % assigned to employee % Total tasks: %', 
        p_task_name, p_employee_id, p_task_count;
END;
$$;

/*After creating stored procedure test by calling  it:
 CALL assign_task(1, 'Review Reports');
 
You should see the entry in employee_tasks table. */

  CALL assign_task(1, 'Review Reports');
  CALL assign_task(1, 'Design Reports');
  CALL assign_task(2, 'Create Reports');
  CALL assign_task(2, 'Design Reports');
  CALL assign_task(2, 'Review Reports');
  

 