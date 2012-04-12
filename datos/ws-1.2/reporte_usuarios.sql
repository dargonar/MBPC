CREATE TABLE tbl_reporte_usuario_ext (
  id          INTEGER NOT NULL,
  usuario     VARCHAR2(50),
  reporte_id  INTEGER NOT NULL
)
/

ALTER TABLE tbl_reporte_usuario_ext
  ADD CONSTRAINT pk_repusuario PRIMARY KEY (
    id
  )
/

ALTER TABLE tbl_reporte_usuario_ext
  ADD CONSTRAINT fk_repusuario_reporte FOREIGN KEY (
    reporte_id
  ) REFERENCES tbl_reporte (
    id
  )
/

CREATE SEQUENCE reporte_usuario_seq
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  INCREMENT BY 1
  NOCYCLE
  NOORDER
  CACHE 20
/

CREATE OR REPLACE TRIGGER reporte_usuario_trigger
before insert on tbl_reporte_usuario_ext
for each row
begin
select reporte_usuario_seq.nextval into :new.id from dual;
end;
/

