DROP DATABASE IF EXISTS movies_db;
CREATE DATABASE movies_db;
USE movies_db;

-- Import tables using Import Table Data Wizard
DESC actor;
DESC cast;
DESC  director;
DESC  genres;
DESC  movie;
DESC  movie_direction;
DESC  movie_genres;
DESC  ratings;
DESC  reviewer;

SELECT * FROM  actor;
SELECT * FROM  cast;
SELECT * FROM  director;
SELECT * FROM  genres;
SELECT * FROM  movie;
SELECT * FROM  movie_direction;
SELECT * FROM  movie_genres;
SELECT * FROM  ratings;
SELECT * FROM  reviewer;


-- Add PRIMARY KEY and FOREIGN KEY

-- Actor Table
ALTER TABLE actor ADD PRIMARY KEY (act_id);

-- Director Table
ALTER TABLE director ADD PRIMARY KEY (dir_id);

-- Genre Table
ALTER TABLE genres ADD PRIMARY KEY (gen_id);

-- Movie Table
ALTER TABLE movie ADD PRIMARY KEY (mov_id);

-- Reviewer Table
ALTER TABLE reviewer ADD PRIMARY KEY (rev_id);

-- Cast table
ALTER TABLE cast
	ADD CONSTRAINT fk_actor_cast FOREIGN KEY (act_id) REFERENCES actor(act_id),
    ADD CONSTRAINT fk_movie_cast FOREIGN KEY (mov_id) REFERENCES movie(mov_id)
;

-- Movie Direction Table
ALTER TABLE movie_direction
	ADD CONSTRAINT fk_director_movdir FOREIGN KEY (dir_id) REFERENCES director(dir_id),
    ADD CONSTRAINT fk_movie_movdir FOREIGN KEY (mov_id) REFERENCES movie(mov_id)
;

-- Movie Genre Table
ALTER TABLE movie_genres
    ADD CONSTRAINT fk_movie_movgen FOREIGN KEY (mov_id) REFERENCES movie(mov_id),
    ADD CONSTRAINT fk_genres_movgen FOREIGN KEY (gen_id) REFERENCES genres(gen_id)
;

-- Ratings Table
ALTER TABLE ratings
	ADD CONSTRAINT fk_movie_rat FOREIGN KEY (mov_id) REFERENCES movie(mov_id),
    ADD CONSTRAINT fk_reviewer_rat FOREIGN KEY (rev_id) REFERENCES reviewer(rev_id)
;

-- ------------------------------------------------------------------------------------------------------------------------
/*
i. Write a SQL query to find when the movie 'American Beauty' released. Return movie release year. 
*/
SELECT mov_title, mov_year FROM movie
WHERE mov_title = 'American Beauty';


-- ------------------------------------------------------------------------------------------------------------------------
/*
ii. Write a SQL query to find those movies, which were released before 1998. Return movie title. 
*/
SELECT mov_title FROM movie
WHERE mov_year < 1998;

-- ------------------------------------------------------------------------------------------------------------------------
/*
iii. Write a query where it should contain all the data of the movies which were released after 1995 and their movie duration 
was greater than 120. 
*/
SELECT * FROM movie
WHERE mov_year > 1995 AND mov_time > 120;

-- ------------------------------------------------------------------------------------------------------------------------
/*
iv. Write a query to determine the Top 7 movies which were released in United Kingdom. Sort the data in ascending order of 
the movie year. 
*/
SELECT m.mov_title, r.rev_stars, mov_rel_country FROM
movie m JOIN ratings r USING (mov_id)
WHERE mov_rel_country = 'UK'
ORDER BY r.rev_stars DESC
LIMIT 7;

-- ------------------------------------------------------------------------------------------------------------------------
/*
v. Set the language of movie language as 'Chinese' for the movie which has its existing language as Japanese and the movie 
year was 2001. 
*/
UPDATE movie SET mov_lang = 'Chinese'
WHERE mov_lang = 'Japanese' AND mov_year = 2001;

-- ------------------------------------------------------------------------------------------------------------------------
/*
vi. Write a SQL query to find name of all the reviewers who rated the movie 'Slumdog Millionaire'. 
*/
SELECT m.mov_title, rev.rev_name FROM
movie m JOIN ratings r USING (mov_id)
JOIN reviewer rev USING (rev_id)
WHERE m.mov_title = 'Slumdog Millionaire';


-- ------------------------------------------------------------------------------------------------------------------------
/*
vii. Write a query which fetch the first name, last name & role played by the actor where output should all exclude Male actors. 
*/
SELECT concat(a.act_fname, " ", a.act_lname) Actor_Name, c.role, m.mov_title FROM
actor a JOIN cast c USING (act_id)
JOIN movie m USING (mov_id)
WHERE a.act_gender = 'F';

-- ------------------------------------------------------------------------------------------------------------------------
/*
viii. Write a SQL query to find the actors who played a role in the movie 'Annie Hall'. Fetch all the fields of actor table.
(Hint: Use the IN operator). 
*/
SELECT concat(a.act_fname, " ", a.act_lname) Actor_Name, c.role, m.mov_title FROM
actor a JOIN cast c USING (act_id)
JOIN movie m USING (mov_id)
WHERE mov_title = 'Annie Hall';

-- TODO
-- No idea where and why to use the IN operator. Ask someone.

-- ------------------------------------------------------------------------------------------------------------------------
/*
ix. Write a SQL query to find those movies that have been released in countries other than the United Kingdom.
 Return movie title, movie year, movie time, and date of release, releasing country. 
*/
SELECT 
	mov_title, mov_year, mov_time,
    mov_dt_rel, mov_rel_country
FROM movie
WHERE mov_rel_country != 'UK';

-- ------------------------------------------------------------------------------------------------------------------------
/*
x. Print genre title, maximum movie duration and the count the number of movies in each genre. (HINT: By using inner join) 
*/
SELECT g.gen_title, max(m.mov_time) Max_Duration, count(*) Count FROM
movie m JOIN movie_genres mg USING (mov_id)
JOIN genres g USING (gen_id)
GROUP BY g.gen_title;

-- ------------------------------------------------------------------------------------------------------------------------
/*
xi. Create a view which should contain the first name, last name, title of the movie & role played by particular actor. 
*/
CREATE VIEW actor_mov_role AS
	SELECT concat(a.act_fname, " ", a.act_lname) Actor_Name, m.mov_title, c.role FROM
	movie m JOIN cast c USING (mov_id)
	JOIN actor a USING (act_id)
;

SELECT * FROM actor_mov_role;

-- ------------------------------------------------------------------------------------------------------------------------
/*
xii. Write a SQL query to find the movies with the lowest ratings 
*/
SELECT m.mov_title, r.rev_stars FROM
movie m JOIN ratings r USING (mov_id)
ORDER BY r.rev_stars
LIMIT 1;

-- ------------------------------------------------------------------------------------------------------------------------
