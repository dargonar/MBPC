-- Start of DDL Script for Table BUQUES.TBL_BQ_PROPBUQ
-- Generated 16-Ago-2010 7:36:43 from BUQUES@DESAPRO.PREFECTURA.NET

CREATE TABLE tbl_bq_propbuq
    (unico                          NUMBER(6,0) NOT NULL,
    cuit                           VARCHAR2(13 BYTE),
    matricula                      VARCHAR2(10 BYTE) NOT NULL,
    nro                            NUMBER(3,0),
    provdef                        VARCHAR2(1 BYTE),
    porcentaje                     NUMBER(6,3),
    escritura                      VARCHAR2(255 BYTE),
    domi1                          VARCHAR2(50 BYTE),
    loca1                          VARCHAR2(30 BYTE),
    prov1                          VARCHAR2(1 BYTE),
    codpos1                        VARCHAR2(8 BYTE),
    tel1                           VARCHAR2(15 BYTE),
    domi2                          VARCHAR2(50 BYTE),
    loca2                          VARCHAR2(30 BYTE),
    prov2                          VARCHAR2(1 BYTE),
    codpos2                        VARCHAR2(8 BYTE),
    tel2                           VARCHAR2(15 BYTE),
    cygcuit                        VARCHAR2(13 BYTE),
    cygapenom                      VARCHAR2(50 BYTE),
    cygtipodoc                     VARCHAR2(3 BYTE),
    cygnrodoc                      NUMBER(8,0),
    cygfechanac                    DATE,
    estadocivil                    NUMBER(2,0),
    email                          VARCHAR2(255 BYTE),
    estado_reg                     NUMBER(2,0))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  buques
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  NOMONITORING
  NOPARALLEL
  LOGGING
/


-- Indexes for TBL_BQ_PROPBUQ

CREATE INDEX idx_matri_propbuq ON tbl_bq_propbuq
  (
    matricula                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  buques
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX ind_propbuq_domi1 ON tbl_bq_propbuq
  (
    domi1                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  buques
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX ind_probemb_codpos1 ON tbl_bq_propbuq
  (
    codpos1                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  buques
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE UNIQUE INDEX uniq_propbuq_unico ON tbl_bq_propbuq
  (
    unico                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  buques
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX ind_propbuq_provdef ON tbl_bq_propbuq
  (
    provdef                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  buques
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX ind_propbuq_prov ON tbl_bq_propbuq
  (
    prov1                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  buques
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX ind_propemb_estadoreg ON tbl_bq_propbuq
  (
    estado_reg                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  buques
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX ind_propbuq_cuit ON tbl_bq_propbuq
  (
    cuit                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  buques
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE UNIQUE INDEX pk_propbuq ON tbl_bq_propbuq
  (
    cuit                            ASC,
    matricula                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  buques
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/



-- Constraints for TBL_BQ_PROPBUQ



-- Comments for TBL_BQ_PROPBUQ

COMMENT ON COLUMN tbl_bq_propbuq.estadocivil IS '0=NE,1=S,2=C,3=V,4=D'
/
COMMENT ON COLUMN tbl_bq_propbuq.provdef IS 'P provisorio, D definitivo'
/

-- End of DDL Script for Table BUQUES.TBL_BQ_PROPBUQ

-- Foreign Key
ALTER TABLE tbl_bq_propbuq
ADD CONSTRAINT fk_propbuq_matri FOREIGN KEY (matricula)
REFERENCES tbl_bq_buques (matricula)
/
-- End of DDL script for Foreign Key(s)
