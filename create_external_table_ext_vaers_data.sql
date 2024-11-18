-- Drop the existing table if it exists
DROP TABLE EXT_VAERS_DATA;

-- Validate Object Storage access and generate table list
SELECT *  
FROM DBMS_CLOUD.LIST_OBJECTS(
    'OBJECT_STORAGE',
    'https://id7flmkqdjfm.objectstorage.us-ashburn-1.oci.customer-oci.com/n/id7flmkqdjfm/b/AllVAERSDataCSVS/o/'
)
WHERE OBJECT_NAME LIKE '%VAERSDATA.csv';

BEGIN
    DBMS_CLOUD.CREATE_EXTERNAL_TABLE(
        table_name      => 'EXT_VAERS_DATA',
        credential_name => 'OBJECT_STORAGE',
        file_uri_list   => 'https://id7flmkqdjfm.objectstorage.us-ashburn-1.oci.customer-oci.com/n/id7flmkqdjfm/b/AllVAERSDataCSVS/o/*VAERSDATA.csv',
        column_list     => '
            VAERS_ID NUMBER(7),
            RECVDATE DATE,
            STATE CHAR(2),
            AGE_YRS NUMBER(4, 1),
            CAGE_YR NUMBER(3),
            CAGE_MO NUMBER(3, 1),
            SEX CHAR(1),
            RPT_DATE DATE,
            SYMPTOM_TEXT VARCHAR2(32767),
            DIED CHAR(1),
            DATEDIED DATE,
            L_THREAT CHAR(1),
            ER_VISIT CHAR(1),
            HOSPITAL CHAR(1),
            HOSPDAYS NUMBER(3),
            X_STAY CHAR(1),
            DISABLE CHAR(1),
            RECOVD CHAR(1),
            VAX_DATE DATE,
            ONSET_DATE DATE,
            NUMDAYS NUMBER(5),
            LAB_DATA VARCHAR2(32767),
            V_ADMINBY CHAR(3),
            V_FUNDBY CHAR(3),
            OTHER_MEDS VARCHAR2(240),
            CUR_ILL VARCHAR2(32767),
            HISTORY VARCHAR2(32767),
            PRIOR_VAX VARCHAR2(128),
            SPLTTYPE VARCHAR2(25),
            FORM_VERS NUMBER(1),
            TODAYS_DATE DATE,
            BIRTH_DEFECT CHAR(1),
            OFC_VISIT CHAR(1),
            ER_ED_VISIT CHAR(1),
            ALLERGIES VARCHAR2(32767)
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
        table_name => 'EXT_VAERS_DATA',
        stop_on_error => FALSE
    );
END;
/

-- Check the validation status
-- SELECT table_name, owner_name, type, status, start_time, update_time, logfile_table, badfile_table
-- FROM user_load_operations
-- WHERE type = 'VALIDATE';

-- Verify data load
SELECT COUNT(*) "ROWS IN EXT_VAERS_DATA"
FROM EXT_VAERS_DATA;
