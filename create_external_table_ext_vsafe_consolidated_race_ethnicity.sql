-- Drop the existing table if it exists
DROP TABLE EXT_VSAFE_RACE_ETHNICITY;

-- Validate Object Storage access and generate table list
SELECT *  
FROM DBMS_CLOUD.LIST_OBJECTS(
    'OBJECT_STORAGE',
    'https://id7flmkqdjfm.objectstorage.us-ashburn-1.oci.customer-oci.com/n/id7flmkqdjfm/b/AllVAERSDataCSVS/o/'
)
WHERE LOWER(OBJECT_NAME) LIKE 'consolidated%.csv';

BEGIN
    DBMS_CLOUD.CREATE_EXTERNAL_TABLE(
        table_name      => 'EXT_VSAFE_RACE_ETHNICITY',
        credential_name => 'OBJECT_STORAGE',
        file_uri_list   => '
            https://id7flmkqdjfm.objectstorage.us-ashburn-1.oci.customer-oci.com/n/id7flmkqdjfm/b/AllVAERSDataCSVS/o/consolidated_race_ethnicity.csv
        ',
        column_list     => '
            REGISTRANT_CODE     VARCHAR2(15),
            RACE                VARCHAR2(130),
            ETHNICITY           VARCHAR2(30)
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
        table_name    => 'EXT_VSAFE_RACE_ETHNICITY',
        stop_on_error => FALSE
    );
END;
/

-- Verify the data load
SELECT COUNT(*) "ROWS IN EXT_VSAFE_RACE_ETHNICITY"
FROM EXT_VSAFE_RACE_ETHNICITY;
