-- Start of DDL Script for Table CIALA.PUERTOS_INTERNAC
-- Generated 16-Ago-2010 8:02:28 from CIALA@CEPAD92.PREFECTURA.NET

CREATE TABLE puertos_internac
    (puertoid                       NUMBER(10,0) NOT NULL,
    paisesid                       NUMBER(10,0) NOT NULL,
    codigoalfa                     VARCHAR2(3 BYTE),
    descripcion                    VARCHAR2(50 BYTE) NOT NULL,
    operador                       NUMBER(5,0) NOT NULL,
    estado                         NUMBER(5,0) NOT NULL,
    fechaaudit                     DATE NOT NULL,
    direccion                      VARCHAR2(70 BYTE),
    localidad                      VARCHAR2(50 BYTE),
    codpostal                      VARCHAR2(10 BYTE),
    telefono                       VARCHAR2(50 BYTE),
    fax                            VARCHAR2(50 BYTE),
    email                          VARCHAR2(50 BYTE),
    autoridad                      VARCHAR2(70 BYTE))
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





-- Indexes for PUERTOS_INTERNAC

CREATE UNIQUE INDEX puertos_pk ON puertos_internac
  (
    puertoid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  ciala
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/



-- End of DDL Script for Table CIALA.PUERTOS_INTERNAC

