/* PostgreSQL Tutorial */
-- PostgreSQL Tutorial
-- https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-subquery/

 
\c dvdrental

-- Option 1 - use CTE in next section
WITH CTE AS
(
	SELECT	film_id, title, rental_rate
	FROM	film
	WHERE	rental_rate > ( SELECT	AVG (rental_rate)
							FROM	film)
)

SELECT COUNT(*) FROM CTE;

-- Option 2 - use subquery
-- subquery in FROM must have an alias (may be Oracle no need)

SELECT	COUNT(*)
FROM
		(
			SELECT	film_id, title, rental_rate
			FROM	film
			WHERE	rental_rate > ( SELECT	AVG (rental_rate)
									FROM	film)
		) AS CTE;


-- change from inner join to basic sql join
-- Option 1
SELECT	count (*) FROM (
	SELECT		MAX(length)
	FROM		film INNER JOIN film_category
				USING (film_id)
	GROUP BY	category_id
) AS CTE;

-- Change option
SELECT 	count (*) FROM (
	SELECT		MAX(f.length)
	FROM		film f, film_category fc
	WHERE		f.film_id = fc.film_id
	GROUP BY	fc.category_id
) AS CTE;

-- ANY:
-- x = 		ANY (a,b,c) ~ x IN (a,b,c)
-- x <> 	ANY (a,b,c) ~ (x <> a) OR (x <> b) OR (x <> c)
-- x >=| >  ANY (a,b,c) ~ x >= | > MIN (a,b,c)
-- x <= | < ANY (a,b,c) ~ x <= | < MAX (a,b,c)

-- eg: =ANY
SELECT count(*) FROM
(
	SELECT title, category_id
	FROM   film INNER JOIN film_category USING(film_id)
	WHERE  category_id = ANY
		(
			SELECT category_id
			FROM   category
			WHERE  NAME = 'Action' OR NAME = 'Drama'
		)
) AS CTE;

SELECT count(*) FROM
(
	SELECT f.title, fc.category_id
	FROM   film f, film_category fc
	WHERE  f.film_id = fc.film_id
	  AND  fc.category_id IN
		(
			SELECT category_id
			FROM   category
			WHERE  NAME = 'Action' OR NAME = 'Drama'
		)
) AS CTE;


-- ALL:
-- x =     ALL (a,b,c)  ~ x IN (a,b,c)							 
-- x <>    ALL (a,b,c)  ~ x NOT IN (a, b, c) ~ (x <> a) AND (x <> b) AND (x <> c) 
-- x >=| > ALL (a,b,c)  ~ x >= | > MAX (a,b,c)
-- x <= | < ALL (a,b,c) ~ x <= | < MIN (a,b,c)

-- CTE RECURSIVE QUERY
-- https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-recursive-query/
/*
WITH RECURSIVE cte_name AS(
    CTE_query_definition -- non-recursive term
    UNION [ALL]
    CTE_query definion   -- recursive term
) 
SELECT * FROM cte_name;
*/

/*
Execute the non-recursive term to create the base result set (R0).
Execute recursive term with Ri as an input to return the result set Ri+1 as the output.
Repeat step 2 until an empty set is returned. (termination check)
Return the final result set that is a UNION or UNION ALL of the result set R0, R1, … Rn
*/

-- eg:
\c Test

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
	employee_id serial PRIMARY KEY,
	full_name VARCHAR NOT NULL,
	manager_id INT
);

INSERT INTO employees (employee_id, full_name, manager_id)
VALUES
	(1, 'Michael North', NULL),
	(2, 'Megan Berry', 1),
	(3, 'Sarah Berry', 1),
	(4, 'Zoe Black', 1),
	(5, 'Tim James', 1),
	(6, 'Bella Tucker', 2),
	(7, 'Ryan Metcalfe', 2),
	(8, 'Max Mills', 2),
	(9, 'Benjamin Glover', 2),
	(10, 'Carolyn Henderson', 3),
	(11, 'Nicola Kelly', 3),
	(12, 'Alexandra Climo', 3),
	(13, 'Dominic King', 3),
	(14, 'Leonard Gray', 4),
	(15, 'Eric Rampling', 4),
	(16, 'Piers Paige', 7),
	(17, 'Ryan Henderson', 7),
	(18, 'Frank Tucker', 8),
	(19, 'Nathan Ferguson', 8),
	(20, 'Kevin Rampling', 8);

WITH RECURSIVE SUBORDINATES AS (
	-- non-recursive term
	SELECT employee_id, manager_id, full_name
	FROM   employees
	WHERE  employee_id = 2
	
	UNION
	
	-- recursive term
	SELECT e.employee_id, e.manager_id, e.full_name
	FROM   employees e, SUBORDINATES s 
    WHERE  s.employee_id = e.manager_id
) 

SELECT * FROM SUBORDINATES;
