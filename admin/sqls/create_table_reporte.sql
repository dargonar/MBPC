drop sequence reporte_param_seq;
drop sequence reporte_seq;

drop table tbl_reporte_param;
drop table tbl_reporte;

drop trigger reporte_param_trigger;
drop trigger reporte_trigger;


CREATE TABLE tbl_reporte
    (id                             NUMBER(*,0) NOT NULL,
    nombre                          VARCHAR2(255 BYTE) NOT NULL,
    descripcion                     VARCHAR2(512 BYTE) NULL,
    fecha_creacion                  DATE default SYSDATE,
    consulta_sql                    VARCHAR2(2048) NOT NULL,
  CONSTRAINT PK_TBL_REPORTE
  PRIMARY KEY (id));

create sequence reporte_seq
start with 1
increment by 1
nomaxvalue;

create trigger reporte_trigger
before insert on tbl_reporte
for each row
begin
select reporte_seq.nextval into :new.id from dual;
end;


/* Tabla params de reporte */
CREATE TABLE tbl_reporte_param(
  id               INTEGER      NOT NULL,
  reporte_id       INTEGER      NOT NULL,
  indice           INTEGER      NOT NULL, 
  nombre           VARCHAR2(56 BYTE) NOT NULL,
  tipo_dato        INTEGER      NOT NULL
);
   

ALTER TABLE tbl_reporte_param
  ADD CONSTRAINT pk_tbl_reporte_param PRIMARY KEY (
    id
  )
  USING INDEX;
    

ALTER TABLE tbl_reporte_param
  ADD FOREIGN KEY (
    reporte_id
  ) REFERENCES tbl_reporte (
    id
  );
 

create sequence reporte_param_seq
start with 1
increment by 1
nomaxvalue;

CREATE OR REPLACE TRIGGER reporte_param_trigger
before insert on tbl_reporte_param
for each row
begin
select reporte_param_seq.nextval into :new.id from dual;
end;

