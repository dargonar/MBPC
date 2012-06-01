alter table tbl_evento
add
(
  latitud2            NUMBER NULL,
  longitud2           NUMBER NULL
);

UPDATE tbl_evento SET latitud2=latitud, longitud2=longitud;

ALTER TABLE tbl_evento DROP ( latitud, longitud );

ALTER TABLE tbl_evento RENAME COLUMN latitud2 TO latitud;
ALTER TABLE tbl_evento RENAME COLUMN longitud2 TO longitud;
