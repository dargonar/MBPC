prompt tbl_viaje

CREATE TABLE tbl_viaje
    (id                             NUMBER(*,0) NOT NULL,
    origen_id                       references tbl_muelles,
    destino_id                      references tbl_muelles,
    buque_id                        references tbl_bq_buques,
    buque_int_id                    VARCHAR2(255 BYTE),
    fecha_salida                    DATE, 
    fecha_llegada                   DATE,
    eta                             DATE,
    zoe                             DATE,
    etapa_actual                    NUMBER(*,0) default 0,
    estado                          NUMBER(*,0) default 0,
    notas                           VARCHAR2(2048 BYTE)
  ,
  CONSTRAINT PK_TBL_VIAJES
  PRIMARY KEY (id))
  TABLESPACE  mbpc;

prompt viaje_seq viaje_trigger tbl_practico

create sequence viaje_seq 
start with 1 
increment by 1 
nomaxvalue;


create trigger viaje_trigger
before insert on tbl_viaje
for each row
begin
select viaje_seq.nextval into :new.id from dual;
end;



CREATE TABLE tbl_practico
    (id                             NUMBER(*,0) NOT NULL,
    nombre                            VARCHAR2(255 BYTE)
  ,
  CONSTRAINT PK_TBL_PRACTICO
  PRIMARY KEY (id))
  TABLESPACE  mbpc;


prompt tbl_capitan

CREATE TABLE tbl_capitan
    (id                             NUMBER(*,0) NOT NULL,
    nombre                            VARCHAR2(255 BYTE)
  ,
  CONSTRAINT PK_TBL_CAPITAN
  PRIMARY KEY (id))
  TABLESPACE  mbpc;


prompt tbl_puntodecontrol

CREATE TABLE tbl_puntodecontrol
    (
      id                           NUMBER(6,0),
      canal                        VARCHAR2(255 BYTE),
      km                           VARCHAR2(255 BYTE),
      zona_id                      references tbl_zonas
      ,
      CONSTRAINT PK_TBL_puntodecontrol
      PRIMARY KEY (id)      
    )
  TABLESPACE  mbpc;



prompt tbl_etapa

CREATE TABLE tbl_etapa
    (id                             NUMBER(*,0) NOT NULL,
    nro_etapa                       NUMBER(*,0) NOT NULL,
    viaje_id                        references tbl_viaje,
    origen_id                       references tbl_puntodecontrol,
    actual_id                       references tbl_puntodecontrol,
    destino_id                      references tbl_puntodecontrol,
    --carga_id                         references tbl_cargaetapa,
    velocidad                       NUMBER(*,0),
    hrp                             DATE,
    eta                             DATE,
    fecha_salida                    DATE, 
    fecha_llegada                   DATE,
    cantidad_tripulantes            NUMBER(*,0),
    cantidad_pasajeros              NUMBER(*,0),
    practico_id                     references tbl_practico,
    capitan_id                      references tbl_capitan,
    sentido                         NUMBER(1,0),
    calado_proa                     NUMBER(*,0),
    calado_popa                     NUMBER(*,0),
    calado_maximo                   NUMBER(*,0),
    calado_informado                NUMBER(*,0),
    latitud                         NUMBER(*,0),
    longitud                        NUMBER(*,0),
    km                              NUMBER(*,0),
    rumbo                           VARCHAR2(255 BYTE),
  CONSTRAINT PK_TBL_ETAPA
  PRIMARY KEY (id))
  TABLESPACE  mbpc;


prompt tbl_cargaetapa

CREATE TABLE tbl_cargaetapa
    (
    id                              NUMBER(*,0) NOT NULL,
    tipocarga_id                    references tbl_tipo_carga NOT NULL,
    cantidad                        NUMBER(*,0) NOT NULL,
    unidad_id                       references tbl_unidad NOT NULL,
    etapa_id                        references tbl_etapa NOT NULL,
    buque_id                      references tbl_bq_buques
  ,
  CONSTRAINT PK_TBL_CARGAETAPA
  PRIMARY KEY (id))
  TABLESPACE  mbpc;


prompt pdcu_seq carga_seq

drop sequence pdcu_seq;

create sequence pdcu_seq 
start with 1 
increment by 1 
nomaxvalue;

create or replace trigger pdcu_trigger
before insert on tbl_puntodecontrolusuario
for each row
begin
select pdcu_seq.nextval into :new.id from dual;
end;



drop sequence carga_seq;

create sequence carga_seq 
start with 1 
increment by 1 
nomaxvalue;

create or replace trigger carga_trigger
before insert on tbl_cargaetapa
for each row
begin
select carga_seq.nextval into :new.id from dual;
end;


prompt tbl_tipoevento

CREATE TABLE tbl_tipoevento
    (id                             NUMBER(*,0) NOT NULL,
    descripcion                     VARCHAR2(255 BYTE)
  ,
  CONSTRAINT PK_TBL_tipoevento
  PRIMARY KEY (id))
  TABLESPACE  mbpc;


prompt tbl_evento

CREATE TABLE tbl_evento
    (
    usuario_id                      NUMBER(*,0),
    viaje_id                        NUMBER(*,0),
    etapa_id                        references tbl_etapa,
    tipo_id                         references tbl_tipoevento,
    fecha                           DATE,
    buque_id                        VARCHAR2(255 BYTE),
    buque_int_id                    VARCHAR2(255 BYTE),
    carga_id                        NUMBER(*,0),
    puntodecontrol1_id              NUMBER(*,0),
    puntodecontrol2_id              NUMBER(*,0),
    muelle_id                       NUMBER(*,0),
    barcaza_id                      VARCHAR2(10),
    comentario                      VARCHAR2(255 BYTE)
  )
  TABLESPACE  mbpc;


prompt tbl_conexionpuntodecontrol tbl_pbip

CREATE TABLE tbl_conexionpuntodecontrol
    (
      puntodecontrol1                 NUMBER(6,0),
      puntodecontrol2                 NUMBER(6,0),
      aguasarriba                     NUMBER(1,0),
      peso                            NUMBER(*,0)
    )
  TABLESPACE  mbpc;


CREATE TABLE tbl_pbip
    (
      viaje_id                        references tbl_viaje,
      puertodematricula               VARCHAR2(255 BYTE),
      nroinmarsat                     VARCHAR2(255 BYTE),
      arqueobruto                     VARCHAR2(255 BYTE),
      compania                        VARCHAR2(255 BYTE),
      contactoOCPM                    VARCHAR2(255 BYTE),
      objetivo                       VARCHAR2(255 BYTE),
      CONSTRAINT PK_TBL_PBIP
      PRIMARY KEY (viaje_id))

  TABLESPACE  mbpc;


prompt tbl_puntodecontrolusuario
CREATE TABLE tbl_puntodecontrolusuario
    (
      id                             NUMBER(*,0) NOT NULL,
      puntodecontrol                 references tbl_puntodecontrol,
      usuario                        NUMBER(*,0)
    )
  TABLESPACE mbpc;

prompt tbl_conexionpuntodecontrol
ALTER TABLE tbl_conexionpuntodecontrol
ADD CONSTRAINT fk_puntodecontrol1
FOREIGN KEY (puntodecontrol1)
REFERENCES tbl_puntodecontrol(id);

prompt tbl_conexionpuntodecontrol

ALTER TABLE tbl_conexionpuntodecontrol
ADD CONSTRAINT fk_puntodecontrol2
FOREIGN KEY (puntodecontrol2)
REFERENCES tbl_puntodecontrol(id);


prompt etapa_seq

drop sequence etapa_seq;

create sequence etapa_seq 
increment by 1
start with 1
nomaxvalue;


prompt etapa_trigger

create or replace trigger etapa_trigger
before insert on tbl_etapa
for each row
begin
select etapa_seq.nextval into :new.id from dual;
end;


prompt muelle_seq

drop sequence muelle_seq;

create sequence muelle_seq 
start with 100 
increment by 1 
nomaxvalue;



prompt muelle_trigger

create or replace trigger muelle_trigger
before insert on tbl_muelles
for each row
begin
select muelle_seq.nextval into :new.id from dual;
end;


prompt etapa_sentido_insert

create or replace trigger etapa_sentido_insert
before insert on tbl_etapa
for each row
declare
cxz tbl_conexionpuntodecontrol%ROWTYPE;
etp number;
begin

  --CASO DE INSERT EN PRIMERA ETAPA COMO ORIGEN ES NULL SE TOMA COMO UPDATE (buscando el sentido del trayecto de la etapa actual al primer destino)
  if :new.sentido is NULL then
    if :new.origen_id IS NULL then
        --ETAPA INICIAL
        :new.nro_etapa := 0;
        --COPIA EL SENTIDO DEL TRAYECTO DE LA MATRIZ A LA ETAPA
        select * into cxz from tbl_conexionpuntodecontrol cx where (cx.puntodecontrol1 = :new.actual_id and cx.puntodecontrol2 = :new.destino_id) OR (cx.puntodecontrol1 = :new.destino_id and cx.puntodecontrol2 = :new.actual_id);

        IF (cxz.puntodecontrol1 = :new.actual_id) THEN
          :new.sentido := cxz.aguasarriba;
        ELSE 
          IF (cxz.aguasarriba = 0) THEN
            :new.sentido := 1;
          ELSE
            :new.sentido := 0;
          END IF;
        END IF;
    else
      --ETAPA SIGUIENTE
      select MAX(nro_etapa) + 1 into etp from tbl_etapa where viaje_id = :new.viaje_id;
      :new.nro_etapa := etp;
      UPDATE tbl_viaje SET etapa_actual = etp where id = :new.viaje_id;
      
      --COPIA EL SENTIDO DEL TRAYECTO DE LA MATRIZ A LA ETAPA 
      select * into cxz from tbl_conexionpuntodecontrol cx where (cx.puntodecontrol1 = :new.origen_id and cx.puntodecontrol2 = :new.actual_id) OR (cx.puntodecontrol1 = :new.actual_id and cx.puntodecontrol2 = :new.origen_id);
      
      IF (cxz.puntodecontrol1 = :new.origen_id) THEN
        :new.sentido := cxz.aguasarriba;
      ELSE 
        IF (cxz.aguasarriba = 0) THEN
          :new.sentido := 1;
        ELSE
          :new.sentido := 0;
        END IF;
      END IF;
    end if;
  end if;
  
  
  
  
end etapa_sentido_insert;


prompt etapa_sentido_update

create or replace trigger etapa_sentido_update
before update of destino_id on tbl_etapa
for each row
declare
cxz tbl_conexionpuntodecontrol%ROWTYPE;
begin
  select * into cxz from tbl_conexionpuntodecontrol cx where (cx.puntodecontrol1 = :new.actual_id and cx.puntodecontrol2 = :new.destino_id) OR (cx.puntodecontrol1 = :new.destino_id and cx.puntodecontrol2 = :new.actual_id);

  IF (cxz.puntodecontrol1 = :new.actual_id) THEN
    :new.sentido := cxz.aguasarriba;
  ELSE 
    IF (cxz.aguasarriba = 0) THEN
      :new.sentido := 1;
    ELSE
      :new.sentido := 0;
    END IF;
  END IF;
end etapa_sentido_update;


prompt default_instport_muelles

create or replace trigger default_instport_muelles
after insert on tbl_puertos
for each row
--declare
--cxz tbl_conexionpuntodecontrol%ROWTYPE;
begin
  insert into tbl_insta_puert (id_puerto, 
                              nombre, 
                              puerto, 
                              direccion, 
                              provincia, 
                              contacto, 
                              eval_riesgo, 
                              plan_protect, 
                              decl_cumpl,
                              operatoria,
                              buques, 
                              spa, 
                              localidad,
                              cargo_responsable, 
                              apellido_responsable, 
                              usu_alta, 
                              f_usu_alta, 
                              puerto_id)
  VALUES (                    :new.id,
                             :new.nombre, 
                             '--',
                             '--',
                             'A', 
                             '--',
                             '--',
                             '--',
                             '--',
                             '--', 
                             123, 
                             'sp', 
                             '--', 
                             '--',
                             '--',
                             '--', 
                             SYSDATE, 
                             :new.id);  
  Insert into tbl_muelles
     (ID, PUERTO_ID, INSTA_PORT, TIPO_NAV_ID, TIPO_CARG_ID, DESCRIPCION)
   Values
     (muelle_seq.nextval, :new.id, :new.id, 0, 0, :new.nombre);                             
end default_instport_muelles;


alter table
   tbl_bq_buques
add
   (
    sdist varchar2(255 BYTE),
    arqueo_neto NUMBER(*,0),
    arqueo_total NUMBER(*,0),
    provisorio varchar2(13)
   );
   
alter table
   tbl_bq_internac
add
   (
    inscrip_provisoria varchar2(15),
    sdist varchar2(255 BYTE)
   );


prompt view_buques view_muelles view_pbip

CREATE or replace VIEW view_buques as
SELECT MATRICULA matricula,     
      NRO_OMI nro_omi, 
      NOMBRE nombre,
      TO_CHAR(NULL) bandera,
      TO_CHAR(ANIO_CONSTRUCCION) anio_construccion,
      TO_CHAR(ESTADO_REG) estado_reg,
      NRO_ISMM nro_ismm,
      TO_CHAR(FECHA_INSCRIP) fecha_inscrip,
      EXPTE_INSCRIP expte_inscrip,
      ASTILL_PARTIC astill_partic,
      INSCRIP_PROVISORIA inscrip_provisoria,
      VARIANTE variante,
      IMPNAC impnac,
      VALOR valor,
      CAUSA_ELIMINACION causa_eliminacion,
      EXPTE_ELIMINACION expte_eliminacion,
      TO_CHAR(FECHA_ELIMINACION) fecha_eliminacion,
      ACTUALIZACION_USUARIO actualizacion_usuario,
      TO_CHAR(ACTUALIZACION_FECHA) actualizacion_fecha,
      REGISTRO registro,
      ELIMINACION eliminacion,
      TO_CHAR(TIPO_BUQUE) tipo_buque,
      TO_CHAR(TIPO_SERVICIO) tipo_servicio,
      TO_CHAR(TIPO_EXPLOTACION) tipo_explotacion,
      TO_CHAR(ARBOLADURA_ID) arboladura_id,
      TO_CHAR(BUQUE_ID) buque_id,
      SDIST sdist,
      TO_CHAR(ARQUEO_NETO) arqueo_neto,
      TO_CHAR(ARQUEO_TOTAL) arqueo_total,
      TO_CHAR(NULL) sociedadclasif,
      TO_CHAR(NULL) estado,
      TO_CHAR(NULL) tonelajebr,
      TO_CHAR(NULL) pesomuerto,
      TO_CHAR(NULL) distllam,
      TO_CHAR(NULL) nroomicia,
      TO_CHAR(NULL) nombrecia,
      TO_CHAR(NULL) paisregcia,
      TO_CHAR(NULL) codarmador,
      TO_CHAR(NULL) armador,
      TO_CHAR(NULL) paisarmador,
      TO_CHAR(NULL) codpropiet,
      TO_CHAR(NULL) propietario,
      TO_CHAR(NULL) paisregisprop,
      'nacional'    tipo from TBL_BQ_BUQUES UNION
SELECT TO_CHAR(MMSI) matricula,  
      NROOMI nro_omi,
      NOMBRE nombre,
      BANDERA bandera,
      ANIOCONSTR anio_construccion,
      TO_CHAR(NULL) estado_reg,
      MMSI nro_ismm,
      TO_CHAR(NULL) fecha_inscrip,
      TO_CHAR(NULL) expte_inscrip,
      TO_CHAR(NULL) astill_partic,
      INSCRIP_PROVISORIA inscrip_provisoria,
      TO_CHAR(NULL) variante,
      TO_CHAR(NULL) impnac,
      TO_CHAR(NULL) valor,
      TO_CHAR(NULL) causa_eliminacion,
      TO_CHAR(NULL) expte_eliminacion,
      TO_CHAR(NULL) fecha_eliminacion,
      TO_CHAR(NULL) actualizacion_usuario,
      TO_CHAR(NULL) actualizacion_fecha,
      TO_CHAR(NULL) registro,
      TO_CHAR(NULL) eliminacion,
      TIPOBUQUE tipo_buque,
      TO_CHAR(NULL) tipo_servicio,
      TO_CHAR(NULL) tipo_explotacion,
      TO_CHAR(NULL) arboladura_id,
      TO_CHAR(NULL) buque_id,
      SDIST sdist,
      TO_CHAR(NULL) arqueo_neto,
      TO_CHAR(NULL) arqueo_total,
      SOCIEDADCLASIF sociedadclasif,
      ESTADO estado,
      TONELAJEBR tonelajebr,
      PESOMUERTO pesomuerto,
      DISTLLAM distllam,
      TO_CHAR(NROOMICIA) nroomicia,
      NOMBRECIA nombrecia,
      PAISREGCIA paisregcia,
      TO_CHAR(CODARMADOR) codarmador,
      TO_CHAR(ARMADOR) armador,
      PAISARMADOR paisarmador,
      TO_CHAR(CODPROPIET) codpropiet,
      PROPIETARIO propietario,
      PAISREGISPROP paisregisprop,
      'internacional' tipo from TBL_BQ_INTERNAC;

CREATE or replace VIEW view_muelles as
select m.id, p.nombre nombre_p, ip.nombre nombre_ip, m.descripcion nombre_m from tbl_muelles m left join tbl_insta_puert ip on m.insta_port = ip.id_puerto left join tbl_puertos p on ip.puerto_id = p.id;


CREATE or replace VIEW view_pbip as
  select pbip.viaje_id, b.nro_omi, b.nombre buque, pbip.puertodematricula, b.bandera_id, b.tipo_buque, b.sdist, pbip.nroinmarsat, pbip.arqueobruto, pbip.compania, pbip.contactoOCPM, p.nombre puerto, ip.nombre instport, v.eta, v.id viaje, pbip.objetivo
  from tbl_viaje v
  left join tbl_bq_buques b on v.buque_id = b.matricula
  left join tbl_muelles m on v.destino_id = m.id
  left join tbl_insta_puert ip on m.insta_port = ip.id_puerto
  left join tbl_puertos p on p.id = m.puerto_id
  left join tbl_pbip pbip on pbip.viaje_id = v.id;


prompt tbl_tipocargaunidad

CREATE TABLE tbl_tipocargaunidad
    (
      tipocarga_id                   references tbl_tipo_carga,
      unidad_id                      references tbl_unidad
    )
  TABLESPACE  mbpc;

--CREATE or replace VIEW view_tipocargas as
--select m.nombre, u.nombre from tbl_tipo_carga m left join tbl_tipocargaunidad cu on m.id = cu.tipocarga_id left join tbl_unidad on cu.unidad_id = u.id;
--
prompt altertbl_bq_buques