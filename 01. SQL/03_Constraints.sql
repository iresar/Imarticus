-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP DATABASE IF EXISTS constraints_db;
CREATE DATABASE constraints_db;
USE constraints_db;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Create the customers table
CREATE TABLE customers(
	c_id INT PRIMARY KEY AUTO_INCREMENT,
    c_name VARCHAR(30) NOT NULL,
    gender ENUM('M', 'F') NOT NULL,
    age INT DEFAULT 18 CHECK(age > 18),
    email VARCHAR(100) UNIQUE,
    address TEXT NOT NULL
);

DESC customers;
SELECT * FROM customers;
INSERT INTO customers VALUES (1, 'Mohammed Maanish', 'M', 28, 'maanish@gmail.com', 'Bangalore');

INSERT INTO customers VALUES (1, 'Anish', 'M', 27, 'aanish@gmail.com', 'Bangalore'); # Will not work since the value 1 is repeated and the c_id column is a primary key
INSERT INTO customers VALUES (2, 'Anish', 'M', 27, 'aanish@gmail.com', 'Bangalore'); # Will work.

INSERT INTO customers VALUES (3, 'Zaanish', 'Male', 25, 'zaanish@gmail.com', 'Bangalore'); # Will not work since the gender can only be 'M' or 'F'.
INSERT INTO customers VALUES (3, 'Zaanish', 'M', 25, 'zaanish@gmail.com', 'Bangalore'); # Will not work since the gender can only be 'M' or 'F'.

INSERT INTO customers VALUES (4, 'Zanish', 'M', 17, 'zanish@email.com', 'Bangalore'); # Will not work because age should be > 18 and email should end with @gmail.com
INSERT INTO customers VALUES (4, 'Zanish', 'M', 19, 'zanish@gmail.com', 'Bangalore');

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
-- Create the orders table
CREATE TABLE orders(
	o_id INT PRIMARY KEY AUTO_INCREMENT,
    c_id INT,
    o_date DATE NOT NULL,
    CONSTRAINT fk_CustomerOrder FOREIGN KEY (c_id) REFERENCES customers (c_id)
);

DESC orders;
SELECT * FROM orders;
INSERT INTO orders VALUES 
	(1, 1, '2023-09-07'),
    (2, 1, '2023-09-08');
    
INSERT INTO orders VALUES (3, 10, '2023-09-09'); # This will not work since we don't have any customer with an ID of 10 in the customers table.

INSERT INTO orders VALUES
	(3, 2, '2020-12-20'),
    (4, 1, '2020-10-29');

INSERT INTO orders VALUES
	(5, 3, '2021-08-20'),
    (6, 4, '2022-05-09'),
    (7, 3, '2022-04-15');
    
-- Try to remove the record of the customer with c_id = 2
DELETE FROM customers WHERE c_id = 2; # This will not work because the customer with c_id = 2 is referenced in the orders table.

-- This can be overcome in two ways
-- ON DELETE SET NULL - Sets the value to child table to NULL
-- ON DELETE SET CASCADE - Deletes the record in the child table

-- ON DELETE SET NULL
ALTER TABLE orders
DROP CONSTRAINT fk_CustomerOrder;

ALTER TABLE orders
ADD CONSTRAINT fk_CustomersOrders FOREIGN KEY (c_id) REFERENCES customers (c_id)
ON DELETE SET NULL;

SELECT * FROM orders;

DELETE FROM customers WHERE c_id = 2; # Will work now and set the c_id to NULL in the orders table where c_id = 2
SELECT * FROM orders;

-- ON DELETE CASCADE
ALTER TABLE orders
DROP CONSTRAINT fk_CustomersOrders;

ALTER TABLE orders
ADD CONSTRAINT fk_Customers_Orders FOREIGN KEY (c_id) REFERENCES customers (c_id)
ON DELETE CASCADE;

DELETE FROM customers WHERE c_id = 1; # Will work and will delete all records in the order table with c_id = 1
SELECT * FROM orders;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Create the users table
CREATE TABLE users(
	u_id INT PRIMARY KEY AUTO_INCREMENT,
    u_name VARCHAR(30) NOT NULL,
    email VARCHAR(100) NOT NULL CHECK (email like '%@gmail.com%')
);
