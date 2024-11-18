-- CreateCredential.sql
-- Allows access from database to object storage

-- User must be granted EXECUTE on DBMS.CLOUD 

BEGIN
  DBMS_CLOUD.CREATE_CREDENTIAL(
    credential_name => 'OBJECT_STORAGE',
    username        => 'username',
    password        => 'token'
  );
END;
/

SELECT * FROM DBMS_CLOUD.LIST_OBJECTS('OBJECT_STORAGE', 
    'https://id7flmkqdjfm.objectstorage.us-ashburn-1.oci.customer-oci.com/n/id7flmkqdjfm/b/AllVAERSDataCSVS/o/');