-- Drop the existing table if it exists
DROP TABLE EXT_VSAFE_VACCINATION;

-- Validate Object Storage access and generate table list
SELECT *  
FROM DBMS_CLOUD.LIST_OBJECTS(
    'OBJECT_STORAGE',
    'https://id7flmkqdjfm.objectstorage.us-ashburn-1.oci.customer-oci.com/n/id7flmkqdjfm/b/AllVAERSDataCSVS/o/'
)
WHERE LOWER(OBJECT_NAME) LIKE 'consolidated%.csv';

BEGIN
    DBMS_CLOUD.CREATE_EXTERNAL_TABLE(
        table_name      => 'EXT_VSAFE_VACCINATION',
        credential_name => 'OBJECT_STORAGE',
        file_uri_list   => '
            https://id7flmkqdjfm.objectstorage.us-ashburn-1.oci.customer-oci.com/n/id7flmkqdjfm/b/AllVAERSDataCSVS/o/consolidated_vaccinations.csv
        ',
        column_list     => '
            REGISTRANT_CODE         VARCHAR2(15),
            MANUFACTURER            VARCHAR2(25),
            DOSE_NUMBER             NUMBER(3),
            VACCINATION_DATE        DATE,
            COADMINISTERED          VARCHAR2(3),
            COADMINISTERED_VAX      VARCHAR2(125),
            DATE_RECORDED           DATE,
            UPDATED_DATE            DATE,
            AGE_AT_VAX_YRS          VARCHAR2(7)
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
        table_name    => 'EXT_VSAFE_VACCINATION',
        stop_on_error => FALSE
    );
END;
/

/*
-- View validation results
SELECT table_name, owner_name, type, status, start_time, update_time, logfile_table, badfile_table
FROM user_load_operations
WHERE type = 'VALIDATE';
*/

-- Verify the data load
SELECT COUNT(*) "ROWS IN EXT_VSAFE_VACCINATION"
FROM EXT_VSAFE_VACCINATION;
