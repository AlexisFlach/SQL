/* 
Insert data into directors table
*/

INSERT INTO directors (first, last, date_of_birth, nationality) VALUES ('Tomas','Alfredson','1965-04-01','Swedish'),
('Paul','Anderson','1970-06-26','American'),
('Wes','Anderson','1969-05-01','American'),
('Richard','Ayoade','1977-06-12','British');


INSERT INTO actors (first, last, gender, date_of_birth) VALUES ('Malin','Akerman','F','1978-05-12'),
('Tim','Allen','M','1953-06-13'),
('Julie','Andrews','F','1935-10-01'),
('Ivana','Baquero','F','1994-06-11'),
('Lorraine','Bracco','F','1954-10-02'),
('Alice','Braga','F','1983-04-15'),
('Marlon','Brando','M','1924-04-03');


INSERT INTO movies (movie_name, movie_length, movie_lang, release_date, age_certificate, director_id) VALUES ('A Clockwork Orange','112','English','1972-02-02','18','3'),
('Apocalypse Now','168','English','1979-08-15','15','1'),
('Battle Royale ','111','Japanese','2001-01-04','18','1'),
('Blade Runner ','121','English','1982-06-25','15','2'),
('Chungking Express','113','Chinese','1996-08-03','15','3'),
('City of God','145','Portuguese','2003-01-17','18','4');


INSERT INTO movie_revenues (revenue_id, movie_id, domestic_takings, international_takings) VALUES ('1','13','22.2','1.3'),
('2','9','199.4','201.2'),
('3','11','102.1',null),
('4','12','158.7',null),
('6','12','27.1',null),
('7','13',null,null),
('17','12','260.3','210.9'),
('9','13','28.1',null),
('5','14','461.2','314.2');

INSERT INTO movies_actors (actor_id, movie_id) VALUES ('1','12'),
('2','9'),
('3','11'),
('4','12'),
('5','12'),
('6','13');