alter table tbl_etapa
add
(
  created_by         INTEGER
  -- with created_at
);



alter table tbl_viaje
add
(
  created_by         INTEGER,
  updated_by         INTEGER,
  updated_at         DATE
);


alter table tbl_viaje
add
(
  riokm_actual       INTEGER
);