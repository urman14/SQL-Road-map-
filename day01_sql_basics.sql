-- Day 1: SQL Basics — SELECT, WHERE, ORDER BY, LIMIT
-- Practice dataset: movies table

-- Setup: create and populate the table
CREATE TABLE movies (
  id INTEGER PRIMARY KEY,
  title TEXT,
  genre TEXT,
  release_year INTEGER,
  rating REAL,
  box_office_millions INTEGER
);

INSERT INTO movies (title, genre, release_year, rating, box_office_millions) VALUES
('Inception','Sci-Fi',2010,8.8,829),
('The Dark Knight','Action',2008,9.0,1005),
('Interstellar','Sci-Fi',2014,8.6,731),
('The Matrix','Sci-Fi',1999,8.7,466),
('Parasite','Thriller',2019,8.5,258),
('Get Out','Thriller',2017,7.7,255),
('La La Land','Romance',2016,8.0,447),
('Whiplash','Drama',2014,8.5,49),
('Mad Max: Fury Road','Action',2015,8.1,375),
('Avatar','Sci-Fi',2009,7.9,2923),
('Titanic','Romance',1997,7.9,2257),
('The Grand Budapest Hotel','Comedy',2014,8.1,173);

-- 1. Movies released before 2010, newest first
SELECT title, release_year FROM movies
WHERE release_year < 2010
ORDER BY release_year DESC;

-- 2. Top 3 highest-grossing Sci-Fi movies
SELECT title, box_office_millions FROM movies
WHERE genre = 'Sci-Fi'
ORDER BY box_office_millions DESC
LIMIT 3;

-- 3. Thriller or Romance movies rated above 8
SELECT title FROM movies
WHERE (genre = 'Thriller' OR genre = 'Romance') AND rating > 8;

-- 4. Movies rated 8.5 or higher, best first
SELECT title, rating FROM movies
WHERE rating >= 8.5
ORDER BY rating DESC;

-- 5. The 2 lowest-grossing movies
SELECT title, box_office_millions FROM movies
ORDER BY box_office_millions
LIMIT 2;

-- 6. Movies released in 2014
SELECT title, genre FROM movies
WHERE release_year = 2014;

-- 7. Movies released between 2010 and 2019, newest first
SELECT title, release_year FROM movies
WHERE release_year BETWEEN 2010 AND 2019
ORDER BY release_year DESC;

-- 8. Action, Thriller, or Romance movies (using IN)
SELECT title, genre FROM movies
WHERE genre IN ('Action', 'Thriller', 'Romance');

-- 9. Movies with "the" anywhere in the title
SELECT title FROM movies
WHERE title LIKE '%the%';

-- 10. Count of Sci-Fi movies (first aggregation!)
SELECT COUNT(*) FROM movies
WHERE genre = 'Sci-Fi';