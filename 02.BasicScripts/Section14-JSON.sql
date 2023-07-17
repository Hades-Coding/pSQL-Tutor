/* Section 14 - JSON.sql */
-- Section 14 - JSON.sql

-- Switch Test Database
-- \c Test

-- 1. Create table has JSON column (info)
CREATE TABLE orders (
	id serial NOT NULL PRIMARY KEY,
	info json NOT NULL
);

-- 2. Insert JSON data (1 or many rows in 1 SQL STATEMENT)
-- => Note about JSON form
-- The operator -> returns JSON object field by JSON.
-- The operator ->> returns JSON object field by TEXT.

INSERT INTO orders (info)
VALUES('{ "customer": "John Doe", "items": {"product": "Beer","qty": 6}}');

INSERT INTO orders (info)
VALUES('{ "customer": "Lily Bush", "items": {"product": "Diaper","qty": 24}}'),
      ('{ "customer": "Josh William", "items": {"product": "Toy Car","qty": 1}}'),
      ('{ "customer": "Mary Clark", "items": {"product": "Toy Train","qty": 2}}');

SELECT id, info FROM orders;

--3. OUTPUT TYPE value & QUERY on JSON column
--3a. Return JSON form
SELECT info -> 'customer' AS customer
FROM orders;

-- 3b. Return TEXT form
SELECT info ->> 'customer' AS customer
FROM orders;


-- 4. Use JSON operator in WHERE clause
SELECT info ->> 'customer' AS customer
FROM orders
WHERE info -> 'items' ->> 'product' = 'Diaper';

SELECT info ->> 'customer' AS customer,
	info -> 'items' ->> 'product' AS product
FROM orders
WHERE CAST ( info -> 'items' ->> 'qty' AS INTEGER) = 2;

-- 5. Apply aggregate functions to JSON data
SELECT 
   MIN (CAST (info -> 'items' ->> 'qty' AS INTEGER)),
   MAX (CAST (info -> 'items' ->> 'qty' AS INTEGER)),
   SUM (CAST (info -> 'items' ->> 'qty' AS INTEGER)),
   AVG (CAST (info -> 'items' ->> 'qty' AS INTEGER))
FROM orders;

-- 6. PostgreSQL JSON functions => https://www.postgresql.org/docs/current/static/functions-json.html
-- to expand the outermost JSON object into a set of key-value pairs
SELECT *, json_each (info) FROM orders;

-- returns all keys of JSON object
SELECT json_object_keys (info->'items') FROM orders;

-- returns data type of the outermost JSON value as a string
SELECT json_typeof (info->'items') FROM orders;
