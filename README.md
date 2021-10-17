

## Relational Database Design Theory

##### Entities och deras Attributes

I Databas Design brukar man börja med att identifiera **entities**. En entity är något som vi lagrar data för. 

- **Student** är en entity
- **Lesson** är en entity.

En entity har data som beskriver dem; **attributes**. 

<img src="./assets/entity.png" alt="1" style="zoom:50%;" />

###### Basic Data Relationships

Vi bestämmer själva, eller försöker att se, relationen entities emellan. Det finns tre basic typer av relationer; one-to-one, one-to-many och many-to-many. Vi kollar efter relationerna som instanserna av entities har.

En relation etablerar en förbindelse mellan ett par tables som är logiskt relaterade till varandra. 

###### One-to-one

```
CREATE TABLE teacher (
  id INT NOT NULL AUTO_INCREMENT,
  firstName VARCHAR(255),
  lastName VARCHAR(255),
  admin_username VARCHAR(255) UNIQUE,
  PRIMARY KEY (id)
);
```

<img src="./assets/one-to-one.png" alt="one-to-one" style="zoom:50%;" />



Bara genom att använda oss av **Unique** har vi skapat oss en one-to-one relation.

Lärarern kan endast ha ett admin_username, och det måste vara unikt.

###### One-to-Many

Vilken table är egentligen "One" och vilken är "Many"?

Alltså; vilken är parent och vilken är child?

En student kan endast gå på en skola, men en skola kan ha flera studenter.

Säg att skolan har ett bibliotek, då kan biblioteket ha flera böcker, men en bok kan ju endast finnas på ett bibliotek.

```
CREATE TABLE library (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255),
  address VARCHAR(255),
  PRIMARY KEY(id)
);
```

```
CREATE TABLE book (
  book_id INT NOT NULL AUTO_INCREMENT,
  library_id INT,
  title VARCHAR(255),
  PRIMARY KEY(book_id),
  FOREIGN KEY(library_id) REFERENCES library(id)
);
```

```
INSERT INTO library(name, address) VALUES('Humanisten', 'Göteborg nånstans');
INSERT INTO book(library_id, title) VALUES (1, 'mysql bascis');
INSERT INTO book(library_id, title) VALUES (1, 'postgres basics');
```

```
SELECT book.title
FROM book
JOIN library
ON library.id = book.library_id;
```

###### Many-To-Many

Inga limitioner på hur många relationer som kan finnas.

En student kan gå flera kurser, och en kurs kan ha flera studenter.

```
CREATE TABLE course (
     course_id MEDIUMINT NOT NULL AUTO_INCREMENT,
     subject VARCHAR(255) NOT NULL,
     PRIMARY KEY (course_id)
);
```

```
INSERT INTO course(subject) VALUES('mysql course');
```

```
CREATE TABLE student (
     student_id MEDIUMINT NOT NULL AUTO_INCREMENT,
     firstName CHAR(30) NOT NULL,
     lastName CHAR(30) NOT NULL,
     course_id MEDIUMINT,
     PRIMARY KEY (student_id),
     FOREIGN KEY(course_id) REFERENCES course(course_id)
);
```

```
CREATE TABLE student_course (
  student_id INT REFERENCES student(id),
  course_id INT REFERENCES course(id),
  PRIMARY KEY (student_id, course_id)
);
```



###### Single-Valued Versus Multivalued Attributes

Attributen i vår data model måste vara **single-valued**. Har ett attribut flera värden, som till exempel flera telefonnummer lagrade i samma attribut, kallar vi det för **multivalued attributes**. Eftersom att ett attribut inte får inne ha multivalued attributes så behöver vi då skapa en egen entity åt dessa.

Vad är problemet med multivalued attributes? De kan skapa problem med *meaning* av data i en databas, gör sökningar långsamma och skapar onödiga restriktioner för hur mycket data som kan lagras i vår databas.

Försök att se det som en god sak. Har du multivalued attributes så VET du att du måste skapa en ny entity åt dessa.

#### Data Integrity

I stort handlar Data Integrity om att ha korrekt data i ens databas.

- Entity Integrity

Uniqueness among your entities. Vi säger att vi applicerar Entity Integrity när vi exempelvis använder oss av **Primary Key** eller **NOT NULL**.

- Referential Integrity

Vi säger att vi applicerar Referential Integrity när vi exempelvis använder oss av **Foreign Key**

- Domain Integrity

Acceptabla värden för en kolumn. Vi säger att vi applicerar Domain Integrity när vi exempelvis använder oss av **check**

```
CREATE TABLE student(id INT, age INT check(age between 18 and 24));
```

#### Data Redundancy

 När samma data är finns på olika ställen.

```
CREATE TABLE school (
id MEDIUMINT NOT NULL AUTO_INCREMENT,
name CHAR(30) NOT NULL,
school_address VARCHAR(255),
PRIMARY KEY (id)
);
```

```
CREATE TABLE student (
id MEDIUMINT NOT NULL AUTO_INCREMENT,
name CHAR(30) NOT NULL,
school_id MEDIUMINT,
school_address VARCHAR(255),
FOREIGN KEY(school_id) REFERENCES school(id),
PRIMARY KEY (id)
);
```

Här finns data av skolan address på två olika ställen.

<img src="./assets/data_redundancy.png" alt="data_redundancy" style="zoom:50%;" />

#### Database Anomalies 

**Database Anomalies** sker vid dåligt planerad databas-design. En teknik för att undgå database anomalies, och ha en väl planerad databas-design kallas för **Normalization**. 

Det finns tre typer av database anomalies:

###### Insertion Anomalies

Detta sker när vi inte kan sätta in ett attribut utan närvaron av ett annat attribut.

Läraren har anställts av skolan, men ännu inte fått någon kurs att lära ut.

```
CREATE TABLE teacher (
     id MEDIUMINT NOT NULL AUTO_INCREMENT,
     name CHAR(30) NOT NULL,
     course VARCHAR(50) NOT NULL,
     PRIMARY KEY (id)
);
```

```
INSERT INTO teacher(name) VALUES('Teachy-Teach');
```

För att undvika problem behöver vi dela upp **teacher** och **course** tables.

```
CREATE TABLE teacher (
     teacher_id MEDIUMINT NOT NULL AUTO_INCREMENT,
     name CHAR(30) NOT NULL,
     course_id MEDIUMINT,
     PRIMARY KEY (teacher_id),
     FOREIGN KEY(course_id) REFERENCES course(course_id)
);
```

```
CREATE TABLE course (
     course_id MEDIUMINT NOT NULL AUTO_INCREMENT,
     name CHAR(30) NOT NULL,
     PRIMARY KEY (course_id)
);
```

```
INSERT INTO course(name) VALUES('history');
INSERT INTO teacher(name, course_id) VALUES('Alex', 1);
```

```
SELECT course.name
FROM course
LEFT JOIN teacher
ON course.course_id = teacher.course_id;
```

Ett annat exempel är om vi tar in extern personal

```
CREATE TABLE externalTeacher (
     id MEDIUMINT NOT NULL AUTO_INCREMENT,
     name CHAR(30) NOT NULL,
     company VARCHAR(255),
     PRIMARY KEY (id),
);
```

```
INSERT INTO externalTeacher(
name, company
VALUES('alex', 'felstavat company name')
);
```

###### Update Anomaly

Om vi har information om samma data i två olika tables, och uppdaterar informationen i en table så att datan blir inkonsekvent.

```
CREATE TABLE student (
  id MEDIUMINT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255),
  address VARCHAR(255),
  PRIMARY KEY (id)
);
```

```
CREATE TABLE grade (
  id MEDIUMINT NOT NULL AUTO_INCREMENT,
  grade CHAR(30),
  student_id MEDIUMINT,
  student_address VARCHAR(255),
  sent_grade BOOL,
  PRIMARY KEY (id),
  FOREIGN KEY(student_id) REFERENCES student(id)
);
```

###### Delete Anomaly

När data raderas på grund av radering av någon annan data. 

```
CREATE TABLE student (
  id MEDIUMINT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255),
  PRIMARY KEY (id)
);
```

```
CREATE TABLE course (
 id MEDIUMINT NOT NULL AUTO_INCREMENT,
 subject VARCHAR(255),
 PRIMARY KEY(id)
);
```

```
CREATE TABLE grade (
  id MEDIUMINT NOT NULL AUTO_INCREMENT,
  grade CHAR(30),
  course_id MEDIUMINT,
  student_id MEDIUMINT,
  PRIMARY KEY (id),
  FOREIGN KEY(student_id) REFERENCES student(id),
  FOREIGN KEY(course_id) REFERENCES course(id)
);
```

```
INSERT INTO student(name) VALUES('Elevsson');

INSERT INTO course(subject) VALUES('SQL');

INSERT INTO grade(grade, course_id, student_id) VALUES('VG', 1, 1);
```

Säg att vi nu ska sluta använda oss av IG/G/VG och kör

```
DELETE FROM grade WHERE grade = 'VG';
```

#### Database Normalization

Database Normalization är processen i att strukturera en databas. Denna process går igenom en serie av **Normal Forms** och syftet är att reducera **data redundency** och samtidigt stärka **data integrity**.

Med **data redundency** menas, när det kommer till databaser, att vi vill undvika att samma data finns på flera olika ställen. Data redundency kommer med största sannolikhet att leda till **data anomalies** och **korruption**.

**Data integrity** betyder i sammanhanget säkerställandet av att datan är korrekt och konsistent genom hela dess livscykel.

#### Normal Forms

Varje Normal Forms representerar en ökad grad av förbättrad databas design. Ju högre nivå, ju bättre design. I de flesta fall räcker det med att implementera de 3 första, men totalt finns det 6 Normal Forms vilka vi kommer att gå igenom steg för steg utifrån ett exempel.

#### First Normal Form (1NF)

En table är i first normal form om den möter följande kriterier:

- The data are stored in a two-dimensional table.

- There are no repeating groups.

###### Repeating Groups

En **repeterad grupp** (Repeating Groups) är ett attribut som har fler än ett värde i varje row av en table

<img src="./assets/1nf.png" alt="1" style="zoom:50%;" />



Här ser vi ett tydligt exempel på repeating groups. Courses. Det skapar två stora problem:

1. Vi kan inte veta med 100% säkerhet vilket betyg korrespondar med vilken kurs. Vi skulle kunna utgå ifrån att det är i samma position som courses, men vad säger att den relativa positionen alltid kommer att förbli densamma?
2. Att söka igenom table:n är väldigt svårt. Skulle vi söka efter betyg för kurser i JavaScript som gavs före 2005 behöver vi utföra komplicerade queries.

Lösningen är simpel. Vi undviker helt enkelt repeterade grupper.

Tillvägagångsättet är att skapa ytterligare en table där vi lagrar betyg. 



<img src="./assets/1nfb.png" alt="3" style="zoom:50%;" />



###### Problem när det kommer till First Normal Forms

Vi har nu löst problemet med repeated groups, men det betyder inte att vi är färdiga med vår design, eller att ens first normal forms är fri från problem.

Låt oss ta ett annat exempel för att enklare kunna visa och förstå problematiken.

Säg att skolan behöver köpa in produkter och skapar en **orders table**

![4](./assets/4.png)

Det första vi behöver göra är att bestämma **Primary Key**.

Baserat på vår Table design hittills är ända sättat att hitta en **unique identifier** att använda oss av en **concatenated key**, i detta fall en kombination av **order_num** och **item_num**.

Det betyder att vi blir limiterade i vårt arbete.

- Vi kan inte lägga till data om kunden(customer) förens den har lagt en order, därför att utan en order och en item har vi ingen primary key
- Vi kan inte lägga till data om item innan den har blivit beställd

Detta kallas för **insertion anomalies** vilket sker när du förhindras att lägga till data därför att vi saknar en komplett primary key.

Insertion anomalies är väldigt vanliga i 1NF. De kommer till därför att det finns data om fler än en **entity** i samma relation.

Vi kan även få problem med **deletion anomalies**. De kommer till därför att delar av primary key blir till **null**, om vi till exempel raderar en item så kommer vi förlora data från hela beställningen.

Att ha fler än en **entity** i samma table är en dålig sak!

#### Second Normal Form (2NF)

Även om vi har lyckats ta oss ifrån 1NF och åtminstone undviktit repeterade grupper, så är vi, previs som vi gick igenom med våra insert och deletion- anomalies, långt ifrån färdiga med vår design.

Lösningen är att bryta ned relationen så vi tillslut har en relation för varje enity. 

Second Nomal Forms definieras som:

- The relation is in first normal form
- All non-key attributes are functionally dependent on the entire primary key

###### Functional Dependencies

Functional Dependency är en *one-way* relationship mellan två attribut. Vid varje given tidpunkt, för varje unikt värde av attribut A är endast ett värde av attribut B associerat med det i deras relation.

```
relation orders

attribut A = cust_num

cust_num --> first, last, street, city, state, zip, phone

Läses som: Customer Number bestämmer first, last, street... I denna relation är cust_num determinant, ett attribut som bestämmer värdet av andra attribut. 
```

first, last, street, city, state, zip, phone är alla **functionally dependent** av **cust_num**

Även om deras värden kan ändras så handlar det fortfarande bara om ett attribut

Vilka andra functional dependencies har vi?

```
item num --> title, price

order_num --> cust_num, order_date

item_num + order_num --> has_shipped
```

###### Att använda Functional Dependencies för att nå 2NF

Vi kan använda denna information till att skapa Second Normal Forms relationer. Varje **determant** blir **primary key** av en relation. Varje attribut som är functionally dependant av denna blir non-key attributes i deras relation.

```
customer(cust_num, first, last, street, city, state, zip, phone)

item(item_num, title, price)

order (order_num, cust_num, order_date)

order_items (order_num AND item_num, has_shipped)
```



#### Third Normal Form

3NF definition är:

- The relation is in second normal form
- There are no transitive dependencies

###### Transitive Dependencies

Transitive Dependency pattern existerar när man har följande **functional dependency pattern**:

```
A --> B och B --> C 
```

Så säg att vi säljer en bok, som dsitribueras av ett lager och vi lagrara ett telefonnummer till detta lager

```
item(item_num, title, price, dist_num, warehouse_phone_number)
```

Ända anledningen till varför **warehouse_phone_number** är functionally dependent av **item_num** är tack vare att **dist_num** är functionaly dependent av **item_num**

```
item_num --> dist_num
dist_num --> warehouse_phone_number
```

Vi har med andra ord två styck **determinants**, vilka bägga borde vara primary key i sina egna respektive relationer. Men vi måste inte göra på sätett som vi gjort hittills, att dela upp i olika tables. Vad som är avgörande här är att **dist_num** inte är en **candidate key**, och alltså inte kan användas som en primary key.

Se följande relation

```
Item(item_num, dist_num, price)
```

**item_num** är ett random nummer som ges till varje vara.

Functional dependencies i denna relation är:

```
item_num --> dist_num, price

upc -> item_num, dist_num, price
```

Det finns inte längre någon transitive dependency. Den andra **determinent(dist_num)** är en **candidate key**.

En transitive dependency finns endast när determinent, som inte är primary key,  inte är candidate key.

#### Boyce-Codd Normal Form

I de flesta fall är 3NF "good enough" och vi är nu fria från de flesta anomalies.

Boyce-Codd Normal Form

- The relation is in third normal form
- All determinants are candidate keys

#### Övningsuppgift

Fundera över ett databas-system som du som student ska vara en del av.

Vilken information behöver skolan ha om dig?

```
- Program

- kurser

- betyg

- adress

osv.
```

Skapa en table där all information lagras.

Gå därefter igenom samtliga Normal Forms och skapa dig en bra Databas Design!



