alter table tbl_puntodecontrol add
(
  tipo  		NUMBER  NULL,
  puerto_id		VARCHAR2(3) NULL
);

ALTER TABLE tbl_kstm_puertos
  ADD CONSTRAINT id_pto_kstm2 PRIMARY KEY (
   cod
  )
/

ALTER TABLE tbl_puntodecontrol 
  ADD FOREIGN KEY (
    puerto_id
  ) REFERENCES tbl_kstm_puertos (
    cod
  )
/



