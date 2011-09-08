alter table rios_canales_km add   (constraint pk_rios_canales_km_id primary key (id));
alter table rios_canales add   (constraint pk_rios_canales primary key (id));

---------------------------------------------------------------------------------
alter table tbl_evento add   id number(*,0);

create sequence evento_seq 
start with 1 
increment by 1 
nomaxvalue;


create or replace trigger evento_trigger
before insert on tbl_evento
for each row
begin
  select evento_seq.nextval into :new.id from dual;
end;
/

update tbl_evento set id = evento_seq.nextval;

alter table tbl_evento add (constraint pk_tbl_evento primary key (id));

---------------------------------------------------------------------------------
alter table tbl_tipocargaunidad add   id number(*,0);



create sequence tipocargaunidad_seq 
start with 1 
increment by 1 
nomaxvalue;

create or replace trigger tipocargaunidad_trigger
before insert on tbl_tipocargaunidad
for each row
begin
select tipocargaunidad_seq.nextval into :new.id from dual;
end;
/

update tbl_evento set id = evento_seq.nextval;

alter table tbl_tipocargaunidad add (constraint pk_tbl_tipocargaunidad primary key (id));

----------------------------------------------------------------------------------------------------

alter table tbl_practicoetapa add   id number(*,0);


create sequence practicoetapa_seq 
start with 1 
increment by 1 
nomaxvalue;

create or replace trigger practicoetapa_trigger
before insert on tbl_practicoetapa
for each row
begin
select practicoetapa_seq.nextval into :new.id from dual;
end;
/

update tbl_practicoetapa set id = practicoetapa_seq.nextval;


alter table tbl_practicoetapa add (constraint pk_tbl_practicoetapa primary key (id));

----------------------------------------------------------------------------------------------------


alter table tbl_conexionpuntodecontrol add   id number(*,0);


create sequence conexionpuntodecontrol_seq 
start with 1 
increment by 1 
nomaxvalue;

create or replace trigger conexionpuntodecontrol_trigger
before insert on tbl_conexionpuntodecontrol
for each row
begin
select conexionpuntodecontrol_seq.nextval into :new.id from dual;
end;
/

update tbl_conexionpuntodecontrol set id = conexionpuntodecontrol_seq.nextval;

alter table tbl_conexionpuntodecontrol add (constraint pk_tbl_conexionpuntodecontrol primary key (id));

----------------------------------------------------------------------------------------------------

alter table tbl_posicion add   id number(*,0);


create sequence posicion_seq 
start with 1 
increment by 1 
nomaxvalue;


create or replace trigger posicion_trigger
before insert on tbl_posicion
for each row
begin
select posicion_seq.nextval into :new.id from dual;
end;
/

update tbl_posicion set id = posicion_seq.nextval;

alter table tbl_posicion add (constraint pk_tbl_posicion primary key (id));

----------------------------------------------------------------------------------------------------
commit;


alter view view_buques add constraint view_buques_pk primary key (matricula) disable;
alter view view_muelles add constraint view_muelles_pk primary key (id) disable;
alter view view_pbip add constraint view_pbip_pk primary key (viaje_id) disable;


    
ALTER TABLE tbl_puntodecontrol
ADD CONSTRAINT fk_rios_canales
FOREIGN KEY (rios_canales_km_id)
REFERENCES rios_canales_km(id);

ALTER TABLE rios_canales_km
ADD CONSTRAINT fk_rio_canal
FOREIGN KEY (id_rio_canal)
REFERENCES rios_canales(id);

    
CREATE VIEW VPUNTO_DE_CONTROL AS 
select tp.ID, 
case WHEN tp.USO<>0 THEN 'MARITIMO' ELSE 'FLUVIAL' END as USO
,zo.CUATRIGRAMA, rc.NOMBRE||' '||rck.UNIDAD||' '||rck.KM CANAL from tbl_puntodecontrol tp
left join RIOS_CANALES_KM rck on tp.RIOS_CANALES_KM_ID=rck.ID
left join RIOS_CANALES  rc on rck.ID_RIO_CANAL=rc.ID
left join TBL_ZONAS  zo on tp.ZONA_ID=zo.ID;
alter view VPUNTO_DE_CONTROL add constraint view_punto_pk primary key (ID) disable;


alter table
    tbl_viaje
 modify
    (
    buque_int_id  number(7,0)
    );



ALTER TABLE tbl_viaje
ADD CONSTRAINT fk_internac
FOREIGN KEY (buque_int_id)
REFERENCES tbl_bq_internac(nroomi);

ALTER TABLE tbl_puntodecontrolusuario
ADD CONSTRAINT fk_tbl_usuario
FOREIGN KEY (usuario)
REFERENCES int_usuarios(usuario_id);


ALTER TABLE tbl_puntodecontrolusuario
ADD CONSTRAINT tbl_puntodecontrolusuario
PRIMARY KEY (id);


create sequence pdc_seq 
start with 100 
increment by 1 
nomaxvalue;


create or replace trigger pdc_trigger
before insert on tbl_puntodecontrol
for each row
begin
select pdc_seq.nextval into :new.id from dual;
end;
/


