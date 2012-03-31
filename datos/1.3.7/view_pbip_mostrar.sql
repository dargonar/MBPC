PROMPT CREATE OR REPLACE VIEW view_pbip_listar
CREATE OR REPLACE VIEW view_pbip_listar (
  id,
  costera,
  nombre,
  imo,
  bandera,
  eta,
  puerto_llegada,
  procedencia,
  nivel_proteccion_actual,
  cipb_expiracion
) AS
select p.id, u.destino costera, p.buque_nombre nombre, p.nro_imo, p.bandera, p.eta, p.puerto_llegada,
       pm.descripcion procedencia, p.proteccion_nivel_actual, p.cipb_expiracion
  from tbl_pbip p
  LEFT JOIN vw_int_usuarios u on p.created_by=u.ndoc
  LEFT JOIN tbl_pbip_params pm ON pm.tbl_pbip_id=p.id AND pm.tipo_param=0 AND pm.indice=1
  ORDER BY p.created_at
/

