-- Drop the existing table if it exists
DROP TABLE EXT_VAERS_VAX;

-- Validate Object Storage access and generate table list
SELECT *  
FROM DBMS_CLOUD.LIST_OBJECTS(
    'OBJECT_STORAGE', 
    'https://id7flmkqdjfm.objectstorage.us-ashburn-1.oci.customer-oci.com/n/id7flmkqdjfm/b/AllVAERSDataCSVS/o/'
)
WHERE OBJECT_NAME LIKE '%VAERSVAX.csv';

BEGIN
    DBMS_CLOUD.CREATE_EXTERNAL_TABLE(
        table_name      => 'EXT_VAERS_VAX',
        credential_name => 'OBJECT_STORAGE',
        file_uri_list   => '
            https://id7flmkqdjfm.objectstorage.us-ashburn-1.oci.customer-oci.com/n/id7flmkqdjfm/b/AllVAERSDataCSVS/o/*VAERSVAX.csv
        ',
        column_list => '
            VAERS_ID NUMBER(7),
            VAX_TYPE VARCHAR2(15),
            VAX_MANU VARCHAR2(40),
            VAX_LOT VARCHAR2(15),
            VAX_DOSE_SERIES CHAR(3),
            VAX_ROUTE VARCHAR2(6),
            VAX_SITE VARCHAR2(6),
            VAX_NAME VARCHAR2(100)
        ',
        format => JSON_OBJECT(
            'type' value 'CSV',
            'skipHeaders' value '1',
            'delimiter' value ',',
            'dateformat' value 'mm/dd/yyyy',
            'ignoremissingcolumns' value 'true',
            'rejectlimit' value 'unlimited'
        )
    );
END;
/

-- Validate Data Load
-- SELECT VALIDATE$<#>_LOG for Errors - scroll to the bottom of the table
-- SELECT VALIDATE$<#>_BAD for rejected rows
BEGIN
    DBMS_CLOUD.VALIDATE_EXTERNAL_TABLE(
        table_name    => 'EXT_VAERS_VAX',
        stop_on_error => FALSE
    );
END;
/

-- View validation results
-- SELECT table_name, owner_name, type, status, start_time, update_time, logfile_table, badfile_table
-- FROM user_load_operations
-- WHERE type = 'VALIDATE';

-- Verify the data load
SELECT COUNT(*) "ROWS IN EXT_VAERS_VAX"
FROM EXT_VAERS_VAX;
