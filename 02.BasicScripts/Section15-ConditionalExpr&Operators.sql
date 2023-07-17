/* Section 15 - Conditional Expr & Operators.sql */
-- Section 15 - Conditional Expr & Operators.sql

-- Switch dvdrental Database
-- \c dvdrental

-- SELECT title, length FROM film ORDER BY title;
/*
SELECT title, count(*) FROM film
GROUP BY title
HAVING COUNT (*) > 1
ORDER BY title;
*/


-- 1. CASE
-- A general CASE example
SELECT title, length,
       CASE
           WHEN length> 0 AND length <= 50 THEN 'Short'
           WHEN length > 50 AND length <= 120 THEN 'Medium'
           WHEN length> 120 THEN 'Long'
		   ELSE 'N/A'
       END duration
FROM film
ORDER BY title;

-- CASE with an aggregate function
SELECT
	SUM (
		CASE
			WHEN rental_rate = 0.99 THEN 1
			ELSE 0
		 END
		) AS "Economy",
	SUM (
		CASE
			WHEN rental_rate = 2.99 THEN 1
			ELSE 0
		END
		) AS "Mass",
	SUM (
		CASE
			WHEN rental_rate = 4.99 THEN 1
			ELSE 0
		END
		) AS "Premium"
FROM	film;

-- Simple PostgreSQL CASE expression
SELECT title,
       rating,
       CASE rating
           WHEN 'G' THEN 'General Audiences'
           WHEN 'PG' THEN 'Parental Guidance Suggested'
           WHEN 'PG-13' THEN 'Parents Strongly Cautioned'
           WHEN 'R' THEN 'Restricted'
           WHEN 'NC-17' THEN 'Adults Only'
		   ELSE "N/A"
       END rating_description
FROM film
ORDER BY title;

-- Simple PostgreSQL CASE expression with aggregate function
SELECT
       SUM(CASE rating
             WHEN 'G' THEN 1 
		     ELSE 0 
		   END) "General Audiences",
       SUM(CASE rating
             WHEN 'PG' THEN 1 
		     ELSE 0 
		   END) "Parental Guidance Suggested",
       SUM(CASE rating
             WHEN 'PG-13' THEN 1 
		     ELSE 0 
		   END) "Parents Strongly Cautioned",
       SUM(CASE rating
             WHEN 'R' THEN 1 
		     ELSE 0 
		   END) "Restricted",
       SUM(CASE rating
             WHEN 'NC-17' THEN 1 
		     ELSE 0 
		   END) "Adults Only"
FROM film;

-- 2. COALESCE
-- COALESCE (argument_1, argument_2, …);
/*
The COALESCE function accepts an unlimited number of arguments. It returns the first argument that is not null. If all arguments are null, the COALESCE function will return null.

The COALESCE function evaluates arguments from left to right until it finds the first non-null argument. All the remaining arguments from the first non-null argument are not evaluated.

The COALESCE function provides the same functionality as NVL or IFNULL function provided by SQL-standard. MySQL has IFNULL function, while Oracle provides NVL function.
*/

-- 3. NULLIF 
-- NULLIF(argument_1,argument_2);
-- The NULLIF function returns a null value if argument_1 equals to argument_2, otherwise it returns argument_1.

/*
=> Should check excerpt means
*/

-- 4. CAST To Convert 
-- CAST ( expression AS target_type );

-- PostgreSQL type cast :: operator

SELECT '100'::INTEGER;
SELECT CAST ('100' AS INTEGER);

SELECT CAST ('10.2' AS DOUBLE); -- Error
SELECT CAST ('10.2' AS DOUBLE PRECISION);
