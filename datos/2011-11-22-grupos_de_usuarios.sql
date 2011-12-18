---# borra tutto
drop table tbl_usuariogrupo;
drop table tbl_grupopunto;
drop table tbl_grupo;

drop sequence tbl_grupo_seq;
drop sequence tbl_grupopunto_seq;
drop sequence tbl_usuariogrupo_seq;

---# crea tutto
CREATE TABLE tbl_grupo (
  id             INTEGER        NOT NULL,
  nombre         VARCHAR2(100)      NULL
)

/

ALTER TABLE tbl_grupo
  ADD CONSTRAINT tbl_grupo PRIMARY KEY (
    id
  )
  USING INDEX
    STORAGE (
      NEXT       1024 K
    )
/

CREATE SEQUENCE tbl_grupo_seq
  MINVALUE 1
  MAXVALUE 9999999999999999999999999999
  INCREMENT BY 1
  NOCYCLE
  NOORDER
  CACHE 20
/

CREATE OR REPLACE TRIGGER tbl_grupo_trigger
before insert on tbl_grupo
for each row
begin
select tbl_grupo_seq.nextval into :new.id from dual;
end;
/



#--------------
CREATE TABLE tbl_usuariogrupo (
  id             INTEGER     NOT NULL,
  grupo          INTEGER     NOT NULL,
  usuario        INTEGER     NOT NULL
)

/

ALTER TABLE tbl_usuariogrupo
  ADD CONSTRAINT tbl_usuariogrupo PRIMARY KEY (
    id
  )
  USING INDEX
    STORAGE (
      NEXT       1024 K
    )
/

ALTER TABLE tbl_usuariogrupo
  ADD FOREIGN KEY (
    grupo
  ) REFERENCES tbl_grupo (
    id
  )
  ON DELETE CASCADE
/

ALTER TABLE tbl_usuariogrupo
  ADD FOREIGN KEY (
    usuario
  ) REFERENCES int_usuarios (
    usuario_id
  )
  ON DELETE CASCADE
/

CREATE SEQUENCE tbl_usuariogrupo_seq
  MINVALUE 1
  MAXVALUE 9999999999999999999999999999
  INCREMENT BY 1
  NOCYCLE
  NOORDER
  CACHE 20
/

CREATE OR REPLACE TRIGGER tbl_usuariogrupo_trigger
before insert on tbl_usuariogrupo
for each row
begin
select tbl_usuariogrupo_seq.nextval into :new.id from dual;
end;
/


#--------------
CREATE TABLE tbl_grupopunto (
  id             INTEGER     NOT NULL,
  grupo          INTEGER     NOT NULL,
  punto          INTEGER     NOT NULL,
  orden          INTEGER     DEFAULT 0
)

/

ALTER TABLE tbl_grupopunto
  ADD CONSTRAINT tbl_grupopunto PRIMARY KEY (
    id
  )
  USING INDEX
    STORAGE (
      NEXT       1024 K
    )
/

ALTER TABLE tbl_grupopunto
  ADD FOREIGN KEY (
    grupo
  ) REFERENCES tbl_grupo (
    id
  )
  ON DELETE CASCADE
/

ALTER TABLE tbl_grupopunto
  ADD FOREIGN KEY (
    punto
  ) REFERENCES tbl_puntodecontrol (
    id
  )
  ON DELETE CASCADE
/

CREATE SEQUENCE tbl_grupopunto_seq
  MINVALUE 1
  MAXVALUE 9999999999999999999999999999
  INCREMENT BY 1
  NOCYCLE
  NOORDER
  CACHE 20
/

CREATE OR REPLACE TRIGGER tbl_grupopunto_trigger
before insert on tbl_grupopunto
for each row
begin
select tbl_grupopunto_seq.nextval into :new.id from dual;
end;
/

#
# ARMARDOR INICIAL
#

delete from tbl_grupopunto;
delete from tbl_usuariogrupo;
delete from tbl_grupo;

declare
  theid integer;
  nombre varchar2(100);
  orden integer;
begin

for usrr in ( select distinct(usuario) usr, count(*) cnt from tbl_puntodecontrolusuario where usuario is not null group by usuario  )
loop

  
  select nombres||' '||apellido into nombre from int_usuarios where usuario_id=usrr.usr;

  insert into tbl_grupo (nombre) values (nombre||'#'||usrr.usr) returning id into theid;
  
  insert into tbl_usuariogrupo (usuario, grupo) values (usrr.usr,theid);
  
  orden := 0;
  for pto in (select * from tbl_puntodecontrolusuario where usuario=usrr.usr)
  loop
    insert into tbl_grupopunto (grupo,punto,orden) values ( theid, pto.PUNTODECONTROL,orden);
    orden := orden + 1;
  end loop;
  
end loop;

end;