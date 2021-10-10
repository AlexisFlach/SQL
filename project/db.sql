CREATE DATABASE movie_data;

CREATE TABLE directors (
  director_id SERIAL PRIMARY KEY,
  first VARCHAR(30),
  last VARCHAR(30),
  date_of_birth DATE,
  nationality VARCHAR(25)
);

CREATE TABLE actors (
  actor_id SERIAL PRIMARY KEY,
  first VARCHAR(30),
  last VARCHAR(30),
  gender CHAR(1),
  date_of_birth DATE
);

CREATE TABLE movies (
  movie_id SERIAL PRIMARY KEY,
  movie_name VARCHAR(50),
  movie_length INT,
  movie_lang VARCHAR(20),
  release_date DATE,
  age_certificate VARCHAR(5),
  director_id INT REFERENCES directors (director_id)
);

CREATE TABLE movie_revenues (
  revenue_id SERIAL PRIMARY KEY,
  movie_id INT REFERENCES movies (movie_id),
  domestic_takings NUMERIC(6,2),
  international_takings NUMERIC(6,2)
);

CREATE TABLE movies_actors (
  movie_id INT REFERENCES movies(movie_id),
  actor_id INT REFERENCES actors(actor_id),
  PRIMARY KEY (movie_id, actor_id)
);

CREATE TABLE example (
  example_id SERIAL PRIMARY KEY,
  first VARCHAR(50),
  last VARCHAR(50)
);

ALTER TABLE example
ADD COLUMN email VARCHAR(50) UNIQUE;

ALTER TABLE example
ALTER COLUMN email TYPE TEXT;

INSERT INTO example(first, last) VALUES ( 'Alex', 'ito'), ('Thomp', 'Lompa');

UPDATE example
SET first = 'Ronaldinho'
WHERE first = 'Alex';

UPDATE example
SET first = 'Alex', last = 'inho'
WHERE example_id = 1;

DELETE FROM example
WHERE first = 'Alex';

DELETE FROM example;

DROP TABLE example;


# Aggregate functions
# Perform a calculation on column data and returns one row of data as a result

SELECT COUNT(*) FROM movie_revenues;
SELECT COUNT(international_takings) FROM movie_revenues;
SELECT COUNT(*) FROM movies
WHERE movie_lang = 'English';

SELECT SUM(domestic_takings) FROM movie_revenues;

SELECT SUM(domestic_takings) FROM movie_revenues
WHERE domestic_takings > 100.0;

SELECT MAX(domestic_takings) FROM movie_revenues;
SELECT MIN(movie_length) FROM movies
WHERE movie_lang = 'English';

SELECT AVG(movie_length) FROM movies;

SELECT COUNT(movie_lang) FROM movies;

SELECT movie_lang, COUNT(movie_lang) FROM movies
GROUP BY movie_lang;











