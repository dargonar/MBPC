-- acompanante
ALTER TABLE tbl_etapa ADD acompanante2_id  NUMBER(10,0) NULL;
ALTER TABLE tbl_etapa ADD acompanante3_id  NUMBER(10,0) NULL;
ALTER TABLE tbl_etapa ADD acompanante4_id  NUMBER(10,0) NULL;

ALTER TABLE tbl_evento ADD acompanante2_id NUMBER(10,0);
ALTER TABLE tbl_evento ADD acompanante3_id NUMBER(10,0);
ALTER TABLE tbl_evento ADD acompanante4_id NUMBER(10,0);

----------
-- cantidad cambio de tipo
ALTER TABLE tbl_cargaetapa ADD cantidad_f NUMBER DEFAULT 0 NOT NULL;
ALTER TABLE tbl_cargaetapa ADD cantidad_inicial_f NUMBER DEFAULT 0 NOT NULL;    
ALTER TABLE tbl_cargaetapa ADD cantidad_entrada_f NUMBER DEFAULT 0 NOT NULL;
ALTER TABLE tbl_cargaetapa ADD cantidad_salida_f NUMBER DEFAULT 0 NOT NULL;

UPDATE tbl_cargaetapa SET cantidad_f=cantidad, cantidad_inicial_f=cantidad_inicial, cantidad_entrada_f=cantidad_entrada, cantidad_salida_f=cantidad_salida;

ALTER TABLE tbl_cargaetapa DROP COLUMN cantidad;
ALTER TABLE tbl_cargaetapa DROP COLUMN cantidad_inicial;
ALTER TABLE tbl_cargaetapa DROP COLUMN cantidad_entrada;
ALTER TABLE tbl_cargaetapa DROP COLUMN cantidad_salida;

ALTER TABLE tbl_cargaetapa RENAME COLUMN cantidad_f TO cantidad;
ALTER TABLE tbl_cargaetapa RENAME COLUMN cantidad_inicial_f TO cantidad_inicial;
ALTER TABLE tbl_cargaetapa RENAME COLUMN cantidad_entrada_f TO cantidad_entrada;
ALTER TABLE tbl_cargaetapa RENAME COLUMN cantidad_salida_f TO cantidad_salida;

-----
-- practicos

CREATE TABLE tbl_practicoviaje (
  id                 INTEGER        NOT NULL,
  fecha_subida       DATE           NULL,
  fecha_bajada       DATE           NULL,
  etapa_subida       INTEGER        NULL,
  etapa_bajada       INTEGER        NULL,
  viaje_id           INTEGER        NULL,
  created_at         DATE           NULL
)
  STORAGE (
    NEXT       1024 K
  )
/

ALTER TABLE tbl_practicoviaje
  ADD CONSTRAINT pk_tbl_practicoviaje PRIMARY KEY (
    id
  )
  USING INDEX
    STORAGE (
      NEXT       1024 K
    )
/

PROMPT CREATE SEQUENCE practicoviaje_seq
CREATE SEQUENCE practicoviaje_seq
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  INCREMENT BY 1
  NOCYCLE
  NOORDER
  CACHE 20
/

CREATE OR REPLACE TRIGGER practicoviaje_trigger
before insert on tbl_practicoviaje
for each row
begin
select practicoviaje_seq.nextval into :new.id from dual;
end;
/

ALTER TABLE tbl_practicoviaje
  ADD FOREIGN KEY (
    etapa_subida
  ) REFERENCES tbl_etapa (
    id
  )
/

ALTER TABLE tbl_practicoviaje
  ADD FOREIGN KEY (
    etapa_bajada
  ) REFERENCES tbl_etapa (
    id
  )
/

ALTER TABLE tbl_practicoviaje
  ADD FOREIGN KEY (
    viaje_id
  ) REFERENCES tbl_viaje (
    id
  )
/

alter table tbl_practicoviaje add practico_id integer;

ALTER TABLE tbl_practicoviaje
  ADD FOREIGN KEY (
    practico_id
  ) REFERENCES tbl_practico (
    id
  )
/

alter table tbl_practicoviaje add activo        integer;
alter table tbl_practicoviaje add fecha_activo  integer;
alter table tbl_practicoviaje add total         integer;

--tipo eventos
UPDATE tbl_tipoevento SET descripcion='Bajar practico' WHERE id=17;

--chau tabla vieja de practicoetapa
DROP TABLE tbl_practicoetapa;

--
CREATE TABLE tbl_registrousuario (
  id                 INTEGER        NOT NULL,
  usuario_id         INTEGER        NOT NULL,
  login              INTEGER,
  created_at         DATE          DEFAULT sysdate NULL
)
  STORAGE (
    NEXT       1024 K
  )
/

ALTER TABLE tbl_registrousuario
  ADD CONSTRAINT pk_tbl_registrousuario PRIMARY KEY (
    id
  )
  USING INDEX
    STORAGE (
      NEXT       1024 K
    )
/

CREATE SEQUENCE registrousuario_seq
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  INCREMENT BY 1
  NOCYCLE
  NOORDER
  CACHE 20
/

CREATE OR REPLACE TRIGGER registrousuario_trigger
before insert on tbl_registrousuario
for each row
begin
select registrousuario_seq.nextval into :new.id from dual;
end;
/