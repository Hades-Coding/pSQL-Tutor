/* Section 16 - PostgreSQL Utilities.sql */
-- Section 16 - PostgreSQL Utilities.sql

-- 1. Connect from command line
psql.exe -h %server% -U %username% -W %pwd% -d %database% -p %port%

/*
Connection options:
  -h, --host=HOSTNAME      database server host or socket directory (default: "local socket")
  -p, --port=PORT          database server port (default: "5432")
  -U, --username=USERNAME  database user name (default: "o862757879")
  -w, --no-password        never prompt for password
  -W, --password           force password prompt (should happen automatically)
*/

-- 2. DB info:
SELECT current_database();

\conninfo
/*
You are connected to database "Test" as user "postgres" on host "localhost" (address "::1") at port "5432".
*/

-- \c DBname [username] -- Switch DB

--3. Security
\du -- List users and their roles
\dn -- List available schema

--4. Objects
\dt -- List all tables

-- \d table_name
--\d+ table_name
-- => Describe a table

\dv -- List all views
\dD -- List domain

\dT -- List types
\dT+ -- List types

\df -- List available functions

-- 5. Some usefull info:
SELECT version();

\h SET

SHOW ALL;

SHOW TIMEZONE;
SELECT CURRENT_TIMESTAMP;
SELECT TIMEOFDAY();
SET timezone = 'America/New_York';
SET timezone = 'America/Los_Angeles';
SET timezone = 'Asia/Bangkok';

\! cls  -- Clear pSQL screen
\q 
exit
quit

