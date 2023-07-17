/* PostgreSQL Tutorial */
-- PostgreSQL Tutorial
-- Section 13 - Constraints.sql
-- https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-primary-key/

/*
  Including: PK, UK, CK, NN, FK
*/

-- PK, UK: Can add colum then set PK, UK event table already have data
-- Column data type must be SERIAL type or is Identity Colum.

-- 1. PK
CREATE TABLE vendors (name VARCHAR(255));

INSERT INTO vendors (NAME)
VALUES
	('Microsoft'),
	('IBM'),
	('Apple'),
	('Samsung');
	
ALTER TABLE vendors ADD COLUMN ID SERIAL PRIMARY KEY;

-- ALTER TABLE table_name DROP CONSTRAINT [PK_constraint_name];
 
SELECT * FROM vendors;
 
\d vendors -- to find PK_constraint_name

\d+ vendors -- to find PK_constraint_name

ALTER TABLE vendors  DROP CONSTRAINT vendors_pkey;

SELECT * FROM vendors;

-- 2. UK

-- Option 1
DROP TABLE IF EXISTS equipment;
CREATE TABLE equipment (
	id SERIAL PRIMARY KEY,
	name VARCHAR (50) NOT NULL,
	equip_id VARCHAR (16) NOT NULL
);

CREATE UNIQUE INDEX CONCURRENTLY equipment_equip_id 
ON equipment (equip_id);

ALTER TABLE equipment 
ADD CONSTRAINT unique_equip_id 
UNIQUE USING INDEX equipment_equip_id;

-- NOTICE:  ALTER TABLE / ADD CONSTRAINT USING INDEX will rename index "equipment_equip_id" to "unique_equip_id"
-- index was changed name automatically


-- Option 2
DROP TABLE IF EXISTS equipment;
CREATE TABLE equipment (
	id SERIAL PRIMARY KEY,
	name VARCHAR (50) NOT NULL,
	equip_id VARCHAR (16) NOT NULL UNIQUE
);

\d equipment
-- => Unique index name "equipment_equip_id_key" <> "unique_equip_id"

-- 3. FK
/*
[CONSTRAINT fk_name]
   FOREIGN KEY(fk_columns) 
   REFERENCES parent_table(parent_key_columns)
   [ON DELETE delete_action]
   [ON UPDATE update_action]

Notes:

PostgreSQL supports the following actions:
	SET NULL
	SET DEFAULT
	RESTRICT -- this is default if not specified
	NO ACTION
	CASCADE
*/

-- 4. CK
-- {table}_{column}_check

-- 5. NN
/*
Use the NOT NULL constraint for a column to enforce a column not accept NULL. By default, a column can hold NULL.
To check if a value is NULL or not, you use the IS NULL operator. The IS NOT NULL negates the result of the IS NULL.
Never use equal operator = to compare a value with NULL because it always returns NULL.
*/

