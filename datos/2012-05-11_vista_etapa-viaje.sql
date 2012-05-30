PROMPT CREATE OR REPLACE VIEW vw_etapa_viaje
CREATE OR REPLACE VIEW vw_etapa_viaje (
  id,
  nro_etapa,
  viaje_id,
  origen_id,
  actual_id,
  destino_id,
  hrp,
  eta,
  fecha_salida,
  fecha_llegada,
  cantidad_tripulantes,
  cantidad_pasajeros,
  capitan_id,
  calado_proa,
  calado_popa,
  calado_maximo,
  calado_informado,
  km,
  created_at,
  acompanante_id,
  sentido,
  velocidad,
  rumbo,
  created_by,
  acompanante2_id,
  acompanante3_id,
  acompanante4_id,
  puerto_origen,
  puerto_destino,
  origen_desc,
  destino_desc,
  descripcion
) AS
SELECT e.id, nro_etapa, viaje_id, origen_id, actual_id, destino_id, hrp, eta, fecha_salida, fecha_llegada, cantidad_tripulantes, cantidad_pasajeros, capitan_id,
        calado_proa, calado_popa, calado_maximo, calado_informado, km, created_at, acompanante_id, e.sentido, velocidad, rumbo, created_by, acompanante2_id, acompanante3_id,
        acompanante4_id, puerto_origen, puerto_destino , '(' || m.COD || ') ' || m.PUERTO || ' (' || m.PAIS || ')' origen_desc
        , '(' || u.COD || ') ' || u.PUERTO || ' (' || u.PAIS || ')' destino_desc,
        CASE WHEN rck.km <> 0 then rc.nombre||' '||rck.unidad||' '||rck.km ELSE rc.nombre||' '||rck.unidad END descripcion
      from
        tbl_etapa e
        LEFT JOIN vw_int_usuarios u on created_by=u.ndoc
        left join tbl_kstm_puertos m on puerto_origen = m.cod
        left join tbl_kstm_puertos u on puerto_destino = u.cod
        left JOIN tbl_puntodecontrol pdc ON pdc.id = actual_id
        left join rios_canales_km rck on rck.id = pdc.rios_canales_km_id
        left join rios_canales rc on rck.id_rio_canal = rc.id 
/

