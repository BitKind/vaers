-- Drop the existing table if it exists
DROP TABLE EXT_VSAFE_HEALTH_CHECKIN_SURVEYS;

-- Validate Object Storage access and generate table list
SELECT *  
FROM DBMS_CLOUD.LIST_OBJECTS(
    'OBJECT_STORAGE',
    'https://id7flmkqdjfm.objectstorage.us-ashburn-1.oci.customer-oci.com/n/id7flmkqdjfm/b/AllVAERSDataCSVS/o/'
)
WHERE LOWER(OBJECT_NAME) LIKE 'consolidated%.csv';

BEGIN
    DBMS_CLOUD.CREATE_EXTERNAL_TABLE(
        table_name      => 'EXT_VSAFE_HEALTH_CHECKIN_SURVEYS',
        credential_name => 'OBJECT_STORAGE',
        file_uri_list   => '
            https://id7flmkqdjfm.objectstorage.us-ashburn-1.oci.customer-oci.com/n/id7flmkqdjfm/b/AllVAERSDataCSVS/o/consolidated_health_checkin.csv
        ',
        column_list     => '
            SURVEY_STATIC_ID                VARCHAR2(30),
            REGISTRANT_CODE                 VARCHAR2(15),
            RESPONSE_ID                     VARCHAR2(40),
            STARTED_ON                      DATE,
            STARTED_ON_TIME                 VARCHAR2(11),
            DAYS_SINCE                      NUMBER(3),
            ABDOMINAL_PAIN                  VARCHAR2(8),
            CHILLS                          VARCHAR2(8),
            DIARRHEA                        VARCHAR2(8),
            FATIGUE                         VARCHAR2(8),
            FEELING_TODAY                   VARCHAR2(4),
            FEVER                           VARCHAR2(3),
            HAD_SYMPTOMS                    VARCHAR2(3),
            HEADACHE                        VARCHAR2(8),
            HEALTH_IMPACT                   VARCHAR2(250),
            HEALTH_NOW                      VARCHAR2(9),
            HEALTH_NOW_COMPARISON           VARCHAR2(15),
            VACCINE_CAUSED_HEALTH_ISSUES    VARCHAR2(3),
            HEALTHCARE_VISITS               VARCHAR2(250),
            ITCHING                         VARCHAR2(8),
            JOINT_PAINS                     VARCHAR2(8),
            MUSCLE_OR_BODY_ACHES            VARCHAR2(8),
            NAUSEA                          VARCHAR2(8),
            PAIN                            VARCHAR2(8),
            PREGNANT                        VARCHAR2(12),
            PREGNANCY_TEST                  VARCHAR2(3),
            RASH_OUTSIDE_INJECTION_SITE     VARCHAR2(8),
            REDNESS                         VARCHAR2(8),
            SITE_REACTION                   VARCHAR2(250),
            SWELLING                        VARCHAR2(8),
            SYSTEMIC_REACTION               VARCHAR2(250),
            TEMPERATURE_CELSIUS             NUMBER(5, 1),
            TEMPERATURE_FAHRENHEIT          NUMBER(5, 1),
            TEMPERATURE_READING             VARCHAR2(50),
            TESTED_POSITIVE                 VARCHAR2(3),
            TESTED_POSITIVE_DATE            DATE,
            VOMITING                        VARCHAR2(8),
            DURATION_MINS                   NUMBER(5, 2),
            PREFERRED_LANGUAGE              VARCHAR2(15)
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
        table_name    => 'EXT_VSAFE_HEALTH_CHECKIN_SURVEYS',
        stop_on_error => FALSE
    );
END;
/

-- View validation results
-- SELECT table_name, owner_name, type, status, start_time, update_time, logfile_table, badfile_table
-- FROM user_load_operations
-- WHERE type = 'VALIDATE';

-- Verify the data load
SELECT COUNT(*) "ROWS IN EXT_VSAFE_HEALTH_CHECKIN_SURVEYS"
FROM EXT_VSAFE_HEALTH_CHECKIN_SURVEYS;
