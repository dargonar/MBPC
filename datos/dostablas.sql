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