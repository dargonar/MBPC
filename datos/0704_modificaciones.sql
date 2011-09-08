alter table tbl_puntodecontrol add entrada number(1,0);
alter table tbl_evento add 
(
 estado varchar(2),
 velocidad number(*,2),
 rumbo number(3,0),
 rios_canales_km_id references rios_canales_km
);

insert into tbl_tipoevento (id,descripcion,tipo) values (19, 'Agregar Reporte', 1);
insert into tbl_tipoevento (id,descripcion,tipo) values (20, 'Cambio de estado', 1);
drop table tbl_posicion;

alter table tbl_viaje add rios_canales_km_id number(*,0);
--ALTER TABLE tbl_viaje
--ADD CONSTRAINT fk_riocanal
--FOREIGN KEY (rios_canales_km_id)
--REFERENCES rios_canales_km(id);

