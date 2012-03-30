PROMPT CREATE OR REPLACE VIEW vw_viajes_maritimos
CREATE OR REPLACE VIEW vw_viajes_maritimos (
  pid,
  id,
  etapa,
  proxdest,
  id_buque,
  nombre,
  nro_omi,
  matricula,
  sdist,
  bandera,
  latitud,
  longitud,
  origen,
  destino,
  estado,
  ultimo,
  costera
) AS
SELECT p.id PID, v.ID, e.id ETAPA, p2.ID PROXDEST, b.ID_BUQUE, b.NOMBRE, b.NRO_OMI, b.MATRICULA, b.SDIST, b.BANDERA, trunc(v.LATITUD,2), trunc(v.LONGITUD,2),
       v.ORIGEN_ID ORIGEN, v.DESTINO_ID DESTINO , Nvl(ST.ESTADO,'N/A') ESTADO, Nvl(trunc( (sysdate-updated_at)*24*60*60 ),9999999) ULTIMO, u.DESTINO COSTERA
from
tbl_viaje v
                    left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual)
                    left join buques_new b on v.buque_id = b.ID_BUQUE
                    left join tbl_puntodecontrol p on p.id = e.actual_id
                    left join tbl_puntodecontrol p2 on p2.id = e.destino_id
                    left join tbl_bq_estados st on v.estado_buque = st.cod
					left join vw_int_usuarios u on v.updated_by = u.ndoc
                    WHERE v.estado =0'