-- Master Script
-- 
-- Run each script in sequence
-- no Schema Prefix: Must be run from correct schema
-- DATA_PUMP_DIR read,write required for External Table Create

-- @create_credential.sql

@create_external_table_ext_vaers_data.sql
@create_external_table_ext_vaers_vax.sql
@create_external_table_ext_vaers_symptoms.sql

@create_external_table_ext_vsafe_consolidated_health_checkin.sql
@create_external_table_ext_vsafe_consolidated_health_checkin_u3.sql
@create_external_table_ext_vsafe_consolidated_race_ethnicity.sql
@create_external_table_ext_vsafe_consolidated_vaccinations.sql
@create_external_table_ext_vsafe_registrants.sql

@create_tables_vaers.sql

@create_tables_vsafe.sql






