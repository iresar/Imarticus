DROP DATABASE IF EXISTS insurance_db;
CREATE DATABASE insurance_db;
USE insurance_db;

-- Import the tables using Table Data Import Wizard
DESC insurance;
SELECT * FROM insurance;

-- ----------------------------------------------------------------------------------------------------
/*
1. Count for each categories of ‘region  
*/
SELECT region, count(*) FROM insurance
GROUP BY region;

-- ----------------------------------------------------------------------------------------------------
/*
2. Find 50 records of highest ‘age’ and export data/table to desktop  
*/
SELECT * FROM insurance
ORDER BY age DESC
LIMIT 50;

-- Use the export button on the Result Grid to export the data.

-- ----------------------------------------------------------------------------------------------------
/*
3. Add index name ‘quick’ on ‘id’  
*/
CREATE INDEX quick ON insurance (id);

-- ----------------------------------------------------------------------------------------------------
/*
4. Describe the schema of table  
*/
DESC insurance;

-- ----------------------------------------------------------------------------------------------------
/*
5. Create view name as ‘gender’ where users can not see ‘sex’ 
[Hint: first run appropriate query then create view]  
*/
SELECT id, age, bmi, children, smoker, region, charges FROM insurance;

CREATE VIEW gender AS
	SELECT id, age, bmi, children, smoker, region, charges FROM insurance;

SELECT * FROM gender;

-- ----------------------------------------------------------------------------------------------------
/*
6. Rename the view as ‘type’  
*/
RENAME TABLE gender TO type;

SELECT * FROM type;

-- ----------------------------------------------------------------------------------------------------
/*
7. Count how many are ‘northwest’ insurance holders  
*/
SELECT region, count(*) insurance_holders FROM insurance
WHERE region = 'northwest'
GROUP BY region;

-- ----------------------------------------------------------------------------------------------------
/*
8. Count how many insurance holders were ‘femail’  
*/
SELECT sex, count(*) insurance_holders FROM insurance
WHERE sex = 'female'
GROUP BY sex;

-- ----------------------------------------------------------------------------------------------------
/*
9. Create Primary key on a suitable column  
*/
ALTER TABLE insurance ADD PRIMARY KEY (id);

-- ----------------------------------------------------------------------------------------------------
/*
10. Create a new column ‘ratio’ which is age multiply by bmi  
*/
ALTER TABLE insurance ADD COLUMN ratio int;

UPDATE insurance SET ratio = age * bmi;

-- ----------------------------------------------------------------------------------------------------
/*
11. Arrange the table from high to low according to charges  
*/
SELECT * FROM insurance
ORDER BY charges DESC;

-- ----------------------------------------------------------------------------------------------------
/*
12. Find MAX of ‘charges’  
*/
SELECT max(charges) maximum_charge FROM insurance;

-- ----------------------------------------------------------------------------------------------------
/*
13. Find MIN of ‘charges’  
*/
SELECT min(charges) minimum_charge FROM insurance;

-- ----------------------------------------------------------------------------------------------------
/*
14. Find average of ‘charges’ of male and female  
*/
SELECT sex, round(avg(charges), 2) average_charge FROM insurance
GROUP BY sex;

-- ----------------------------------------------------------------------------------------------------
/*
15. Write a Query to rename column name sex to Gender 
*/
ALTER TABLE insurance CHANGE sex gender VARCHAR(10);

-- ----------------------------------------------------------------------------------------------------
/*
16. Add new column as HL_Charges where more than average charges should be categorized as HIGH and less 
than average charges should be categorized as LOW  
*/
ALTER TABLE insurance ADD COLUMN HL_Charges CHAR(4);

UPDATE insurance SET  HL_Charges = 
	CASE
		WHEN charges > (SELECT avg(charges) FROM insurance) THEN 'HIGH'
        ELSE 'LESS'
    END
;

-- ----------------------------------------------------------------------------------------------------
/*
17. Change location/position of ‘smoker’ and bring before ‘children’  
*/
ALTER TABLE insurance MODIFY COLUMN smoker VARCHAR(10) AFTER bmi;

-- ----------------------------------------------------------------------------------------------------
/*
18. Show top 20 records  
*/
SELECT * FROM insurance
LIMIT 20;

-- ----------------------------------------------------------------------------------------------------
/*
19. Show bottom 20 records  
*/
SELECT * FROM insurance
ORDER BY id DESC
LIMIT 20;

-- ----------------------------------------------------------------------------------------------------
/*
20. Randomly select 20% of records and export to desktop  
*/

-- Find out how much is 20%
SELECT round(count(*) / 100 * 20, 0) FROM insurance;

SELECT * FROM insurance
ORDER BY rand()
LIMIT 268;

-- ----------------------------------------------------------------------------------------------------
/*
21. Remove column ‘ratio’  
*/
ALTER TABLE insurance DROP COLUMN ratio;

-- ----------------------------------------------------------------------------------------------------
/*
22. Craete one example of Sub Queries involving ‘bmi’ and ‘sex’ and give explanation in the script itself 
with remarks by using #  
*/
-- Meh

-- ----------------------------------------------------------------------------------------------------
/*
23. Create a view called Female_HL_Charges that shows only those data where HL_Charges is High, Female,
Smokers and with 0 children  
*/
SELECT * FROM insurance
WHERE HL_Charges = 'HIGH' AND gender = 'FEMALE' AND smoker = 'yes' AND children = 0;

CREATE VIEW Female_HL_Charges AS
	SELECT * FROM insurance
    WHERE HL_Charges = 'HIGH' AND gender = 'FEMALE' AND smoker = 'yes' AND children = 0
;

SELECT * FROM Female_HL_Charges;
-- ----------------------------------------------------------------------------------------------------
/*
24. Update children column if there is 0 children then make it as Zero Children, if 1 then one_children,
if 2 then two_children, if 3 then three_children, if 4 then four_children if 5 then five_children else 
print it as More_than_five_children. 
*/
ALTER TABLE insurance MODIFY COLUMN children varchar(25);

UPDATE insurance SET children =
	CASE
		WHEN children = 0 THEN 'Zero Children'
        WHEN children = 1 THEN 'One Child'
        WHEN children = 2 THEN 'Two Children'
        WHEN children = 3 THEN 'Three Children'
        WHEN children = 4 THEN 'Four Children'
        WHEN children = 5 THEN 'Five Children'
        ELSE 'More Than Five Children'
    END
;

SELECT * FROM insurance;
-- ----------------------------------------------------------------------------------------------------