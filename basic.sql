CREATE DATABASE shelter;

CREATE TABLE dog(
dog_id int NOT NULL,
name VARCHAR(255),
PRIMARY KEY(dog_id)
);


DESCRIBE dog;

INSERT INTO dog(name) VALUES('Lassie');

ALTER TABLE dog
MODIFY COLUMN dog_id INT NOT NULL AUTO_INCREMENT;

SELECT * FROM dog;

INSERT INTO dog(name)
VALUES('Beethoven'), ('Gatsby');

SELECT name FROM dog WHERE dog_id = 1;

SELECT name FROM dog ORDER BY name asc;


ALTER TABLE dog ADD age INT;

UPDATE dog SET age = 10 WHERE dog_id = 1;

DROP TABLE IF EXIST dog;

CREATE TABLE dog(
dog_id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(50),
ownerId INT,
PRIMARY KEY(dog_id),
FOREIGN KEY(ownerId) REFERENCES owner(owner_id)
);

CREATE TABLE collar(
collar_id INT NOT NULL AUTO_INCREMENT,
dogId INT UNIQUE,
PRIMARY KEY(collar_id),
FOREIGN KEY(dogId) REFERENCES dog(dog_id)
);

CREATE TABLE owner(
owner_id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(255),
phone VARCHAR(255),
PRIMARY KEY(owner_id)
);

INSERT INTO owner(name, phone) VALUES('Alex', '0709191919');
INSERT INTO dog(name, ownerId) VALUES('Lassie', 1);
INSERT INTO collar(dogId) VALUES(1);

SELECT dog.name FROM dog
JOIN collar ON dog.dog_id = collar.dogId;

SELECT dog.name, owner.name, owner.phone
FROM dog
INNER JOIN owner ON owner.owner_id = dog.owner_id;

SELECT dog.name, owner.name, owner.phone
FROM collar
INNER JOIN dog ON dog.dog_id = collar.dogId
INNER JOIN owner ON owner.owner_id = dog.ownerId;






















