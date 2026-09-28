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


-- Quick check: show every row in the table
SELECT * FROM movies;

-- How many movies are in each genre?
SELECT genre, COUNT(*)
FROM movies
GROUP BY genre;

-- What is the total box office per genre? (highest first)
SELECT SUM(box_office_millions) AS TOTAL_COLLECTION , genre FROM movies
GROUP BY genre
ORDER BY SUM(box_office_millions) DESC;

-- What is the average rating per genre? (highest first)
SELECT AVG(rating) AS AVERAGE , genre FROM movies
GROUP BY genre
ORDER BY AVERAGE DESC;


-- Which genres have 2 or more movies?
SELECT genre , COUNT(title) AS NUMBER_OF_MOVIES
FROM movies
GROUP BY genre
HAVING COUNT(title) >= 2;

-- What is the highest rating in each genre?
SELECT MAX(rating) AS BEST_RATING ,genre
FROM movies
GROUP BY genre ;

-- Which genres have an average rating above 8?
SELECT genre, AVG(rating) AS AVG_RATING
FROM movies
GROUP BY genre
HAVING ROUND(AVG(rating),2) > 8;

--For movies released 2010 or later, show each genre's count and total box office,
--only for genres with more than one such movie, sorted by total box office (highest first).

SELECT COUNT(title) AS TOTAL_MOVIES, genre,SUM(box_office_millions) AS TOTAL_BOX_OFFICE_COLLECTION
FROM movies
WHERE release_year >= 2010
GROUP BY genre
HAVING COUNT(title) > 1

ORDER BY TOTAL_BOX_OFFICE_COLLECTION DESC;

--Count how many movies were released per year (release_year, count). Which year was busiest

SELECT COUNT(title) AS MOVIES_THAT_YEAR, release_year
FROM movies
GROUP BY release_year
ORDER BY MOVIES_THAT_YEAR DESC;

--The average box office per genre, rounded to a whole number, highest average first

SELECT ROUND(AVG(box_office_millions),0) AS BOX_OFFICE_COLLECTION , genre
FROM movies
GROUP BY genre
ORDER BY BOX_OFFICE_COLLECTION DESC;


-- What is the oldest release year in the table?
SELECT MIN(release_year) AS OLDEST_YEAR
FROM movies;


-- How many distinct genres are there?
SELECT COUNT(DISTINCT(genre))
FROM movies;

--Average rating per genre, but only counting movies released in 2010 or later,
-- and only show genres that still have 2 or more such movies

SELECT AVG(rating) AS AVG_RATING , genre
FROM movies
WHERE release_year >= 2010
GROUP BY genre
HAVING COUNT(title) >= 2
ORDER BY AVG_RATING DESC;

--Show each genre's total box office, but exclude the movie Avatar from the calculation entirely
--(it's a $2.9B outlier skewing Sci-Fi).Then sort by total, highest first


 SELECT SUM(box_office_millions) AS TOTAL_COLLECTION , genre
 FROM movies
 WHERE title != 'Avatar'
 GROUP by genre
 order by TOTAL_COLLECTION DESC;


 --"Which genres have a higher average rating than 8.0 and more than one movie —
 --and what's their average rating and movie count?"


 SELECT genre , AVG(rating) AS AVERAGE_RATING , COUNT(title) AS TOTAL_MOVIES
 FROM movies
 GROUP BY genre
 HAVING COUNT(title) > 1 AND AVG(rating) > 8
 ORDER BY AVERAGE_RATING DESC;
