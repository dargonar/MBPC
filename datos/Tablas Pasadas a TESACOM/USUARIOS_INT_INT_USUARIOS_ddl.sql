-- Start of DDL Script for Table USUARIOS_INT.INT_USUARIOS
-- Generated 16-Ago-2010 8:11:06 from USUARIOS_INT@CEPAD92.PREFECTURA.NET

CREATE TABLE int_usuarios
    (ndoc                           NUMBER(8,0),
    password                       VARCHAR2(80 BYTE) ,
    apellido                       VARCHAR2(25 BYTE) NOT NULL,
    nombres                        VARCHAR2(40 BYTE) NOT NULL,
    destino                        VARCHAR2(4 BYTE) NOT NULL,
    fechavenc                      DATE,
    tedirecto                      VARCHAR2(15 BYTE),
    teinterno                      VARCHAR2(6 BYTE),
    email                          VARCHAR2(50 BYTE),
    estado                         NUMBER(2,0),
    seccion                        VARCHAR2(80 BYTE),
    ndoc_admin                     NUMBER(8,0),
    fecha_audit                    DATE DEFAULT SYSDATE,
    nombredeusuario                NUMBER(8,0) NOT NULL,
    usuario_id                     NUMBER)
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  usuarios_int
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



-- Indexes for INT_USUARIOS

CREATE UNIQUE INDEX ind_ndoc_usuarios ON int_usuarios
  (
    ndoc                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  usuarios_int
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX ind_ape_usuarios ON int_usuarios
  (
    apellido                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  usuarios_int
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX ind_fecven_usuarios ON int_usuarios
  (
    fechavenc                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  usuarios_int
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/





-- End of DDL Script for Table USUARIOS_INT.INT_USUARIOS

