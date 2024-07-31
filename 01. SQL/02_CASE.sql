-- Load the database
CREATE DATABASE insurance_db;
USE insurance_db;

-- Import the tables using Table Data Import Wizard
DESC insurance;
SELECT * FROM insurance;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Add a new column called age_range and set its values to 'Younger' if age is < 20 and 'Older' if age >= 20

-- Add column
ALTER TABLE insurance ADD COLUMN age_range varchar(7);

-- Use CASE statement
UPDATE insurance SET age_range =
CASE
	WHEN AGE >= 20 THEN 'Older' ELSE 'Younger'
END;
SELECT * FROM insurance;

-- This same operation can be performed using 2 different WHERE clause

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Add a new column called update_children and set its values to string instead of integers. (1 -> One, 2 -> Two, etc.)

SELECT DISTINCT children FROM insurance
ORDER BY children;

-- Add the new column
ALTER TABLE insurance ADD COLUMN updated_children varchar(5);

-- Use CASE statement to perform the operation
UPDATE insurance SET updated_children =
CASE
	WHEN children = 0 THEN 'Zero'
    WHEN children = 1 THEN 'One'
    WHEN children = 2 THEN 'Two'
    WHEN children = 3 THEN 'Three'
    WHEN children = 4 THEN 'Four'
    WHEN children = 5 THEN 'Five'
    ELSE 'Null'
END;
SELECT * FROM insurance;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Case statement to create new column without altering original table

SELECT *,
CASE
	WHEN charges <= (SELECT avg(charges) FROM insurance) THEN 'Low'
    ELSE 'High'
END AS charge_range
FROM insurance;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------