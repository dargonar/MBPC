/* ***************************************************** */
/* PBIP */
PROMPT CREATE TABLE tbl_pbip
CREATE TABLE tbl_pbip (
  viaje_id                      INTEGER       NULL,
  puertodematricula             VARCHAR2(255) NULL,
  nroinmarsat                   VARCHAR2(255) NULL,
  arqueobruto                   VARCHAR2(255) NULL,
  compania                      VARCHAR2(255) NULL,
  contactoocpm                  VARCHAR2(255) NULL,
  objetivo                      VARCHAR2(255) NULL,
  nro_imo                       VARCHAR2(56)  NULL,
  buque_nombre                  VARCHAR2(56)  NULL,
  tipo_buque                    VARCHAR2(56)  NULL,
  distintivo_llamada            VARCHAR2(56)  NULL,
  nro_identif_compania          VARCHAR2(256) NULL,
  puerto_llegada                VARCHAR2(256) NULL,
  eta                           DATE          NULL,
  instalacion_portuaria         VARCHAR2(256) NULL,
  cipb_estado                   VARCHAR2(256) NULL,
  cipb_expedido_por             VARCHAR2(256) NULL,
  cipb_expiracion               DATE          NULL,
  cipb_motivo_incumplimiento    VARCHAR2(256) NULL,
  longitud_notif                NUMBER(21,18) NULL,
  latitud_notif                 NUMBER(21,18) NULL,
  plan_proteccion_mant_bab_desc CLOB          NULL,
  carga_desc_gral               CLOB          NULL,
  carga_sust_peligrosas_desc    CLOB          NULL,
  prot_notifica_polizon_desc    CLOB          NULL,
  prot_notifica_rescate_desc    CLOB          NULL,
  prot_notifica_otra_desc       CLOB          NULL,
  agente_pto_llegada_nombre     VARCHAR2(256) NULL,
  agente_pto_llegada_tel        VARCHAR2(256) NULL,
  agente_pto_llegada_mail       VARCHAR2(256) NULL,
  facilitador_nombre            VARCHAR2(256) NULL,
  facilitador_titulo_cargo      VARCHAR2(256) NULL,
  facilitador_lugar             VARCHAR2(256) NULL,
  facilitador_fecha             DATE          NULL,
  id                            INTEGER       NOT NULL,
  proteccion_plan_aprobado      INTEGER       NULL,
  proteccion_nivel_actual       INTEGER       NULL,
  plan_proteccion_mant_bab      INTEGER       NULL,
  carga_sust_peligrosas         INTEGER       NULL,
  lista_pasajeros               INTEGER       NULL,
  prot_notifica_cuestion        INTEGER       NULL,
  prot_notifica_polizon         INTEGER       NULL,
  prot_notifica_rescate         INTEGER       NULL,
  prot_notifica_otra            INTEGER       NULL,
  lista_tripulantes             INTEGER       NULL,
  bandera                       VARCHAR2(256) NULL
)
  STORAGE (
    NEXT       1024 K
  )
/

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

PROMPT ALTER TABLE tbl_pbip ADD FOREIGN KEY
ALTER TABLE tbl_pbip
  ADD FOREIGN KEY (
    viaje_id
  ) REFERENCES tbl_viaje (
    id
  )
/

PROMPT CREATE OR REPLACE TRIGGER tbl_pbip_trigger
CREATE OR REPLACE TRIGGER tbl_pbip_trigger
before insert on tbl_pbip
for each row
begin
select tbl_pbip_seq.nextval into :new.id from dual;
end;
/





/* ***************************************************** */
/* PBIP PARAMS */

PROMPT CREATE TABLE tbl_pbip_params
CREATE TABLE tbl_pbip_params (
  id                        INTEGER NOT NULL,
  tbl_pbip_id               INTEGER NOT NULL,
  tipo_param                INTEGER NOT NULL,
  indice                    INTEGER NOT NULL,
  descripcion               CLOB    NULL,
  nivel_proteccion          INTEGER NULL,
  escalas_medidas_adic      INTEGER NULL,
  escalas_medidas_adic_desc CLOB    NULL,
  actividad_bab             CLOB    NULL,
  fecha_desde               DATE    NULL,
  fecha_hasta               DATE    NULL
)
  STORAGE (
    NEXT       1024 K
  )
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




/* ***************************************************** */
/* VISTA*/
PROMPT CREATE OR REPLACE VIEW view_pbip_listar
CREATE OR REPLACE VIEW view_pbip_listar (
  id,
  nro_imo,
  buque_nombre,
  compania,
  objetivo,
  puerto_llegada,
  eta,
  cipb_estado
) AS
select id, nro_imo, buque_nombre, compania, objetivo, puerto_llegada, eta,
      CASE WHEN  cipb_estado = 1 THEN 'Válido' WHEN  cipb_estado = 2 THEN 'Aprobado' ELSE 'No posee' END cipb_estado
  from tbl_pbip ORDER BY id desc
/

