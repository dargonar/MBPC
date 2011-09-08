alter table
   tbl_puntodecontrol 
add   rios_canales_km_id        number(*,0);
   
alter table
    tbl_puntodecontrol
drop column canal;
alter table
    tbl_puntodecontrol
drop column km;
  
update tbl_puntodecontrol set rios_canales_km_id = 1;
commit;

alter table
   tbl_viaje
add   latitud        number(*,8);

alter table
   tbl_viaje
add   longitud       number(*,8);

alter table
  tbl_etapa
drop column latitud;

alter table
  tbl_etapa
drop column longitud;

CREATE TABLE tbl_posicion
 (	
  viaje_id references tbl_viaje,
  etapa_id references tbl_etapa,
  latitud   NUMBER(*,8),
  longitud  NUMBER(*,8),
  created_at date
 ) 
TABLESPACE "MBPC" ;

alter table tbl_tipoevento add tipo number (1,0);
update tbl_tipoevento set tipo = 0;
commit;

insert into tbl_tipoevento VALUES (80, 'Evento1', 1);
insert into tbl_tipoevento VALUES (81, 'Evento2', 1);
insert into tbl_tipoevento VALUES (82, 'Evento3', 1);
insert into tbl_tipoevento VALUES (83, 'Evento4', 1);
insert into tbl_tipoevento VALUES (84, 'Evento5', 1);
insert into tbl_tipoevento VALUES (85, 'Evento6', 1);
insert into tbl_tipoevento VALUES (86, 'Evento7', 1);
insert into tbl_tipoevento VALUES (87, 'Evento8', 1);
insert into tbl_tipoevento VALUES (88, 'Evento9', 1);
insert into tbl_tipoevento VALUES (89, 'Evento10', 1);

alter table tbl_evento add latitud number (*,8);
alter table tbl_evento add longitud number (*,8);

alter table rios_canales_km add unidad varchar (10 BYTE);

alter table tbl_viaje add created_at date;