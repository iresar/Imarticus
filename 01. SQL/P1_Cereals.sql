 -- ---------------------------------------------------------------------------------------------------- 
 DROP DATABASE IF EXISTS cereal_db;
 CREATE DATABASE cereal_db;
 USE cereal_db;
 -- Import table using Table Data Wizard
 DESC cereals_data;
 SELECT * FROM cereals_data;
 
 -- ---------------------------------------------------------------------------------------------------- 
 /* 1. Add index name fast on name  */
CREATE INDEX fast ON cereals_data (name); # Key length is too long. Change it.
ALTER TABLE cereals_data DROP INDEX fast;

-- Find out max length
SELECT name, max(length(name)) FROM cereals_data;
-- Since the max name length is 38, we can modify the column to have VARCHAR(40) instead of TEXT
ALTER TABLE cereals_data MODIFY name VARCHAR(40);
DESC cereals_data;
-- Retrying the index code
CREATE INDEX fast ON cereals_data (name); # No more warning

 -- ---------------------------------------------------------------------------------------------------- 
 /* 2. Describe the schema of table  */
DESC cereals_data;

 -- ---------------------------------------------------------------------------------------------------- 
 /* 3. Create view name as see where users can not see type column [first run appropriate query then create view]  */
SELECT
	name, mfr, calories, protein, fat,
    sodium, fiber, carbo, sugars, potass,
    vitamins, shelf, weight, cups, rating
FROM cereals_data;

CREATE VIEW name AS
SELECT
	name, mfr, calories, protein, fat,
    sodium, fiber, carbo, sugars, potass,
    vitamins, shelf, weight, cups, rating
FROM cereals_data;

 -- ---------------------------------------------------------------------------------------------------- 
 /* 4. Rename the view as saw  */
RENAME TABLE name TO saw;

 -- ---------------------------------------------------------------------------------------------------- 
 /* 5. Count how many are cold cereals  */
SELECT count(type) Count_of_Cold FROM cereals_data
WHERE type = 'C';

 -- ---------------------------------------------------------------------------------------------------- 
 /* 6. Count how many cereals are kept in shelf 3  */
SELECT count(shelf) Count_of_Shelf_3 FROM cereals_data
WHERE shelf = 3;

 -- ---------------------------------------------------------------------------------------------------- 
 /* 7. Arrange the table from high to low according to ratings  */
SELECT * FROM cereals_data
ORDER BY rating DESC;

 -- ---------------------------------------------------------------------------------------------------- 
 /* 8. Suggest some column/s which can be Primary key  */
SELECT count(distinct(name)) FROM cereals_data; # Check to see if all the names are unique.
-- Since the names are unique and does not contain any null values, the names column can be used as a Primary Key

 -- ---------------------------------------------------------------------------------------------------- 
 /* 9. Find average of calories of hot cereal and cold cereal in one query  */
SELECT
	(
		SELECT avg(calories) FROM cereals_data
		WHERE type = 'H'
	) Average_Cal_Hot,
	(
		SELECT avg(calories) FROM cereals_data
		WHERE type = 'C'
	) Average_Cal_Cold;
    
-- OR use your brain properly.

SELECT type, avg(calories) FROM cereals_data
GROUP BY type;

 -- ---------------------------------------------------------------------------------------------------- 
 /* 10. Add new column as HL_Calories where more than average calories should be categorized as HIGH and less than average calories 
 should be categorized as LOW  */
SELECT *,
	CASE
		WHEN calories > ( SELECT avg(calories) FROM cereals_data )
        THEN 'HIGH'
        ELSE 'LOW'
    END HL_Calories
FROM cereals_data;

-- OR manually add a new column.

ALTER TABLE cereals_data ADD COLUMN HL_Calories VARCHAR(10);
UPDATE cereals_data SET HL_Calories =
	CASE
		WHEN calories > ( SELECT avg(calories) FROM cereals_data )
        THEN 'HIGH'
        ELSE 'LOW'
    END;

 -- ---------------------------------------------------------------------------------------------------- 
 /* 11. List only those cereals whose name begins with B */
 SELECT name FROM cereals_data
 WHERE name LIKE 'B%';

 -- ---------------------------------------------------------------------------------------------------- 
 /* 12. List only those cereals whose name begins with F */
SELECT name FROM cereals_data
 WHERE name LIKE 'F%';

 -- ---------------------------------------------------------------------------------------------------- 
 /* 13. List only those cereals whose name ends with s */
SELECT name FROM cereals_data
 WHERE name LIKE '%S';
 
 -- ---------------------------------------------------------------------------------------------------- 
 /* 14. Select only those records which are HIGH in column HL_calories */
SELECT * FROM cereals_data
WHERE HL_Calories = 'HIGH';

 -- ---------------------------------------------------------------------------------------------------- 
 /* 15. Find maximum of ratings  */
SELECT name, rating FROM cereals_data
ORDER BY rating DESC
LIMIT 1;

 -- ---------------------------------------------------------------------------------------------------- 
 /* 16. Find average ratings of those were High and Low calories  */
SELECT HL_Calories, round(avg(rating), 2) Average_Rating FROM cereals_data
GROUP BY HL_Calories;

 -- ---------------------------------------------------------------------------------------------------- 
 /* 17. Craete two examples of Sub Queries of your choice and give explanation in the script itself with remarks by using # */
SELECT
	(
		SELECT avg(calories) FROM cereals_data
		WHERE type = 'H'
	) Average_Cal_Hot,
	(
		SELECT avg(calories) FROM cereals_data
		WHERE type = 'C'
	) Average_Cal_Cold;
    
/* A query within a query is called a sub query. There are two types.
- Correlated sub query: Sub query refers to the same table as the outer query
- Non-Correlated sub query: Sub query does not refer to the same table as the outer query

 -- ---------------------------------------------------------------------------------------------------- 
 /* 18. Remove column fat  */
ALTER TABLE cereals_data DROP COLUMN fat;

 -- ---------------------------------------------------------------------------------------------------- 
 /* 19. Count records for each manufacturer [mfr]  */
SELECT mfr, count(mfr) Records_Per_Manufacturer FROM cereals_data
GROUP BY mfr;

 -- ---------------------------------------------------------------------------------------------------- 
 /* 20. Select name, calories and ratings only  */
SELECT name, calories, rating FROM cereals_data;

 -- ---------------------------------------------------------------------------------------------------- 