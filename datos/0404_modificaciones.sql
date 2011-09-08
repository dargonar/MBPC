DROP TABLE tbl_practicoetapa
/
CREATE TABLE tbl_practicoetapa
    (
    practico_id                   references tbl_practico,
    etapa_id                      references tbl_etapa,
    activo                        number(1,0)
    )
  TABLESPACE  mbpc
/
