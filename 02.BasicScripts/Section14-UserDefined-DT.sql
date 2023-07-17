/* Section 14 - User_Defined_DT.sql */
-- Section 14 - User_Defined_DT.sql

-- Switch Test Database
-- \c Test

-- 1. PostgreSQL CREATE DOMAIN statement
DROP TABLE IF EXISTS mailing_list;
-- 1a. Old option:
CREATE TABLE mailing_list (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
	
	-- both first_name and last_name columns do not accept null OR contain space
    CHECK (
        first_name !~ '\s'
        AND last_name !~ '\s'
    )
);

-- 1b. NEW option:
-- Do not accept null OR contain space
CREATE DOMAIN contact_name AS 
   VARCHAR NOT NULL CHECK (value !~ '\s');

DROP TABLE IF EXISTS mailing_list;
CREATE TABLE mailing_list (
    id serial PRIMARY KEY,
    first_name contact_name,
    last_name contact_name,
    email VARCHAR NOT NULL
);

-- 2. Test & see response message
INSERT INTO mailing_list (first_name, last_name, email)
VALUES('Jame V','Doe','jame.doe@example.com');

INSERT INTO mailing_list (first_name, last_name, email)
VALUES('Jane','Doe','jane.doe@example.com');

-- 3. View domain definition (\dD or select clause) -- shema public
SELECT	typname
FROM	pg_catalog.pg_type JOIN pg_catalog.pg_namespace ON pg_namespace.oid = pg_type.typnamespace 
WHERE	typtype = 'd' and nspname = 'public';

-- 4. PostgreSQL CREATE TYPE
CREATE TYPE film_summary AS (
    film_id INT,
    title VARCHAR,
    release_year SMALLINT
); 

CREATE OR REPLACE FUNCTION get_film_summary (f_id INT) 
    RETURNS film_summary AS 
$$ 
SELECT film_id, title, release_year
FROM film
WHERE film_id = f_id ; 
$$ 
LANGUAGE SQL;

-- 3. View types
-- \dT or \dT+