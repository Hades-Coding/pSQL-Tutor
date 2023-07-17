/* PostgreSQL Tutorial */
-- PostgreSQL Tutorial
-- Section 09+10 - Modifying Data & TXN.sql
-- Section 09 - Modifying Data
-- Section 10 - Transactions placed here

\c Test

-- 1. PostgreSQL INSERT
-- Default Return oid, COUNT
-- OID is system generated value
-- Can add RETURNING clause at the last clause
-- eg: RETURNING id;
-- eg: RETURNING * | output_expression;

-- 2. PostgreSQL UPDATE
-- Default Return COUNT
-- Can add RETURNING clause at the last clause 
-- eg: RETURNING id;
-- eg: RETURNING *; -- return all row after updated!

-- 3. PostgreSQL UPDATE Join

DROP TABLE IF EXISTS product_segment;
CREATE TABLE product_segment (
    id SERIAL PRIMARY KEY,
    segment VARCHAR NOT NULL,
    discount NUMERIC (4, 2)
);

INSERT INTO product_segment (segment, discount)
VALUES
    ('Grand Luxury', 0.05),
    ('Luxury', 0.06),
    ('Mass', 0.1);

DROP TABLE IF EXISTS product;
CREATE TABLE product(
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    price NUMERIC(10,2),
    net_price NUMERIC(10,2),
    segment_id INT NOT NULL,
    FOREIGN KEY(segment_id) REFERENCES product_segment(id)
);

INSERT INTO product (name, price, segment_id) 
VALUES 
    ('diam', 804.89, 1),
    ('vestibulum aliquet', 228.55, 3),
    ('lacinia erat', 366.45, 2),
    ('scelerisque quam turpis', 145.33, 3),
    ('justo lacinia', 551.77, 2),
    ('ultrices mattis odio', 261.58, 3),
    ('hendrerit', 519.62, 2),
    ('in hac habitasse', 843.31, 1),
    ('orci eget orci', 254.18, 3),
    ('pellentesque', 427.78, 2),
    ('sit amet nunc', 936.29, 1),
    ('sed vestibulum', 910.34, 1),
    ('turpis eget', 208.33, 3),
    ('cursus vestibulum', 985.45, 1),
    ('orci nullam', 841.26, 1),
    ('est quam pharetra', 896.38, 1),
    ('posuere', 575.74, 2),
    ('ligula', 530.64, 2),
    ('convallis', 892.43, 1),
    ('nulla elit ac', 161.71, 3);
	
-- Then update Join:
-- Data returning from both tables
UPDATE	product
SET		net_price = price - price * discount
FROM	product_segment
WHERE	product.segment_id = product_segment.id

RETURNING *;

-- or change like this:
-- Data returning from both tables
UPDATE	product p
SET		net_price = price - price * discount
FROM	product_segment s
WHERE	p.segment_id = s.id

RETURNING *;

-- 4. PostgreSQL DELETE
-- Default Return COUNT

-- DELETE FROM table_name
-- WHERE condition
-- RETURNING (select_list | *);

DROP TABLE IF EXISTS links;
CREATE TABLE links (
    id serial PRIMARY KEY,
    url varchar(255) NOT NULL,
    name varchar(255) NOT NULL,
    description varchar(255),
    rel varchar(10),
    last_update date DEFAULT now()
);

INSERT INTO links 
VALUES 
   ('1', 'https://www.postgresqltutorial.com', 'PostgreSQL Tutorial', 'Learn PostgreSQL fast and easy', 'follow', '2013-06-02'),
   ('2', 'http://www.oreilly.com', 'O''Reilly Media', 'O''Reilly Media', 'nofollow', '2013-06-02'),
   ('3', 'http://www.google.com', 'Google', 'Google', 'nofollow', '2013-06-02'),
   ('4', 'http://www.yahoo.com', 'Yahoo', 'Yahoo', 'nofollow', '2013-06-02'),
   ('5', 'http://www.bing.com', 'Bing', 'Bing', 'nofollow', '2013-06-02'),
   ('6', 'http://www.facebook.com', 'Facebook', 'Facebook', 'nofollow', '2013-06-01'),
   ('7', 'https://www.tumblr.com/', 'Tumblr', 'Tumblr', 'nofollow', '2013-06-02'),
   ('8', 'http://www.postgresql.org', 'PostgreSQL', 'PostgreSQL', 'nofollow', '2013-06-02');

-- Return deleted row
DELETE FROM links
WHERE id = 7
RETURNING *;

DELETE FROM links
WHERE id IN (6,5)
RETURNING *;

-- 5. PostgreSQL DELETE
-- PostgreSQL DELETE statement with USING clause
-- DELETE FROM table_name1
-- USING table_expression
-- WHERE condition
-- RETURNING returning_columns;
-- => DELETE USING is not a SQL-standard

-- DELETE FROM t1
-- USING t2
-- WHERE t1.id = t2.id

DROP TABLE IF EXISTS contacts;
CREATE TABLE contacts(
   contact_id serial PRIMARY KEY,
   first_name varchar(50) NOT NULL,
   last_name varchar(50) NOT NULL,
   phone varchar(15) NOT NULL
);

DROP TABLE IF EXISTS blacklist;
CREATE TABLE blacklist(
    phone varchar(15) PRIMARY KEY
);

INSERT INTO contacts(first_name, last_name, phone)
VALUES ('John','Doe','(408)-523-9874'),
       ('Jane','Doe','(408)-511-9876'),
       ('Lily','Bush','(408)-124-9221');


INSERT INTO blacklist(phone)
VALUES ('(408)-523-9874'),
       ('(408)-511-9876');

-- Option 1: DELETE & USING - is not a SQL-standard
DELETE FROM contacts c
USING blacklist b
WHERE c.phone = b.phone;

-- Option 2: DELETE uses SUB-QUERY - is a SQL-standard
DELETE FROM contacts
WHERE phone IN (SELECT phone FROM blacklist);

-- 6. PostgreSQL INSERT ON CONFLICT
-- Available from PostgreSQL 9.5
-- INSERT INTO table_name(column_list) 
-- VALUES(value_list)
-- ON CONFLICT target action;

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
	customer_id serial PRIMARY KEY,
	name VARCHAR UNIQUE, -- here
	email VARCHAR NOT NULL,
	active bool NOT NULL DEFAULT TRUE
);

INSERT INTO customers (name, email)
VALUES 
    ('IBM', 'contact@ibm.com'),
    ('Microsoft', 'contact@microsoft.com'),
    ('Intel', 'contact@intel.com');

-- constraint violated
INSERT INTO customers (NAME, email)
VALUES('Microsoft','hotline@microsoft.com') 
ON CONFLICT ON CONSTRAINT customers_name_key
	DO NOTHING;

SELECT COUNT(*) FROM customers;
select customer_id, email from customers;

-- or
INSERT INTO customers (name, email)
VALUES('Microsoft','hotline@microsoft.com') 
ON CONFLICT (name) 
	DO NOTHING;

SELECT COUNT(*) FROM customers;
select customer_id, email from customers;

-- other example - add EXCLUDED email at front.
INSERT INTO customers (name, email)
VALUES('Microsoft','hotline@microsoft.com') 
ON CONFLICT (name) 
	DO UPDATE SET email = EXCLUDED.email || ';' || customers.email;

SELECT COUNT(*) FROM customers;
select customer_id, email from customers;


-- Section 10. Transactions