--------------------------------------------------
-- Section01-Managing-DB.sql
--------------------------------------------------
-- list all db
\l

--------------------------------------------------
-- 01. CREATE DB
--------------------------------------------------
/*
CREATE DATABASE database_name
WITH
   [OWNER =  role_name] -- Assign owned by which user
   [TEMPLATE = template]
   [ENCODING = encoding]
   [LC_COLLATE = collate] -- impact SORTING (ORDER BY)
   [LC_CTYPE = ctype]
   [TABLESPACE = tablespace_name]
   [ALLOW_CONNECTIONS = true | false]
   [CONNECTION LIMIT = max_concurrent_connection]
   [IS_TEMPLATE = true | false ]
*/

-- Default Params
CREATE DATABASE sales;

-- Some Params
CREATE DATABASE hr 
WITH 
   ENCODING = 'UTF8'
   OWNER = hr
   CONNECTION LIMIT = 100;
--------------------------------------------------
-- 02. ALTER DB
--------------------------------------------------
-- 2a. Changing DB attributes
-- ALTER DATABASE name [WITH] option;
/*
option are:
	IS_TEMPLATE
	CONNECTION LIMIT
	ALLOW_CONNECTIONS
*/

--2b. Rename DB
-- ALTER DATABASE database_name RENAME TO new_name;

-- 2c. Change DB Owner
/*
ALTER DATABASE database_name
OWNER TO new_owner | current_user | session_user;
*/

-- 2d. Change DB default tablespace 
/*
ALTER DATABASE database_name
SET TABLESPACE new_tablespace;
*/

-- 2e. Change session defaults for run-time configuration variables
/*
ALTER DATABASE database_name
SET configuration_parameter = value;
*/

--------------------------------------------------
-- 03. DROP DB
-- superuser or CreateDB privilege
--------------------------------------------------
-- 3 steps:
-- Step 1: Check active connection
/*
SELECT pid, usename, client_addr
FROM pg_stat_activity
WHERE datname = '<database_name>';
*/

-- Step 2: Kill active process
/*
SELECT	pg_terminate_backend (pg_stat_activity.pid)
FROM	pg_stat_activity
WHERE	pg_stat_activity.datname = '<database_name>';
*/

-- Step 3: Drop DB
-- DROP DATABASE <database_name>;

--------------------------------------------------
-- 04. COPY DB: pg_dump --help
--------------------------------------------------
-- Option 1:
/*
CREATE DATABASE targetdb 
WITH TEMPLATE sourcedb;
*/

-- Option 2:
-- 03 steps like drop DB
-- THEN
-- pg_dump -U postgres -d sourcedb -f sourcedb.sql
-- CREATE DATABASE targetdb;
-- psql -U postgres -d targetdb -f sourcedb.sql

-- Other option (directly)
-- pg_dump -C -h local -U localuser sourcedb | psql -h remote -U remoteuser targetdb
-- -C ~ CREATE

--------------------------------------------------
-- 05. Get DB object size
--------------------------------------------------
SELECT pg_relation_size('actor');
SELECT pg_size_pretty (pg_relation_size('actor'));

SELECT	 relname AS "relation", 
		 pg_size_pretty (pg_total_relation_size (C.oid)) AS "total_size"
FROM	 pg_class C LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace)
WHERE	 nspname NOT IN ('pg_catalog', 'information_schema')
  AND	 C.relkind <> 'i'
  AND	 nspname !~ '^pg_toast'
ORDER BY pg_total_relation_size (C.oid) DESC
LIMIT 5;

SELECT pg_size_pretty (pg_database_size ('dvdrental'));

SELECT pg_size_pretty (pg_indexes_size('actor'));

\db
SELECT pg_size_pretty (pg_tablespace_size ('pg_default'));

select pg_column_size(5::smallint);
select pg_column_size(5::int);
select pg_column_size(5::bigint);

