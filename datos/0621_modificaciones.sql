alter table tbl_etapa drop column velocidad;
alter table tbl_posicion add velocidad NUMBER(*,2);
alter table tbl_etapa drop column rumbo;
alter table tbl_posicion add rumbo NUMBER(3,0);
alter table tbl_bq_estados add constraint pk_tbl_estados primary key (cod);
alter table tbl_posicion add estado references tbl_bq_estados;