alter table tbl_evento add
(
  updated_at                    DATE          DEFAULT sysdate NULL,
  updated_by                    NUMBER        NULL
);

--                     left join vw_int_usuarios u on v.updated_by = u.ndoc