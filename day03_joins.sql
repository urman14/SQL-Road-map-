-- ============================================================
-- Day 3: JOINs
-- Two related tables: movies + directors (linked by director_id)
-- Topics: INNER JOIN, LEFT JOIN, orphan-hunting with IS NULL,
--         CROSS JOIN, SELF JOIN, and JOIN + GROUP BY aggregation
-- ============================================================

-- Setup: two related tables
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS directors;

CREATE TABLE directors (
  director_id INTEGER PRIMARY KEY,
  name TEXT,
  country TEXT
);

CREATE TABLE movies (
  movie_id INTEGER PRIMARY KEY,
  title TEXT,
  genre TEXT,
  release_year INTEGER,
  rating REAL,
  director_id INTEGER
);

INSERT INTO directors (director_id, name, country) VALUES
(1,'Christopher Nolan','UK'),
(2,'Bong Joon-ho','South Korea'),
(3,'Jordan Peele','USA'),
(4,'Damien Chazelle','USA'),
(5,'George Miller','Australia'),
(6,'James Cameron','Canada');

INSERT INTO movies (movie_id, title, genre, release_year, rating, director_id) VALUES
(1,'Inception','Sci-Fi',2010,8.8,1),
(2,'The Dark Knight','Action',2008,9.0,1),
(3,'Interstellar','Sci-Fi',2014,8.6,1),
(4,'Parasite','Thriller',2019,8.5,2),
(5,'Get Out','Thriller',2017,7.7,3),
(6,'La La Land','Romance',2016,8.0,4),
(7,'Whiplash','Drama',2014,8.5,4),
(8,'Mad Max: Fury Road','Action',2015,8.1,5),
(9,'Avatar','Sci-Fi',2009,7.9,6),
(10,'Titanic','Romance',1997,7.9,6),
(11,'Tenet','Sci-Fi',2020,7.3,NULL);   -- movie with NO director (NULL) on purpose

-- Quick checks
SELECT * FROM movies;
SELECT * FROM directors;


-- ============================================================
-- Block 1: INNER JOIN
-- ============================================================

-- Show each movie next to its director's name
-- (INNER JOIN drops Tenet, because it has no matching director)
SELECT movies.title, directors.name
FROM movies
JOIN directors ON movies.director_id = directors.director_id;

-- Show each movie's title, genre, and director's name
SELECT movies.title , movies.genre , directors.name
FROM movies
JOIN directors ON movies.director_id = directors.director_id;

-- Show title and director name for Sci-Fi movies only
SELECT M.title , D.name
FROM movies AS M JOIN directors AS D ON M.director_id = D.director_id
WHERE M.genre = 'Sci-Fi';

-- Show title, director name, and the director's country
SELECT M.title , D.name , D.country
FROM movies AS M JOIN directors AS D ON M.director_id = D.director_id;


-- ============================================================
-- Block 2: LEFT JOIN and NULL handling
-- ============================================================

-- Keep ALL movies, attach a director where one exists
-- (Tenet stays, with a NULL director) -> 11 rows vs INNER's 10
SELECT m.title, d.name
FROM movies AS m
LEFT JOIN directors AS d ON m.director_id = d.director_id;

-- Orphan-hunting: find movies with NO director (the data-quality check)
SELECT m.title
FROM movies AS m
LEFT JOIN directors AS d ON m.director_id = d.director_id
WHERE d.director_id IS NULL;

-- Flip the sides: list every director and each movie they directed
SELECT d.name, m.title
FROM directors AS d
LEFT JOIN movies AS m ON d.director_id = m.director_id;

-- Find any director with NO movies (same orphan pattern, flipped)
-- Returns nothing until an orphan director exists (see Gerwig test below)
SELECT d.name, m.title
FROM directors AS d
LEFT JOIN movies AS m ON d.director_id = m.director_id
WHERE m.movie_id IS NULL;

-- Test the orphan-finder: add a director with no movies, then re-run the query above
-- (Gerwig should appear with a NULL title)
INSERT INTO directors (director_id, name, country) VALUES (7, 'Greta Gerwig', 'USA');


-- ============================================================
-- Extra JOIN types (for reference)
-- ============================================================

-- CROSS JOIN: every genre paired with every year (all combinations)
SELECT g.genre, y.yr
FROM (SELECT DISTINCT genre FROM movies) AS g
CROSS JOIN (SELECT DISTINCT release_year AS yr FROM movies) AS y;

-- SELF JOIN: a table joined to itself (employee -> manager)
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
  emp_id INTEGER PRIMARY KEY,
  name TEXT,
  manager_id INTEGER
);
INSERT INTO employees VALUES
(1,'Sarah',NULL),
(2,'James',1),
(3,'Priya',1),
(4,'Tom',2),
(5,'Lena',2);

-- Each employee next to their manager's name (both sides = employees table)
SELECT e.name AS employee, m.name AS manager
FROM employees AS e
LEFT JOIN employees AS m ON e.manager_id = m.emp_id;


-- ============================================================
-- Block 3: JOIN + GROUP BY (cross-table aggregation)
-- ============================================================

-- Total and average rating per director, most movies first
SELECT D.name , COUNT(M.title) AS TOTAL_MOVIES , ROUND(AVG(M.rating),2) AS AVG_RATING
FROM directors AS D LEFT JOIN movies AS M ON D.director_id = M.director_id
GROUP BY D.name
ORDER BY TOTAL_MOVIES DESC;

-- Which directors have made more than one movie? Show name and movie count.
SELECT D.name , COUNT(M.title) AS MOVIE_COUNT
FROM directors AS D LEFT JOIN movies AS M ON D.director_id = M.director_id
GROUP BY D.name
HAVING MOVIE_COUNT > 1;

-- Average movie rating per director's country
SELECT D.country , ROUND(AVG(M.rating),2) AS AVG_PER_C
FROM directors AS D LEFT JOIN movies AS M ON D.director_id = M.director_id
GROUP BY D.country;

-- The highest-rated movie's rating for each director, plus how many movies they've made
SELECT D.name , MAX(M.rating) AS BEST_RATED , COUNT(M.title) AS TOTAL_MOVIES
FROM directors AS D LEFT JOIN movies AS M ON D.director_id = M.director_id
GROUP BY D.name;

-- Stacked: USA directors only, average rating, only those averaging above 8, highest first
-- (Note: AVG(M.rating) in HAVING/ORDER BY, not the alias, for portability)
SELECT D.name , ROUND(AVG(M.rating),2) AS AVG_RATING
FROM directors AS D JOIN movies AS M ON D.director_id = M.director_id
WHERE D.country = 'USA'
GROUP BY D.name
HAVING AVG(M.rating) > 8
ORDER BY AVG(M.rating) DESC;
