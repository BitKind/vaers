-- Manual Delete Clear Validate Tables
BEGIN
    FOR tbl IN (
SELECT table_name
        FROM user_tables
        WHERE table_name LIKE 'VALIDATE%'
    ) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || tbl.table_name;
        DBMS_OUTPUT.PUT_LINE('Dropped table: ' || tbl.table_name);
    END LOOP;
END;
/


-- Manual Delete External Tables
BEGIN
    FOR tbl IN (
SELECT table_name
        FROM user_tables
        WHERE table_name LIKE 'EXT_%'
    ) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || tbl.table_name;
        DBMS_OUTPUT.PUT_LINE('Dropped table: ' || tbl.table_name);
    END LOOP;
END;
/

/*
-- WARNING: WILL DROP ALL TABLES
-- RESET SCHEMA
BEGIN
    FOR tbl IN (
SELECT table_name
        FROM user_tables
    ) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || tbl.table_name || ' CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Dropped table: ' || tbl.table_name);
    END LOOP;
    EXCEPTION
      WHEN OTHERS THEN
      NULL;
END;
/
*/

-- monitor longops progress APPEND LOGGING etc
SELECT username, sid, serial#, context, sofar, totalwork,(sofar/totalwork) complete
  FROM v$session_longops
 WHERE  username like 'VAERS%' AND sofar < totalwork;
/
