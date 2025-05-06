/* 
1.	Write  a function to Calculate the total stock value for a given category:
(Stock value=ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
Return data type is DECIMAL(10,2) */

create or replace function total_stock_value(category int)
returns DECIMAL(10,2)
language plpgsql
as
$$
declare
   stock_value integer;
begin
select ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2) into stock_value from products where category_id = category
group by category_id;
   return stock_value;
end;
$$;

select total_stock_value(4);

--2.	Try writing a   cursor query which I executed in the training.

CREATE OR REPLACE FUNCTION fetch_product_unit_price(
   OUT p_name VARCHAR(50),
   OUT p_unit_price REAL
)
RETURNS SETOF RECORD AS
$$
DECLARE
    product_cursor CURSOR FOR
        SELECT product_name, unit_price
        FROM products;
    product_record RECORD;
BEGIN
    -- Open cursor
    OPEN product_cursor;

    -- Fetch rows and return
    LOOP
        FETCH NEXT FROM product_cursor INTO product_record;
        EXIT WHEN NOT FOUND;

        p_name = product_record.product_name;
        p_unit_price = product_record.unit_price;
        RETURN NEXT;
    END LOOP;

    -- Close cursor
    CLOSE product_cursor;
END;
$$
LANGUAGE PLPGSQL;

SELECT * FROM fetch_product_unit_price();

SELECT *  FROM PRODUCTS;

