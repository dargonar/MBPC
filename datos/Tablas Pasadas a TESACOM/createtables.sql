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

-- Start of DDL Script for Table BUQUES.TBL_BQ_BUQUES
-- Generated 16-Ago-2010 7:26:51 from BUQUES@DESAPRO.PREFECTURA.NET

CREATE TABLE tbl_bq_buques
    (matricula                      VARCHAR2(10 BYTE) ,
    nro_omi                        NUMBER(7,0),
    nombre                         VARCHAR2(50 BYTE),
    bandera_id                     NUMBER(3,0),
    anio_construccion              NUMBER(4,0),
    estado_reg                     NUMBER(1,0),
    nro_ismm                       NUMBER(9,0),
    fecha_inscrip                  DATE,
    expte_inscrip                  VARCHAR2(15 BYTE),
    astill_partic                  VARCHAR2(70 BYTE),
    inscrip_provisoria             VARCHAR2(10 BYTE),
    variante                       VARCHAR2(1 BYTE),
    impnac                         VARCHAR2(5 BYTE),
    valor                          VARCHAR2(12 BYTE),
    causa_eliminacion              VARCHAR2(60 BYTE),
    expte_eliminacion              VARCHAR2(15 BYTE),
    fecha_eliminacion              DATE,
    actualizacion_usuario          VARCHAR2(15 BYTE),
    actualizacion_fecha            DATE,
    registro                       VARCHAR2(3 BYTE),
    eliminacion                    VARCHAR2(1 BYTE),
    tipo_buque                     NUMBER(3,0),
    tipo_servicio                  NUMBER(3,0),
    tipo_explotacion               NUMBER(3,0),
    arboladura_id                  NUMBER(3,0),
    buque_id                       NUMBER(10,0))
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





-- Indexes for TBL_BQ_BUQUES

CREATE INDEX ind_buques_nombre ON tbl_bq_buques
  (
    nombre                          ASC
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

CREATE INDEX ind_estadoreg ON tbl_bq_buques
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

CREATE INDEX ind_buques_ismm ON tbl_bq_buques
  (
    nro_ismm                        ASC
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

CREATE INDEX ind_buques_registro ON tbl_bq_buques
  (
    registro                        ASC
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

CREATE INDEX ind_buque_eliminacion ON tbl_bq_buques
  (
    eliminacion                     ASC
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

CREATE INDEX ind_buques_variante ON tbl_bq_buques
  (
    variante                        ASC
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

CREATE INDEX ind_buques_fechainscrip ON tbl_bq_buques
  (
    fecha_inscrip                   ASC
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

-- Constraints for TBL_BQ_BUQUES

ALTER TABLE tbl_bq_buques
ADD CONSTRAINT pk_buques_matri PRIMARY KEY (matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  buques
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/



-- Foreign Key
ALTER TABLE tbl_bq_propbuq
ADD CONSTRAINT fk_propbuq_matri FOREIGN KEY (matricula)
REFERENCES tbl_bq_buques (matricula)
/
-- End of DDL script for Foreign Key(s)




-- Comments for TBL_BQ_BUQUES

COMMENT ON COLUMN tbl_bq_buques.buque_id IS 'SQ_BUQUEID'
/
COMMENT ON COLUMN tbl_bq_buques.eliminacion IS 'NULL=activa;N=elim x no censar;E=Elim x otro motivo;'
/
COMMENT ON COLUMN tbl_bq_buques.matricula IS 'tiene que empezar con "0" para que la emb este activa'
/
COMMENT ON COLUMN tbl_bq_buques.tipo_buque IS 'para los MAY,MEN,FIS'
/
COMMENT ON COLUMN tbl_bq_buques.tipo_explotacion IS 'para los MAY,MEN,FIS'
/
COMMENT ON COLUMN tbl_bq_buques.tipo_servicio IS 'para los MAY,MEN,FIS'
/

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

