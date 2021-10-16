DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS teacher;

CREATE TABLE student (
  id INT NOT NULL AUTO_INCREMENT,
  firstName VARCHAR(255),
  lastName VARCHAR(255),
  age INT,
  PRIMARY KEY(id)
);

INSERT INTO student(firstName, lastName, age) VALUES('Elev', 'Elevsson', 29);

CREATE TABLE teacher (
  id INT NOT NULL AUTO_INCREMENT,
  firstName VARCHAR(255),
  lastName VARCHAR(255),
  admin_username VARCHAR(255) UNIQUE,
  PRIMARY KEY (id)
);

CREATE TABLE student (
  id INT NOT NULL AUTO_INCREMENT,
  firstName VARCHAR(255),
  lastName VARCHAR(255),
  age INT,
  PRIMARY KEY(id)
);

CREATE TABLE book_rentals (
  id INT NOT NULL AUTO_INCREMENT,
  student_id INT,
  title VARCHAR(255),
  PRIMARY KEY(id),
  FOREIGN KEY(student_id) REFERENCES student(id)
);

INSERT INTO student(firstName, lastName, age) VALUES('Elev', 'Elevsson', 33);
INSERT INTO book_rentals(student_id, title) VALUES (1, 'mysql bascis');
INSERT INTO book_rentals(student_id, title) VALUES (1, 'postgres basics');

SELECT student.firstName
FROM student
LEFT JOIN book_rentals
ON book_rentals.student_id = student.id;

SELECT book_rentals.title
FROM book_rentals
LEFT JOIN student
ON student.id = book_rentals.student_id;

DROP TABLE IF EXISTS course;
CREATE TABLE course (
     course_id MEDIUMINT NOT NULL AUTO_INCREMENT,
     subject VARCHAR(255) NOT NULL,
     PRIMARY KEY (course_id)
);

INSERT INTO course(subject) VALUES('mysql course');

CREATE TABLE student_course (
  student_id INT REFERENCES student(id),
  course_id INT REFERENCES course(id),
  PRIMARY KEY (student_id, course_id)
);

CREATE TABLE student (
     student_id MEDIUMINT NOT NULL AUTO_INCREMENT,
     firstName CHAR(30) NOT NULL,
     lastName CHAR(30) NOT NULL,
     course_id MEDIUMINT,
     PRIMARY KEY (student_id),
     FOREIGN KEY(course_id) REFERENCES course(course_id)
);

INSERT INTO student_course(student_id, course_id) VALUES(1, 1);

