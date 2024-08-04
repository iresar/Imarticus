DROP DATABASE IF EXISTS clinic_db;
CREATE DATABASE clinic_db;
USE clinic_db;

-- Import table from Import Table Wizard
DESC clinictrial;
SELECT * FROM clinictrial;

-- ----------------------------------------------------------------------------------------------------  
/*
1. Add index name fast on Name 
*/
CREATE INDEX fast ON clinictrial (Name); # Name is of TEXT datatype. Change it.

-- Find the max lenght in Name
SELECT Name, max(length(Name)) FROM clinictrial;
-- Modify the column datatype
ALTER TABLE clinictrial MODIFY Name varchar(10);
-- Drop existing Index
ALTER TABLE clinictrial DROP INDEX fast;
-- Create new index without warning
CREATE INDEX fast ON clinictrial (Name);

-- ----------------------------------------------------------------------------------------------------  
/*
2. Describe the schema of table 
*/
DESC clinictrial;


-- ----------------------------------------------------------------------------------------------------  
/*
3. Find average of Age 
*/
SELECT avg(Age) "Average Age" FROM clinictrial;

-- ----------------------------------------------------------------------------------------------------  
/*
4. Find minimum of Age 
*/
SELECT min(Age) "Mininum Age" FROM clinictrial;

-- ----------------------------------------------------------------------------------------------------  
/*
5. Find maximum of Age 
*/
SELECT max(Age) "Maximum Age" FROM clinictrial;

-- ----------------------------------------------------------------------------------------------------  
/*
6. Find average age of those were pregnant and not pregnant 
*/
SELECT Pregnant, round(avg(age), 0) "Average Age" FROM clinictrial
GROUP BY Pregnant;

-- ----------------------------------------------------------------------------------------------------  
/*
7. Find average blood pressure of those had drug reaction and did not had drug reaction 
*/
SELECT Drug_Reaction, avg(BP) "Average BP" FROM clinictrial
GROUP BY Drug_Reaction;

-- ----------------------------------------------------------------------------------------------------  
/*
8. Add new column name as ‘Age_group’ and those having age between 16 & 21 should be categorized as Low, 
more than 21 and less than 35 should be categorized as Middle and above 35 should be categorized as High.  
*/

-- Add the column
ALTER TABLE clinictrial ADD COLUMN Age_Group varchar(10);

-- Update the entries
UPDATE clinictrial SET Age_Group =
	CASE
		WHEN Age BETWEEN 16 AND 21 THEN 'Low'
        WHEN Age Between 22 AND 35 THEN 'Middle'
        ELSE 'High'
    END
;

-- ----------------------------------------------------------------------------------------------------  
/*
9. Change ‘Age’ of Reetika to 32 
*/
UPDATE clinictrial SET Age = 32
WHERE Name = 'Reetika';

SELECT Name, Age FROM clinictrial
WHERE Name = 'Reetika';

-- ----------------------------------------------------------------------------------------------------  
/*
10. Change name of Reena as Shara’ 
*/
UPDATE clinictrial SET Name = 'Shara'
WHERE Name = 'Reena';

SELECT Name FROM clinictrial;

-- ----------------------------------------------------------------------------------------------------  
/*
11. Remove Chlstrl column 
*/
ALTER TABLE clinictrial DROP COLUMN Chlstrl;

DESC clinictrial;

-- ----------------------------------------------------------------------------------------------------  
/*
12. Select only Name, Age and BP 
*/
SELECT Name, Age, BP FROM clinictrial;

-- ----------------------------------------------------------------------------------------------------  
/*
13. Select ladies whose first name starts with ‘E’ 
*/
SELECT * FROM clinictrial
WHERE Name LIKE 'E%';

-- ----------------------------------------------------------------------------------------------------  
/*
14. Select ladies whose Age_group were Low 
*/
SELECT * FROM clinictrial
WHERE Age_Group = 'Low';

-- ----------------------------------------------------------------------------------------------------  
/*
15. Select ladies whose Age_group were High 
*/
SELECT * FROM clinictrial
WHERE Age_Group = 'High';

-- ----------------------------------------------------------------------------------------------------  
/*
16. Select ladies whose name starts with ‘A’ and those were pregnant  
*/
SELECT * FROM clinictrial
WHERE Name LIKE 'A%' AND Pregnant = 'yes';

-- ----------------------------------------------------------------------------------------------------  
/*
17. Identify ladies whose BP was more than 120  
*/
SELECT * FROM clinictrial
WHERE BP > 120;

-- ----------------------------------------------------------------------------------------------------  
/*
18. Identify ladies whose BP was between 100 and 120  
*/
SELECT * FROM clinictrial
WHERE BP BETWEEN 100 AND 120;

-- ----------------------------------------------------------------------------------------------------  
/*
19. Identify ladies who had low anxiety aged less than 30 
*/
SELECT * FROM clinictrial
WHERE Age < 30 AND Anxty_LH = 'no';

-- ----------------------------------------------------------------------------------------------------  
/*
20. Select ladies whose name ends with ‘i’ 
*/
SELECT * FROM clinictrial
WHERE Name LIKE '%i';

-- ----------------------------------------------------------------------------------------------------  
/*
21. Select ladies whose name ends with ‘a’  
*/
SELECT * FROM clinictrial
WHERE Name LIKE '%a';

-- ----------------------------------------------------------------------------------------------------  
/*
22. Select ladies whose name starts with ‘K’ 
*/
SELECT * FROM clinictrial
WHERE Name LIKE 'k%';

-- ----------------------------------------------------------------------------------------------------  
/*
23. Select ladies whose name have ‘a’ anywhere  
*/
SELECT * FROM clinictrial
WHERE Name LIKE '%a%';

-- ----------------------------------------------------------------------------------------------------  
/*
24. Order ladies in ascending way based on ‘BP’ 
*/
SELECT * FROM clinictrial
ORDER BY BP ASC;

-- ----------------------------------------------------------------------------------------------------  
/*
25. Order ladies in descending way based on ‘Age’ 
*/
SELECT * FROM clinictrial
ORDER BY Age DESC;

-- ----------------------------------------------------------------------------------------------------  
