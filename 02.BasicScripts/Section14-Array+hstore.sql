/* Section 14 - Array+hstore.sql */
-- Section 14 - Array+hstore.sql

-- 1. Array
-- Every data type has its own companion array type

CREATE TABLE contacts (
	id serial PRIMARY KEY,
	name VARCHAR (100),
	phones TEXT []
);

INSERT INTO contacts (name, phones)
VALUES('John Doe',ARRAY [ '(408)-589-5846','(408)-589-5555' ]);

INSERT INTO contacts (name, phones)
VALUES('Lily Bush','{"(408)-589-5841"}'),
      ('William Gate','{"(408)-589-5842","(408)-589-58423"}');
	  
SELECT	name, phones
FROM	contacts;

SELECT	name, phones [2]
FROM	contacts;

SELECT	name, phones
FROM	contacts
WHERE	'(408)-589-5555' = ANY (phones);

-- expand an array to a list of rows
SELECT	name, unnest(phones)
FROM	contacts;

-- 2. hstore
DROP TABLE IF EXISTS books;
CREATE TABLE books (
	id serial primary key,
	title VARCHAR (255),
	attr hstore
);

INSERT INTO books (title, attr)
VALUES('PostgreSQL Tutorial',
'
    "paperback" => "243",
    "publisher" => "postgresqltutorial.com",
    "language"  => "English",
    "ISBN-13"   => "978-1449370000",
    "weight"    => "10.2 ounces"
'
);

INSERT INTO books (title, attr)
VALUES('PostgreSQL Cheat Sheet',
'
    "paperback" => "5",
    "publisher" => "postgresqltutorial.com",
    "language"  => "English",
    "ISBN-13"   => "978-1449370001",
    "weight"    => "20.5 ounces"
'
);

SELECT	attr -> 'ISBN-13' AS isbn
FROM	books;

SELECT	title, attr -> 'weight' AS weight
FROM	books
WHERE	attr -> 'ISBN-13' = '978-1449370000';

UPDATE	books
SET		attr = attr || '"freeshipping"=>"yes"' :: hstore
WHERE	attr -> 'ISBN-13' = '978-1449370000';

SELECT title, attr FROM books;

UPDATE books
SET attr = attr || '"freeshipping"=>"no"' :: hstore;

SELECT title, attr FROM books;

SELECT	title, attr->'publisher' as publisher, attr
FROM	books
WHERE	attr ? 'publisher';

SELECT	title
FROM	books
WHERE	attr @> '"weight"=>"11.2 ounces"' :: hstore;

-- akeys() | skeys(): Get all keys from an hstore column => return string | result set
-- avals() | svals(): Get all values from an hstore column => return string | result set

-- Convert hstore data to JSON
SELECT title, hstore_to_json (attr) json
FROM books;

SELECT title, (EACH(attr) ).*
FROM books;
