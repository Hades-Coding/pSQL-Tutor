--------------------------------------------------
-- Section02-Schema.sql
-- https://www.postgresqltutorial.com/postgresql-schema/
--------------------------------------------------
\c dvdrental
--------------------------------------------------
-- Section 2. Managing Schemas
--------------------------------------------------
-- 2.0. Notes
-- 0. Schema Info
\db
\db+

-- FQDN (fully qualified domain name): database.schema.table

-- View schema search path
SELECT current_schema();
SHOW search_path;
-- SET search_path TO [schema_name], public;
-- eg:
\c dvdrental
\dn
CREATE SCHEMA sales;

\dn
SELECT current_schema();
SHOW search_path;

-- for this session only
SET search_path TO sales, public;
SHOW search_path;
\dn

SELECT current_schema();
-- then quit & re-login
-- ..

-- ALL STATEMENT HERE show Schema Info:
\dn
SELECT current_schema();
SHOW search_path;

SELECT * 
FROM pg_catalog.pg_namespace
ORDER BY nspname;

-- PostgreSQL schemas and privileges
-- GRANT USAGE ON SCHEMA schema_name TO role_name; -- View DEFINITION ONLY
-- GRANT CREATE ON SCHEMA schema_name TO user_name; -- Create object on that schema
-- eg:
create role test login password '123456';
grant usage on sales to test;

SET search_path TO sales, public; -- to create objects on sales schema
DROP TABLE IF EXISTS links;

CREATE TABLE links (
	id SERIAL PRIMARY KEY,
	url VARCHAR(255) NOT NULL,
	name VARCHAR(255) NOT NULL,
	description VARCHAR (255),
        last_update DATE
);

\dt links;
\q

-- login by user test to check
psql -U test -d dvdrental

\dt links; -- Did not find any relation named "links".
\dt sales.links; --OK
select * from sales.links; -- ERROR:  permission denied for table links

--------------------------------------------------
-- 2.1 CREATE SCHEMA
--------------------------------------------------
-- CREATE SCHEMA [IF NOT EXISTS] schema_name;

-- CREATE schema & user | role have the same name
-- CREATE SCHEMA [IF NOT EXISTS] AUTHORIZATION [username | role name];

/* -- does not end with a semicolon (;), each subcommand
CREATE SCHEMA schema_name
    CREATE TABLE table_name1 (...)
    CREATE TABLE table_name2 (...)
    CREATE VIEW view_name1
        SELECT select_list FROM table_name1;
*/

--------------------------------------------------
-- 2.2 ALTER SCHEMA
--------------------------------------------------
-- Rename: ALTER SCHEMA schema_name RENAME TO new_name;
-- Change Owner: ALTER SCHEMA schema_name OWNER TO { new_owner | CURRENT_USER | SESSION_USER};
-- Check user-created schema:
SELECT	 * 
FROM	 pg_catalog.pg_namespace
WHERE	 nspacl is NULL AND nspname NOT LIKE 'pg_%'
ORDER BY nspname;

SELECT	 * 
FROM	 pg_catalog.pg_namespace;

--------------------------------------------------
-- 2.3 DROP SCHEMA
--------------------------------------------------
-- DROP SCHEMA [IF EXISTS] schema_name1 [,schema_name2,...] [CASCADE | RESTRICT];
