PROMPT CREATE OR REPLACE VIEW vw_etapa_viaje
CREATE OR REPLACE VIEW vw_etapa_viaje (
  id, nro_etapa, viaje_id, origen_id, actual_id, destino_id, hrp, eta, fecha_salida, fecha_llegada, cantidad_tripulantes, cantidad_pasajeros, capitan_id,
        calado_proa, calado_popa, calado_maximo, calado_informado, km, created_at, acompanante_id, sentido, velocidad, rumbo, created_by, acompanante2_id, acompanante3_id,
        acompanante4_id, puerto_origen, puerto_destino , origen_desc, destino_desc)
  AS
    SELECT DISTINCT id, nro_etapa, viaje_id, origen_id, actual_id, destino_id, hrp, eta, fecha_salida, fecha_llegada, cantidad_tripulantes, cantidad_pasajeros, capitan_id,
        calado_proa, calado_popa, calado_maximo, calado_informado, km, created_at, acompanante_id, sentido, velocidad, rumbo, created_by, acompanante2_id, acompanante3_id,
        acompanante4_id, puerto_origen, puerto_destino , m.puerto origen_desc, u.puerto destino_desc
      from
        tbl_etapa 
        LEFT JOIN vw_int_usuarios u on created_by=u.ndoc
        left join tbl_kstm_puertos m on puerto_origen = m.cod
        left join tbl_kstm_puertos u on puerto_destino = u.cod
      
/