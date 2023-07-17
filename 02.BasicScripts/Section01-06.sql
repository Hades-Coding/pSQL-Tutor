/* PostgreSQL Tutorial */
-- PostgreSQL Tutorial
-- https://www.postgresqltutorial.com/

-- Note: \! cls => call cls command from OS command line

-------------------------------------
-- Section 1. Querying Data
-- Select | Column aliases | Order By | Select Distinct
-------------------------------------

SELECT 5 * 3;
SELECT 5 * 3 xXx;


-- chec which DB
-- \conninfo

-- Switch dvdrental Database
\c dvdrental

SELECT first_name || ' ' || last_name as "Full Name", email "Email"
FROM   customer;

-- Switch Test DB
\c Test;

CREATE TABLE distinct_demo (
	id serial NOT NULL PRIMARY KEY,
	bcolor VARCHAR,
	fcolor VARCHAR
);

INSERT INTO distinct_demo (bcolor, fcolor)
VALUES
	('red', 'red'),
	('red', 'red'),
	('red', NULL),
	(NULL, 'red'),
	('red', 'green'),
	('red', 'blue'),
	('green', 'red'),
	('green', 'blue'),
	('green', 'green'),
	('blue', 'red'),
	('blue', 'green'),
	('blue', 'blue');

-- Run test
SELECT   DISTINCT bcolor
FROM     distinct_demo
ORDER BY bcolor;

SELECT   DISTINCT bcolor, fcolor
FROM     distinct_demo
ORDER BY bcolor, fcolor;

-- DISTINCT ON expression must match the leftmost expression in the ORDER BY clause.
SELECT   DISTINCT ON (bcolor) bcolor, fcolor
FROM     distinct_demo 
ORDER BY bcolor, fcolor;

-- Section 1 SUMMARY
-- ORDER BY sort_expresssion [ASC | DESC] [NULLS FIRST | NULLS LAST]
-- END SUMMARY

-------------------------------------
-- Section 2. Filtering Data
-- WHERE
--		 | IS [NOT] NULL | [NOT] IN | [NOT] BETWEEN | [NOT] LIKE | [NOT] ILIKE

-- LIMIT | FETCH
-- [OFFSET start { ROW | ROWS }]
-- FETCH { FIRST | NEXT } [ row_count ] { ROW | ROWS } ONLY
-------------------------------------

-- Switch dvdrental DB
\c dvdrental

SELECT   film_id, title
FROM     film
ORDER BY title 
OFFSET 5 ROWS 
FETCH FIRST 5 ROW ONLY; 

-- Section 2 SUMMARY
-- FETCH is SQL Standard, LIMIT is not
-- LIKE | ILIKE => case-sensitive| case-INsensitive
-- END SUMMARY

-------------------------------------
-- Section 3. Joining Multiple Tables
-- Table aliases
-- Joins (LEFT, RIGHT, FULL, INNER, SELF, CROSS) ON | , USING (..), 
-- Natural Join (on matched colums name): NATURAL [INNER, LEFT, RIGHT] JOIN
-------------------------------------

-------------------------------------
-- Section 4. Grouping Data
-- 		Group By, Having
-- Section 5. Set Operations
-- 		Union, Union ALL, Intersect, Except
-- 		Except LIKE ORACLE MINUS
-- Section 6. Grouping sets, Cube, and Rollup
-- 		GROUPING SETS => Instead of having multiple UNION ALL
-- 		CUBE, ROLLUP => PARTIAL CUBE, PARTIAL ROLLUP
-------------------------------------
-- NOTES: GROUPING (Column | Expr): Colum or Expr must be in GROUP BY clause
-------------------------------------

