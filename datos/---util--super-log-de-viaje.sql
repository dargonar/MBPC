SELECT t.created_at fecha, t.id, t.tipo_id tipo, CASE
  -- Creacion viaje
  WHEN t.tipo_id = 1 then
    (select 'Creacion de viaje: '||b.nombre||' ('||b.matricula||','||Trim(b.tipo)||') '||m.puerto||'->'||u.puerto||', fecha '||To_Char(v.fecha_salida,'dd/mm/yyyy HH24:MM') info
    from tbl_viaje v
    join buques b on v.buque_id = b.ID_BUQUE
    join tbl_kstm_puertos m on v.origen_id = m.cod
    join tbl_kstm_puertos u on v.destino_id = u.cod
    where v.id = t.viaje_id)

  -- Insercion carga (en barcaza)
  WHEN t.tipo_id = 4 THEN
    'Se agrega carga'||(SELECT
       CASE WHEN ce.buque_id IS NULL THEN
       ' - '
       ELSE
       ' en barcaza '||b.nombre||' - '
       END ||ce.cantidad_inicial||' '||Trim(u.nombre)||' de '||tc.nombre
    FROM tbl_cargaetapa ce
    left JOIN tbl_tipo_carga tc ON ce.tipocarga_id=tc.id
    left JOIN tbl_unidad u ON ce.unidad_id=u.id
    left JOIN buques b ON ce.buque_id=b.id_buque
    WHERE ce.id=t.carga_id)

  -- Modificacion de carga
  WHEN t.tipo_id = 5 THEN
    'Se modifica carga'||(SELECT
       CASE WHEN ce.buque_id IS NULL THEN
       ' - '
       ELSE
       ' en barcaza '||b.nombre||' - '
       END ||ce.cantidad||' '||Trim(u.nombre)||' de '||tc.nombre
    FROM tbl_cargaetapa ce
    left JOIN tbl_tipo_carga tc ON ce.tipocarga_id=tc.id
    left JOIN tbl_unidad u ON ce.unidad_id=u.id
    left JOIN buques b ON ce.buque_id=b.id_buque
    WHERE ce.id=t.carga_id)

  -- Eliminacion de carga
  WHEN t.tipo_id = 6 THEN
    'Se elimina carga'

  -- Pasar barco
  WHEN t.tipo_id = 7 then
    (SELECT 'Pasaje de barco a '|| CASE WHEN rck.km <> 0 then rc.nombre||' '||rck.unidad||' '||rck.km ELSE rc.nombre||' '||rck.unidad END descripcion
    FROM tbl_puntodecontrol pdc
    join rios_canales_km rck on rck.id = pdc.rios_canales_km_id
    join rios_canales rc on rck.id_rio_canal = rc.id
    WHERE pdc.id = t.puntodecontrol2_id)

  -- Modificacion de datos etapa/viaje
  WHEN t.tipo_id = 8 then
    'Modificacion datos de etapa'

  -- Finalizacion de viaje
  WHEN t.tipo_id = 9 then
    'Finalizacion de viaje'

  -- Recibe barcaza
  WHEN t.tipo_id = 10 then
    'Recibe barcaza'||(SELECT ' '||b.nombre FROM buques b WHERE b.id_buque=t.barcaza_id)||(SELECT ' de buque '||b.nombre||' ('||v.id||')' FROM tbl_viaje v left JOIN buques b ON v.buque_id=b.id_buque WHERE v.id=t.viaje2_id)

  -- Transfiere barcaza
  WHEN t.tipo_id = 11 then
    'Transfiere barcaza'||(SELECT ' '||b.nombre FROM buques b WHERE b.id_buque=t.barcaza_id)||(SELECT ' a buque '||b.nombre||' ('||v.id||')' FROM tbl_viaje v left JOIN buques b ON v.buque_id=b.id_buque WHERE v.id=t.viaje2_id)

  -- Reactivacion de viaje
  WHEN t.tipo_id = 12 then
    'Viaje reactivado'

  -- Agrega acompanante
  WHEN t.tipo_id = 13 then
    'Acompañantes '||(SELECT b1.nombre||', '||b2.nombre||', '||b3.nombre||', '||b4.nombre
      FROM tbl_evento e
      left JOIN buques b1 ON e.acompanante_id=b1.id_buque
      left JOIN buques b2 ON e.acompanante2_id=b2.id_buque
      left JOIN buques b3 ON e.acompanante3_id=b3.id_buque
      left JOIN buques b4 ON e.acompanante4_id=b4.id_buque
      WHERE e.id=t.id
    )

  -- Quita acompanante no se hace (14)

  -- Separar convoy
  WHEN t.tipo_id = 15 then
    'Separa convoy, se crean viajes para '||(SELECT b1.nombre||', '||b2.nombre||', '||b3.nombre||', '||b4.nombre
      FROM tbl_evento e
      left JOIN buques b1 ON e.acompanante_id=b1.id_buque
      left JOIN buques b2 ON e.acompanante2_id=b2.id_buque
      left JOIN buques b3 ON e.acompanante3_id=b3.id_buque
      left JOIN buques b4 ON e.acompanante4_id=b4.id_buque
      WHERE e.id=t.id
    )

  -- Sube practico
  WHEN t.tipo_id = 16 then
    'Sube practico '||(SELECT p.nombre||' con fecha '||To_char(t.fecha,'dd-mm-yyyy HH24:MM') FROM tbl_practico p WHERE p.id=t.practico_id)

  -- Baja practico
  WHEN t.tipo_id = 17 then
    'Baja practico '||(SELECT p.nombre||' con fecha '||To_char(t.fecha,'dd-mm-yyyy HH24:MM') FROM tbl_practico p WHERE p.id=t.practico_id)

  -- Se activa practico
  WHEN t.tipo_id = 18 then
    'Se activa practico '||(SELECT p.nombre||' con fecha '||To_char(t.fecha,'dd-mm-yyyy HH24:MM') FROM tbl_practico p WHERE p.id=t.practico_id)

  -- Barco reporta
  WHEN t.tipo_id = 19 then
    'Nuevo reporte '||
    (SELECT 'rumbo:'||t.rumbo||' | velocidad:'||t.velocidad||' | lat:'||t.latitud||' | lon:'||t.longitud||' | estado:'||es.estado FROM tbl_evento ev
      left JOIN tbl_bq_estados es ON ev.estado=es.cod
      WHERE ev.id=t.id)||' con fecha '||To_Char(t.fecha,'dd-mm-yyyy HH24:MM')

  -- Cambio de estado
  WHEN t.tipo_id = 20 then
    'Nuevo estado '||
    (SELECT 'estado:'||es.estado||' | lat:'||ev.latitud||' | lon:'||ev.longitud||' | Canal: '||CASE WHEN rck.km <> 0 then rc.nombre||' '||rck.unidad||' '||rck.km ELSE rc.nombre||' '||rck.unidad END FROM tbl_evento ev
    left JOIN tbl_bq_estados es ON ev.estado=es.cod
    left join rios_canales_km rck on rck.id = ev.rios_canales_km_id
    left join rios_canales rc on rck.id_rio_canal = rc.id
    WHERE ev.id=t.id)

  -- Descarga barcaza
  WHEN t.tipo_id = 21 then
  'Descarga barcaza'||(SELECT ' '||b.nombre FROM buques b WHERE b.id_buque=t.barcaza_id)

  -- Fondea barcaza
  WHEN t.tipo_id = 22 then
  'Fondea barcaza'||(SELECT ' '||b.nombre FROM buques b WHERE b.id_buque=t.barcaza_id)||
      (SELECT ' lat:'||ev.latitud||' | lon:'||ev.longitud||' | Canal: '||CASE WHEN rck.km <> 0 then rc.nombre||' '||rck.unidad||' '||rck.km ELSE rc.nombre||' '||rck.unidad END FROM tbl_evento ev
      left join rios_canales_km rck on rck.id = ev.rios_canales_km_id
      left join rios_canales rc on rck.id_rio_canal = rc.id
      WHERE ev.id=t.id)

  -- Incorpora barcaza fondeada
  WHEN t.tipo_id = 23 then
    'Incorpora barcaza fondeada'||(SELECT ' '||b.nombre FROM buques b WHERE b.id_buque=t.barcaza_id)

  -- Elimina evento
  WHEN t.tipo_id = 24 then
    'Elimina evento id '||t.evento_id

  -- Corrige barcaza
  WHEN t.tipo_id = 25 then
    'Corrige barcaza'||(SELECT ' '||b2.nombre||'->'||b1.nombre FROM tbl_evento ev
      left JOIN buques b1 ON ev.buque_id=b1.id_buque
      left JOIN buques b2 ON ev.barcaza_id=b2.id_buque
      WHERE ev.id=t.id)

  -- Recibe carga
  WHEN t.tipo_id = 26 then
    'Recibe carga'||t.evento_id

  -- Transfiere carga
  WHEN t.tipo_id = 27 then
    'Transfiere carga'||t.evento_id
  END
  descripcion

 FROM tbl_evento t

 WHERE viaje_id=:p1
 ORDER BY t.created_at



