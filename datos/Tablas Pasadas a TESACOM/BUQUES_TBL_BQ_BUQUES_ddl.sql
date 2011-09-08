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

