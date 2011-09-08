-- Start of DDL Script for Table CIALA.PUERTOS_INTERNAC
-- Generated 16-Ago-2010 8:02:28 from CIALA@CEPAD92.PREFECTURA.NET

prompt 4

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
  TABLESPACE  mbpc
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

prompt 36


-- Indexes for PUERTOS_INTERNAC

CREATE UNIQUE INDEX puertos_pk ON puertos_internac
  (
    puertoid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

prompt 58

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
  TABLESPACE  mbpc
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

prompt 96

-- Indexes for INT_USUARIOS

CREATE UNIQUE INDEX ind_ndoc_usuarios ON int_usuarios
  (
    ndoc                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

prompt 117

CREATE INDEX ind_ape_usuarios ON int_usuarios
  (
    apellido                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

prompt 136

CREATE INDEX ind_fecven_usuarios ON int_usuarios
  (
    fechavenc                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

prompt 155

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
  TABLESPACE  mbpc
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

prompt 188

-- Indexes for PAISES

CREATE INDEX descripcion ON paises
  (
    descripcion                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
PARALLEL (DEGREE DEFAULT)
LOGGING
/

prompt 209

CREATE INDEX paises_index1 ON paises
  (
    paisesid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

prompt 228

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
  TABLESPACE  mbpc
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

prompt 276

-- Indexes for TBL_BQ_PROPBUQ

CREATE INDEX idx_matri_propbuq ON tbl_bq_propbuq
  (
    matricula                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

prompt 297

CREATE INDEX ind_propbuq_domi1 ON tbl_bq_propbuq
  (
    domi1                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

prompt 316

CREATE INDEX ind_probemb_codpos1 ON tbl_bq_propbuq
  (
    codpos1                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

prompt 335

CREATE UNIQUE INDEX uniq_propbuq_unico ON tbl_bq_propbuq
  (
    unico                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

prompt 354

CREATE INDEX ind_propbuq_provdef ON tbl_bq_propbuq
  (
    provdef                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

prompt 373

CREATE INDEX ind_propbuq_prov ON tbl_bq_propbuq
  (
    prov1                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

prompt 392

CREATE INDEX ind_propemb_estadoreg ON tbl_bq_propbuq
  (
    estado_reg                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

prompt 411

CREATE INDEX ind_propbuq_cuit ON tbl_bq_propbuq
  (
    cuit                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

prompt 430

CREATE UNIQUE INDEX pk_propbuq ON tbl_bq_propbuq
  (
    cuit                            ASC,
    matricula                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

prompt 450

-- Constraints for TBL_BQ_PROPBUQ
-- Comments for TBL_BQ_PROPBUQ

COMMENT ON COLUMN tbl_bq_propbuq.estadocivil IS '0=NE,1=S,2=C,3=V,4=D'
/
COMMENT ON COLUMN tbl_bq_propbuq.provdef IS 'P provisorio, D definitivo'
/

-- End of DDL Script for Table BUQUES.TBL_BQ_PROPBUQ

-- Start of DDL Script for Table BUQUES.TBL_BQ_BUQUES
-- Generated 16-Ago-2010 7:26:51 from BUQUES@DESAPRO.PREFECTURA.NET
prompt 464


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
  TABLESPACE  mbpc
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


prompt 510


-- Indexes for TBL_BQ_BUQUES

CREATE INDEX ind_buques_nombre ON tbl_bq_buques
  (
    nombre                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

prompt 532

CREATE INDEX ind_estadoreg ON tbl_bq_buques
  (
    estado_reg                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

prompt 551

CREATE INDEX ind_buques_ismm ON tbl_bq_buques
  (
    nro_ismm                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

prompt 570

CREATE INDEX ind_buques_registro ON tbl_bq_buques
  (
    registro                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

prompt 589

CREATE INDEX ind_buque_eliminacion ON tbl_bq_buques
  (
    eliminacion                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

prompt 608

CREATE INDEX ind_buques_variante ON tbl_bq_buques
  (
    variante                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

prompt 627

CREATE INDEX ind_buques_fechainscrip ON tbl_bq_buques
  (
    fecha_inscrip                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

prompt 646

-- Constraints for TBL_BQ_BUQUES

ALTER TABLE tbl_bq_buques
ADD CONSTRAINT pk_buques_matri PRIMARY KEY (matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

prompt 664

-- Foreign Key
ALTER TABLE tbl_bq_propbuq
ADD CONSTRAINT fk_propbuq_matri FOREIGN KEY (matricula)
REFERENCES tbl_bq_buques (matricula)
/
-- End of DDL script for Foreign Key(s)

prompt 673


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

prompt 694

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
  TABLESPACE  mbpc
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


prompt 733


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
  TABLESPACE  mbpc
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

prompt 775

-- Grants for Table
GRANT SELECT ON tbl_zonas TO public
/
GRANT REFERENCES ON tbl_zonas TO public
/

prompt 783

-- Constraints for TBL_ZONAS

ALTER TABLE tbl_zonas
ADD CONSTRAINT pk_tbl_zonas_id PRIMARY KEY (id)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

prompt 801
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
    km_id                          NUMBER(*,0) DEFAULT -1,
    extra1                         number(*,0),  
    extra2                         number(*,0)    
  ,
  CONSTRAINT PK_TBL_PUERTOS
  PRIMARY KEY (id))
  ORGANIZATION INDEX
   PCTTHRESHOLD 50 
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  mbpc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOPARALLEL
  LOGGING
/

prompt 845

CREATE TABLE tbl_insta_puert
   (id_puerto                     NUMBER(6,0) NOT NULL,
    nombre                         VARCHAR2(400) NOT NULL,
    puerto                         VARCHAR2(100) NOT NULL,
    latitud                        VARCHAR2(50),
    longitud                       VARCHAR2(50),
    direccion                      VARCHAR2(400) NOT NULL,
    provincia                      VARCHAR2(1) NOT NULL,
    contacto                       VARCHAR2(400) NOT NULL,
    eval_riesgo                    VARCHAR2(50) NOT NULL,
    fecha_eval                     DATE,
    plan_protect                   VARCHAR2(50) NOT NULL,
    fecha_plan                     DATE,
    f_audi_inicial                 DATE,
    decl_cumpl                     VARCHAR2(50) NOT NULL,
    operatoria                     VARCHAR2(400) NOT NULL,
    buques                         NUMBER(3,0) NOT NULL,
    depe                           NUMBER(6,0),
    id_apv                         NUMBER(6,0),
    spa                            VARCHAR2(2) NOT NULL,
    f_decl_cumpl                   DATE,
    localidad                      VARCHAR2(50) NOT NULL,
    cargo_responsable              VARCHAR2(50) NOT NULL,
    apellido_responsable           VARCHAR2(50) NOT NULL,
    usu_alta                       VARCHAR2(30) NOT NULL,
    f_usu_alta                     DATE NOT NULL,
    usu_modi                       VARCHAR2(30),
    f_usu_modi                     DATE,
    mail                           VARCHAR2(70),
    cp                             VARCHAR2(8),
    omi                            VARCHAR2(50),
    puerto_id                      NUMBER(10,0) NOT NULL)
/
ALTER TABLE tbl_insta_puert
ADD CONSTRAINT pk_id_puerto PRIMARY KEY (id_puerto)
/


prompt 885

CREATE TABLE tbl_muelles
    (id                             NUMBER(10,0) NOT NULL,
    puerto_id                      NUMBER(10,0) NOT NULL,
    insta_port                     NUMBER(6,0) NOT NULL,
    tipo_nav_id                    NUMBER(10,0) NOT NULL,
    tipo_carg_id                   NUMBER(10,0) NOT NULL,
    latitud                        VARCHAR2(50),
    longitud                       VARCHAR2(50),
    direccion                      VARCHAR2(400),
    int                            VARCHAR2(10),
    mail                           VARCHAR2(255),
    te                             VARCHAR2(255),
    fax                            VARCHAR2(2),
    descripcion                    VARCHAR2(255))
/
ALTER TABLE tbl_muelles
ADD CONSTRAINT pk_f_tbl_muelles_id PRIMARY KEY (id)
/



prompt 908



-- End of DDL Script for Table GBARBOSA.TBL_PUERTOS


--CREATE TABLE USUARIOS_INT.INT_SISTEMAS
--CREATE TABLE USUARIOS_INT.INT_USER_SIST
--CREATE TABLE GBARBOSA.TBL_CARGAS
--CREATE TABLE TBL_TIPO_CARGA
--CREATE TABLE TBL_CLASIFICACION
--CREATE TABLE GBARBOSA.TBL_UNIDAD
--CREATE TABLE TBL_MOVIMIENTOS_BUQUE
--CREATE TABLE TBL_TIPO_CARGAS_PELIGROSAS
--CREATE TABLE TBL_ESTADO
--CREATE TABLE TBL_BQ_CODPROV
--CREATE TABLE TBL_BQ_PROPIETARIOS

--================================================================================================================

CREATE TABLE INT_SISTEMAS
(
  SISTEMA_ID           NUMBER(10),
  NOMBRE_SIST          VARCHAR2(99 BYTE)        NOT NULL,
  NRO_SISTEMA          VARCHAR2(8 BYTE),
  PAGINA_INICIO        VARCHAR2(100 BYTE),
  MAIL_RESPONSABLE     VARCHAR2(100 BYTE),
  NDOC_ADMIN           NUMBER(10),
  FECHA_AUDIT          DATE                     DEFAULT sysdate,
  MOSTRAR              NUMBER(1),
  PAGINA_CONSULTA      VARCHAR2(100 BYTE),
  AGRUPAMIENTO         NUMBER(1),
  DESCRIPCION          VARCHAR2(300 BYTE),
  LENGUAJE             VARCHAR2(37 BYTE),
  FUNCIONA             VARCHAR2(2 BYTE),
  TIENE_DOCUMENTACION  VARCHAR2(2 BYTE),
  REPROGRAMAR          VARCHAR2(2 BYTE),
  COD_FUENTE           VARCHAR2(2 BYTE),
  LOG_OPER             VARCHAR2(9 BYTE),
  WEB                  VARCHAR2(2 BYTE),
  UBIC_DOCU            VARCHAR2(100 BYTE),
  SOPORTE_TEC          VARCHAR2(2 BYTE),
  ID_DIRECCION         NUMBER(5),
  DES_CPAD             VARCHAR2(2 BYTE),
  DICO                 VARCHAR2(2 BYTE),
  PROYECTO             VARCHAR2(2 BYTE),
  RESPONSABLE_CEPD     NUMBER(8),
  ORGAN_EXTERNO        VARCHAR2(300 BYTE),
  DIRECCION            VARCHAR2(100 BYTE),
  DEPTO_ORGANISMO      NUMBER(6),
  PAGINA_LOGIN         VARCHAR2(200 BYTE)
)
TABLESPACE mbpc
/

prompt 965

CREATE UNIQUE INDEX PK_ID_SISTEMA ON INT_SISTEMAS (SISTEMA_ID)
/
COMMENT ON COLUMN INT_SISTEMAS.LOG_OPER IS 'SI ES LOGISTICO U OPERATIVO';
/
COMMENT ON COLUMN INT_SISTEMAS.WEB IS 'SI ES WEB';
/
COMMENT ON COLUMN INT_SISTEMAS.SOPORTE_TEC IS 'SI TIENE PERSONAL ENCARGADO PARA EL SISTEMA';
/
COMMENT ON COLUMN INT_SISTEMAS.UBIC_DOCU IS 'DONDE FIGURA LA DOCUMENTACION';
/
COMMENT ON COLUMN INT_SISTEMAS.ID_DIRECCION IS 'ID DE DIRECCIONES';
/
COMMENT ON COLUMN INT_SISTEMAS.DEPTO_ORGANISMO IS 'ID DE DIRECCIONES DE TBL_ZONAS';
/
COMMENT ON COLUMN INT_SISTEMAS.MOSTRAR IS '1=MOSTRAR,0=NO MOSTRAR';
/


prompt 985

ALTER TABLE INT_SISTEMAS ADD (
  CHECK ("_SISTEMA" IS NOT NULL) DISABLE,
  CONSTRAINT PK_ID_SISTEMA
 PRIMARY KEY
 (SISTEMA_ID))
    USING INDEX 
    TABLESPACE mbpc;
/

--================================================================================================================
prompt 997

CREATE TABLE INT_USER_SIST
(
  UNICO            NUMBER(6)                    NOT NULL,
  NRO_SISTEMA      VARCHAR2(8 BYTE)             NOT NULL,
  NRO_PRIV_SIST    NUMBER(2),
  NDOC_ADMIN       NUMBER(8),
  FECHA_AUDIT      DATE                         DEFAULT SYSDATE,
  NDOC             NUMBER(8),
  NOMBREDEUSUARIO  NUMBER(8)                    NOT NULL,
  SISTEMA_ID       NUMBER(3)
)
TABLESPACE mbpc;
/

prompt 1013

CREATE INDEX IND_NDOC_USERSIST ON INT_USER_SIST
(NDOC)
LOGGING
TABLESPACE mbpc;
/

prompt 1021

CREATE UNIQUE INDEX PK_INT_USER_SIST_UNICO ON INT_USER_SIST
(UNICO)
LOGGING
TABLESPACE mbpc;
/

prompt 1029

ALTER TABLE INT_USER_SIST ADD (
  CONSTRAINT PK_INT_USER_SIST_UNICO
 PRIMARY KEY (UNICO)
    USING INDEX 
    TABLESPACE mbpc
    )
   ;
/

prompt 1040

ALTER TABLE INT_USER_SIST ADD (
  CONSTRAINT FK_USUARIO_SISTEMA 
 FOREIGN KEY (SISTEMA_ID) 
 REFERENCES INT_SISTEMAS (SISTEMA_ID));
/

prompt 1048

--================================================================================================================

ALTER TABLE TBL_CARGAS
 DROP PRIMARY KEY CASCADE;
/
DROP TABLE TBL_CARGAS CASCADE CONSTRAINTS;
/
CREATE TABLE TBL_CARGAS
(
  ID              INTEGER                       NOT NULL,
  TIPO_CARGA_ID   INTEGER                       NOT NULL,
  CANTIDAD        NUMBER(8,2)                   NOT NULL,
  MOVIMIENTO_ID   INTEGER                       NOT NULL,
  NOMBRE_USUARIO  VARCHAR2(8 BYTE)              DEFAULT -1                    NOT NULL
)
TABLESPACE mbpc
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
NOMONITORING;
/

prompt 1084

CREATE UNIQUE INDEX PK_TBL_CARGAS2 ON TBL_CARGAS
(ID)
LOGGING
TABLESPACE mbpc
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;
/


prompt 1104

create sequence ID_cargas_buques
increment by 1
start with 1
nomaxvalue;
/


prompt 1113

CREATE OR REPLACE TRIGGER AUTONUMERICO_ID_CARGAS_BUQUES
BEFORE INSERT
ON TBL_CARGAS 
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
IF INSERTING THEN
IF :NEW.ID IS NULL THEN
SELECT ID_cargas_buques.NEXTVAL INTO :NEW.ID FROM dual;
END IF;
END IF;
END;
/

prompt 1129

ALTER TABLE TBL_CARGAS ADD (
  CONSTRAINT PK_TBL_CARGAS2
 PRIMARY KEY
 (ID)
    USING INDEX 
    TABLESPACE mbpc
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
               ));

--================================================================================================================
prompt 1148
/
CREATE TABLE TBL_TIPO_CARGA
(
  ID                       INTEGER              NOT NULL,
  NOMBRE                   VARCHAR2(100 BYTE),
  CODIGO                   CHAR(3 BYTE),
  AGRUPACION_ID            INTEGER              DEFAULT -1                    NOT NULL,
  UNIDAD_ID                INTEGER              DEFAULT -1                    NOT NULL,
  ESTADO_ID                INTEGER              DEFAULT -1                    NOT NULL,
  TIPO_CARGA_PELIGROSA_ID  INTEGER              DEFAULT -1                    NOT NULL,
  NOMBRE_USUARIO           VARCHAR2(8 BYTE)     DEFAULT -1                    NOT NULL, 
  CONSTRAINT PK_TIPO_CARGA
 PRIMARY KEY
 (ID)
);
/

prompt 1166

create sequence ID_cargas
increment by 1
start with 1
nomaxvalue;
/

prompt 1174

CREATE OR REPLACE TRIGGER AUTONUMERICO_ID_CARGA
BEFORE INSERT
ON TBL_TIPO_CARGA 
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
IF INSERTING THEN
IF :NEW.ID IS NULL THEN
SELECT ID_cargas.NEXTVAL INTO :NEW.ID FROM dual;
END IF;
END IF;
END;
/

prompt 1190

--================================================================================================================

CREATE TABLE TBL_CLASIFICACION
(
  ID      INTEGER                               NOT NULL,
  NOMBRE  VARCHAR2(100 BYTE), 
  CONSTRAINT PK_TBL_CLASIFICACION
 PRIMARY KEY
 (ID)
);
/
--================================================================================================================
prompt 1204

CREATE TABLE TBL_UNIDAD
(
  ID      INTEGER                               NOT NULL,
  NOMBRE  VARCHAR2(100 BYTE), 
  CONSTRAINT PK_TBL_UNIDAD
 PRIMARY KEY
 (ID)
);
--================================================================================================================
prompt 1215
/
CREATE TABLE TBL_MOVIMIENTOS_BUQUE
(
  ID                           INTEGER          NOT NULL,
  VIAJE_ID                     INTEGER          NOT NULL,
  TIPO_VIA_ID                  NUMBER(1)        NOT NULL,
  LATITUD                      NUMBER(21,18),
  LONGITUD                     NUMBER(21,18),
  OBSERVACION                  VARCHAR2(255 BYTE),
  FECHA_CREACION               DATE             NOT NULL,
  VELOCIDAD                    INTEGER          NOT NULL,
  FECHA                        DATE             NOT NULL,
  HORA                         VARCHAR2(5 BYTE) NOT NULL,
  KM_ID                        INTEGER,
  DETALLE_SUBCLASIFICACION_ID  INTEGER          DEFAULT 0                     NOT NULL,
  DIRECCION_NAVEGACION_ID      NUMBER(1)        DEFAULT -1,
  RUMBO                        NUMBER(3)        DEFAULT -1,
  PREFECTURA_ID                INTEGER          DEFAULT -1                    NOT NULL,
  CALADO_ACTUAL                NUMBER(6,3)      DEFAULT -1,
  PUERTO_ORIGEN_ID             INTEGER          DEFAULT -1, 
  CONSTRAINT PK_TBL_MOVIMIENTOS_BUQUE
 PRIMARY KEY
 (ID)
);
/

prompt 1242

create sequence ID_movimientos_buque 
increment by 1
start with 1
nomaxvalue;
/

prompt 1250

CREATE OR REPLACE TRIGGER AUTONUMERICO_ID_mov_buque
BEFORE INSERT
ON TBL_MOVIMIENTOS_BUQUE REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
IF INSERTING THEN
IF :NEW.ID IS NULL THEN
SELECT ID_movimientos_buque.NEXTVAL INTO :NEW.ID FROM dual;
END IF;
END IF;
END;
/

prompt 1265
--================================================================================================================

CREATE TABLE TBL_TIPO_CARGAS_PELIGROSAS
(
  ID      INTEGER                               NOT NULL,
  NOMBRE  VARCHAR2(50 BYTE)                     NOT NULL
);
/

prompt 1275

CREATE UNIQUE INDEX PK_TBL_TIPO_CARGAS_PELIGROSAS ON 
TBL_TIPO_CARGAS_PELIGROSAS
(ID);
/
ALTER TABLE TBL_TIPO_CARGAS_PELIGROSAS ADD (
  CONSTRAINT PK_TBL_TIPO_CARGAS_PELIGROSAS
 PRIMARY KEY
 (ID))
    USING INDEX;
/

prompt 1288

--================================================================================================================
CREATE TABLE TBL_ESTADO
(
  ID      INTEGER                               NOT NULL,
  NOMBRE  VARCHAR2(100 BYTE), 
  CONSTRAINT PK_TBL_ESTADO
 PRIMARY KEY
 (ID)
);
/
--========================QUERY QUE RELACIONA PROPIETARIOS CON SUS EMBARCACIONES (SOLO PARA NACIONALES)
--SELECT m.matricula, m.registro, b.apenom, b.cuit, A.porcentaje, A.domi1,A.loca1,P.prov,a.codpos1 
--FROM tbl_bq_buques m, tbl_bq_propbuq a, tbl_bq_propietarios b, tbl_bq_codprov P 
--where m.matricula = A.MATRICULA
--and a.matricula= '0111' 
--and a.estado_reg=0 
--and a.cuit=b.cuit 
--AND A.prov1=P.codigo
/

prompt 1310

--================================================================================================================
CREATE TABLE TBL_BQ_CODPROV
(
  PROV    VARCHAR2(23 BYTE),
  CODIGO  VARCHAR2(1 BYTE)
);
/

prompt 1320

--================================================================================================================
CREATE TABLE TBL_BQ_PROPIETARIOS
(
  CUIT          VARCHAR2(13 BYTE)               NOT NULL,
  TIPODOC       VARCHAR2(3 BYTE),
  NRODOC        NUMBER(8),
  CEDULA        NUMBER(8),
  EXPPOR        VARCHAR2(2 BYTE),
  APENOM        VARCHAR2(100 BYTE),
  SOCIEDAD      VARCHAR2(255 BYTE),
  ESTADO_REG    NUMBER(1),
  FECHANAC      DATE,
  PASAPORTE     VARCHAR2(10 BYTE),
  NACIONALIDAD  NUMBER(3)
);
/
--================================================================================================================


 


