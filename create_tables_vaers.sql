-- The Vaccine Adverse Event Reporting System (VAERS) is a national passive surveillance system
-- co-administered by the U.S. Food and Drug Administration (FDA) and the Centers for Disease Control
-- and Prevention (CDC). VAERS collects and monitors reports of adverse events following vaccination
-- to detect potential safety signals and identify rare or unusual vaccine adverse events.
--
-- The data is sourced from healthcare providers, vaccine manufacturers, and the public, and includes
-- details on patient demographics, symptoms, health outcomes, and vaccine information.
-- 
-- The dataset is divided into three components:
--   1. VAERS_DATA: Core patient and report information.
--   2. VAERS_VAX: Details about administered vaccines.
--   3. VAERS_SYMPTOMS: MedDRA-coded symptoms reported in adverse events.
--
-- Note: VAERS data represents unverified reports and does not establish causality between a vaccine
-- and an adverse event. It is intended for surveillance and research purposes to identify safety signals.
--
-- More information: https://vaers.hhs.gov/
--
-- VAERS csv data updates monthly and is typically four weeks behind current date
-- https://vaers.hhs.gov/data/datasets.html

/*
DELETE VAERS_SYMPTOMS CASCADE CONSTRAINTS;
DELETE VAERS_VAX CASCADE CONSTRAINTS;
DELETE VAERS_DATA CASCADE_CONSTRAINTS;
*/


CREATE TABLE VAERS_SYMPTOMS (
    VAERS_ID NUMBER(7) 			---- COMMENT ON COLUMN VAERS_SYMPTOMS.VAERS_ID IS 'VAERS identification number, unique identifier for linking records';
    ,SYMPTOM1 VARCHAR2(100)  		---- COMMENT ON COLUMN VAERS_SYMPTOMS.SYMPTOM1 IS 'Adverse event MedDRA term 1';
    ,SYMPTOMVERSION1 NUMBER(5, 2) 	---- COMMENT ON COLUMN VAERS_SYMPTOMS.SYMPTOMVERSION1 IS 'MedDRA dictionary version for symptom term 1';
    ,SYMPTOM2 VARCHAR2(100) 		---- COMMENT ON COLUMN VAERS_SYMPTOMS.SYMPTOM2 IS 'Adverse event MedDRA term 2';
    ,SYMPTOMVERSION2 NUMBER(5, 2) 	---- COMMENT ON COLUMN VAERS_SYMPTOMS.SYMPTOMVERSION2 IS 'MedDRA dictionary version for symptom term 2';
    ,SYMPTOM3 VARCHAR2(100) 		---- COMMENT ON COLUMN VAERS_SYMPTOMS.SYMPTOM3 IS 'Adverse event MedDRA term 3';
    ,SYMPTOMVERSION3 NUMBER(5, 2) 	---- COMMENT ON COLUMN VAERS_SYMPTOMS.SYMPTOMVERSION3 IS 'MedDRA dictionary version for symptom term 3';
    ,SYMPTOM4 VARCHAR2(100) 		---- COMMENT ON COLUMN VAERS_SYMPTOMS.SYMPTOM4 IS 'Adverse event MedDRA term 4';
    ,SYMPTOMVERSION4 NUMBER(5, 2) 	---- COMMENT ON COLUMN VAERS_SYMPTOMS.SYMPTOMVERSION4 IS 'MedDRA dictionary version for symptom term 4';
    ,SYMPTOM5 VARCHAR2(100) 		---- COMMENT ON COLUMN VAERS_SYMPTOMS.SYMPTOM5 IS 'Adverse event MedDRA term 5';
    ,SYMPTOMVERSION5 NUMBER(5, 2) 	---- COMMENT ON COLUMN VAERS_SYMPTOMS.SYMPTOMVERSION5 IS 'MedDRA dictionary version for symptom term 5;
);

COMMENT ON COLUMN VAERS_SYMPTOMS.VAERS_ID IS 'VAERS identification number, unique identifier for linking records';
COMMENT ON COLUMN VAERS_SYMPTOMS.SYMPTOM1 IS 'Adverse event MedDRA term 1';
COMMENT ON COLUMN VAERS_SYMPTOMS.SYMPTOMVERSION1 IS 'MedDRA dictionary version for symptom term 1';
COMMENT ON COLUMN VAERS_SYMPTOMS.SYMPTOM2 IS 'Adverse event MedDRA term 2';
COMMENT ON COLUMN VAERS_SYMPTOMS.SYMPTOMVERSION2 IS 'MedDRA dictionary version for symptom term 2';
COMMENT ON COLUMN VAERS_SYMPTOMS.SYMPTOM3 IS 'Adverse event MedDRA term 3';
COMMENT ON COLUMN VAERS_SYMPTOMS.SYMPTOMVERSION3 IS 'MedDRA dictionary version for symptom term 3';
COMMENT ON COLUMN VAERS_SYMPTOMS.SYMPTOM4 IS 'Adverse event MedDRA term 4';
COMMENT ON COLUMN VAERS_SYMPTOMS.SYMPTOMVERSION4 IS 'MedDRA dictionary version for symptom term 4';
COMMENT ON COLUMN VAERS_SYMPTOMS.SYMPTOM5 IS 'Adverse event MedDRA term 5';
COMMENT ON COLUMN VAERS_SYMPTOMS.SYMPTOMVERSION5 IS 'MedDRA dictionary version for symptom term 5';


CREATE TABLE VAERS_VAX (
    VAERS_ID NUMBER(7) 		    ---- COMMENT ON COLUMN VAERS_SYMPTOMS.VAERS_ID IS 'VAERS identification number, unique identifier for linking records';
    ,VAX_TYPE VARCHAR2(15) 	    ---- COMMENT ON COLUMN VAERS_SYMPTOMS.VAX_TYPE IS 'Administered vaccine type';
    ,VAX_MANU VARCHAR2(40) 	    ---- COMMENT ON COLUMN VAERS_SYMPTOMS.VAX_MANU IS 'Vaccine manufacturer';
    ,VAX_LOT VARCHAR2(15) 	    ---- COMMENT ON COLUMN VAERS_SYMPTOMS.VAX_LOT IS 'Manufacturer�s vaccine lot number';
    ,VAX_DOSE_SERIES CHAR(3) 	    ---- COMMENT ON COLUMN VAERS_SYMPTOMS.VAX_DOSE_SERIES IS 'Number of doses administered in this series';
    ,VAX_ROUTE VARCHAR2(6) 	    ---- COMMENT ON COLUMN VAERS_SYMPTOMS.VAX_ROUTE IS 'Route of administration for the vaccine';
    ,VAX_SITE VARCHAR2(6) 	    ---- COMMENT ON COLUMN VAERS_SYMPTOMS.VAX_SITE IS 'Anatomic site where the vaccine was administered';
    ,VAX_NAME VARCHAR2(100) 	    ---- COMMENT ON COLUMN VAERS_SYMPTOMS.VAX_NAME IS 'Brand name of the vaccine administered';
);

COMMENT ON COLUMN VAERS_VAX.VAERS_ID IS 'VAERS identification number, unique identifier for linking records';
COMMENT ON COLUMN VAERS_VAX.VAX_TYPE IS 'Administered vaccine type';
COMMENT ON COLUMN VAERS_VAX.VAX_MANU IS 'Vaccine manufacturer';
COMMENT ON COLUMN VAERS_VAX.VAX_LOT IS 'Manufacturer�s vaccine lot number';
COMMENT ON COLUMN VAERS_VAX.VAX_DOSE_SERIES IS 'Number of doses administered in this series';
COMMENT ON COLUMN VAERS_VAX.VAX_ROUTE IS 'Route of administration for the vaccine';
COMMENT ON COLUMN VAERS_VAX.VAX_SITE IS 'Anatomic site where the vaccine was administered';
COMMENT ON COLUMN VAERS_VAX.VAX_NAME IS 'Brand name of the vaccine administered';


CREATE TABLE VAERS_DATA (
    VAERS_ID NUMBER(7) 			    ---- COMMENT ON VAERS_DATA.VAERS_ID IS 'VAERS identification number, unique identifier for linking records',
    ,RECVDATE DATE 			    ---- COMMENT ON VAERS_DATA.RECVDATE IS 'Date report was received by VAERS',
    ,STATE CHAR(2) 			    ---- COMMENT ON VAERS_DATA.STATE IS 'State abbreviation (two-letter code)',
    ,AGE_YRS NUMBER(4, 1) 		    ---- COMMENT ON VAERS_DATA.AGE_YRS IS 'Age in years of the vaccine recipient',
    ,CAGE_YR NUMBER(3) 			    ---- COMMENT ON VAERS_DATA.CAGE_YR IS 'Calculated age in years',
    ,CAGE_MO NUMBER(3, 1) 		    ---- COMMENT ON VAERS_DATA.CAGE_MO IS 'Calculated age in months (up to 2 years old)',
    ,SEX CHAR(1) 			    ---- COMMENT ON VAERS_DATA.SEX IS 'Sex of the vaccine recipient (M=Male, F=Female, Blank=Unknown)',
    ,RPT_DATE DATE 			    ---- COMMENT ON VAERS_DATA.RPT_DATE IS 'Date the VAERS form was completed',
    ,SYMPTOM_TEXT VARCHAR2(32767) 	    ---- COMMENT ON VAERS_DATA.SYMPTOM_TEXT IS 'Reported symptom text from the VAERS form',
    ,DIED CHAR(1) 			    ---- COMMENT ON VAERS_DATA.DIED IS 'Indicates if the vaccine recipient died (Y=Yes, Blank=No)',
    ,DATEDIED DATE 			    ---- COMMENT ON VAERS_DATA.DATEDIED IS 'Date of death of the vaccine recipient',
    ,L_THREAT CHAR(1) 			    ---- COMMENT ON VAERS_DATA.L_THREAD IS 'Life-threatening illness indicator (Y=Yes, Blank=No)',
    ,ER_VISIT CHAR(1) 			    ---- COMMENT ON VAERS_DATA.ER_VISIT IS 'Emergency room visit indicator (Y=Yes, Blank=No)',
    ,HOSPITAL CHAR(1) 			    ---- COMMENT ON VAERS_DATA.HOSPITAL IS 'Hospitalization indicator (Y=Yes, Blank=No)',
    ,HOSPDAYS NUMBER(3) 		    ---- COMMENT ON VAERS_DATA.HOSPDAYS IS 'Number of days hospitalized',
    ,X_STAY CHAR(1) 			    ---- COMMENT ON VAERS_DATA.X_STAY IS 'Prolongation of existing hospitalization (Y=Yes, Blank=No)',
    ,DISABLE CHAR(1) 			    ---- COMMENT ON VAERS_DATA.DISABLE IS 'Disability indicator (Y=Yes, Blank=No)',
    ,RECOVD CHAR(1) 			    ---- COMMENT ON VAERS_DATA.RECOVD IS 'Recovery status (Y=Recovered, N=Not recovered, Blank=Unknown)',
    ,VAX_DATE DATE 			    ---- COMMENT ON VAERS_DATA.VAX_DATE IS 'Date of vaccination',
    ,ONSET_DATE DATE 			    ---- COMMENT ON VAERS_DATA.ONSET_DATE IS 'Adverse event onset date',
    ,NUMDAYS NUMBER(5) 			    ---- COMMENT ON VAERS_DATA.NUMDAYS IS 'Interval in days between vaccination and onset of adverse event',
    ,LAB_DATA VARCHAR2(32767) 		    ---- COMMENT ON VAERS_DATA.LAB_DATA IS 'Relevant diagnostic tests or laboratory data',
    ,V_ADMINBY CHAR(3) 			    ---- COMMENT ON VAERS_DATA.V_ADMINBY IS 'Type of facility where the vaccine was administered',
    ,V_FUNDBY CHAR(3) 			    ---- COMMENT ON VAERS_DATA.V_FUNDBY IS 'Funding source for the vaccine (VAERS 1 only)',
    ,OTHER_MEDS VARCHAR2(240) 		    ---- COMMENT ON VAERS_DATA.OTHER_MEDS IS 'Other medications the recipient was taking at the time of vaccination',
    ,CUR_ILL VARCHAR2(32767) 		    ---- COMMENT ON VAERS_DATA.CUR_ILL IS 'Illnesses at the time of vaccination',
    ,HISTORY VARCHAR2(32767) 	    	    ---- COMMENT ON VAERS_DATA.HISTORY IS 'Chronic or long-standing health conditions',
    ,PRIOR_VAX VARCHAR2(128) 		    ---- COMMENT ON VAERS_DATA.PRIOR_VAX IS 'Prior vaccination event information',
    ,SPLTTYPE VARCHAR2(25) 		    ---- COMMENT ON VAERS_DATA.SPLTTYPE IS 'Manufacturer or Immunization Project report number',
    ,FORM_VERS NUMBER(1) 		    ---- COMMENT ON VAERS_DATA.FORM_VERS IS 'VAERS form version (1 or 2)',
    ,TODAYS_DATE DATE 			    ---- COMMENT ON VAERS_DATA.TODAYS_DATE IS 'Date the form was completed',
    ,BIRTH_DEFECT CHAR(1) 		    ---- COMMENT ON VAERS_DATA.BIRTH_DEFECT IS 'Congenital anomaly or birth defect (Y=Yes, Blank=No)',
    ,OFC_VISIT CHAR(1) 			    ---- COMMENT ON VAERS_DATA.OFC_VISIT IS 'Doctor or other healthcare provider office/clinic visit (Y=Yes, Blank=No)',
    ,ER_ED_VISIT CHAR(1) 		    ---- COMMENT ON VAERS_DATA.ER_ED_VISIT IS 'Emergency room or urgent care visit (Y=Yes, Blank=No)',
    ,ALLERGIES VARCHAR2(32767) 		    ---- COMMENT ON VAERS_DATA.ALLERGIES IS 'Allergies to medications, food, or other products'
);

COMMENT ON COLUMN VAERS_DATA.VAERS_ID IS 'VAERS identification number, unique identifier for linking records';
COMMENT ON COLUMN VAERS_DATA.RECVDATE IS 'Date report was received by VAERS';
COMMENT ON COLUMN VAERS_DATA.STATE IS 'State abbreviation (two-letter code)';
COMMENT ON COLUMN VAERS_DATA.AGE_YRS IS 'Age in years of the vaccine recipient';
COMMENT ON COLUMN VAERS_DATA.CAGE_YR IS 'Calculated age in years';
COMMENT ON COLUMN VAERS_DATA.CAGE_MO IS 'Calculated age in months (up to 2 years old)';
COMMENT ON COLUMN VAERS_DATA.SEX IS 'Sex of the vaccine recipient (M=Male, F=Female, Blank=Unknown)';
COMMENT ON COLUMN VAERS_DATA.RPT_DATE IS 'Date the VAERS form was completed';
COMMENT ON COLUMN VAERS_DATA.SYMPTOM_TEXT IS 'Reported symptom text from the VAERS form';
COMMENT ON COLUMN VAERS_DATA.DIED IS 'Indicates if the vaccine recipient died (Y=Yes, Blank=No)';
COMMENT ON COLUMN VAERS_DATA.DATEDIED IS 'Date of death of the vaccine recipient';
COMMENT ON COLUMN VAERS_DATA.L_THREAD IS 'Life-threatening illness indicator (Y=Yes, Blank=No)';
COMMENT ON COLUMN VAERS_DATA.ER_VISIT IS 'Emergency room visit indicator (Y=Yes, Blank=No)';
COMMENT ON COLUMN VAERS_DATA.HOSPITAL IS 'Hospitalization indicator (Y=Yes, Blank=No)';
COMMENT ON COLUMN VAERS_DATA.HOSPDAYS IS 'Number of days hospitalized';
COMMENT ON COLUMN VAERS_DATA.X_STAY IS 'Prolongation of existing hospitalization (Y=Yes, Blank=No)';
COMMENT ON COLUMN VAERS_DATA.DISABLE IS 'Disability indicator (Y=Yes, Blank=No)';
COMMENT ON COLUMN VAERS_DATA.RECOVD IS 'Recovery status (Y=Recovered, N=Not recovered, Blank=Unknown)';
COMMENT ON COLUMN VAERS_DATA.VAX_DATE IS 'Date of vaccination';
COMMENT ON COLUMN VAERS_DATA.ONSET_DATE IS 'Adverse event onset date';
COMMENT ON COLUMN VAERS_DATA.NUMDAYS IS 'Interval in days between vaccination and onset of adverse event';
COMMENT ON COLUMN VAERS_DATA.LAB_DATA IS 'Relevant diagnostic tests or laboratory data';
COMMENT ON COLUMN VAERS_DATA.V_ADMINBY IS 'Type of facility where the vaccine was administered';
COMMENT ON COLUMN VAERS_DATA.V_FUNDBY IS 'Funding source for the vaccine (VAERS 1 only)';
COMMENT ON COLUMN VAERS_DATA.OTHER_MEDS IS 'Other medications the recipient was taking at the time of vaccination';
COMMENT ON COLUMN VAERS_DATA.CUR_ILL IS 'Illnesses at the time of vaccination';
COMMENT ON COLUMN VAERS_DATA.HISTORY IS 'Chronic or long-standing health conditions';
COMMENT ON COLUMN VAERS_DATA.PRIOR_VAX IS 'Prior vaccination event information';
COMMENT ON COLUMN VAERS_DATA.SPLTTYPE IS 'Manufacturer or Immunization Project report number';
COMMENT ON COLUMN VAERS_DATA.FORM_VERS IS 'VAERS form version (1 or 2)';
COMMENT ON COLUMN VAERS_DATA.TODAYS_DATE IS 'Date the form was completed';
COMMENT ON COLUMN VAERS_DATA.BIRTH_DEFECT IS 'Congenital anomaly or birth defect (Y=Yes, Blank=No)';
COMMENT ON COLUMN VAERS_DATA.OFC_VISIT IS 'Doctor or other healthcare provider office/clinic visit (Y=Yes, Blank=No)';
COMMENT ON COLUMN VAERS_DATA.ER_ED_VISIT IS 'Emergency room or urgent care visit (Y=Yes, Blank=No)';
COMMENT ON COLUMN VAERS_DATA.ALLERGIES IS 'Allergies to medications, food, or other products';

/*
SELECT * FROM USER_COL_COMMENTS WHERE TABLE_NAME IN ('VAERS_DATA','VAERS_VAX','VAERS_SYMPTOMS');

CREATE VIEW DATA AS SELECT * FROM VAERS_DATA;
CREATE VIEW SYMPTOMS AS SELECT * FROM VAERS_SYMPTOMS;
CREATE VIEW VAX AS SELECT * FROM VAERS_VAX;
*/

---- LOADING DATA ----

-- VAERS_DATA
ALTER TABLE VAERS_DATA NOLOGGING;
INSERT /*+ APPEND */ INTO VAERS_DATA 
    SELECT * 
    FROM EXT_VAERS_DATA;

-- VAERS_VAX
ALTER TABLE VAERS_VAX NOLOGGING;
INSERT  /*+ APPEND */ INTO VAERS_VAX 
    SELECT * 
      FROM EXT_VAERS_VAX;

-- VAERS_SYMPTOMS
ALTER TABLE VAERS_SYMPTOMS NOLOGGING;
INSERT  /*+ APPEND */ INTO VAERS_SYMPTOMS 
    SELECT * 
      FROM EXT_VAERS_SYMPTOMS;
      
/*
ALTER TABLE VAERS_DATA LOGGING;
ALTER TABLE VAERS_VAX LOGGING;
ALTER TABLE VAERS_SYMPTOMS LOGGING;
*/

---- SAVE PROBLEM ROWS FOR FUTURE FIX ----
-- 8 ROWS MISSING DURING INITAL LOAD TO VAX_DATA
-- PKs Cannot be created until data is fixed

---- VAERS_VAX ---- 
  -- SAVE AND REMOVE ROWS WITHOUT PARENT VAERS_ID

CREATE TABLE MISSING_VAERS_DATA_FROM_VAERS_VAX 
   AS SELECT * 
        FROM VAERS_VAX 
       WHERE VAERS_ID 
      NOT IN (SELECT VAERS_ID 
                FROM VAERS_DATA);
                
DELETE VAERS_VAX 
 WHERE VAERS_ID 
    IN (SELECT VAERS_ID 
          FROM MISSING_VAERS_DATA_FROM_VAERS_VAX);

---- VAERS_SYMPTOMS ----
  -- SAVE AND REMOVE ROWS WITHOUT PARENT VAERS_ID

CREATE TABLE MISSING_VAERS_DATA_FROM_VAERS_SYMPTOMS 
   AS SELECT * 
        FROM VAERS_SYMPTOMS 
       WHERE VAERS_ID 
      NOT IN (SELECT VAERS_ID 
                FROM VAERS_DATA);
       
DELETE VAERS_SYMPTOMS 
 WHERE VAERS_ID 
    IN (SELECT VAERS_ID 
          FROM MISSING_VAERS_DATA_FROM_VAERS_SYMPTOMS);


---- ADDING TABLE CONSTRAINTS ----

-- VAERS_DATA 
ALTER TABLE VAERS_DATA 
    ADD CONSTRAINT pk_VAERS_DATA 
    PRIMARY KEY (VAERS_ID);

-- VAERS_VAX
ALTER TABLE VAERS_VAX
    ADD CONSTRAINT fk_VAERS_VAX_VAERS_DATA 
    FOREIGN KEY (VAERS_ID)
    REFERENCES VAERS_DATA (VAERS_ID)
    ON DELETE CASCADE;

-- VAERS_SYMPTOMS
ALTER TABLE VAERS_SYMPTOMS
    ADD CONSTRAINT fk_VAERS_SYMPTOMS_VAERS_DATA
    FOREIGN KEY (VAERS_ID)
    REFERENCES VAERS_DATA (VAERS_ID)
    ON DELETE CASCADE;

SELECT COUNT(*) "MISSING_VAERS_DATA_FROM_VAERS_VAX" FROM MISSING_VAERS_DATA_FROM_VAERS_VAX;
SELECT COUNT(*) "MISSING_VAERS_DATA_FROM_VAERS_SYMPTOMS" FROM MISSING_VAERS_DATA_FROM_VAERS_SYMPTOMS;

--SELECT * FROM VALIDATE$19_LOG;
--CREATE TABLE MISSING_VAERS_DATA_LOAD_ERROR AS SELECT * FROM VALIDATE$19_LOG WHERE RECORD LIKE ('ORA%') OR RECORD LIKE ('error%') OR RECORD LIKE ('KUP%');
-- SELECT COUNT(*) FROM MISSING_VAERS_DATA_LOAD_ERROR;







