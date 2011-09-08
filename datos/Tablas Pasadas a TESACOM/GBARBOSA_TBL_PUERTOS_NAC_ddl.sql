-- Start of DDL Script for Table GBARBOSA.TBL_PUERTOS
-- Generated 16-Ago-2010 7:54:37 from GBARBOSA@DESAPRO.PREFECTURA.NET

CREATE TABLE tbl_puertos
    (id                             NUMBER(*,0) NOT NULL,
    prefectura_id                  NUMBER(*,0) NOT NULL,
    tipoubicacion_id               NUMBER(*,0) NOT NULL,
    jurisdiccion_id                NUMBER(*,0) NOT NULL,
    pais_id                        NUMBER(*,0) NOT NULL,
    tipo_puerto_id                 NUMBER(*,0) NOT NULL,
    codigo_onu                     CHAR(3 BYTE),
    nombre                         VARCHAR2(255 BYTE),
    tipo_via_id                    NUMBER(*,0) NOT NULL,
    instalacion_telefono           VARCHAR2(100 BYTE),
    instalacion_email              VARCHAR2(100 BYTE),
    longitud                       NUMBER(21,18) NOT NULL,
    latitud                        NUMBER(21,18) NOT NULL,
    codigo_omi                     CHAR(4 BYTE),
    baja                           NUMBER(*,0) DEFAULT 0 NOT NULL,
    wtf2                            NUMBER(*,0) DEFAULT -1,
    wtf                            NUMBER(*,0) DEFAULT -1,
    fecha_baja                     DATE,
    km_id                          NUMBER(*,0) DEFAULT -1
  ,
  CONSTRAINT PK_TBL_PUERTOS
  PRIMARY KEY (id))
  ORGANIZATION INDEX
   PCTTHRESHOLD 50 
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  usuarios
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOPARALLEL
  LOGGING
/





-- End of DDL Script for Table GBARBOSA.TBL_PUERTOS

