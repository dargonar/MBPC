-- Start of DDL Script for Table CIALA.PAISES
-- Generated 16-Ago-2010 8:05:22 from CIALA@CEPAD92.PREFECTURA.NET

CREATE TABLE paises
    (paisesid                       NUMBER(10,0) NOT NULL,
    descripcion                    VARCHAR2(50 BYTE) NOT NULL,
    conveniosrat                   NUMBER(10,0),
    codalfabetico                  VARCHAR2(2 BYTE) NOT NULL,
    rector                         NUMBER(5,0) NOT NULL,
    operador                       NUMBER(5,0) NOT NULL,
    estado                         NUMBER(5,0) NOT NULL,
    fechaaudit                     DATE NOT NULL,
    descripcionin                  VARCHAR2(50 BYTE),
    email                          VARCHAR2(200 BYTE))
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





-- Indexes for PAISES

CREATE INDEX descripcion ON paises
  (
    descripcion                     ASC
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
PARALLEL (DEGREE DEFAULT)
LOGGING
/

CREATE INDEX paises_index1 ON paises
  (
    paisesid                        ASC
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



-- End of DDL Script for Table CIALA.PAISES

