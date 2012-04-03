

CREATE TABLE tbl_codigo_malvinas (
  id                INTEGER        NOT NULL,
  codigo            VARCHAR2(5)    NOT NULL,
  descripcion       VARCHAR2(512)  NOT NULL,
  tipo              INTEGER        NOT NULL
)
  STORAGE (
    NEXT       1024 K
  )
/

PROMPT CREATE SEQUENCE tbl_codigo_malvinas_seq
CREATE SEQUENCE tbl_codigo_malvinas_seq
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  INCREMENT BY 1
  NOCYCLE
  NOORDER
  CACHE 20
/


PROMPT ALTER TABLE tbl_codigo_malvinas ADD CONSTRAINT pk_tbl_codigo_malvinas PRIMARY KEY
ALTER TABLE tbl_codigo_malvinas
  ADD CONSTRAINT pk_tbl_codigo_malvinas PRIMARY KEY (
    id
  )
  USING INDEX
    STORAGE (
      NEXT       1024 K
    )
/

PROMPT CREATE OR REPLACE TRIGGER tbl_codigo_malvinas_trigger
CREATE OR REPLACE TRIGGER tbl_codigo_malvinas_trigger
before insert on tbl_codigo_malvinas
for each row
begin
select tbl_codigo_malvinas_seq.nextval into :new.id from dual;
end;
/


/* INSERT */

INSERT INTO tbl_codigo_malvinas(codigo, descripcion, tipo)
  VALUES ('A', 'Va a malvinas: Tiene autorización de la CPER', 1);
INSERT INTO tbl_codigo_malvinas(codigo, descripcion, tipo)
  VALUES ('Z', 'Va a malvinas: No tiene autorización de la CPER', 1);
INSERT INTO tbl_codigo_malvinas(codigo, descripcion, tipo)
  VALUES ('P', 'Va a malvinas: Se ordenó fondeo - No tiene autorización', 1);
INSERT INTO tbl_codigo_malvinas(codigo, descripcion, tipo)
  VALUES ('R', 'Va a malvinas: Reinicia navegación - Tiene autorización', 1);

INSERT INTO tbl_codigo_malvinas(codigo, descripcion, tipo)
  VALUES ('B', 'No va a malvinas', 1);
INSERT INTO tbl_codigo_malvinas(codigo, descripcion, tipo)
  VALUES ('K', 'No va a malvinas: Reinicia navegación - Presentó DDJJ', 1);
INSERT INTO tbl_codigo_malvinas(codigo, descripcion, tipo)
  VALUES ('J', 'No va a malvinas: Presentó DDJJ', 1);
INSERT INTO tbl_codigo_malvinas(codigo, descripcion, tipo)
  VALUES ('N', 'No va a malvinas: No presentó DDJJ', 1);
INSERT INTO tbl_codigo_malvinas(codigo, descripcion, tipo)
  VALUES ('E', 'No va a malvinas: Exceptuado, navegación RADA-RIA o costera', 1);  
INSERT INTO tbl_codigo_malvinas(codigo, descripcion, tipo)
  VALUES ('X', 'No va a malvinas: Exceptuado, por otros motivos', 1);  
INSERT INTO tbl_codigo_malvinas(codigo, descripcion, tipo)
  VALUES ('G', 'No va a malvinas: Exceptuado, giro interior puerto - misma jurisd.', 1);  
  

INSERT INTO tbl_codigo_malvinas(codigo, descripcion, tipo)
  VALUES ('M', 'Viene de Malvinas: Tiene autorización de la CPER', 0);
INSERT INTO tbl_codigo_malvinas(codigo, descripcion, tipo)
  VALUES ('V', 'Viene de Malvinas: Solicitó autorización (Amarra en el país)', 0);
INSERT INTO tbl_codigo_malvinas(codigo, descripcion, tipo)
  VALUES ('Y', 'Viene de Malvinas: No solicitó autorización (Amarra en el país)', 0);
INSERT INTO tbl_codigo_malvinas(codigo, descripcion, tipo)
  VALUES ('I', 'Viene de Malvinas: Se ordenó fondeo - No tiene autorización', 0);
INSERT INTO tbl_codigo_malvinas(codigo, descripcion, tipo)
  VALUES ('R', 'Viene de Malvinas: Reinicia navegación - Tiene autorización', 0);

INSERT INTO tbl_codigo_malvinas(codigo, descripcion, tipo)
  VALUES ('L', 'No viene de Malvinas', 0);
  
INSERT INTO tbl_codigo_malvinas(codigo, descripcion, tipo)
  VALUES ('T', 'Transita a Malvinas: Solicitó autorización', 0);
INSERT INTO tbl_codigo_malvinas(codigo, descripcion, tipo)
  VALUES ('O', 'Transita a Malvinas: No solicitó autorización', 0);
INSERT INTO tbl_codigo_malvinas(codigo, descripcion, tipo)
  VALUES ('C', 'Transita a Malvinas: Tiene autorización CPER', 0);

/* ALTERS */
alter table tbl_viaje add( codigo_malvinas_inicio         INTEGER          NULL);
alter table tbl_viaje add( codigo_malvinas_final          INTEGER          NULL);
ALTER TABLE tbl_viaje
  ADD CONSTRAINT fk_codigo_malvinas_inicio
  FOREIGN KEY (codigo_malvinas_inicio)
  REFERENCES tbl_codigo_malvinas(id);
  
ALTER TABLE tbl_viaje
  ADD CONSTRAINT fk_codigo_malvinas_final
  FOREIGN KEY (codigo_malvinas_final)
  REFERENCES tbl_codigo_malvinas(id);