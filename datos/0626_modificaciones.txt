update tbl_posicion set velocidad = null;
commit;
alter table tbl_posicion drop column velocidad;
alter table tbl_posicion add velocidad number (*,2);