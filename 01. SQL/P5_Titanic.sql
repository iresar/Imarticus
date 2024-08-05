DROP DATABASE IF EXISTS titanic_db;
CREATE DATABASE titanic_db;
USE titanic_db;

-- Load tables using Table Data Import Wizard
DESC titanic;
SELECT * FROM titanic;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
1. How many passengers are in the Titanic dataset? 
*/
SELECT 
    COUNT(*) Passenger_Count
FROM
    titanic;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
2. What are the distinct classes of passengers onboard? 
*/
SELECT DISTINCT
    pclass
FROM
    titanic;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
3. How many passengers survived the Titanic disaster? 
*/
SELECT 
    survived, COUNT(*) Survivors
FROM
    titanic
WHERE
    survived = 1
GROUP BY survived;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
4. What is the average age of passengers onboard? 
*/
SELECT 
    ROUND(AVG(age), 0) Average_Age
FROM
    titanic;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
5. How many male passengers were there? 
*/
SELECT 
    COUNT(*) Males
FROM
    titanic
WHERE
    sex = 'male';

-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
6. What is the highest fare paid for a ticket? 
*/
SELECT 
    fare
FROM
    titanic
ORDER BY fare DESC
LIMIT 1;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
7. How many siblings/spouses were onboard for each passenger? 
*/
SELECT 
    (SELECT 
            COUNT(*) Survivors
        FROM
            titanic
        WHERE
            survived = 1
        GROUP BY survived) / (SELECT 
            COUNT(*) Total
        FROM
            titanic) * 100 'Survivors %'
;
    

-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
9. What is the most common port of embarkation? 
*/
SELECT 
    embarked, COUNT(*) Count
FROM
    titanic
GROUP BY embarked
ORDER BY count DESC
LIMIT 1;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
10. How many passengers have missing values for the 'age' column? 
*/
SELECT 
    COUNT(age) Count
FROM
    titanic
WHERE
    age IS NULL;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------


SELECT 
    (SELECT 
            COUNT(*) Survivors
        FROM
            titanic
        WHERE
            survived = 1 AND pclass = 1
        GROUP BY survived) / (SELECT 
            COUNT(*) Total
        FROM
            titanic) * 100 'Survivors Class 1 %',
    (SELECT 
            COUNT(*) Survivors
        FROM
            titanic
        WHERE
            survived = 1 AND pclass = 2
        GROUP BY survived) / (SELECT 
            COUNT(*) Total
        FROM
            titanic) * 100 'Survivors Class 2 %',
    (SELECT 
            COUNT(*) Survivors
        FROM
            titanic
        WHERE
            survived = 1 AND pclass = 3
        GROUP BY survived) / (SELECT 
            COUNT(*) Total
        FROM
            titanic) * 100 'Survivors Class 3 %'
;
	

-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
2. What is the average fare paid by passengers who survived vs. those who didn't? 
*/
SELECT 
	survived, round(avg(fare), 2) Average_Fare
FROM
	titanic
GROUP BY survived;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
3. What is the age distribution of passengers who survived? 
*/
-- ?


-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
4. How many passengers traveled alone (without siblings/spouses or parents/children)? 
*/


-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
5. What is the average fare paid by passengers from each port of embarkation? 
*/


-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
6. What is the survival rate among passengers of different age groups (e.g., children, adults, elderly)? 
*/


-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
7. What is the survival rate among male vs. female passengers in each class? 
*/


-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
8. What is the average age of passengers who survived vs. those who didn't? 
*/


-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
9. How many passengers have siblings/spouses onboard but no parents/children? 
*/


-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
10. What is the survival rate among passengers with different numbers of siblings/spouses? 
*/


-- ------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------


-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
1. What is the survival rate among passengers of different age groups and genders? 
*/


-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
2. What is the survival rate among passengers who paid high vs. low fares, considering each class separately? 
*/


-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
3. What is the survival rate among passengers who traveled alone vs. with family members? 
*/


-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
4. What is the average fare paid by passengers of different age groups and genders? 
*/


-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
5. What is the survival rate among passengers with different ticket numbers (considering ticket numbers as a proxy for ticket class or fare)? 
*/


-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
6. What is the survival rate among passengers from each port of embarkation, considering their ticket class? traveled alone vs. with family members? 
*/


-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
8. What is the average fare paid by passengers with different numbers of siblings/spouses and parents/children? 
*/


-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
9. What is the survival rate among passengers who paid different fares, considering their gender? 
*/


-- ------------------------------------------------------------------------------------------------------------------------------------------------------
/*
10. What is the survival rate among passengers who boarded from each port of embarkation, considering their age groups? 
*/


-- ------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------