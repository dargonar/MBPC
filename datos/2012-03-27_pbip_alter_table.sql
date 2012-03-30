/* Quito constraint de NOT NULL para id de viaje.*/

/*
alter table 
        tbl_pbip
      MODIFY 
         ( 
          viaje_id     INTEGER      NULL
      );
*/

/* Campos actuales de la tabla.*/
/*
  viaje_id          INTEGER       NOT NULL,
  puertodematricula VARCHAR2(255) NULL,
  nroinmarsat       VARCHAR2(255) NULL,
  arqueobruto       VARCHAR2(255) NULL,
  compania          VARCHAR2(255) NULL,
  contactoocpm      VARCHAR2(255) NULL,
  objetivo          VARCHAR2(255) NULL
*/

/* Campos nuevos/requeridos de la tabla.*/
alter table tbl_pbip
  add
   (
    bandera                 VARCHAR2(256) NULL,
    id                      INTEGER NULL,
    nro_imo                 VARCHAR2(56) NULL,
    buque_nombre            VARCHAR2(56) NULL,
    tipo_buque              VARCHAR2(56) NULL,
    distintivo_llamada      VARCHAR2(56) NULL,
    nro_identif_compania    VARCHAR2(256) NULL,
    
    puerto_llegada          VARCHAR2(256) NULL,
    eta                     DATE NULL,
    instalacion_portuaria   VARCHAR2(256) NULL,
    
    cipb_estado             VARCHAR2(256) NULL,
    cipb_expedido_por       VARCHAR2(256) NULL,
    cipb_expiracion         DATE NULL,
    cipb_motivo_incumplimiento  VARCHAR2(256) NULL,
    proteccion_plan_aprobado  INTEGER NULL,
    proteccion_nivel_actual  INTEGER NULL, /* 1, 2, 3 */
    longitud_notif          NUMBER(21,18) NULL,
    latitud_notif           NUMBER(21,18) NULL,
    
    plan_proteccion_mant_bab      INTEGER NULL,
    plan_proteccion_mant_bab_desc CLOB NULL,
    
    carga_desc_gral               CLOB NULL,
    carga_sust_peligrosas         INTEGER NULL,
    carga_sust_peligrosas_desc    CLOB NULL,
    
    lista_pasajeros               INTEGER NULL,
    lista_tripuantes              INTEGER NULL,
    
    prot_notifica_cuestion        INTEGER NULL,
    prot_notifica_polizon         INTEGER NULL,
    prot_notifica_polizon_desc    CLOB NULL,
    prot_notifica_rescate         INTEGER NULL,
    prot_notifica_rescate_desc    CLOB NULL,
    prot_notifica_otra            INTEGER NULL,
    prot_notifica_otra_desc       CLOB NULL,
    
    agente_pto_llegada_nombre           VARCHAR2(256) NULL,
    agente_pto_llegada_tel              VARCHAR2(256) NULL,
    agente_pto_llegada_mail             VARCHAR2(256) NULL,
    
    facilitador_nombre                  VARCHAR2(256) NULL,
    facilitador_titulo_cargo            VARCHAR2(256) NULL,
    facilitador_lugar                   VARCHAR2(256) NULL,
    facilitador_fecha                   DATE NULL
   );
           
   
   /* Elimino PK viaje_id*/
  ALTER TABLE tbl_pbip DROP CONSTRAINT pk_tbl_pbip;
 
 /* Armo la secuencia para nueva PK "id". */
PROMPT CREATE SEQUENCE tbl_pbip_seq
CREATE SEQUENCE tbl_pbip_seq
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  INCREMENT BY 1
  NOCYCLE
  NOORDER
  CACHE 20
/

/* Asigno PK "id". */
PROMPT ALTER TABLE tbl_pbip ADD CONSTRAINT pk_tbl_pbip PRIMARY KEY
ALTER TABLE tbl_pbip
  ADD CONSTRAINT pk_tbl_pbip PRIMARY KEY (
    id
  )
  USING INDEX
    STORAGE (
      NEXT       1024 K
    )
/

/* trigger */
PROMPT CREATE OR REPLACE TRIGGER tbl_pbip_trigger
CREATE OR REPLACE TRIGGER tbl_pbip_trigger
before insert on tbl_pbip
for each row
begin
select tbl_pbip_seq.nextval into :new.id from dual;
end;
/

/* NUEVA TABLA */
/* tbl_pbip_params*/

CREATE TABLE tbl_pbip_params (
  id                 INTEGER        NOT NULL,
  tbl_pbip_id        INTEGER        NOT NULL,
  tipo_param         INTEGER        NOT NULL,
  indice             INTEGER        NOT NULL,
  fecha_desde        DATE           NOT NULL,
  fecha_hasta        DATE           NOT NULL,
  descripcion        CLOB           NULL,
  nivel_proteccion   INTEGER        NULL,
  
  escalas_medidas_adic        INTEGER        NULL,
  escalas_medidas_adic_desc   CLOB           NULL,

  actividad_bab               CLOB           NULL,
  
)
  STORAGE (
    NEXT       1024 K
  )
/

PROMPT CREATE SEQUENCE tbl_pbip_params_seq
CREATE SEQUENCE tbl_pbip_params_seq
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  INCREMENT BY 1
  NOCYCLE
  NOORDER
  CACHE 20
/


PROMPT ALTER TABLE tbl_pbip_params ADD CONSTRAINT pk_tbl_pbip_params PRIMARY KEY
ALTER TABLE tbl_pbip_params
  ADD CONSTRAINT pk_tbl_pbip_params PRIMARY KEY (
    id
  )
  USING INDEX
    STORAGE (
      NEXT       1024 K
    )
/

PROMPT CREATE OR REPLACE TRIGGER tbl_pbip_params_trigger
CREATE OR REPLACE TRIGGER tbl_pbip_params_trigger
before insert on tbl_pbip_params
for each row
begin
select tbl_pbip_params_seq.nextval into :new.id from dual;
end;
/

PROMPT CREATE OR REPLACE VIEW view_pbip_listar
CREATE OR REPLACE VIEW view_pbip_listar (
  id,
  nro_omi,
  buque,
  puertodematricula,
  bandera_id,
  tipo_buque,
  sdist,
  nroinmarsat,
  arqueobruto,
  compania,
  contactoocpm,
  eta,
  viaje,
  objetivo,
  destino,
  origen
) AS
select pbip.viaje_id, b.nro_omi, b.nombre buque, pbip.puertodematricula, b.bandera, b.tipo_buque, b.sdist,
       pbip.nroinmarsat, pbip.arqueobruto, pbip.compania, pbip.contactoOCPM, v.eta, v.id viaje, pbip.objetivo, k.puerto destino, k2.puerto origen
  from tbl_viaje v
  left join buques b on v.buque_id = b.id_buque
  left join tbl_pbip pbip on pbip.viaje_id = v.id
  left join kstm_puertos k on k.cod=v.destino_id
  left join kstm_puertos k2 on k2.cod=v.origen_id
/

