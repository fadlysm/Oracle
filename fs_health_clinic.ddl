-- Generated by Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   at:        2025-02-03 23:18:18 EST
--   site:      Oracle Database 21c
--   type:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE fs_appointments 
    ( 
     appointment_date TIMESTAMP  NOT NULL , 
     status           VARCHAR2 (20 CHAR) DEFAULT 'Scheduled' , 
     notes            CLOB , 
     appointments_ID  NUMBER  NOT NULL , 
     doctors_ID       NUMBER  NOT NULL , 
     patients_ID      NUMBER  NOT NULL 
    ) 
;

ALTER TABLE fs_appointments 
    ADD CONSTRAINT fs_appointments_PK PRIMARY KEY ( appointments_ID ) ;

CREATE TABLE fs_billing 
    ( 
     total_amount    NUMBER (11,2)  NOT NULL , 
     payment_status  VARCHAR2 (20 CHAR) DEFAULT 'Pending' , 
     payment_date    TIMESTAMP , 
     billing_ID      NUMBER  NOT NULL , 
     appointments_ID NUMBER  NOT NULL , 
     patients_ID     NUMBER  NOT NULL 
    ) 
;

ALTER TABLE fs_billing 
    ADD 
    CHECK (billing_ID = 1) 
;
CREATE UNIQUE INDEX fs_billing__IDX ON fs_billing 
    ( 
     appointments_ID ASC 
    ) 
;

ALTER TABLE fs_billing 
    ADD CONSTRAINT fs_billing_PK PRIMARY KEY ( billing_ID ) ;

CREATE TABLE fs_doctors 
    ( 
     first_name     VARCHAR2 (255 CHAR)  NOT NULL , 
     last_name      VARCHAR2 (255 CHAR) , 
     specialization VARCHAR2 (255 CHAR)  NOT NULL , 
     phone_number   VARCHAR2 (20 CHAR)  NOT NULL , 
     email          VARCHAR2 (255 CHAR)  NOT NULL , 
     doctors_ID     NUMBER  NOT NULL 
    ) 
;

ALTER TABLE fs_doctors 
    ADD CONSTRAINT fs_doctors_PK PRIMARY KEY ( doctors_ID ) ;

CREATE TABLE fs_patients 
    ( 
     first_name    VARCHAR2 (255 CHAR)  NOT NULL , 
     last_name     VARCHAR2 (255 CHAR) , 
     date_of_birth DATE  NOT NULL , 
     phone_number  VARCHAR2 (255 CHAR)  NOT NULL , 
     email         VARCHAR2 (255 CHAR) , 
     address       VARCHAR2 (255 CHAR) , 
     patients_ID   NUMBER  NOT NULL 
    ) 
;

ALTER TABLE fs_patients 
    ADD CONSTRAINT fs_patients_PK PRIMARY KEY ( patients_ID ) ;

CREATE TABLE fs_treatments 
    ( 
     treatment_name  VARCHAR2 (255 CHAR)  NOT NULL , 
     cost            NUMBER (11,2)  NOT NULL , 
     description     CLOB , 
     treatment_ID    NUMBER  NOT NULL , 
     appointments_ID NUMBER  NOT NULL 
    ) 
;

ALTER TABLE fs_treatments 
    ADD 
    CHECK (treatment_ID = 1) 
;

ALTER TABLE fs_treatments 
    ADD CONSTRAINT fs_treatments_PK PRIMARY KEY ( treatment_ID ) ;

ALTER TABLE fs_appointments 
    ADD CONSTRAINT fs_appointments_fs_doctors_FK FOREIGN KEY 
    ( 
     doctors_ID
    ) 
    REFERENCES fs_doctors 
    ( 
     doctors_ID
    ) 
;

ALTER TABLE fs_appointments 
    ADD CONSTRAINT fs_appointments_fs_patients_FK FOREIGN KEY 
    ( 
     patients_ID
    ) 
    REFERENCES fs_patients 
    ( 
     patients_ID
    ) 
;

ALTER TABLE fs_billing 
    ADD CONSTRAINT fs_billing_fs_appointments_FK FOREIGN KEY 
    ( 
     appointments_ID
    ) 
    REFERENCES fs_appointments 
    ( 
     appointments_ID
    ) 
;

ALTER TABLE fs_billing 
    ADD CONSTRAINT fs_billing_fs_patients_FK FOREIGN KEY 
    ( 
     patients_ID
    ) 
    REFERENCES fs_patients 
    ( 
     patients_ID
    ) 
;

ALTER TABLE fs_treatments 
    ADD CONSTRAINT fs_treat_fs_appoint_FK FOREIGN KEY 
    ( 
     appointments_ID
    ) 
    REFERENCES fs_appointments 
    ( 
     appointments_ID
    ) 
;

CREATE SEQUENCE fs_appointments_appointments_I 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER fs_appointments_appointments_I 
BEFORE INSERT ON fs_appointments 
FOR EACH ROW 
WHEN (NEW.appointments_ID IS NULL) 
BEGIN 
    :NEW.appointments_ID := fs_appointments_appointments_I.NEXTVAL; 
END;
/

CREATE SEQUENCE fs_billing_billing_ID_SEQ 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER fs_billing_billing_ID_TRG 
BEFORE INSERT ON fs_billing 
FOR EACH ROW 
WHEN (NEW.billing_ID IS NULL) 
BEGIN 
    :NEW.billing_ID := fs_billing_billing_ID_SEQ.NEXTVAL; 
END;
/

CREATE SEQUENCE fs_doctors_doctors_ID_SEQ 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER fs_doctors_doctors_ID_TRG 
BEFORE INSERT ON fs_doctors 
FOR EACH ROW 
WHEN (NEW.doctors_ID IS NULL) 
BEGIN 
    :NEW.doctors_ID := fs_doctors_doctors_ID_SEQ.NEXTVAL; 
END;
/

CREATE SEQUENCE fs_patients_patients_ID_SEQ 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER fs_patients_patients_ID_TRG 
BEFORE INSERT ON fs_patients 
FOR EACH ROW 
WHEN (NEW.patients_ID IS NULL) 
BEGIN 
    :NEW.patients_ID := fs_patients_patients_ID_SEQ.NEXTVAL; 
END;
/

CREATE SEQUENCE fs_treatments_treatment_ID_SEQ 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER fs_treatments_treatment_ID_TRG 
BEFORE INSERT ON fs_treatments 
FOR EACH ROW 
WHEN (NEW.treatment_ID IS NULL) 
BEGIN 
    :NEW.treatment_ID := fs_treatments_treatment_ID_SEQ.NEXTVAL; 
END;
/



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             5
-- CREATE INDEX                             1
-- ALTER TABLE                             12
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           5
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          5
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
