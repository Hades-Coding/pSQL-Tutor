-- Download DVD Rental Sample Database
-- https://www.postgresqltutorial.com/
-- https://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip
-- The database file is in zipformat ( dvdrental.zip) so you need to extract it to dvdrental.tar

-- 0. System | User variables & PATH
-- System | User variables: PSQL_Home => C:\Program Files\PostgreSQL\15\bin (eg)
-- PATH: Add %PSQL_Home%\bin

-- Change working dir to %PSQL_Home%\bin from command line
-- cd %PSQL_Home%\bin

-- 1. Connect pSQL first
-- psql.exe -h %server% -U %username% -W %pwd% -d %database% -p %port%
psql -U postgres

CREATE DATABASE dvdrental;
EXIT;

-- 2. Restore DB from command line, not pSQL:
pg_restore -U postgres -d dvdrental [PATH]\dvdrental.tar

-- 3. Connect pSQL from commndline, then  check
psql -U postgres

-- list all DB
\l

-- change to dvdrental DB
\c dvdrental

-- List all tables
\dt

-- List users and their roles
\du

\h set -- Setup parameter
SHOW ALL; -- SHOW all parameter

SHOW DateStyle;
SHOW TIMEZONE;
SET timezone = 'Asia/Bangkok';


-- ...........
-- details see section 16 in x-mind file
