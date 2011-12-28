alter table tbl_viaje ADD longitud1 number;
alter table tbl_viaje ADD latitud1 number;

UPDATE tbl_viaje SET latitud1=latitud, longitud1=longitud; 

ALTER TABLE tbl_viaje DROP COLUMN latitud;
ALTER TABLE tbl_viaje DROP COLUMN longitud;

alter table tbl_viaje rename column longitud1 to longitud;
alter table tbl_viaje rename column latitud1 to latitud;
