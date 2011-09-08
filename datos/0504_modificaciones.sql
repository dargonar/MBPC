alter table
   tbl_etapa 
add
   (
    created_at        DATE
   );

alter table
   tbl_evento 
add
   (
    practico_id        number(*,0),
    created_at         DATE default sysdate
   );


alter table
   tbl_etapa
drop column
   practico_id;


alter table
   tbl_practico 
drop column
    etapa_id


ALTER TABLE int_usuarios
ADD CONSTRAINT pk_usuario_id
PRIMARY KEY (usuario_id);



drop sequence practico_seq;

create sequence practico_seq 
start with 1 
increment by 1 
nomaxvalue;

create or replace trigger practico_trigger
before insert on tbl_practico
for each row
begin
select practico_seq.nextval into :new.id from dual;
end;





insert into tbl_tipoevento VALUES (16, 'Agregar practico');
insert into tbl_tipoevento VALUES (17, 'Quitar practico');
insert into tbl_tipoevento VALUES (18, 'Cambiar Practico Activo');

ALTER TABLE tbl_bq_internac
ADD CONSTRAINT pk_omi
PRIMARY KEY (nroomi);


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
SELECT TO_CHAR(NROOMI) matricula,  
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




