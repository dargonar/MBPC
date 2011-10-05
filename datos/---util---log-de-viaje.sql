select usuario_id, viaje_id, etapa_id, te.descripcion, carga_id,barcaza_id 
from tbl_evento e left join tbl_tipoevento te on e.tipo_id=te.id
order by e.viaje_id, e.created_at, e.etapa_id