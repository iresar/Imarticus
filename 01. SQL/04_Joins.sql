-- -------------------------------------------------------------------------------
DROP DATABASE IF EXISTS joins_db;
CREATE DATABASE IF NOT EXISTS joins_db;
USE joins_db;
-- -------------------------------------------------------------------------------

CREATE TABLE customer (
	cust_id INT,
    cust_name VARCHAR(20),
    contact_name VARCHAR(20),
    city VARCHAR(10),
    telephone VARCHAR(10)
);

INSERT INTO customer VALUES
	(101, 'John', 'Bill', 'New York', '207998701'),
    (102, 'Joe', 'Amy', 'New Jersey', '207998702'),
    (103, 'Gary', 'George', 'Chicago', '207998703'),
    (104, 'Mark', 'Mark', 'Texas', '207998704');
    
SELECT * FROM customer;

-- -------------------------------------------------------------------------------

CREATE TABLE orders (
	o_id INT,
    o_date DATE,
    cust_id INT,
    shipper_id VARCHAR(10)
);

INSERT INTO orders (
	cust_id, o_id, o_date, shipper_id
) VALUES
	(101, 1, '2020-10-10', 'A111'),
    (102, 2, '2020-10-11', 'A112'),
    (103, 3, '2020-10-12', 'A113'),
    (104, 4, '2020-10-12', 'A114'),
    (104, 5, '2020-10-14', 'A114');
    
SELECT * FROM orders;

-- -------------------------------------------------------------------------------

-- INNER JOIN

-- If both the foreign key column name is the same as the primary key column name
SELECT c.*, o.* FROM 
customer c JOIN orders o USING (cust_id);

-- If the foreign key column name is not the same as the primary key column name
SELECT c.*, o.o_date FROM
customer c JOIN orders o
ON c.cust_id = o.cust_id;

-- Question 1: Count the number of orders made by each customer
SELECT 
	c.cust_name,
	count(c.cust_name) no_of_orders 
FROM
customer c JOIN orders o USING (cust_id)
GROUP BY c.cust_name;

-- -------------------------------------------------------------------------------

-- LEFT JOIN

-- Insert some records
INSERT INTO customer VALUES
	(105, 'Manish', 'Raj', 'Bangalore', '9113579352'),
    (106, 'Anish', 'Raj', 'Bangalore', '9113579359');
    
SELECT *
FROM
customer c LEFT JOIN orders o USING (cust_id);

-- Question 1: Show the customers who have not placed any orders
SELECT c.cust_name
FROM
customer c LEFT JOIN orders o USING (cust_id)
WHERE o.o_id IS NULL;
-- -------------------------------------------------------------------------------

-- RIGHT JOIN IS THE SAME AS LEFT JOIN