-- Start of DDL Script for Table GBARBOSA.TBL_ZONAS
-- Generated 16-Ago-2010 7:44:38 from GBARBOSA@DESAPRO.PREFECTURA.NET

CREATE TABLE tbl_zonas
    (cuatrigrama                    VARCHAR2(4 BYTE) NOT NULL,
    descripcion                    VARCHAR2(255 BYTE) NOT NULL,
    nivel                          VARCHAR2(1 BYTE) NOT NULL,
    direccion_postal               VARCHAR2(50 BYTE),
    ubic_geog                      VARCHAR2(50 BYTE),
    dependencia                    VARCHAR2(6 BYTE),
    estado                         NUMBER(1,0),
    codnum                         NUMBER(4,0),
    zona                           NUMBER(3,0),
    nivelnum                       VARCHAR2(2 BYTE),
    id                             NUMBER(6,0) NOT NULL,
    rpv                            VARCHAR2(10 BYTE),
    int                            VARCHAR2(10 BYTE),
    mail                           VARCHAR2(255 BYTE),
    te                             VARCHAR2(255 BYTE),
    fax                            VARCHAR2(2 BYTE),
    cod_cargo                      VARCHAR2(2 BYTE),
    descentralizado                VARCHAR2(1 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  usuarios
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

-- Grants for Table
GRANT SELECT ON tbl_zonas TO public
/
GRANT REFERENCES ON tbl_zonas TO public
/




-- Constraints for TBL_ZONAS

ALTER TABLE tbl_zonas
ADD CONSTRAINT pk_tbl_zonas_id PRIMARY KEY (id)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  destinos_pna
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Table GBARBOSA.TBL_ZONAS

