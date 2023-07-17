--------------------------------------------------
-- Section03-TBS.sql
-- https://www.postgresqltutorial.com/postgresql-schema/
--------------------------------------------------

--------------------------------------------------
-- Section 3. Managing Tablespace
-- Notes: TBS doesn't belong to 1 DB, it can belonged to many DB.
--------------------------------------------------
\c dvdrental

-- 3.1 CREATE TABLESPACE 
-- name prefixed pg_, reserved for the system tablespaces.

/*
CREATE TABLESPACE tablespace_name
[OWNER user_name] -- default CURRENT_USER
LOCATION directory_path;
*/

-- Folder must EXISTS!
CREATE TABLESPACE ts_primary 
LOCATION 'D:\DB\PostGreSQL\Logistics';
-- create one folder empty inside named PG_15_202209061

-- create one folder inside PG_15_202209061, named 16722 
-- with 298 files firsts :D
CREATE DATABASE logistics 
TABLESPACE ts_primary;

-- 3.2 ALTER TABLESPACE
/*
ALTER TABLESPACE tablespace_name action;
action: 
	Rename the tablespace: ALTER TABLESPACE tablespace_name RENAME TO new_name;
	Change the owner: ALTER TABLESPACE tablespace_name OWNER TO new_owner;
	Sett the parameters for the tablespace:
		ALTER TABLESPACE tablespace_name SET parameter_name = value;
*/

-- 3.3 DROP TABLESPACE
-- DROP TABLESPACE [IF EXISTS] tablespace_name;
/*
 If TBS has data:
	SELECT	ts.spcname, cl.relname
	FROM	pg_class cl JOIN pg_tablespace ts ON cl.reltablespace = ts.oid
	WHERE	ts.spcname = 'demo';
	
	ALTER DATABASE dbdemo
	SET TABLESPACE = pg_default;
	
	DROP TABLESPACE demo;
*/
drop tablespace ts_primary; -- tablespace "ts_primary" is not empty
drop database logistics; -- drop foleder 16722 with all file inside
-- now can drop TBS
drop tablespace ts_primary;
