alter table tmp_buques
add
(
  created_by         INTEGER,
  created_at         DATE,
  final				 INTEGER DEFAULT 0
);
