-- Drop the existing table if it exists
DROP TABLE EXT_VAERS_SYMPTOMS;

-- Validate Object Storage access and generate table list
SELECT *  
FROM DBMS_CLOUD.LIST_OBJECTS(
    'OBJECT_STORAGE', 
    'https://id7flmkqdjfm.objectstorage.us-ashburn-1.oci.customer-oci.com/n/id7flmkqdjfm/b/AllVAERSDataCSVS/o/'
)
WHERE OBJECT_NAME LIKE '%VAERSSYMPTOMS.csv';

BEGIN
    DBMS_CLOUD.CREATE_EXTERNAL_TABLE(
        table_name      => 'EXT_VAERS_SYMPTOMS',
        credential_name => 'OBJECT_STORAGE',
        file_uri_list   => '
            https://id7flmkqdjfm.objectstorage.us-ashburn-1.oci.customer-oci.com/n/id7flmkqdjfm/b/AllVAERSDataCSVS/o/*VAERSSYMPTOMS.csv
        ',
        column_list => '
            VAERS_ID NUMBER(7),
            SYMPTOM1 VARCHAR2(100),
            SYMPTOMVERSION1 NUMBER(5, 2),
            SYMPTOM2 VARCHAR2(100),
            SYMPTOMVERSION2 NUMBER(5, 2),
            SYMPTOM3 VARCHAR2(100),
            SYMPTOMVERSION3 NUMBER(5, 2),
            SYMPTOM4 VARCHAR2(100),
            SYMPTOMVERSION4 NUMBER(5, 2),
            SYMPTOM5 VARCHAR2(100),
            SYMPTOMVERSION5 NUMBER(5, 2)
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
        table_name    => 'EXT_VAERS_SYMPTOMS',
        stop_on_error => FALSE
    );
END;
/

-- Verify the data load
SELECT COUNT(*) "ROWS IN EXT_VAERS_SYMPTOMS"
FROM EXT_VAERS_SYMPTOMS;
