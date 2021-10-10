CREATE DATABASE employees;

CREATE TABLE employee (
id INT, first VARCHAR(50),
last VARCHAR(50),
childs_name VARCHAR(50),
childs_birth VARCHAR(50)
);

INSERT INTO employee(
id,
first,
last,
childs_name,
childs_birth
)
VALUES
(1, 'John', 'Doe', '"Mary", "Sam"', '"1/9/02","4/8/03"'),
(2, 'Mel', 'Doe', '"Sanna", "Sansson"', '"18/9/10","4/8/13"'),
(3, 'Jane', 'Del Rey', '"Anna", "Sammy"', '"7/9/02","4/8/03"'),
(4, 'Hanna', 'Morrisey', '"Berit", "Berta"', '"13/9/02","4/8/03"');

ALTER TABLE employee
DROP childs_name,
DROP childs_birth;

CREATE TABLE children(
  emp_id INT,
  first VARCHAR(50),
  birthday VARCHAR(50)
);

INSERT INTO employee(
id,
first,
last
)
VALUES
(1, 'John', 'Doe', '"Mary", "Sam"', '"1/9/02","4/8/03"'),
(2, 'Mel', 'Doe', '"Sanna", "Sansson"', '"18/9/10","4/8/13"'),
(3, 'Jane', 'Del Rey', '"Anna", "Sammy"', '"7/9/02","4/8/03"'),
(4, 'Hanna', 'Morrisey', '"Berit", "Berta"', '"13/9/02","4/8/03"');

INSERT INTO children(
  emp_id,
  first,
  birthday
)
VALUES
(1, 'Mary', '1/9/02'),
(1, 'Sam', '4/8/03'),
(2, 'Sanna', '18/0/10');

CREATE DATABASE myshop;

CREATE TABLE orders(
 cust_num INT,
 first VARCHAR(50),
 last VARCHAR(50),
 street VARCHAR(50),
 city VARCHAR(50),
 state VARCHAR(50),
 zip INT,
 phone VARCHAR(50),
 order_num INT,
 order_date date,
 item_num INT,
 title VARCHAR(50),
 price DECIMAL,
 has_shipped BOOL
);

INSERT INTO orders(
 cust_num,
 first,
 last,
 street,
 city,
 state,
 zip,
 phone,
 order_num,
 order_date,
 item_num,
 title,
 price,
 has_shipped
)
VALUES(
  1,
  'John',
  'Doe',
  'silvermyntsgatan',
  'Göteborg',
  'västra götaland',
  41479,
  'xxxx-xxxxxx',
  415,
  '02/20/2020',
  37272,
  'En go vas',
  199.99,
  FALSE
);












