ALTER TABLE tbl_reporte ADD categoria_id INTEGER;


CREATE TABLE tbl_reportecategoria (
  id                 INTEGER        NOT NULL,
  nombre             VARCHAR2(64),
  created_at         DATE           DEFAULT SYSDATE
)
  STORAGE (
    NEXT       1024 K
  )
/

ALTER TABLE tbl_reportecategoria
  ADD CONSTRAINT pk_tbl_reportecategoria PRIMARY KEY (
    id
  )
  USING INDEX
    STORAGE (
      NEXT       1024 K
    )
/

CREATE SEQUENCE reportecategoria_seq
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  INCREMENT BY 1
  NOCYCLE
  NOORDER
  CACHE 20
/

CREATE OR REPLACE TRIGGER reportecategoria_trigger
before insert on tbl_reportecategoria
for each row
begin
select reportecategoria_seq.nextval into :new.id from dual;
end;
/

ALTER TABLE tbl_reporte
  ADD FOREIGN KEY (
    categoria_id
  ) REFERENCES tbl_reportecategoria (
    id
  )
/

INSERT INTO tbl_reportecategoria (nombre) VALUES ('General');
UPDATE tbl_reporte SET categoria_id=1;


ALTER TABLE tbl_reporte ADD consulta_sql2 CLOB;
UPDATE tbl_reporte SET consulta_sql2=consulta_sql;
ALTER TABLE tbl_reporte DROP COLUMN consulta_sql;
ALTER TABLE tbl_reporte rename COLUMN consulta_sql2 TO consulta_sql;
