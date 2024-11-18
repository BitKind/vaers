-- Optional Create User
-- Tables are created without Schema Refrence
-- This script creates the VAERS user and grants appropriate rights
-- Tables can be created under this Schema

DROP USER VAERS CASCADE;

-- Create the user VAERS
CREATE USER VAERS
DEFAULT TABLESPACE DATA
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON DATA;

-- Grant privileges to the VAERS user
GRANT CREATE SESSION TO VAERS; -- Allow the user to connect to the database
GRANT CREATE TABLE TO VAERS; -- Allow the user to create tables
GRANT CREATE VIEW TO VAERS; -- Allow the user to create views
GRANT CREATE PROCEDURE TO VAERS; -- Allow the user to create stored procedures
GRANT CREATE SEQUENCE TO VAERS; -- Allow the user to create sequences
GRANT CREATE TRIGGER TO VAERS; -- Allow the user to create triggers
GRANT CREATE SYNONYM TO VAERS; -- Allow the user to create synonyms
GRANT CREATE TYPE TO VAERS; -- Allow the user to create types
GRANT CREATE INDEXTYPE TO VAERS; -- Allow the user to create index types

-- Grant unlimited quota on DATA tablespace
ALTER USER VAERS QUOTA UNLIMITED ON DATA;

-- Optional: Grant additional object privileges
GRANT CREATE ANY TABLE TO VAERS; -- Allow the user to create tables in any schema
GRANT CREATE ANY VIEW TO VAERS; -- Allow the user to create views in any schema
GRANT EXECUTE ANY PROCEDURE TO VAERS; -- Allow the user to execute procedures in any schema
GRANT SELECT ANY TABLE TO VAERS; -- Allow the user to query tables in any schema
GRANT INSERT ANY TABLE TO VAERS; -- Allow the user to insert into tables in any schema
GRANT UPDATE ANY TABLE TO VAERS; -- Allow the user to update tables in any schema
GRANT DELETE ANY TABLE TO VAERS; -- Allow the user to delete from tables in any schema

-- Optional - grants dbms_cloud functions including create credential 
-- External tables requires access to credentials
GRANT EXECUTE ON DBMS_CLOUD TO VAERS;


-- Dictionary Grants for Debugging
GRANT SELECT ANY DICTIONARY TO VAERS;
GRANT SELECT_CATALOG_ROLE TO VAERS;

GRANT DWROLE to VAERS;

GRANT READ,WRITE ON directory DATA_PUMP_DIR to VAERS;

alter user vaers identified by "DataFreedom2024";
