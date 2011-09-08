-- Start of DDL Script for Table CIALA.TBL_BQ_INTERNAC
-- Generated 16-Ago-2010 7:30:15 from CIALA@CEPAD92.PREFECTURA.NET

CREATE TABLE tbl_bq_internac
    (nroomi                         NUMBER(7,0),
    nombre                         VARCHAR2(50 BYTE),
    bandera                        VARCHAR2(50 BYTE),
    sociedadclasif                 VARCHAR2(254 BYTE),
    tipobuque                      VARCHAR2(55 BYTE),
    estado                         VARCHAR2(50 BYTE),
    anioconstr                     VARCHAR2(8 BYTE),
    tonelajebr                     VARCHAR2(20 BYTE),
    pesomuerto                     VARCHAR2(20 BYTE),
    distllam                       VARCHAR2(13 BYTE),
    mmsi                           NUMBER(9,0),
    nroomicia                      NUMBER(7,0),
    nombrecia                      VARCHAR2(50 BYTE),
    paisregcia                     VARCHAR2(255 BYTE),
    codarmador                     NUMBER(7,0),
    armador                        VARCHAR2(50 BYTE),
    paisarmador                    VARCHAR2(255 BYTE),
    codpropiet                     NUMBER(7,0),
    propietario                    VARCHAR2(50 BYTE),
    paisregisprop                  VARCHAR2(255 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  ciala
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





-- End of DDL Script for Table CIALA.TBL_BQ_INTERNAC

