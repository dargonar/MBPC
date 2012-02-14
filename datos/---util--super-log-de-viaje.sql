SELECT t.created_at fecha, CASE
  -- Creacion viaje
  WHEN t.tipo_id = 1 then
    (select 'Creacion de viaje: '||b.nombre||' ('||b.matricula||','||Trim(b.tipo)||') '||m.puerto||'->'||u.puerto||', fecha '||To_Char(v.fecha_salida,'dd/mm/yyyy HH24:MM') info
    from tbl_viaje v
    join buques b on v.buque_id = b.ID_BUQUE
    join tbl_kstm_puertos m on v.origen_id = m.cod
    join tbl_kstm_puertos u on v.destino_id = u.cod
    where v.id = 162)

  -- Insercion carga (en barcaza)
  WHEN t.tipo_id = 4 THEN
    (SELECT
       CASE WHEN ce.buque_id IS NULL THEN
       'Se agrega '
       ELSE
       'Se agrega en barcaza '||b.nombre||' '
       END ||ce.cantidad_inicial||' '||Trim(u.nombre)||' de '||tc.nombre
    FROM tbl_cargaetapa ce
    left JOIN tbl_tipo_carga tc ON ce.tipocarga_id=tc.id
    left JOIN tbl_unidad u ON ce.unidad_id=u.id
    left JOIN buques b ON ce.buque_id=b.id_buque
    WHERE ce.id=t.carga_id)

  END
  descripcion

 FROM tbl_evento t WHERE viaje_id=162
 ORDER BY t.created_at



