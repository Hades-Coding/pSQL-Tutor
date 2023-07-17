/* PostgreSQL Tutorial */
-- PostgreSQL Tutorial
-- Section 11. IMP+EXP Data + CSV.sql
-- https://www.postgresqltutorial.com/postgresql-tutorial/import-csv-file-into-posgresql-table/

DROP TABLE IF EXISTS persons;
CREATE TABLE persons (
  id SERIAL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  dob DATE,
  email VARCHAR(255),
  PRIMARY KEY (id)
);

-- Replace path by exact directory
-- import from csv to table
COPY persons(first_name, last_name, dob, email)
FROM 'PATH\persons.csv'
DELIMITER ','
CSV HEADER;

-- check again
SELECT * FROM persons;

-- import table data to csv file
-- maybe has errors on window OS
-- ERROR:  could not open file "PATH\persons_db.csv" for writing: Permission denied
COPY persons TO 'PATH\persons_bck.csv' DELIMITER ',' CSV HEADER;

-- then used \COPY instead
\COPY (SELECT * FROM persons) to 'PATH\persons_bck.csv' with csv;

