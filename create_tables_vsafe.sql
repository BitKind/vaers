-- v-safe COVID-19 Data | CDC
-- https://data.cdc.gov/Public-Health-Surveillance/v-safe-COVID-19/dqgu-gg5d

-- The v-safe dataset is provided by the Centers for Disease Control and Prevention (CDC).
-- It compiles health check-in data from individuals who received COVID-19 vaccinations.
-- The dataset is part of the CDC's effort to monitor vaccine safety and effectiveness.

-- Dataset Details:
-- - Website: The v-safe COVID-19 dataset is available on the CDC's data portal.
-- - Data Format: Provided in CSV format, suitable for analysis and integration.
-- - Data Dictionary: Includes a comprehensive data dictionary with variable descriptions.

-- Key Features:
-- - Participant-Reported Data: The dataset contains self-reported health check-ins,
--   offering insights into post-vaccination experiences.
-- - Anonymized Information: Personal identifiers are removed to ensure privacy.
-- - Regular Updates: The CDC updates the dataset periodically with new data.

-- Usage Considerations:
-- - Data Interpretation: The dataset should be analyzed in the context of broader
--   epidemiological studies, considering the limitations of self-reported data.
-- - Research Applications: Useful for studying vaccine safety, identifying potential
--   adverse events, and assessing vaccine effectiveness across populations.

-- Note:
-- Access the dataset and detailed information directly at the CDC's data portal:
-- https://data.cdc.gov/Public-Health-Surveillance/v-safe-COVID-19/dqgu-gg5d


DROP TABLE VSAFE_RACE_ETHNICITY CASCADE CONSTRAINT;
DROP TABLE VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3 CASCADE CONSTRAINT; 
DROP TABLE VSAFE_VACCINATION CASCADE CONSTRAINT;
DROP TABLE VSAFE_HEALTH_CHECKIN_SURVEYS CASCADE CONSTRAINT;
DROP TABLE VSAFE_REGISTRANTS CASCADE CONSTRAINT;


CREATE TABLE VSAFE_REGISTRANTS (
    REGISTRANT_CODE           VARCHAR2(15)    NOT NULL, -- Unique ID (e.g., XXX-XXXXX-XXXXX)
    ZIP_CODE                  VARCHAR2(3),              -- Participant's Zip Code (first 3 digits only)
    SEX                       VARCHAR2(17),             -- Participant's Sex (Female, Male, Not designated)
    REGISTERED_DATE           DATE,                     -- Date Participant Registered (MMDDYY format converted to DATE)
    TIME_ZONE                 VARCHAR2(32),             -- Participant's Time Zone
    RELATIONSHIP              VARCHAR2(30),             -- Relationship (Adult relative, Child, Other)
    GUARDIAN_REGISTRANT_CODE  VARCHAR2(15)              -- Unique Guardian ID (e.g., XXX-XXXXX-XXXXX)
);

COMMENT ON COLUMN VSAFE_REGISTRANTS.REGISTRANT_CODE            IS 'Unique ID (e.g., XXX-XXXXX-XXXXX)';
COMMENT ON COLUMN VSAFE_REGISTRANTS.ZIP_CODE                   IS 'Participant''''s Zip Code (first 3 digits only)';
COMMENT ON COLUMN VSAFE_REGISTRANTS.SEX                        IS 'Participant''''s Sex (Female, Male, Not designated)';
COMMENT ON COLUMN VSAFE_REGISTRANTS.REGISTERED_DATE            IS 'Date Participant Registered (MMDDYY format converted to DATE)';
COMMENT ON COLUMN VSAFE_REGISTRANTS.TIME_ZONE                  IS 'Participant''''s Time Zone';
COMMENT ON COLUMN VSAFE_REGISTRANTS.RELATIONSHIP               IS 'Relationship (Adult relative, Child, Other)';
COMMENT ON COLUMN VSAFE_REGISTRANTS.GUARDIAN_REGISTRANT_CODE   IS 'Unique Guardian ID (e.g., XXX-XXXXX-XXXXX)';


CREATE TABLE VSAFE_VACCINATION (
    REGISTRANT_CODE         VARCHAR2(15)    NOT NULL, -- Unique ID (e.g., XXX-XXXXX-XXXXX)
    MANUFACTURER            VARCHAR2(25),             -- Vaccine Manufacturer (e.g., Janssen, Pfizer, Moderna, etc.)
    DOSE_NUMBER             NUMBER(3),                -- COVID-19 Dose Number (1, 2, 3, 4, 5, 6)
    VACCINATION_DATE        DATE,                     -- Date of Vaccination (MMDDYY converted to DATE)
    COADMINISTERED          VARCHAR2(3),              -- Yes or No (Coadministered Vaccine Information)
    COADMINISTERED_VAX      VARCHAR2(125),            -- List of coadministered vaccines (varies by age group)
    DATE_RECORDED           DATE,                     -- Date the Vaccine Record was added
    UPDATED_DATE            DATE,                     -- Date the Vaccine Record was updated
    AGE_AT_VAX_YRS          VARCHAR2(7)               -- Age group at vaccination (e.g., 0-4, 5-11, 12-15, etc.)
);

COMMENT ON COLUMN VSAFE_VACCINATION.REGISTRANT_CODE         IS 'Unique ID (e.g., XXX-XXXXX-XXXXX)';
COMMENT ON COLUMN VSAFE_VACCINATION.MANUFACTURER            IS 'Vaccine Manufacturer (e.g., Janssen, Pfizer, Moderna, etc.)';
COMMENT ON COLUMN VSAFE_VACCINATION.DOSE_NUMBER             IS 'COVID-19 Dose Number (1, 2, 3, 4, 5, 6)';
COMMENT ON COLUMN VSAFE_VACCINATION.VACCINATION_DATE        IS 'Date of Vaccination (MMDDYY converted to DATE)';
COMMENT ON COLUMN VSAFE_VACCINATION.COADMINISTERED          IS 'Yes or No (Coadministered Vaccine Information)';
COMMENT ON COLUMN VSAFE_VACCINATION.COADMINISTERED_VAX      IS 'List of coadministered vaccines (varies by age group)';
COMMENT ON COLUMN VSAFE_VACCINATION.DATE_RECORDED           IS 'Date the Vaccine Record was added';
COMMENT ON COLUMN VSAFE_VACCINATION.UPDATED_DATE            IS 'Date the Vaccine Record was updated';
COMMENT ON COLUMN VSAFE_VACCINATION.AGE_AT_VAX_YRS          IS 'Age group at vaccination (e.g., 0-4, 5-11, 12-15, etc.)';



CREATE TABLE VSAFE_HEALTH_CHECKIN_SURVEYS (
    SURVEY_STATIC_ID                VARCHAR2(30),        -- Combination of Survey Day and Dose Number
    REGISTRANT_CODE                 VARCHAR2(15) NOT NULL, -- Unique Participant ID (e.g., XXX-XXXXX-XXXXX)
    RESPONSE_ID                     VARCHAR2(40),        -- Unique Participant Survey ID
    STARTED_ON                      DATE,                -- Day the survey was started (MMDDYY format converted to DATE)
    STARTED_ON_TIME                 VARCHAR2(11),        -- Time the survey was started (structured time in TIMEAMPM format)
    DAYS_SINCE                      NUMBER(3),           -- Number of days since vaccination
    ABDOMINAL_PAIN                  VARCHAR2(8),         -- Abdominal pain severity (Mild, Moderate, Severe)
    CHILLS                          VARCHAR2(8),         -- Chills severity (Mild, Moderate, Severe)
    DIARRHEA                        VARCHAR2(8),         -- Diarrhea severity (Mild, Moderate, Severe)
    FATIGUE                         VARCHAR2(8),         -- Fatigue or tiredness severity (Mild, Moderate, Severe)
    FEELING_TODAY                   VARCHAR2(4),         -- Feeling today (Good, Fair, Poor)
    FEVER                           VARCHAR2(3),         -- Fever or felt feverish (Yes, No)
    HAD_SYMPTOMS                    VARCHAR2(3),         -- New symptoms or worsening health conditions (Yes, No)
    HEADACHE                        VARCHAR2(8),         -- Headache severity (Mild, Moderate, Severe)
    HEALTH_IMPACT                   VARCHAR2(250),       -- Symptoms or health conditions impact
    HEALTH_NOW                      VARCHAR2(9),         -- Current state of health (Excellent, Good, Fair, Poor)
    HEALTH_NOW_COMPARISON           VARCHAR2(15),        -- Health compared to before vaccination (Better, About the same, Worse)
    VACCINE_CAUSED_HEALTH_ISSUES    VARCHAR2(3),         -- Belief that health issues are related to vaccination (Yes, No)
    HEALTHCARE_VISITS               VARCHAR2(250),       -- Type of healthcare visits
    ITCHING                         VARCHAR2(8),         -- Itching severity (Mild, Moderate, Severe)
    JOINT_PAINS                     VARCHAR2(8),         -- Joint pain severity (Mild, Moderate, Severe)
    MUSCLE_OR_BODY_ACHES            VARCHAR2(8),         -- Muscle or body aches severity (Mild, Moderate, Severe)
    NAUSEA                          VARCHAR2(8),         -- Nausea severity (Mild, Moderate, Severe)
    PAIN                            VARCHAR2(8),         -- Pain severity (Mild, Moderate, Severe)
    PREGNANT                        VARCHAR2(12),        -- Pregnancy status (Yes, No, I don't know)
    PREGNANCY_TEST                  VARCHAR2(3),         -- Positive pregnancy test (Yes, No)
    RASH_OUTSIDE_INJECTION_SITE     VARCHAR2(8),         -- Rash outside injection site severity (Mild, Moderate, Severe)
    REDNESS                         VARCHAR2(8),         -- Redness severity (Mild, Moderate, Severe)
    SITE_REACTION                   VARCHAR2(250),       -- Symptoms at or near the injection site
    SWELLING                        VARCHAR2(8),         -- Swelling severity (Mild, Moderate, Severe)
    SYSTEMIC_REACTION               VARCHAR2(250),       -- Systemic reaction symptoms
    TEMPERATURE_CELSIUS             NUMBER(5, 1),        -- Highest temperature reading in Celsius
    TEMPERATURE_FAHRENHEIT          NUMBER(5, 1),        -- Highest temperature reading in Fahrenheit
    TEMPERATURE_READING             VARCHAR2(50),        -- Information about temperature reading
    TESTED_POSITIVE                 VARCHAR2(3),         -- Positive COVID-19 test (Yes, No)
    TESTED_POSITIVE_DATE            DATE,                -- Date of positive COVID-19 test
    VOMITING                        VARCHAR2(8),         -- Vomiting severity (Mild, Moderate, Severe)
    DURATION_MINS                   NUMBER(5, 2),        -- Number of minutes to complete the survey
    PREFERRED_LANGUAGE              VARCHAR2(15)         -- Preferred language of the survey
);

COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.SURVEY_STATIC_ID                 IS 'Combination of Survey Day and Dose Number';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.REGISTRANT_CODE                  IS 'Unique Participant ID (e.g., XXX-XXXXX-XXXXX)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.RESPONSE_ID                      IS 'Unique Participant Survey ID';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.STARTED_ON                       IS 'Day the survey was started (MMDDYY format converted to DATE)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.STARTED_ON_TIME                  IS 'Time the survey was started (structured time in TIMEAMPM format)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.DAYS_SINCE                       IS 'Number of days since vaccination';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.ABDOMINAL_PAIN                   IS 'Abdominal pain severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.CHILLS                           IS 'Chills severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.DIARRHEA                         IS 'Diarrhea severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.FATIGUE                          IS 'Fatigue or tiredness severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.FEELING_TODAY                    IS 'Feeling today (Good, Fair, Poor)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.FEVER                            IS 'Fever or felt feverish (Yes, No)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.HAD_SYMPTOMS                     IS 'New symptoms or worsening health conditions (Yes, No)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.HEADACHE                         IS 'Headache severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.HEALTH_IMPACT                    IS 'Symptoms or health conditions impact';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.HEALTH_NOW                       IS 'Current state of health (Excellent, Good, Fair, Poor)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.HEALTH_NOW_COMPARISON            IS 'Health compared to before vaccination (Better, About the same, Worse)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.VACCINE_CAUSED_HEALTH_ISSUES     IS 'Belief that health issues are related to vaccination (Yes, No)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.HEALTHCARE_VISITS                IS 'Type of healthcare visits';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.ITCHING                          IS 'Itching severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.JOINT_PAINS                      IS 'Joint pain severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.MUSCLE_OR_BODY_ACHES             IS 'Muscle or body aches severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.NAUSEA                           IS 'Nausea severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.PAIN                             IS 'Pain severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.PREGNANT                         IS 'Pregnancy status (Yes, No, I don''''t know)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.PREGNANCY_TEST                   IS 'Positive pregnancy test (Yes, No)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.RASH_OUTSIDE_INJECTION_SITE      IS 'Rash outside injection site severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.REDNESS                          IS 'Redness severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.SITE_REACTION                    IS 'Symptoms at or near the injection site';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.SWELLING                         IS 'Swelling severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.SYSTEMIC_REACTION                IS 'Systemic reaction symptoms';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.TEMPERATURE_CELSIUS              IS 'Highest temperature reading in Celsius';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.TEMPERATURE_FAHRENHEIT           IS 'Highest temperature reading in Fahrenheit';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.TEMPERATURE_READING              IS 'Information about temperature reading';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.TESTED_POSITIVE                  IS 'Positive COVID-19 test (Yes, No)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.TESTED_POSITIVE_DATE             IS 'Date of positive COVID-19 test';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.VOMITING                         IS 'Vomiting severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.DURATION_MINS                    IS 'Number of minutes to complete the survey';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS.PREFERRED_LANGUAGE               IS 'Preferred language of the survey';


CREATE TABLE VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3 (
    SURVEY_STATIC_ID                VARCHAR2(30),        -- Combination of Survey Day and Dose Number
    REGISTRANT_CODE                 VARCHAR2(15) NOT NULL, -- Unique Participant ID (e.g., XXX-XXXXX-XXXXX)
    RESPONSE_ID                     VARCHAR2(40),        -- Unique Participant Survey ID
    STARTED_ON                      DATE,                -- Day the survey was started (MMDDYY format converted to DATE)
    STARTED_ON_TIME                 VARCHAR2(11),        -- Time the survey was started (structured time in TIMEAMPM format)
    DAYS_SINCE                      NUMBER(3),           -- Number of days since vaccination
    DIARRHEA                        VARCHAR2(8),         -- Diarrhea severity (Mild, Moderate, Severe)
    GROIN_UNDERARM_SWELLING         VARCHAR2(8),         -- Groin or underarm swelling severity (Mild, Moderate, Severe)
    IRRITABILITY                    VARCHAR2(8),         -- Irritability severity (Mild, Moderate, Severe)
    LOSS_OF_APPETITE                VARCHAR2(8),         -- Loss of appetite severity (Mild, Moderate, Severe)
    SLEEPINESS                      VARCHAR2(8),         -- Sleepiness severity (Mild, Moderate, Severe)
    FEELING_TODAY                   VARCHAR2(4),         -- How are you feeling today? (Good, Fair, Poor)
    FEVER                           VARCHAR2(3),         -- Fever or felt feverish (Yes, No)
    HAD_SYMPTOMS                    VARCHAR2(3),         -- New symptoms or worsening health conditions (Yes, No)
    HEALTH_IMPACT                   VARCHAR2(250),       -- Health impact based on symptoms
    HEALTH_NOW                      VARCHAR2(9),         -- Current state of health (Excellent, Good, Fair, Poor)
    HEALTH_NOW_COMPARISON           VARCHAR2(15),        -- Health compared to before vaccination (Better, About the same, Worse)
    VACCINE_CAUSED_HEALTH_ISSUES    VARCHAR2(3),         -- Belief that health issues are related to vaccination (Yes, No)
    HEALTHCARE_VISITS               VARCHAR2(250),       -- Types of healthcare visits
    PAIN                            VARCHAR2(8),         -- Pain severity (Mild, Moderate, Severe)
    RASH_OUTSIDE_INJECTION_SITE     VARCHAR2(8),         -- Rash outside injection site severity (Mild, Moderate, Severe)
    REDNESS                         VARCHAR2(8),         -- Redness severity (Mild, Moderate, Severe)
    SITE_REACTION                   VARCHAR2(250),       -- Symptoms at or near the injection site
    SWELLING                        VARCHAR2(8),         -- Swelling severity (Mild, Moderate, Severe)
    SYSTEMIC_REACTION               VARCHAR2(250),       -- Systemic reaction symptoms
    TEMPERATURE_CELSIUS             NUMBER(5, 1),        -- Highest temperature reading in Celsius
    TEMPERATURE_FAHRENHEIT          NUMBER(5, 1),        -- Highest temperature reading in Fahrenheit
    TEMPERATURE_READING             VARCHAR2(50),        -- Details about the temperature reading
    TESTED_POSITIVE                 VARCHAR2(3),         -- Positive COVID-19 test (Yes, No)
    TESTED_POSITIVE_DATE            DATE,                -- Date of positive COVID-19 test
    VOMITING                        VARCHAR2(8),         -- Vomiting severity (Mild, Moderate, Severe)
    DURATION_MINS                   NUMBER(5, 2),        -- Duration in minutes to fill out the survey
    PREFERRED_LANGUAGE              VARCHAR2(15)         -- Language of the survey (e.g., English, Spanish)
);

COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.SURVEY_STATIC_ID               IS 'Combination of Survey Day and Dose Number';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.REGISTRANT_CODE                IS 'Unique Participant ID (e.g., XXX-XXXXX-XXXXX)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.RESPONSE_ID                    IS 'Unique Participant Survey ID';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.STARTED_ON                     IS 'Day the survey was started (MMDDYY format converted to DATE)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.STARTED_ON_TIME                IS 'Time the survey was started (structured time in TIMEAMPM format)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.DAYS_SINCE                     IS 'Number of days since vaccination';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.DIARRHEA                       IS 'Diarrhea severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.GROIN_UNDERARM_SWELLING        IS 'Groin or underarm swelling severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.IRRITABILITY                   IS 'Irritability severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.LOSS_OF_APPETITE               IS 'Loss of appetite severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.SLEEPINESS                     IS 'Sleepiness severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.FEELING_TODAY                  IS 'How are you feeling today? (Good, Fair, Poor)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.FEVER                          IS 'Fever or felt feverish (Yes, No)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.HAD_SYMPTOMS                   IS 'New symptoms or worsening health conditions (Yes, No)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.HEALTH_IMPACT                  IS 'Health impact based on symptoms';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.HEALTH_NOW                     IS 'Current state of health (Excellent, Good, Fair, Poor)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.HEALTH_NOW_COMPARISON          IS 'Health compared to before vaccination (Better, About the same, Worse)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.VACCINE_CAUSED_HEALTH_ISSUES   IS 'Belief that health issues are related to vaccination (Yes, No)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.HEALTHCARE_VISITS              IS 'Types of healthcare visits';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.PAIN                           IS 'Pain severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.RASH_OUTSIDE_INJECTION_SITE    IS 'Rash outside injection site severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.REDNESS                        IS 'Redness severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.SITE_REACTION                  IS 'Symptoms at or near the injection site';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.SWELLING                       IS 'Swelling severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.SYSTEMIC_REACTION              IS 'Systemic reaction symptoms';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.TEMPERATURE_CELSIUS            IS 'Highest temperature reading in Celsius';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.TEMPERATURE_FAHRENHEIT         IS 'Highest temperature reading in Fahrenheit';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.TEMPERATURE_READING            IS 'Details about the temperature reading';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.TESTED_POSITIVE                IS 'Positive COVID-19 test (Yes, No)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.TESTED_POSITIVE_DATE           IS 'Date of positive COVID-19 test';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.VOMITING                       IS 'Vomiting severity (Mild, Moderate, Severe)';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.DURATION_MINS                  IS 'Duration in minutes to fill out the survey';
COMMENT ON COLUMN VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3.PREFERRED_LANGUAGE             IS 'Language of the survey (e.g., English, Spanish)'; 


CREATE TABLE VSAFE_RACE_ETHNICITY (
    REGISTRANT_CODE     VARCHAR2(15) NOT NULL, -- Unique ID (e.g., XXX-XXXXX-XXXXX)
    RACE                VARCHAR2(130),         -- Race of Participant (e.g., Multiracial, White, etc.)
    ETHNICITY           VARCHAR2(30)           -- Ethnicity of Participant (e.g., Hispanic, Not Hispanic, or N/A)
);

COMMENT ON COLUMN VSAFE_RACE_ETHNICITY.REGISTRANT_CODE    IS 'Unique ID (e.g., XXX-XXXXX-XXXXX)sh)';
COMMENT ON COLUMN VSAFE_RACE_ETHNICITY.RACE               IS 'Race of Participant (e.g., Multiracial, White, etc.)sh)';
COMMENT ON COLUMN VSAFE_RACE_ETHNICITY.ETHNICITY          IS 'Ethnicity of Participant (e.g., Hispanic, Not Hispanic, or N/A)sh)';


---- LOADING DATA ----

-- LOAD REGISTRANTS
ALTER TABLE VSAFE_REGISTRANTS NOLOGGING;
INSERT /*+ APPEND */ INTO VSAFE_REGISTRANTS 
    SELECT *
      FROM EXT_VSAFE_REGISTRANTS;

-- LOAD SURVEYS
ALTER TABLE VSAFE_HEALTH_CHECKIN_SURVEYS NOLOGGING;
INSERT /*+ APPEND */ INTO VSAFE_HEALTH_CHECKIN_SURVEYS 
    SELECT * 
      FROM EXT_VSAFE_HEALTH_CHECKIN_SURVEYS;

-- LOAD UNDER 3 SURVEYS
ALTER TABLE VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3 NOLOGGING;
INSERT /*+ APPEND */ INTO VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3 
     SELECT * 
       FROM EXT_VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3;

-- LOAD VACCINATIONS
ALTER TABLE VSAFE_VACCINATION NOLOGGING;
INSERT /*+ APPEND */ INTO VSAFE_VACCINATION
     SELECT * 
       FROM EXT_VSAFE_VACCINATION;

-- LOAD RACE_ETHNICITY
ALTER TABLE VSAFE_RACE_ETHNICITY NOLOGGING;
INSERT /*+ APPEND */ INTO VSAFE_RACE_ETHNICITY 
     SELECT * 
       FROM EXT_VSAFE_RACE_ETHNICITY;

/*
-- Logging can remain off - data is static
-- Enabling logging can take a long time once data is loaded
ALTER TABLE VSAFE_REGISTRANTS LOGGING;
ALTER TABLE VSAFE_HEALTH_CHECKIN_SURVEYS LOGGING;
ALTER TABLE VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3 LOGGING;
ALTER TABLE VSAFE_VACCINATION NOLOGGING;
ALTER TABLE VSAFE_RACE_ETHNICITY NOLOGGING;

*/
---- ADDING TABLE CONSTRAINTS ----

--VSAFE_REGISTRANTS 
ALTER TABLE VSAFE_REGISTRANTS 
    ADD CONSTRAINT PK_REGISTRANT_CODE 
    PRIMARY KEY (REGISTRANT_CODE);

-- VSAFE_VACCINATION 
ALTER TABLE VSAFE_VACCINATION 
    ADD CONSTRAINT PK_VACCINATIONS 
    PRIMARY KEY (REGISTRANT_CODE, MANUFACTURER,DOSE_NUMBER, VACCINATION_DATE); 

ALTER TABLE VSAFE_VACCINATION
    ADD CONSTRAINT FK_VAX_REGCODE
    FOREIGN KEY (REGISTRANT_CODE)
    REFERENCES VSAFE_REGISTRANTS (REGISTRANT_CODE)
    ON DELETE CASCADE;

-- VSAFE_HEALTH_CHECKIN_SURVEYS
ALTER TABLE VSAFE_HEALTH_CHECKIN_SURVEYS 
    ADD CONSTRAINT PK_SURVEY_STATIC_ID 
    PRIMARY KEY (REGISTRANT_CODE,SURVEY_STATIC_ID,RESPONSE_ID);

ALTER TABLE VSAFE_HEALTH_CHECKIN_SURVEYS
    ADD CONSTRAINT FK_CHECK_SURVEY_REGCODE
    FOREIGN KEY (REGISTRANT_CODE)
    REFERENCES VSAFE_REGISTRANTS (REGISTRANT_CODE)
    ON DELETE CASCADE;

-- SAFE_HEALTH_CHECKIN_SURVEYS_UNDER3 
ALTER TABLE VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3 
    ADD CONSTRAINT PK_SURVEY_STATIC_ID_U3 
    PRIMARY KEY (REGISTRANT_CODE,SURVEY_STATIC_ID,RESPONSE_ID);

ALTER TABLE VSAFE_HEALTH_CHECKIN_SURVEYS_UNDER3
    ADD CONSTRAINT FK_CHECK_SURVEY_REGCODE_UNDER3
    FOREIGN KEY (REGISTRANT_CODE)
    REFERENCES VSAFE_REGISTRANTS (REGISTRANT_CODE)
    ON DELETE CASCADE;    

-- VSAFE_RACE_ETHNICITY 
ALTER TABLE VSAFE_RACE_ETHNICITY 
    ADD CONSTRAINT PK_ETHNICITY_REGISTRANT_CODE 
    PRIMARY KEY (REGISTRANT_CODE);

ALTER TABLE VSAFE_RACE_ETHNICITY
    ADD CONSTRAINT FK_CHECK_VSAFE_RACE_ETHNICITY
    FOREIGN KEY (REGISTRANT_CODE)
    REFERENCES VSAFE_REGISTRANTS (REGISTRANT_CODE)
    ON DELETE CASCADE;