/* Section 17 - PostgreSQL Recipes.sql */
-- Section 17 - PostgreSQL Recipes.sql

-- 1. Random FUNCTION
SELECT random(); -- 0<=x<1

CREATE OR REPLACE FUNCTION random_between(low INT ,high INT) 
   RETURNS INT AS
$$
BEGIN
   RETURN floor(random()* (high-low + 1) + low);
END;
$$ LANGUAGE 'plpgsql' STRICT;

SELECT generate_series(1,5), random_between(1,100);

-- 2. EXPLAIN statement
-- EXPLAIN [ ( option [, ...] ) ] sql_statement;
/*
option are:
	ANALYZE [ boolean ] default true [BUFFERS [ boolean ] | default false] [TIMING [ boolean ] | default true]
	VERBOSE [ boolean ] | default false -- additional information
	COSTS [ boolean ] | default true
	SUMMARY [ boolean ] -- default added when analyze used
	
	FORMAT { TEXT | XML | JSON | YAML } | default TEXT
*/

/*
Notes: For DML like IUD, push them on block:
BEGIN;
    EXPLAIN ANALYZE sql_statement;
ROLLBACK;
*/

\c dvdrental

EXPLAIN (COSTS FALSE) 
	SELECT * FROM film WHERE film_id = 100;

EXPLAIN SELECT COUNT(*) FROM film;

EXPLAIN (ANALYZE TRUE, SUMMARY TRUE, COSTS TRUE)
	SELECT f.film_id, title, name category_name
	FROM film f INNER JOIN film_category fc ON fc.film_id = f.film_id
				INNER JOIN category c  ON c.category_id = fc.category_id
	ORDER BY title;

