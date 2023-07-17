/* PostgreSQL Tutorial */
-- PostgreSQL Tutorial
-- Section 14 - Data Types.sql
-- https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-boolean/

/*
	Boolean – store TRUE and FALSE values with the Boolean data type.
	CHAR, VARCHAR and TEXT – learn how to use various character types including CHAR, VARCHAR, and TEXT.
	NUMERIC – show you how to use NUMERIC type to store values that precision is required.
	Integer – introduce you to various integer types in PostgreSQL including SMALLINT, INT and BIGINT.
	DATE  – introduce the DATE data type for storing date values.
	Timestamp – understand timestamp data types quickly.
	Interval – show you how to use interval data type to handle a period of time effectively.
	TIME – use the TIME datatype to manage the time of day values.
	UUID – guide you on how to use UUID datatype and how to generate UUID values using supplied modules.
	Array – show you how to work with the array and introduces you to some handy functions for array manipulation.
	hstore – introduce you to data type which is a set of key/value pairs stored in a single value in PostgreSQL.
	JSON – illustrate how to work with JSON data type and shows you how to use some of the most important JSON operators and functions.
	User-defined data types – show you how to use the CREATE DOMAIN and CREATE TYPE statements to create user-defined data types.
*/

-- 1. DATE Data Types
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
	employee_id serial PRIMARY KEY,
	first_name VARCHAR (255),
	last_name VARCHAR (355),
	birth_date DATE NOT NULL,
	hire_date DATE NOT NULL
);

INSERT INTO employees (first_name, last_name, birth_date, hire_date)
VALUES ('Shannon','Freeman','1980-01-01','2005-01-01'),
	   ('Sheila','Wells','1978-02-05','2003-01-01'),
	   ('Ethel','Webb','1975-01-01','2001-01-01');

SELECT NOW()::date;

SELECT CURRENT_DATE;

SELECT TO_CHAR(NOW() :: DATE, 'dd/mm/yyyy');
SELECT TO_CHAR(NOW() :: DATE, 'Mon dd, yyyy');

SELECT	first_name, last_name, hire_date,
		now() - hire_date as diff, -- 6758 days 15:58:48.226337
        age (now(), hire_date) differ -- 18 years 6 mons 3 days 15:58:48.226337
FROM    employees;

SELECT	employee_id, first_name, last_name,
		EXTRACT (YEAR FROM birth_date) AS YEAR,
		EXTRACT (MONTH FROM birth_date) AS MONTH,
		EXTRACT (DAY FROM birth_date) AS DAY
FROM	employees;


-- 2. Timestamp Data Types
SHOW TIMEZONE;
SET timezone = 'America/New_York';
SET timezone = 'America/Los_Angeles';
SET timezone = 'Asia/Bangkok';

SELECT CURRENT_TIMESTAMP;
-- @ interval [ fields ] [ (p) ]   

SELECT	now(),
		now() - INTERVAL '1 year 3 hours 20 minutes' AS "3 hours 20 minutes ago of last year";

-- 3. Interval Data Types
SET intervalstyle = 'postgres'; -- DEFAULT
-- Others is: 'postgres_verbose'; 'sql_standard'; 'iso_8601';

SET		intervalstyle = 'postgres';
SELECT	INTERVAL '6 years 5 months 4 days 3 hours 2 minutes 1 second';

SET		intervalstyle = 'postgres_verbose';
SELECT	INTERVAL '6 years 5 months 4 days 3 hours 2 minutes 1 second';

SET		intervalstyle = 'sql_standard';
SELECT	INTERVAL '6 years 5 months 4 days 3 hours 2 minutes 1 second';

SET		intervalstyle = 'iso_8601';
SELECT	INTERVAL '6 years 5 months 4 days 3 hours 2 minutes 1 second';

SELECT INTERVAL '2h 50m' + INTERVAL '10m'; -- 03:00:00
SELECT INTERVAL '2h 50m' - INTERVAL '50m'; -- 02:00:00
SELECT 600 * INTERVAL '1 minute'; -- 10:00:00

SELECT EXTRACT(MINUTE FROM INTERVAL '5 hours 21 minutes');

SELECT	justify_days(INTERVAL '30 days'),    -- 1 month
		justify_hours(INTERVAL '24 hours');  -- 1 day
		
SELECT	justify_interval(interval '1 year -1 hour');

-- 4. TIME Data Type
SELECT
    LOCALTIME,
    EXTRACT (HOUR FROM LOCALTIME) as hour,
    EXTRACT (MINUTE FROM LOCALTIME) as minute, 
    EXTRACT (SECOND FROM LOCALTIME) as second,
    EXTRACT (milliseconds FROM LOCALTIME) as milliseconds; 

-- 5. UUID
/*
eg: 8-4-4-4-12
40e6215d-b5c6-4896-987c-f30f3678f608
6ecd8c99-4036-403d-bf84-cf8400f67836
3f333df6-90a4-4fda-8dd3-9485d27cee36
*/
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Generated based on MAC address, current timestamp, and a random value
SELECT uuid_generate_v1();

-- Generated based on andom value ONLY
SELECT uuid_generate_v4();
