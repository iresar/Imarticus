CREATE DATABASE IF NOT EXISTS student;
USE student;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- DDL Commands
-- Drop table
DROP TABLE IF EXISTS student_details;

-- Create table
CREATE TABLE student_details(
	s_name varchar(20), s_age int, s_marks int
);
DESC student_details;

-- ALTER the table

-- Drop a column
ALTER TABLE student_details DROP COLUMN s_marks;
DESC student_details;

-- Add a column
ALTER TABLE student_details ADD COLUMN s_marks int;
DESC student_details;

-- Rename a column
ALTER TABLE student_details CHANGE s_marks s_score int;
DESC student_details;

-- Modify the datatype of a column
ALTER TABLE student_details MODIFY s_name varchar(30);
DESC student_details;

-- Rename a table
ALTER TABLE student_details RENAME student_info;
DESC student_info;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- DML Commands

-- Insert values into the table
-- Using positional arguments

INSERT INTO student_info VALUES
	('Maanish', 28, 92),
    ('Anish', 27, 85);
SELECT * FROM student_info;

-- Using keyword arguments
INSERT INTO student_info(
	s_score, s_age, s_name
) VALUES
	(50, 25, 'Zaanish'),
    (35, 26, 'Zanish');
SELECT * FROM student_info;

-- Updating records
UPDATE student_info SET s_score = 95
WHERE s_name = 'Maanish';
SELECT * FROM student_info;

-- Deleting records
DELETE FROM student_info
WHERE s_score < 50;
SELECT * FROM student_info;



