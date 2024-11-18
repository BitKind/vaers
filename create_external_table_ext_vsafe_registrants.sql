-- Drop the existing table if it exists
DROP TABLE EXT_VSAFE_REGISTRANTS;

-- Validate Object Storage access and generate table list
SELECT *  
FROM DBMS_CLOUD.LIST_OBJECTS(
    'OBJECT_STORAGE',
    'https://id7flmkqdjfm.objectstorage.us-ashburn-1.oci.customer-oci.com/n/id7flmkqdjfm/b/AllVAERSDataCSVS/o/'
)
WHERE LOWER(OBJECT_NAME) LIKE 'consolidated%.csv';

BEGIN
    DBMS_CLOUD.CREATE_EXTERNAL_TABLE(
        table_name      => 'EXT_VSAFE_REGISTRANTS',
        credential_name => 'OBJECT_STORAGE',
        file_uri_list   => '
            https://id7flmkqdjfm.objectstorage.us-ashburn-1.oci.customer-oci.com/n/id7flmkqdjfm/b/AllVAERSDataCSVS/o/consolidated_registrants.csv
        ',
        column_list     => '
            REGISTRANT_CODE           VARCHAR2(15),
            ZIP_CODE                  VARCHAR2(3),
            SEX                       VARCHAR2(17),
            REGISTERED_DATE           DATE,
            TIME_ZONE                 VARCHAR2(32),
            RELATIONSHIP              VARCHAR2(30),
            GUARDIAN_REGISTRANT_CODE  VARCHAR2(15)
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
        table_name    => 'EXT_VSAFE_REGISTRANTS',
        stop_on_error => FALSE
    );
END;
/

-- Verify the data load
SELECT COUNT(*) "ROWS IN EXT_VSAFE_REGISTRANTS"
FROM EXT_VSAFE_REGISTRANTS;
