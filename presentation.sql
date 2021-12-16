DROP TABLE IF EXISTS grade;
DROP TABLE IF EXISTS student_course;
DROP TABLE IF EXISTS book_rentals;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS teacher;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS externalTeacher;


/* Vad är en enity */

CREATE TABLE student (
  id INT NOT NULL AUTO_INCREMENT,
  firstName VARCHAR(255),
  lastName VARCHAR(255),
  age INT,
  PRIMARY KEY(id)
);

INSERT INTO student(firstName, lastName, age) VALUES('Elev', 'Elevsson', 29);


/* ONE-TO-ONE */

CREATE TABLE teacher (
  teacher_id INT NOT NULL AUTO_INCREMENT,
  firstName VARCHAR(255),
  lastName VARCHAR(255),
  admin_username VARCHAR(255) UNIQUE,
  PRIMARY KEY (teacher_id)
);

CREATE TABLE teacher_contact (
  contact_id INT NOT NULL AUTO_INCREMENT,
  email VARCHAR(255),
  phone VARCHAR(255),
  teacherId INT UNIQUE,
  PRIMARY KEY(contact_id),
  FOREIGN KEY(teacherId) REFERENCES teacher(teacher_id)
);

INSERT INTO teacher(firstName, lastName, admin_username) VALUES('Lärar', 'Lärarsson', 'lärare123');
INSERT INTO teacher(firstName, lastName, admin_username) VALUES('Lärar2', 'Lärarsson2', 'lärare12');

INSERT INTO teacher_contact(email, phone, teacherId) VALUES('Lärar@skola.se', '0707-28828', 1);
INSERT INTO teacher_contact(email, phone, teacherId) VALUES('Lärar@skola.se', '0707-28829', 1);

SELECT * FROM teacher;
SELECT * FROM teacher_contact;

SELECT teacher_contact.phone
FROM teacher_contact
JOIN teacher
ON teacher.teacher_id  = teacher_contact.contact_id;

SELECT
  teacher.firstName AS teacher_name,
  teacher_contact.phone AS teacher_phone
FROM teacher
JOIN teacher_contact ON teacher.teacher_id=teacher_contact.teacherId;


/* ONE-TO-MANY */

CREATE TABLE library (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255),
  PRIMARY KEY(id)
);

CREATE TABLE book (
  book_id INT NOT NULL AUTO_INCREMENT,
  library_id INT,
  title VARCHAR(255),
  PRIMARY KEY(book_id),
  FOREIGN KEY(library_id) REFERENCES library(id)
);

INSERT INTO library(name) VALUES('Humanisten');
INSERT INTO book(library_id, title) VALUES (1, 'mysql bascis');
INSERT INTO book(library_id, title) VALUES (1, 'postgres basics');

SELECT book.title
FROM book
JOIN library
ON library.id = book.library_id;

/* MANY-TO-MANY */

CREATE TABLE course (
     course_id MEDIUMINT NOT NULL AUTO_INCREMENT,
     subject VARCHAR(255) NOT NULL UNIQUE,
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
     PRIMARY KEY (student_id)
);

INSERT INTO student(firstName, lastName) VALUES('Student', 'Studentsson');

INSERT INTO student_course(student_id, course_id) VALUES(1, 1);

/* Domain Integrity */

CREATE TABLE student(id INT, age INT check(age between 18 and 24));

/* Data Redundancy*/

CREATE TABLE school (
id MEDIUMINT NOT NULL AUTO_INCREMENT,
name CHAR(30) NOT NULL,
school_address VARCHAR(255),
PRIMARY KEY (id)
);

CREATE TABLE student (
id MEDIUMINT NOT NULL AUTO_INCREMENT,
name CHAR(30) NOT NULL,
school_id MEDIUMINT,
school_address VARCHAR(255),
FOREIGN KEY(school_id) REFERENCES school(id),
PRIMARY KEY (id)
);

INSERT INTO school(
name, school_address
)
VALUES('kodamera', 'gbgnånstans'
);

INSERT INTO student(
  name, school_id, school_address
)
VALUES('Elevsson', 1, 'vettefan'
);

SELECT stud.school_address, school.school_address
FROM student as stud
JOIN school
ON school.id = stud.school_id;

/* Insert Anomaly*/

CREATE TABLE teacher (
     id MEDIUMINT NOT NULL AUTO_INCREMENT,
     name CHAR(30) NOT NULL,
     course VARCHAR(50) NOT NULL,
     PRIMARY KEY (id)
);

INSERT INTO teacher(name) VALUES('Teachy-Teach');

CREATE TABLE teacher (
     teacher_id MEDIUMINT NOT NULL AUTO_INCREMENT,
     name CHAR(30) NOT NULL,
     course_id MEDIUMINT,
     PRIMARY KEY (teacher_id),
     FOREIGN KEY(course_id) REFERENCES course(course_id)
);

CREATE TABLE course (
     course_id MEDIUMINT NOT NULL AUTO_INCREMENT,
     name CHAR(30) NOT NULL,
     PRIMARY KEY (course_id)
);

INSERT INTO course(name) VALUES('history');
INSERT INTO teacher(name, course_id) VALUES('Alex', 1);

SELECT course.name
FROM course
LEFT JOIN teacher
ON course.course_id = teacher.course_id;

CREATE TABLE externalTeacher (
     id MEDIUMINT NOT NULL AUTO_INCREMENT,
     name CHAR(30) NOT NULL,
     company VARCHAR(255),
     PRIMARY KEY (id),
);

INSERT INTO externalTeacher(
name, company
VALUES('alex', 'felstavat company name')
);

/* Update Anomaly */

CREATE TABLE student (
  id MEDIUMINT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255),
  address VARCHAR(255),
  PRIMARY KEY (id)
);

CREATE TABLE grade (
  id MEDIUMINT NOT NULL AUTO_INCREMENT,
  grade CHAR(30),
  course_id INT,
  student_id MEDIUMINT,
  student_address VARCHAR(255),
  sent_grade BOOL,
  PRIMARY KEY (id),
  FOREIGN KEY(student_id) REFERENCES student(id)
);


/* Delete Anomaly */

CREATE TABLE student (
  id MEDIUMINT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255),
  PRIMARY KEY (id)
);

CREATE TABLE grade (
  id MEDIUMINT NOT NULL AUTO_INCREMENT,
  grade CHAR(30),
  course_id MEDIUMINT,
  student_id MEDIUMINT,
  PRIMARY KEY (id),
  FOREIGN KEY(student_id) REFERENCES student(id),
  FOREIGN KEY(course_id) REFERENCES course(id)
);

CREATE TABLE course (
 id MEDIUMINT NOT NULL AUTO_INCREMENT,
 subject VARCHAR(255),
 PRIMARY KEY(id)
);

INSERT INTO student(name) VALUES('Elevsson');

INSERT INTO course(subject) VALUES('SQL');

INSERT INTO grade(grade, course_id, student_id) VALUES('VG', 1, 1);

DELETE FROM grade WHERE grade = 'VG';

/* FIRST NORMAL FORMS */

CREATE TABLE student (
  id MEDIUMINT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255),
  courses VARCHAR(255),
  grades VARCHAR(255),
  PRIMARY KEY (id)
);

INSERT INTO student(
  name, courses, grades
) VALUES('Elevsson', '"SQL", "JavaScript"', '"G", "VG"');



CREATE TABLE student (
  id MEDIUMINT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255),
  PRIMARY KEY (id)
);

CREATE TABLE course_grade (
  course_name VARCHAR(255),
  grade VARCHAR(255),
  student_id MEDIUMINT,
  FOREIGN KEY(student_id) REFERENCES student(id)
);

INSERT INTO student(
  name
) VALUES('Elevsson');

INSERT INTO course_grade (
course_name, grade, student_id
)
VALUES (
  'JavaScript', 'VG', 1
  );