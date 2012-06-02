PROMPT CREATE OR REPLACE VIEW vw_carga_etapa
CREATE OR REPLACE VIEW vw_carga_etapa (
  id,
  etapa_id,
  nombre,
  cantidad,
  cantidad_inicial,
  cantidad_entrada,
  cantidad_salida,
  unidad,
  codigo,
  tipocarga_id,
  carga_id,
  barcaza,
  id_buque
) AS
select c.id, c.etapa_id, tc.nombre, c.cantidad, c.cantidad_inicial, c.cantidad_entrada, c.cantidad_salida,
           u.nombre unidad, tc.codigo, c.tipocarga_id, c.id carga_id, b.nombre barcaza, b.ID_BUQUE
           from tbl_cargaetapa c
    join tbl_tipo_carga tc on c.tipocarga_id = tc.id
    join tbl_unidad u on tc.unidad_id = u.id
    left join buques_new b on b.ID_BUQUE = c.buque_id
/

