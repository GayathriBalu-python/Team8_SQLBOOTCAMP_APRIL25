/* customers table is created with customer_id as primary key 
which uniquely identifies the customer and customer_id & company_name is defined as NOT NULL */

CREATE TABLE customers (
    customer_id bpchar NOT NULL PRIMARY KEY,
    company_name character varying(40) NOT NULL,
    contact_name character varying(30),
    contact_title character varying(30),
    city character varying(15),
    country character varying(15)
);

/* employees table is created with employee_id as primary key 
which uniquely identifies the employee and employee_id & employee_name is defined as NOT NULL.
reports_to is defined as a foreign key which references the same employees table and has values
from employee_id, which is the id of the manager. 
*/

CREATE TABLE employees (
    employee_id smallint NOT NULL PRIMARY KEY,
    employee_name character varying(20) NOT NULL,
    title character varying(30),
    city character varying(15),
    country character varying(15),
    reports_to smallint,
    FOREIGN KEY (reports_to) REFERENCES employees
);

/* shippers table is created with shipper_id as Primary Key as it uniquely identifies each shipper
   shipper_id and company_name cannot be NULL
*/

CREATE TABLE shippers (
    shipper_id smallint NOT NULL PRIMARY KEY,
    company_name character varying(40) NOT NULL
 );

/* categories table is created with category_id as the primary key as is it is the unique identifier
   for each product category. category_id and category_name cannot be NULL.
*/ 
CREATE TABLE categories (
    category_id smallint NOT NULL PRIMARY KEY,
    category_name character varying(25) NOT NULL,
    description text
);

/*products table is created with product_id as primary key as it is the unique identifier for each product.
  category id is the foreign key which references categories table and it is the id of the category the 
  product belongs to. */
  
CREATE TABLE products (
    product_id smallint NOT NULL PRIMARY KEY,
    product_name character varying(40) NOT NULL,
    quantity_per_unit character varying(20),
    unit_price real,
    discontinued integer NOT NULL,
	category_id smallint,
    FOREIGN KEY (category_id) REFERENCES categories
);

/* orders table is created with order_id as primary key and customer_id,employee_id and shipper_id as 
   primary keys*/

CREATE TABLE orders (
    order_id smallint NOT NULL PRIMARY KEY,
    customer_id bpchar,
    employee_id smallint,
    order_date date,
    required_date date,
    shipped_date date,
    shipper_id smallint,
    freight real,
    FOREIGN KEY (customer_id) REFERENCES customers,
    FOREIGN KEY (employee_id) REFERENCES employees,
    FOREIGN KEY (shipper_id) REFERENCES shippers,
);

/* order_details table is created with the composite primary key order_id & product_id and 
   product_id and order_id as foreign keys */

CREATE TABLE order_details (
    order_id smallint NOT NULL,
    product_id smallint NOT NULL,
    unit_price real NOT NULL,
    quantity smallint NOT NULL,
    discount real NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (product_id) REFERENCES products,
    FOREIGN KEY (order_id) REFERENCES orders
);
