--create or replace type NUM_ARRAY as VARRAY(100) of number;
create or replace package mbpc as
  type cur is ref cursor;
  type posdepdc is record (lat number, lon number, uso number, riokm number);
  posicion posdepdc;
  logged number(1,0);
  var_buque buques%ROWTYPE;
  var_puerto tbl_kstm_puertos%ROWTYPE;
  usuario int_usuarios%ROWTYPE;
  usuario2 vw_int_usuarios%ROWTYPE;
  etapa tbl_etapa%ROWTYPE;
  cetapa tbl_cargaetapa%ROWTYPE;
  practicoetapa tbl_practicoetapa%ROWTYPE;
  viaje tbl_viaje%ROWTYPE;
  pbipp tbl_pbip%ROWTYPE;
  evento tbl_evento%ROWTYPE;
  sql_stmt varchar2(2048);
  temp number;
  temp2 number;
  temp3 varchar2(1000);
  temp4 number;
  strtemp1 varchar(50);
  strtemp2 varchar(50);
  strtemp3 varchar(50);
  tempdate date;
  --Login/Home
  procedure login( vid in varchar2, vpassword in varchar2, logged out number);
  procedure login2( vid in varchar2, vpassword in varchar2, logged out number);
  
  procedure grupos_del_usuario( vId in varchar2, usrid in number, vCursor out cur);
  procedure zonas_del_grupo( vId in varchar2, usrid in number, vCursor out cur);
  procedure barcazas_en_zona( vZonaId in varchar2, usrid in number, vCursor out cur);
  procedure barcos_en_zona( vZonaId in varchar2, usrid in number, vCursor out cur);
  procedure barcos_entrantes( vZonaId in varchar2, usrid in number, vCursor out cur);
  procedure barcos_salientes( vZonaId in varchar2, usrid in number, vCursor out cur);
  procedure reporte_diario (vUsuario in varchar2, usrid in number, vCursor out cur);
  procedure datos_del_usuario(vid in varchar2, usrid in number, vCursor out cur );
  procedure todos_los_pdc(usrid in number, vCursor out cur);
  --Viaje
  procedure crear_viaje(vBuque in varchar2, vOrigen in varchar2, vDestino in varchar2, vInicio in varchar2, vEta in varchar2, vZoe in varchar2, vZona in varchar, vProx in varchar, vInternacional in number, vLat in number, vLon in number, vRiocanal in varchar2, usrid in number, vCursor out cur);
  procedure editar_viaje(vViaje in varchar2, vBuque in varchar2, vOrigen in varchar2, vDestino in varchar2, vInicio in varchar2, vEta in varchar2, vZoe in varchar2, vZona in varchar, vProx in varchar, vInternacional in number, vLat in number, vLon in number, vRiocanal in varchar2, usrid in number, vCursor out cur);
  procedure traer_viaje(vViaje in varchar2, usrid in number, vCursor out cur);
  procedure terminar_viaje(vViajeId in number, vFecha in varchar2, vEscalas in varchar2, usrid in number, vCursor out cur);
  procedure viajes_terminados(vZona in number, usrid in number, vCursor out cur);
  procedure reactivar_viaje(vViajeId in number , usrid in number, vCursor out cur);
  procedure traer_pbip(vViaje in varchar2, usrid in number, vCursor out cur);
  procedure modificar_pbip(vViaje in varchar2, vPuertoDeMatricula in varchar2, vNroInmarsat in varchar2, vArqueoBruto in varchar2, vCompania in varchar2, vContactoOCPM in varchar2, vObjetivo in varchar2, usrid in number, vCursor out cur);
  procedure traer_notas(vViaje in varchar2, usrid in number, vCursor out cur);
  procedure guardar_notas(vViaje in varchar2, vNotas in varchar2, usrid in number, vCursor out cur);
  procedure editar_acompanante(vEtapa in varchar2, vBuque in varchar2, vBuque2 in varchar2, vBuque3 in varchar2, vBuque4 in varchar2, usrid in number, vCursor out cur);
  procedure traer_acompanantes(vEtapa in varchar2, usrid in number, vCursor out cur);
  procedure separar_convoy(vViaje in varchar2, vPartida in varchar2, usrid in number, vCursor out cur);
  procedure eliminar_evento(vEvento in number, vEtapa in number, usrid in number, vCursor out cur);
  procedure hist_rvp(vEtapa in varchar2, usrid in number, vCursor out cur);
  procedure hist_pos(vEtapa in varchar2, usrid in number, vCursor out cur);
  procedure hist_evt(vEtapa in varchar2, usrid in number, vCursor out cur);
  procedure insertar_reporte(vViaje in varchar2, vLat in number, vLon in number, vVelocidad in number, vRumbo in number, vEstado in varchar2, vFecha in varchar2, usrid in number, vCursor out cur);
  procedure posicion_de_puntodecontrol(vPdc in varchar2, usrid in number, vCursor out cur);
  procedure eventos_usuario(usrid in number, vCursor out cur);
  procedure insertar_cambioestado(vEtapa in varchar2, vNotas in varchar2,  vLat in number, vLon in number, vFecha in varchar2, vEstado in varchar2, vRiocanal in varchar2, vPuerto in varchar2, usrid in number, vCursor out cur);
  --Etapas
  procedure id_ultima_etapa(vViaje in number, usrid in number, vCursor out cur);
  procedure indicar_proximo(vViajeId in number, vZonaId in number, usrid in number, vCursor out cur);  
  procedure pasar_barco(vViajeId in varchar2, vZonaId in varchar2, vEta in varchar2, vLlegada in varchar2, vVelocidad in number, vRumbo in number, usrid in number, vCursor out cur);
  procedure zonas_adyacentes(vZonaId in varchar2, usrid in number, vCursor out cur);
  procedure traer_etapa(vViaje in varchar2, usrid in number, vCursor out cur);
  procedure editar_etapa(vEtapa in varchar2, vCaladoProa in varchar2, vCaladoPopa in varchar2, vCaladoInformado in varchar2, vHPR in varchar2, vETA in varchar2, vFechaSalida in varchar2, vCantidadTripulantes in varchar2, vCantidadPasajeros in varchar2, vCapitan in varchar2, vVelocidad in number, vRumbo in number, usrid in number, vCursor out cur);
  procedure traer_buque_de_etapa(vEtapa in varchar2, usrid in number, vCursor out cur);
  procedure traer_practicos(vViaje in varchar2, usrid in number, vCursor out cur);
  procedure agregar_practico(vEtapa in varchar2, vPractico in varchar2, vFecha in varchar2, usrid in number, vCursor out cur);
  procedure eliminar_practicos(vEtapa in varchar2, usrid in number, vCursor out cur);
  --Cargas  
  procedure descargar_barcaza(vEtapaId in varchar2, vBarcazaId in varchar2, usrid in number, vCursor out cur);
  procedure corregir_barcaza(vEtapa in varchar2, vBuque in varchar2, usrid in number, vCursor out cur);
  procedure barcazas_utilizadas(usrid in number, vCursor out cur);
  procedure traer_cargas( vEtapaId in varchar2, usrid in number, vCursor out cur);
  procedure traer_cargas_nobarcazas( vEtapaId in varchar2, usrid in number, vCursor out cur);
  procedure traer_carga_por_codigo(vCodigo in varchar2, usrid in number, vCursor out cur);
  procedure traer_barcazas_de_buque(vEtapa in varchar2, usrid in number, vCursor out cur);
  procedure traer_unidades(usrid in number, vCursor out cur);
  procedure insertar_carga( vEtapa in varchar2, vCarga in varchar2, vCantidad in varchar2, vUnidad in varchar2, vBuque in varchar2, vEnTransito in varchar2, usrid in number, vCursor out cur);
  procedure modificar_carga(vCarga in varchar2, vCantidadEntrada in varchar2, vCantidadSalida in varchar2, usrid in number, vCursor out cur);
  procedure eliminar_carga(vCarga in varchar2, checkempty in number, usrid in number, vCursor out cur);
  procedure check_empty(vEtapaId in number, vBuqueId in number);
  procedure adjuntar_barcazas(vEtapaId in number, vViajeId in number, usrid in number);
  procedure fondear_barcaza(vEtapaId in number, vBarcazaId in number, vRioCanalKM in varchar2, vLat in number, vLon in number, vFecha in varchar2, usrid in number, vCursor out cur);
  procedure transferir_cargas(vEtapa in varchar2, vCarga in varchar2, vCantidad in varchar2, vUnidad in varchar2, vTipo in varchar2, vModo in varchar2, vOriginal in varchar2, vRecEmi in varchar2, usrid in number);
  procedure transferir_barcazas(vBarcaza in varchar2, vEtapa in varchar2, usrid in number);
  ---autocompletes
  procedure autocomplete_muelles(vQuery in varchar2, usrid in number, vCursor out cur);
  procedure autocomplete_cargas(vQuery in varchar2, usrid in number, vCursor out cur);
  procedure autocomplete_barcazas(vEtapaId in varchar2, vQuery in varchar2, usrid in number, vCursor out cur);
  procedure autocompleter( vVista in varchar2, vQuery in varchar2, usrid in number, vCursor out cur);
  procedure autocompleterm( vQuery in varchar2, usrid in number, vCursor out cur);
  procedure autocompleterb( vQuery in varchar2, usrid in number, vCursor out cur);
  procedure autocompleterball( vQuery in varchar2, vEstado in varchar2, usrid in number, vCursor out cur);
  procedure autocompleterbdisponibles( vQuery in varchar2, usrid in number, vCursor out cur);
  procedure autocompleterbnacionales( vQuery in varchar2, usrid in number, vCursor out cur);
  procedure autocompleterioscanales( vQuery in varchar2, usrid in number, vCursor out cur); 
  procedure autocompleterestados( vQuery in varchar2, usrid in number, vCursor out cur);
  procedure autocompleterbenzona( vQuery in varchar2, vZonaId in varchar2, usrid in number, vCursor out cur);
  procedure autocompletebactivos( vQuery in varchar2, usrid in number, vCursor out cur);
  procedure paginator(p_statment in varchar2, p_offset in number, p_count in number, sqlquery out varchar2);
 --Buque/Puertos/Muelles
  procedure detalles_tecnicos( vShipId in varchar2, usrid in number, vCursor out cur);
  procedure crear_buque(vMatricula in varchar2, vNombre in varchar2, vSDist in varchar2, vServicio in varchar2, vMMSI in varchar2, usrid in number, vCursor out cur);
  procedure crear_buque_int(vMatricula in varchar2, vNombre in varchar2, vSDist in varchar2, vBandera in varchar2, vServicio in varchar2, vMMSI in varchar2, usrid in number, vCursor out cur);
  procedure traer_puertos(usrid in number, vCursor out cur);
  procedure crear_puerto(vCod in varchar2, vPuerto in varchar2, vPais in varchar2, usrid in number, vCursor out cur);
  --procedure traer_instports(vPuerto in varchar2, usrid in number, vCursor out cur);
  procedure crear_usuario(vNdoc in varchar2, vPassword in varchar2, vApellido in varchar2, vNombres in varchar2, vDestino in varchar2, vFechavenc in varchar2, vTedirecto in varchar2, vTeinterno in varchar2, vEmail in varchar2, vEstado in varchar2, vSeccion in varchar2, vNdoc_admin in varchar2, vFecha_audit in varchar2, vNombredeusuario in varchar2, vUsuario_id in varchar2, usrid in number, vCursor out cur);
  procedure update_usuario(vNdoc in varchar2, vPassword in varchar2, vApellido in varchar2, vNombres in varchar2, vDestino in varchar2, vFechavenc in varchar2, vTedirecto in varchar2, vTeinterno in varchar2, vEmail in varchar2, vEstado in varchar2, vSeccion in varchar2, vNdoc_admin in varchar2, vFecha_audit in varchar2, vNombredeusuario in varchar2, vUsuario_id in varchar2, usrid in number, vCursor out cur);  
  procedure crear_practico(vNombre in varchar2, usrid in number, vCursor out cur);
  procedure update_practico(vNombre in varchar2, usrid in number, vCursor out cur);
  procedure asignar_pdc(vUsuario in varchar2, vPdc in varchar2, usrid in number);
  procedure columnas_de(vTabla in varchar2, usrid in number, vCursor out cur);
  procedure pager(vTabla in varchar2, vOrderBy in varchar2, vCantidad in number, vDesde in number, usrid in number, vCursor out cur );
  procedure count_rows(vTabla in varchar2, number_of_rows out number);
  procedure traer_banderas(usrid in number, vCursor out cur);
  --reportes
  procedure reporte_lista(usrid in number, vCursor out cur);
  procedure reporte_obtener_parametros(vReporte in number, usrid in number, vCursor out cur);
  procedure reporte_obtener_parametros_str(vNombre in varchar2, usrid in number, vCursor out cur);
  procedure reporte_obtener(vReporte in number, usrid in number, vCursor out cur);
  procedure reporte_obtener_str(vNombre in varchar2, usrid in number, vCursor out cur);
  
end;








































































/
create or replace package body mbpc as

---------------------------------------------------------------------------------------------------------------
-----------------------------------------Login/Home------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

-- vw_int_usuarios: usuarios internos (de Prefectura) habilitados a usar el MBPC
-- vw_int_usuarios_ext: usuarios externos (empresas u organismos) habilitados para consumir datos del MBPC
-- vw_pers_desti: personal de Prefectura con sus destinos actualizados

  -------------------------------------------------------------------------------------------------------------
  procedure login2(vid in varchar2, vpassword in varchar2, logged out number ) is

  begin
    SELECT * INTO usuario2 FROM vw_int_usuarios WHERE ndoc = vid AND password = vpassword;
      IF sql%ROWCOUNT != 0 THEN
        SELECT count(*) into temp FROM vw_pers_desti WHERE ndoc=vid AND destino=usuario2.destino;
        if temp != 0 THEN
          if usuario2.fechavenc > SYSDATE THEN
            --usuario ok / destino ok / fecha ok
            logged := 1;
          ELSE
            --usuario ok / destino ok / fecha no
            logged := 4;
          END IF;
          
        ELSE
          --usuario ok / destino no
          logged := 2;
        END IF;
      END IF;
  exception when NO_DATA_FOUND THEN
    --usuario/pass invalido
    logged := 3;
    
  end login2;

  -------------------------------------------------------------------------------------------------------------
  -- Verifica que exista un registro que coincida con el ID del usuario (Legajo) y el password  
  procedure login(vid in varchar2, vpassword in varchar2, logged out number ) is

  begin
    SELECT * INTO usuario FROM int_usuarios WHERE usuario_id = vid AND password = vpassword;
      IF sql%ROWCOUNT != 0 THEN
        logged := 1;
      ELSE
        logged := 0;
      END IF;
  exception when NO_DATA_FOUND THEN
    logged := 0;
  end login;

  -------------------------------------------------------------------------------------------------------------
  --
  procedure datos_del_usuario(vid in varchar2, usrid in number, vCursor out cur ) is
  begin
    open vCursor for
    SELECT * FROM int_usuarios WHERE usuario_id = vid;
  end datos_del_usuario;
  
  -------------------------------------------------------------------------------------------------------------
  --Retorna todos los grupos que tiene asignado el usuario
  
  procedure grupos_del_usuario( vId in varchar2, usrid in number, vCursor out cur) is
  begin 
    open vCursor for 
    select gu.ID, gu.GRUPO, gu.USUARIO, g.NOMBRE 
    from tbl_usuariogrupo gu
    left join tbl_grupo g on g.ID=gu.GRUPO
    WHERE gu.USUARIO=vID;
  end grupos_del_usuario;
  
  -------------------------------------------------------------------------------------------------------------
  --Retorna todos los puntos de control que el usuario tiene asignado  
  
  procedure zonas_del_grupo( vId in varchar2, usrid in number, vCursor out cur) is
  begin 
    --open vCursor for SELECT * FROM tbl_zonausuario;
    open vCursor for 
    SELECT pdc.ID, CUATRIGRAMA, ENTRADA, DESCRIPCION, NIVEL, DIRECCION_POSTAL, UBIC_GEOG, DEPENDENCIA, ESTADO, CODNUM, ZONA, NIVELNUM, RPV, INT, MAIL, TE, FAX, COD_CARGO, DESCENTRALIZADO, rc.nombre CANAL, rck.km KM, rck.unidad, entrada
    FROM tbl_puntodecontrol pdc 
    join tbl_zonas z on pdc.zona_id = z.id 
    join rios_canales_km rck on rck.id = pdc.rios_canales_km_id
    join rios_canales rc on rck.id_rio_canal = rc.id
    WHERE pdc.id IN (SELECT PUNTO FROM tbl_grupopunto WHERE GRUPO = vId);
  end zonas_del_grupo;

  -------------------------------------------------------------------------------------------------------------  
  --Retorna todas las barcazas que esten fondeadas en el punto de control
  procedure barcazas_en_zona( vZonaId in varchar2, usrid in number, vCursor out cur) is
  begin 
    open vCursor for 
      select v.id, v.buque_id, v.notas, v.latitud, v.longitud, b.nombre
      from tbl_viaje v
       left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual)
       left join buques b on v.buque_id = b.ID_BUQUE
     where e.actual_id = vZonaId and v.estado = 100
     order by b.nombre;
  end barcazas_en_zona;
  
  -------------------------------------------------------------------------------------------------------------  
  --Retorna todos los barcos que esten en el punto de control actual, 
  --revisando que en todos los viajes en curso (Estado 0) 
  --la etapa actual (que indica el punto de control del que viene, **donde esta**, donde se dirige y previamente calculado si esta en bajada o subida)
  --coincida con el punto de control que se este verificando
  
  procedure barcos_en_zona( vZonaId in varchar2, usrid in number, vCursor out cur) is
  begin 
    open vCursor for 
      --COLUMNA 'INSCRIPCION PROVISIORIA' reemplazada por constante 'INS.PROV.'
      select v.id, v.buque_id, v.notas, v.latitud, v.longitud, capitan.nombre capitan, acomp.nombre acompanante, 
             acomp2.nombre acompanante2, acomp3.nombre acompanante3, acomp4.nombre acompanante4, 
             e.calado_maximo, e.calado_informado, e.origen_id, e.destino_id, e.sentido, e.eta, e.id etapa_id, 
             'INS.PROV.', b.matricula, b.sdist, b.bandera, b.nombre, b.nro_omi, b.nro_ismm, b.arqueo_neto, 
             b.arqueo_total, b.tipo, z.cuatrigrama, rck.km, st.estado estado_text, v.estado_buque
      from tbl_viaje v
       left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual)
       left join buques b on v.buque_id = b.ID_BUQUE
       left join buques acomp on e.acompanante_id = acomp.ID_BUQUE
       left join buques acomp2 on e.acompanante2_id = acomp2.ID_BUQUE
       left join buques acomp3 on e.acompanante3_id = acomp3.ID_BUQUE
       left join buques acomp4 on e.acompanante4_id = acomp4.ID_BUQUE
       left join tbl_puntodecontrol p on p.id = e.destino_id
       left join rios_canales_km rck on rck.id = p.rios_canales_km_id
       left join rios_canales rc on rck.id_rio_canal = rc.id
       left join tbl_zonas z on p.zona_id = z.id
       left join tbl_capitan capitan on e.capitan_id = capitan.id
       left join tbl_bq_estados st on v.estado_buque = st.cod
     where e.actual_id = vZonaId and v.estado = 0;
  end barcos_en_zona;

  -------------------------------------------------------------------------------------------------------------  
  --Retorna todos los barcos recientemente despachados al punto de control, 
  --revisando que en todos los viajes en curso (Estado 0) 
  --la etapa actual (que indica el punto de control del que viene, donde esta, **donde se dirige** y previamente calculado si esta en bajada o subida)
  --coincida con el punto de control que se este verificando
  
  procedure barcos_entrantes( vZonaId in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
      select v.id, v.buque_id, v.notas, v.latitud, v.longitud, capitan.nombre capitan, acomp.nombre acompanante, 
      acomp2.nombre acompanante2, acomp3.nombre acompanante3, acomp4.nombre acompanante4, 
      e.calado_maximo, e.calado_informado,  e.origen_id, e.destino_id, e.sentido, e.eta, 'INSC.PROV.', b.matricula, 
      b.sdist, b.bandera, b.nombre, b.nro_omi, b.nro_ismm,b.arqueo_neto, b.arqueo_total, b.tipo, z.cuatrigrama, rck.km, 
      st.estado estado_text,v.estado_buque
      from tbl_viaje v
        left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual)
        left join buques b on v.buque_id = b.ID_BUQUE
        left join buques acomp on e.acompanante_id = acomp.ID_BUQUE
        left join buques acomp2 on e.acompanante2_id = acomp2.ID_BUQUE
        left join buques acomp3 on e.acompanante3_id = acomp3.ID_BUQUE
        left join buques acomp4 on e.acompanante4_id = acomp4.ID_BUQUE
        left join tbl_puntodecontrol p on p.id = e.destino_id
        left join rios_canales_km rck on rck.id = p.rios_canales_km_id
        left join rios_canales rc on rck.id_rio_canal = rc.id
        left join tbl_zonas z on p.zona_id = z.id
        left join tbl_capitan capitan on e.capitan_id = capitan.id
        left join tbl_bq_estados st on v.estado_buque = st.cod
      WHERE e.destino_id = vZonaId and v.estado = 0;
  end barcos_entrantes;
  
  ---------------------------------------------------------------------------------------------------------------  
  --Retorna todos los barcos por ingresar al punto de control, 
  --revisando que en todos los viajes en curso (Estado 0) 
  --la etapa actual (que indica el punto de control **del que viene**, donde esta, donde se dirige y previamente calculado si esta en bajada o subida)
  --coincida con el punto de control que se este verificando
  --NOTA: Sólo aparece si, desde el punto de control procedente, indicaron el punto de control actual como Proximo Destino
  
  procedure barcos_salientes( vZonaId in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
      select v.id, v.buque_id, v.latitud, v.longitud, v.notas,capitan.nombre capitan, acomp.nombre acompanante, 
      acomp2.nombre acompanante2, acomp3.nombre acompanante3, acomp4.nombre acompanante4,
      e.calado_maximo, e.calado_informado, e.origen_id, e.destino_id, e.sentido, e.eta, 'INSCR.PROV.', b.matricula, 
      b.sdist, b.bandera, b.nombre, b.nro_omi, b.nro_ismm,b.arqueo_neto, b.arqueo_total,b.tipo, z.cuatrigrama, rck.km, 
      st.estado estado_text,v.estado_buque
      from tbl_viaje v
        left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual)
        left join buques b on v.buque_id = b.ID_BUQUE
        left join buques acomp on e.acompanante_id = acomp.ID_BUQUE
        left join buques acomp2 on e.acompanante2_id = acomp.ID_BUQUE
        left join buques acomp3 on e.acompanante3_id = acomp.ID_BUQUE
        left join buques acomp4 on e.acompanante4_id = acomp.ID_BUQUE
        left join tbl_puntodecontrol p on p.id = e.destino_id
        left join rios_canales_km rck on rck.id = p.rios_canales_km_id
        left join rios_canales rc on rck.id_rio_canal = rc.id
        left join tbl_zonas z on p.zona_id = z.id
        left join tbl_capitan capitan on e.capitan_id = capitan.id
        left join tbl_bq_estados st on v.estado_buque = st.cod
      WHERE e.origen_id = vZonaId and v.estado = 0;
  end barcos_salientes;
  
  procedure reporte_diario (vUsuario in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
      select p.id pdc, b.nombre, b.sdist, b.bandera band, origen.puerto fm, destino.puerto tox, 
             e.calado_proa cal, v.zoe, z.cuatrigrama, rc.nombre CANAL, rck.km KM, rck.unidad, 
             to_char(e.eta,'HH:MM') eta, to_char(e.hrp,'HH:MM') hrp, e.sentido
      from tbl_etapa e
      left join tbl_viaje v on e.viaje_id = v.id
      left join buques b on v.buque_id = b.ID_BUQUE
      left join tbl_kstm_puertos origen on v.origen_id = origen.cod
      left join tbl_kstm_puertos destino on v.destino_id = destino.cod
      left join tbl_puntodecontrol p on e.actual_id = p.id
      left join tbl_zonas z on p.zona_id = z.id
      left join rios_canales_km rck on rck.id = p.rios_canales_km_id
      left join rios_canales rc on rck.id_rio_canal = rc.id
      where to_char(e.fecha_salida, 'YYDD-MM-yy')= to_char(sysdate, 'YYDD-MM-yy')
      and e.actual_id in (select puntodecontrol from tbl_puntodecontrolusuario where usuario = vUsuario) order by nombre, rck.km;
  end reporte_diario;

  procedure todos_los_pdc(usrid in number, vCursor out cur) is
  begin
    open vCursor for
      select * from tbl_puntodecontrol;
  end todos_los_pdc;
  
  
---------------------------------------------------------------------------------------------------------------
-----------------------------------------Viaje-----------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
--

  -------------------------------------------------------------------------------------------------------------  
  --

  procedure hist_rvp(vEtapa in varchar2, usrid in number, vCursor out cur) is
  begin
    select * into etapa from tbl_etapa where id=vEtapa;
    open vCursor for
      select rc.nombre canal, rck.km km, nro_etapa, to_char(created_at ,'YYDD-MM-yy HH:MI:SS') created_at, e.id from tbl_etapa e
        left join tbl_puntodecontrol pdc on actual_id = pdc.id 
        left join rios_canales_km rck on rck.id = pdc.rios_canales_km_id
        left join rios_canales rc on rck.id_rio_canal = rc.id
        where viaje_id = etapa.viaje_id order by created_at desc;
  end hist_rvp;

  -------------------------------------------------------------------------------------------------------------  
  --
  
  procedure hist_pos(vEtapa in varchar2, usrid in number, vCursor out cur) is
  begin
    select * into etapa from tbl_etapa where id=vEtapa;
    open vCursor for
      select p.etapa_id, p.latitud, p.longitud, p.rumbo, p.velocidad, p.estado  from tbl_evento p
      left join tbl_bq_estados e on p.estado = e.cod
      where viaje_id = etapa.viaje_id and tipo_id = 19 and p.borrado = 0
      order by created_at desc;
  end hist_pos;  

  -------------------------------------------------------------------------------------------------------------  
  --
  procedure eliminar_evento(vEvento in number, vEtapa in number, usrid in number, vCursor out cur) is
  begin
      
      select * into evento from tbl_evento where id=vEvento;
      
      temp     := evento.viaje_id;
      tempdate := SYSDATE;
      
      --Soft delete
      update tbl_evento set borrado=1 where id=evento.id;
      
      --Agregar evento 'Evento borrado'
      insert into tbl_evento ( usuario_id , viaje_id , etapa_id , tipo_id , created_at, evento_id) 
      VALUES ( usrid, evento.viaje_id , vEtapa , 24, tempdate, evento.id );
 
      begin
         --Traemos el ultimo evento tipo 20 (para sacar el estado) y actualizar el viaje
        SELECT * into evento FROM 
          (SELECT * FROM tbl_evento 
              where viaje_id=evento.viaje_id and 
                    tipo_id=20 and 
                    borrado=0 
              ORDER BY created_at DESC)
        WHERE ROWNUM=1;

        --Ponemos el ultimo estado en el viaje
        update tbl_viaje set estado_buque=evento.estado, updated_by=usrid, updated_at=tempdate where id=temp;
      
        exception when NO_DATA_FOUND THEN
          update tbl_viaje set estado_buque=NULL, updated_by=usrid, updated_at=tempdate where id=temp;
      end;
      
  end eliminar_evento;    
  
  -------------------------------------------------------------------------------------------------------------  
  --
  
  procedure hist_evt(vEtapa in varchar2, usrid in number, vCursor out cur) is
  begin
    select * into etapa from tbl_etapa where id=vEtapa;
    open vCursor for
      select p.id, p.etapa_id, p.latitud, p.longitud, p.rumbo, p.velocidad, p.comentario, e.descripcion, p.tipo_id, p.estado, rc.nombre || ' - ' || rck.unidad || ' ' || rck.km riocanal 
      from tbl_evento p
      left join tbl_tipoevento e on p.tipo_id = e.id
      left join rios_canales_km rck on p.rios_canales_km_id = rck.id
      left join rios_canales rc on rck.id_rio_canal = rc.id
      where viaje_id = etapa.viaje_id and e.tipo = 1 and p.borrado=0
      order by created_at desc;
  end hist_evt;    
  -------------------------------------------------------------------------------------------------------------  
  --
  
  procedure insertar_reporte(vViaje in varchar2, vLat in number, vLon in number, vVelocidad in number, vRumbo in number, vEstado in varchar2, vFecha in varchar2, usrid in number, vCursor out cur) is
  begin
    select * into viaje from tbl_viaje where id = vViaje;
    select * into etapa from tbl_etapa where nro_etapa = viaje.etapa_actual and viaje_id = viaje.id;
    
    tempdate := SYSDATE;
    
    insert into tbl_evento (usuario_id, viaje_id, etapa_id, tipo_id, latitud, longitud, fecha, velocidad, rumbo, estado, created_at) 
    values (usrid, vViaje, etapa.id, 19, vLat, vLon, TO_DATE(vFecha, 'DD-MM-yy HH24:mi'), vVelocidad, vRumbo, vEstado, tempdate);
    
    if length(vEstado) = 2 THEN
      update tbl_viaje set estado_buque = vEstado, updated_by=usrid, updated_at=tempdate where id = vViaje;
    end if;

    if vLat is not null and vLon is not null THEN
      update tbl_viaje set latitud = vLat, longitud = vLon, updated_by=usrid, updated_at=tempdate where id = vViaje;
    end if;
    
  end insertar_reporte;

--  procedure insertar_posicion(vEtapa in varchar2, vLat in varchar2, vLon in varchar2, usrid in number, vCursor out cur) is
--  begin
--    update tbl_etapa set latitud = vLat , longitud = vLon where id = vEtapa;
--  end insertar_posicion;
  
  procedure posicion_de_puntodecontrol(vPdc in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
      select latitud, longitud, uso from tbl_puntodecontrol pdc
      left join rios_canales_km rck on pdc.rios_canales_km_id = rck.id
      where pdc.id = vPdc;
  end posicion_de_puntodecontrol;
  
  procedure eventos_usuario(usrid in number, vCursor out cur) is
  begin
    open vCursor for
      select * from tbl_tipoevento where tipo = 1;
  end eventos_usuario;
  
  procedure insertar_cambioestado(vEtapa in varchar2, vNotas in varchar2,  vLat in number, vLon in number, vFecha in varchar2, vEstado in varchar2, vRiocanal in varchar2, vPuerto in varchar2, usrid in number, vCursor out cur) is
  begin
      select * into etapa from tbl_etapa where id = vEtapa;
      
      tempdate := SYSDATE;
      
      insert into tbl_evento ( usuario_id , viaje_id , etapa_id, tipo_id, fecha, comentario, latitud, longitud, estado, rios_canales_km_id, puerto_cod, created_at) 
      VALUES ( usrid , etapa.viaje_id , vEtapa, 20 , TO_DATE(vFecha, 'DD-MM-yy HH24:mi'), vNotas, vLat, vLon, vEstado, vRiocanal, vPuerto, tempdate);
      
      update tbl_viaje set estado_buque = vEstado, updated_by=usrid, updated_at=tempdate where id = etapa.viaje_id;
      
      IF vLat is not null and vLon is not null THEN
        update tbl_viaje set latitud = vLat, longitud=vLon where id = etapa.viaje_id;
      END IF;
      
  end insertar_cambioestado;
  
  -------------------------------------------------------------------------------------------------------------  
  --Crea un viaje, se verifica si el buque seleccionado es internacional, 
  --se crea la etapa inicial, 
  --registra el evento

  procedure crear_viaje(vBuque in varchar2, vOrigen in varchar2, vDestino in varchar2, vInicio in varchar2, vEta in varchar2, vZoe in varchar2, vZona in varchar, vProx in varchar, vInternacional in number, vLat in number, vLon in number, vRiocanal in varchar2, usrid in number, vCursor out cur) is
  begin
  
    select latitud, longitud, uso, rios_canales_km_id into posicion 
    from tbl_puntodecontrol pdc 
    left join rios_canales_km rck on pdc.rios_canales_km_id = rck.id  
    where pdc.id = vProx;
    
    tempdate := sysdate;
    
    DECLARE
      lat   varchar(100);
      lon   varchar(100);
      riokm number;
    BEGIN
      lat   := vLat;
      lon   := vLon;
      riokm := vRioCanal;
      
      IF lat is null or lon is null THEN
        lat := posicion.lat;
        lon := posicion.lon;
      END IF;
      
      IF riokm is null or riokm=0 THEN
        riokm := posicion.riokm;
      END IF;
      
      INSERT INTO tbl_viaje ( id, buque_id, origen_id, destino_id, fecha_salida, eta, zoe, 
                               latitud, longitud, created_at, rios_canales_km_id, riokm_actual, created_by, updated_at, updated_by ) 
       
      VALUES ( id_cargas.nextval, vBuque, vOrigen, vDestino, TO_DATE(vInicio, 'DD-MM-yy HH24:mi'), TO_DATE(vEta, 'DD-MM-yy HH24:mi'), TO_DATE(vZoe, 'DD-MM-yy HH24:mi'), 
                lat, lon, tempdate, riokm, riokm, usrid, tempdate, usrid ) returning id into temp;
    END;
   
    insert into tbl_etapa ( viaje_id, actual_id, destino_id, hrp, fecha_salida, created_at, sentido, created_by ) 
    VALUES ( temp, vZona, vProx, TO_DATE(vInicio, 'DD-MM-yy HH24:mi'), TO_DATE(vInicio, 'DD-MM-yy HH24:mi'), tempdate, null, usrid ) returning id into temp2;
    
    insert into tbl_evento ( usuario_id , viaje_id , etapa_id , tipo_id , fecha, puntodecontrol1_id, puntodecontrol2_id) 
    VALUES ( usrid, temp , temp2 , 1 , tempdate, vZona, vProx );
    
    open vCursor for select * from tbl_etapa where id = temp2;
  end crear_viaje;

  ---------------------------------------------------------------------------------------------------------------
  --Edita el viaje, se verifica si el buque seleccionado es internacional, 
  --registra el evento (TODO)
  
  procedure editar_viaje(vViaje in varchar2, vBuque in varchar2, vOrigen in varchar2, vDestino in varchar2, vInicio in varchar2, vEta in varchar2, vZoe in varchar2, vZona in varchar, vProx in varchar, vInternacional in number, vLat in number, vLon in number, vRiocanal in varchar2,usrid in number, vCursor out cur) is
  begin
    --IF vInternacional = 0 THEN
    --Sacar ID de esta lista cuando se habilite el sequence para los viajes
    update tbl_viaje SET  buque_id = vBuque, origen_id = vOrigen, destino_id = vDestino, fecha_salida = TO_DATE(vInicio, 'DD-MM-yy HH24:mi'), eta = TO_DATE(vEta, 'DD-MM-yy HH24:mi'), zoe = TO_DATE(vZoe, 'DD-MM-yy HH24:mi'), latitud = vLat, longitud = vLon, rios_canales_km_id = vRiocanal where id = vViaje ;
    --ELSE               --Sacar ID de esta lista cuando se habilite el sequence para los viajes
    --update tbl_viaje SET  buque_int_id = vBuque, origen_id = vOrigen, destino_id = vDestino, fecha_salida = vInicio, eta = vEta, zoe = vZoe, latitud = vLat, longitud = vLon, rios_canales_km_id = vRiocanal where id = vViaje;
    --END IF;
  end editar_viaje;

  ---------------------------------------------------------------------------------------------------------------
  --Edita el viaje, la verificacion de si el buque es internacional o internacional esta incluida en la vista, 
  --registra el evento (TODO)

  procedure traer_viaje(vViaje in varchar2, usrid in number, vCursor out cur) is
  begin
      open vCursor for select v.id, b.id_buque, b.nombre, b.matricula, b.tipo, m.cod origen_id, m.puerto origen, u.cod destino_id, u.puerto destino, v.fecha_salida, v.eta, v.zoe, v.notas, v.latitud, v.longitud, rc.nombre || ' - ' || rck.unidad || ' ' || rck.km riocanal 
      from tbl_viaje v 
      join buques b on v.buque_id = b.ID_BUQUE
      join tbl_kstm_puertos m on v.origen_id = m.cod
      join tbl_kstm_puertos u on v.destino_id = u.cod
      left join rios_canales_km rck on v.rios_canales_km_id = rck.id
      left join rios_canales rc on rck.id_rio_canal = rc.id
      where v.id = vViaje;
  end traer_viaje;

  ---------------------------------------------------------------------------------------------------------------
  --Finaliza el viaje, (Lo pasa a estado 1)
  --Registra el evento
  
  procedure terminar_viaje(vViajeId in number, vFecha in varchar2, vEscalas in varchar2, usrid in number, vCursor out cur) is
  begin
    
    tempdate := SYSDATE;
    
    update tbl_viaje set estado = 1, 
           fecha_llegada = TO_DATE(vFecha, 'DD-MM-yy HH24:mi'), 
           escalas = vEscalas,
           updated_by=usrid, 
           updated_at=tempdate
           where id = vViajeId;
    
    insert into tbl_evento ( usuario_id , viaje_id , tipo_id, fecha, created_at) 
    VALUES ( usrid , vViajeId , 9 , TO_DATE(vFecha, 'DD-MM-yy HH24:mi'), tempdate);
  end terminar_viaje;

  -------------------------------------------------------------------------------------------------------------
  --  

  procedure viajes_terminados(vZona in number, usrid in number, vCursor out cur) is
  begin
    open vCursor for
      select v.id, b.nombre, origen.puerto origen, destino.puerto destino,  v.etapa_actual ultima_etapa, e.actual_id 
        from tbl_viaje v
        left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual)
        join buques b on v.buque_id = b.ID_BUQUE
        join tbl_kstm_puertos origen on v.origen_id = origen.cod
        join tbl_kstm_puertos destino on v.destino_id = destino.cod
        where ROWNUM <= 10 and v.estado = 1 and e.actual_id = vZona;
 end viajes_terminados;
  
  
  -------------------------------------------------------------------------------------------------------------
  --  
  
  procedure reactivar_viaje(vViajeId in number , usrid in number, vCursor out cur) is
  begin
    update tbl_viaje set estado = 0, fecha_llegada = null where id = vViajeId;
    insert into tbl_evento ( usuario_id , viaje_id , tipo_id, fecha) VALUES ( usrid , vViajeId , 12 , SYSDATE);
  end reactivar_viaje;
  
  
  -------------------------------------------------------------------------------------------------------------
  --  
  
  procedure traer_pbip(vViaje in varchar2, usrid in number, vCursor out cur) is
  begin
      open vCursor for 
        select * from view_pbip where viaje = vViaje;
  end traer_pbip;
  
  -------------------------------------------------------------------------------------------------------------
  --  puertodematricula, numeroinmarsat, arqueobruto, compania, contactoOCPM, objetivo
  
  procedure modificar_pbip(vViaje in varchar2, vPuertoDeMatricula in varchar2, vNroInmarsat in varchar2, vArqueoBruto in varchar2, vCompania in varchar2, vContactoOCPM in varchar2, vObjetivo in varchar2, usrid in number, vCursor out cur) is
  begin
    insert into tbl_pbip (viaje_id, puertodematricula, nroinmarsat, arqueobruto, compania, contactoOCPM, objetivo ) VALUES (vViaje, vPuertoDeMatricula, vNroInmarsat, vArqueoBruto, vCompania, vContactoOCPM, vObjetivo );
  exception
    WHEN DUP_VAL_ON_INDEX THEN
    UPDATE tbl_pbip b SET puertodematricula = vPuertoDeMatricula,  nroinmarsat = vNroInmarsat,  arqueobruto = vArqueoBruto, compania = vCompania, contactoOCPM = vContactoOCPM, objetivo = vObjetivo where b.viaje_id = vViaje ;
  end modificar_pbip;

  procedure guardar_notas(vViaje in varchar2, vNotas in varchar2, usrid in number, vCursor out cur) is
  begin
    UPDATE tbl_viaje v SET v.notas = vNotas where v.id = vViaje ;
  end guardar_notas;

  procedure traer_notas(vViaje in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for 
      select notas from tbl_viaje where id = vViaje;
  end traer_notas;

  procedure editar_acompanante(vEtapa in varchar2, vBuque in varchar2, vBuque2 in varchar2, vBuque3 in varchar2, vBuque4 in varchar2, usrid in number, vCursor out cur) is
    begin
      UPDATE tbl_etapa e SET
        e.acompanante_id  = vBuque, 
        e.acompanante2_id = vBuque2, 
        e.acompanante3_id = vBuque3, 
        e.acompanante4_id = vBuque4 
      WHERE e.id = vEtapa returning e.viaje_id into temp;
      
      insert into tbl_evento ( usuario_id , viaje_id, etapa_id, tipo_id, fecha, acompanante_id, acompanante2_id, acompanante3_id, acompanante4_id ) 
      VALUES ( usrid , temp, vEtapa , 13 , SYSDATE, vBuque, vBuque2, vBuque3, vBuque4);
  end editar_acompanante;

  procedure traer_acompanantes(vEtapa in varchar2, usrid in number, vCursor out cur) is
    begin
    open vCursor for 
      select e.acompanante_id, acomp.nombre,
             e.acompanante2_id, acomp2.nombre nombre2,
             e.acompanante3_id, acomp3.nombre nombre3, 
             e.acompanante4_id, acomp4.nombre nombre4 
      from tbl_etapa e
        left join buques acomp on e.acompanante_id = acomp.ID_BUQUE
        left join buques acomp2 on e.acompanante2_id = acomp2.ID_BUQUE
        left join buques acomp3 on e.acompanante3_id = acomp3.ID_BUQUE
        left join buques acomp4 on e.acompanante4_id = acomp4.ID_BUQUE
      where id = vEtapa;
  end traer_acompanantes;
  
  --procedure quitar_acompanante(vEtapa in varchar2, usrid in number, vCursor out cur) is
  --  begin
  --    UPDATE tbl_etapa e SET e.acompanante_id = NULL where e.id = vEtapa returning e.viaje_id into temp;
  --    insert into tbl_evento ( usuario_id , viaje_id, etapa_id, tipo_id, fecha, acompanante_id ) VALUES ( usrid , temp, vEtapa , 14 , SYSDATE, NULL);
  --end quitar_acompanante;  
  
  procedure separar_convoy(vViaje in varchar2, vPartida in varchar2, usrid in number, vCursor out cur) is
    begin
      select * into viaje from tbl_viaje where id = vViaje;
      select * into etapa from tbl_etapa e where (viaje.id = e.viaje_id and e.nro_etapa = viaje.etapa_actual);
      update tbl_etapa set 
        acompanante_id = null,
        acompanante2_id = null,
        acompanante3_id = null,
        acompanante4_id = null
        where id = etapa.id;
      
      -- Intentamos crear con el 1
      IF etapa.acompanante_id IS NOT NULL THEN
        insert into tbl_viaje ( id, buque_id, origen_id, destino_id, fecha_salida, eta, zoe, viaje_padre ) 
        VALUES ( id_cargas.nextval, etapa.acompanante_id, viaje.origen_id, viaje.destino_id, SYSDATE, viaje.eta, viaje.zoe, viaje.id ) returning id into temp;
        
        insert into tbl_etapa ( nro_etapa, viaje_id, actual_id, sentido, created_at, created_by ) 
        VALUES ( 0, temp, etapa.actual_id, etapa.sentido, sysdate, usrid) returning id into temp2;
      END IF;

      -- Intentamos crear con el 2
      IF etapa.acompanante2_id IS NOT NULL THEN
        insert into tbl_viaje ( id, buque_id, origen_id, destino_id, fecha_salida, eta, zoe, viaje_padre ) 
        VALUES ( id_cargas.nextval, etapa.acompanante2_id, viaje.origen_id, viaje.destino_id, SYSDATE, viaje.eta, viaje.zoe, viaje.id ) returning id into temp;
        
        insert into tbl_etapa ( nro_etapa, viaje_id, actual_id, sentido, created_at, created_by ) 
        VALUES ( 0, temp, etapa.actual_id, etapa.sentido, sysdate, usrid) returning id into temp2;
      END IF;

      -- Intentamos crear con el 3
      IF etapa.acompanante3_id IS NOT NULL THEN
        insert into tbl_viaje ( id, buque_id, origen_id, destino_id, fecha_salida, eta, zoe, viaje_padre ) 
        VALUES ( id_cargas.nextval, etapa.acompanante3_id, viaje.origen_id, viaje.destino_id, SYSDATE, viaje.eta, viaje.zoe, viaje.id ) returning id into temp;
        
        insert into tbl_etapa ( nro_etapa, viaje_id, actual_id, sentido, created_at, created_by ) 
        VALUES ( 0, temp, etapa.actual_id, etapa.sentido, sysdate, usrid) returning id into temp2;
      END IF;

      -- Intentamos crear con el 4
      IF etapa.acompanante4_id IS NOT NULL THEN
        insert into tbl_viaje ( id, buque_id, origen_id, destino_id, fecha_salida, eta, zoe, viaje_padre ) 
        VALUES ( id_cargas.nextval, etapa.acompanante4_id, viaje.origen_id, viaje.destino_id, SYSDATE, viaje.eta, viaje.zoe, viaje.id ) returning id into temp;
        
        insert into tbl_etapa ( nro_etapa, viaje_id, actual_id, sentido, created_at, created_by ) 
        VALUES ( 0, temp, etapa.actual_id, etapa.sentido, sysdate, usrid) returning id into temp2;
      END IF;

      -- Logueamos el evento
      insert into tbl_evento ( usuario_id , viaje_id , etapa_id , tipo_id , buque_id, fecha, acompanante_id, acompanante2_id, acompanante3_id, acompanante4_id) 
      VALUES ( usrid, viaje.id , etapa.id , 15 , viaje.buque_id, SYSDATE, etapa.acompanante_id, etapa.acompanante2_id, etapa.acompanante3_id, etapa.acompanante4_id );
      
      open vCursor for 
        select id from tbl_etapa where id = temp2;
  end separar_convoy;
  
  ---------------------------------------------------------------------------------------------------------------
  -----------------------------------------Etapa-----------------------------------------------------------------
  ---------------------------------------------------------------------------------------------------------------  

  ---------------------------------------------------------------------------------------------------------------
  procedure id_ultima_etapa(vViaje in number, usrid in number, vCursor out cur) is
  begin
    open vCursor for select e.id from tbl_viaje v left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual) where v.id = vViaje;
  end id_ultima_etapa;
  
  --Indica tentativamente cual sera el proximo punto de control
  --Trae el viaje, trae la etapa
  --Actualiza la etapa indicando el punto de control como destino
  
  procedure indicar_proximo(vViajeId in number, vZonaId in number, usrid in number, vCursor out cur) is
  begin
    select * into viaje from tbl_viaje where id = vViajeId;
    select * into etapa from tbl_etapa where nro_etapa = viaje.etapa_actual and viaje_id = viaje.id;
    temp := etapa.id;
    update tbl_etapa set destino_id = vZonaId where id = etapa.id;
    --insert into tbl_evento (      usuario_id , viaje_id , etapa_id, tipo_id, fecha, comentario)
    --values ( usrid, viaje.id , etapa.id, 1, SYSDATE, 'de ' || etapa.origen_id || ' a ' || etapa.actual_id);
  end indicar_proximo;

  ---------------------------------------------------------------------------------------------------------------
  --Pasa un barco de un punto de control a otro
  --Trae el viaje, trae la ultima etapa del viaje, actualiza el proximo destino en la ultima etapa  
  --Crea una etapa nueva (copia de la ultima etapa),   
  --Copia las cargas de la etapa anterior en la recien creada,
  --Registra el evento
  
  procedure pasar_barco(vViajeId in varchar2, vZonaId in varchar2, vEta in varchar2, vLlegada in varchar2, vVelocidad in number, vRumbo in number, usrid in number, vCursor out cur) is
  begin

    select latitud, longitud, uso, rios_canales_km_id into posicion
    from tbl_puntodecontrol pdc 
    left join rios_canales_km rck on pdc.rios_canales_km_id = rck.id  
    where pdc.id = vZonaId;
    
    select * into viaje from tbl_viaje where id = vViajeId;
    select * into etapa from tbl_etapa where nro_etapa = viaje.etapa_actual and viaje_id = viaje.id;
    update tbl_etapa set destino_id = vZonaId, fecha_llegada = TO_DATE(vLlegada , 'DD-MM-yy HH24:mi') where id = etapa.id;
    select * into etapa from tbl_etapa where nro_etapa = viaje.etapa_actual and viaje_id = viaje.id;
   
    temp := etapa.id;
    tempdate := SYSDATE;
    
    --diventi
    --insert into tbl_etapa (   VIAJE_ID,       ORIGEN_ID,        ACTUAL_ID,                      HRP,        ETA,          FECHA_SALIDA,                 CANTIDAD_TRIPULANTES,       CANTIDAD_PASAJEROS,         CAPITAN_ID,               CALADO_PROA,         CALADO_POPA,       CALADO_MAXIMO,       CALADO_INFORMADO,        KM,       ACOMPANANTE_ID,        CREATED_AT,      SENTIDO ) 
    --VALUES (                  etapa.viaje_id, etapa.actual_id,  vZonaId,                  etapa.hrp,        vEta,         etapa.fecha_llegada,           etapa.cantidad_tripulantes, etapa.cantidad_pasajeros,    etapa.capitan_id,        etapa.calado_proa,   etapa.calado_popa,  etapa.calado_maximo, etapa.calado_informado,  etapa.km,  etapa.acompanante_id, sysdate,       null ) 
    --returning ID, NRO_ETAPA, VIAJE_ID,        ORIGEN_ID,        ACTUAL_ID, DESTINO_ID,          HRP,        ETA,         FECHA_SALIDA,  FECHA_LLEGADA, CANTIDAD_TRIPULANTES,       CANTIDAD_PASAJEROS,          CAPITAN_ID,              CALADO_PROA,         CALADO_POPA,        CALADO_MAXIMO,       CALADO_INFORMADO,        KM,       ACOMPANANTE_ID,       CREATED_AT,      SENTIDO                            

    --prefe
    --insert into tbl_etapa (   VIAJE_ID,       ORIGEN_ID,        ACTUAL_ID,                      HRP,        ETA,          FECHA_SALIDA,                 CANTIDAD_TRIPULANTES,       CANTIDAD_PASAJEROS,         CAPITAN_ID, SENTIDO,              CALADO_PROA,         CALADO_POPA,       CALADO_MAXIMO,       CALADO_INFORMADO,        KM,       ACOMPANANTE_ID,        CREATED_AT ) 
    --VALUES (                  etapa.viaje_id, etapa.actual_id,  vZonaId,                  etapa.hrp,  vEta,         etapa.fecha_llegada,                etapa.cantidad_tripulantes, etapa.cantidad_pasajeros,    etapa.capitan_id, null,       etapa.calado_proa,   etapa.calado_popa,  etapa.calado_maximo, etapa.calado_informado,  etapa.km,  etapa.acompanante_id, sysdate) 
    --returning ID, NRO_ETAPA, VIAJE_ID,        ORIGEN_ID,        ACTUAL_ID, DESTINO_ID,          HRP,        ETA,         FECHA_SALIDA,  FECHA_LLEGADA, CANTIDAD_TRIPULANTES,       CANTIDAD_PASAJEROS,          CAPITAN_ID, SENTIDO,             CALADO_PROA,         CALADO_POPA,        CALADO_MAXIMO,       CALADO_INFORMADO,        KM,       ACOMPANANTE_ID,       CREATED_AT                            
    
    --casa
    insert into tbl_etapa ( VIAJE_ID, ORIGEN_ID, ACTUAL_ID, HRP, ETA,
                           FECHA_SALIDA, CANTIDAD_TRIPULANTES, CANTIDAD_PASAJEROS, 
                           CAPITAN_ID, SENTIDO, CALADO_PROA, CALADO_POPA, CALADO_MAXIMO, 
                           CALADO_INFORMADO, KM, CREATED_AT, acompanante_id, acompanante2_id, 
                           acompanante3_id, acompanante4_id, VELOCIDAD, RUMBO, CREATED_BY ) 
    
    VALUES ( etapa.viaje_id, etapa.actual_id, vZonaId, etapa.fecha_llegada, TO_DATE(vEta, 'DD-MM-yy HH24:mi'), 
            etapa.fecha_llegada, etapa.cantidad_tripulantes, etapa.cantidad_pasajeros, 
            etapa.capitan_id, null, etapa.calado_proa, etapa.calado_popa, etapa.calado_maximo, 
            etapa.calado_informado, etapa.km, tempdate, etapa.acompanante_id, etapa.acompanante2_id, 
            etapa.acompanante3_id, etapa.acompanante4_id, vVelocidad, vRumbo, usrid )
    
    returning ID,NRO_ETAPA,VIAJE_ID,ORIGEN_ID,ACTUAL_ID,DESTINO_ID,HRP,ETA,FECHA_SALIDA,
              FECHA_LLEGADA,CANTIDAD_TRIPULANTES,CANTIDAD_PASAJEROS,CAPITAN_ID,CALADO_PROA,
              CALADO_POPA,CALADO_MAXIMO,CALADO_INFORMADO,KM,CREATED_AT,ACOMPANANTE_ID,
              ACOMPANANTE2_ID, ACOMPANANTE3_ID, ACOMPANANTE4_ID, SENTIDO,VELOCIDAD,RUMBO, CREATED_BY

    into etapa;
    
    insert into tbl_cargaetapa ( id, tipocarga_id, CANTIDAD_ENTRADA, CANTIDAD_SALIDA, CANTIDAD_INICIAL, CANTIDAD, unidad_id, etapa_id, buque_id ) 
    ( select carga_seq.nextval, tipocarga_id, 0, 0, cantidad, cantidad, unidad_id, replace(etapa_id, etapa_id, etapa.id), buque_id 
    from tbl_cargaetapa where etapa_id = temp );
    
    insert into tbl_practicoetapa ( practico_id, etapa_id, activo) ( select practico_id, replace(etapa_id, etapa_id, etapa.id), activo from tbl_practicoetapa where etapa_id = temp );
    
    if posicion.uso = 0 THEN
      insert into tbl_evento (usuario_id, viaje_id, etapa_id, tipo_id, latitud, longitud, fecha) 
      values (usrid, etapa.viaje_id, etapa.id, 19, posicion.lat, posicion.lon, tempdate);
    end if;
    
    --BEGIN_NOTA: esto siempre? o solo para los puntos de control fluviales?
    update tbl_viaje set latitud=posicion.lat, longitud=posicion.lon, updated_at=tempdate, updated_by=usrid, riokm_actual=posicion.riokm where id=etapa.viaje_id;
    --ENDNOTA
    
    insert into tbl_evento (usuario_id , viaje_id , etapa_id, tipo_id, puntodecontrol1_id, puntodecontrol2_id, fecha)
    values ( usrid, viaje.id , etapa.id, 7, etapa.origen_id, etapa.actual_id , tempdate  );
    
    open vCursor for select * from tbl_etapa where id = etapa.id;
  end pasar_barco;

  ---------------------------------------------------------------------------------------------------------------
  --Procedimiento auxiliar utilizado por los dos anteriores para crear los menues de los puntos de control a los que es posible pasar el buque
  --usando la matriz. Ignora si el buque esta en bajada o subida
  
  procedure zonas_adyacentes( vZonaId in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for 
      select unique(p.id), CUATRIGRAMA, rc.NOMBRE CANAL, rck.KM, rck.UNIDAD from tbl_puntodecontrol p
      inner join tbl_conexionpuntodecontrol cxz on p.id = cxz.puntodecontrol1 or p.id = cxz.puntodecontrol2
      inner join tbl_zonas z on p.zona_id = z.id
      left join rios_canales_km rck on rck.id = p.rios_canales_km_id
      left join rios_canales rc on rc.id = rck.ID_RIO_CANAL
      
      where (cxz.puntodecontrol1 = vZonaId or cxz.puntodecontrol2 = vZonaId) and p.id != vZonaId;
    
--    select unique(p.id), CUATRIGRAMA, KM 
--      from tbl_puntodecontrol p
--      inner join tbl_conexionpuntodecontrol cxz on p.id = cxz.puntodecontrol1 or p.id = cxz.puntodecontrol2
--      inner join tbl_zonas z on p.zona_id = p.id
--    where (cxz.puntodecontrol1 = vZonaId or cxz.puntodecontrol2 = vZonaId) and p.id != vZonaId;
  end zonas_adyacentes;

  --unique(p.ID), CUATRIGRAMA, DESCRIPCION, NIVEL, DIRECCION_POSTAL, UBIC_GEOG, DEPENDENCIA, ESTADO, CODNUM, ZONA, NIVELNUM, RPV, INT, MAIL, TE, FAX, COD_CARGO, DESCENTRALIZADO, CANAL, KM
  ---------------------------------------------------------------------------------------------------------------
  --Trae la etapa actual del viaje
  --con sus practicos y capitanes
  
  procedure traer_etapa(vViaje in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for 
    select v.id viaje_id, e.id etapa_id, e.nro_etapa, e.origen_id, e.actual_id, e.destino_id, e.calado_proa, e.calado_popa, e.calado_maximo, e.calado_informado, e.hrp, e.eta, e.fecha_salida, e.fecha_llegada, e.cantidad_tripulantes, e.cantidad_pasajeros,  c.nombre capitan, c.id capitan_id, e.rumbo, e.velocidad
    from tbl_viaje v 
    left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual) 
    left join tbl_capitan c on (e.capitan_id = c.id)
    WHERE v.id = vViaje;  
  end traer_etapa;

  ---------------------------------------------------------------------------------------------------------------
  --Edita la informacion etapa
  --Registra el evento

  procedure editar_etapa(vEtapa in varchar2, vCaladoProa in varchar2, vCaladoPopa in varchar2, vCaladoInformado in varchar2, vHPR in varchar2, vETA in varchar2, vFechaSalida in varchar2, vCantidadTripulantes in varchar2, vCantidadPasajeros in varchar2, vCapitan in varchar2, vVelocidad in number, vRumbo in number, usrid in number, vCursor out cur) is
  begin
      
      -- CAMBIAR ACA EN PREFECTURA CAST( REPLACE(____,'.',',') AS NUMBER);
      update tbl_etapa SET
        calado_proa          = vCaladoProa,
        calado_popa          = vCaladoPopa,
        calado_informado     = vCaladoInformado,
        hrp                  = TO_DATE(vHPR, 'DD-MM-yy HH24:mi'),
        eta                  = TO_DATE(vETA, 'DD-MM-yy HH24:mi'),
        fecha_salida         = TO_DATE(vFechaSalida, 'DD-MM-yy HH24:mi'),
        cantidad_tripulantes = vCantidadTripulantes,
        cantidad_pasajeros = vCantidadPasajeros,
        --practico_id = vPractico,
        capitan_id = vCapitan,
        rumbo = vRumbo,
        velocidad = vVelocidad
      where id = vEtapa;
      select * into etapa from tbl_etapa where id=vEtapa;
      insert into tbl_evento ( viaje_id, usuario_id , etapa_id, tipo_id, fecha, rumbo, velocidad ) VALUES ( etapa.viaje_id, usrid, vEtapa , 8, SYSDATE, vRumbo, vVelocidad);
  end editar_etapa;    
  
  procedure traer_buque_de_etapa(vEtapa in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
      select e.id, b.* from buques b
      left join tbl_viaje v on v.buque_id = b.ID_BUQUE
      left join tbl_etapa e on v.id = e.viaje_id
      where e.id = vEtapa;
  end traer_buque_de_etapa;

  procedure traer_practicos(vViaje in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
      SELECT pv.id, pr.nombre, pv.fecha_subida, pv.fecha_bajada FROM tbl_practicoviaje pv 
      LEFT JOIN tbl_practico pr ON pv.practico_id=pr.id
      WHERE pv.viaje_id=vViaje;
  end traer_practicos;
  
  procedure eliminar_practicos(vEtapa in varchar2, usrid in number, vCursor out cur) is
  begin
    delete from tbl_practicoetapa where etapa_id = vEtapa;
  end eliminar_practicos;
  
  procedure agregar_practico(vEtapa in varchar2, vPractico in varchar2, vFecha in varchar2, usrid in number, vCursor out cur) is
  begin
    select * into etapa from tbl_etapa where id = vEtapa;
    
    insert into tbl_practicoviaje (viaje_id, etapa_subida, practico_id, fecha_subida) 
    values( etapa.viaje_id, etapa.id, vPractico, vFecha);

    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, fecha) 
    VALUES (etapa.viaje_id, etapa.id, usrid, 16, vFecha);
  
  end agregar_practico;
  ---------------------------------------------------------------------------------------------------------------
  ---------------------------------------------Cargas------------------------------------------------------------
  ---------------------------------------------------------------------------------------------------------------
  -------------------------------------------------------------------------------------------------------------
  --

  procedure barcazas_utilizadas(usrid in number, vCursor out cur) is
  begin
    open vCursor for
      select unique(c.buque_id) from tbl_viaje v 
      left join tbl_etapa e on e.viaje_id = v.id
      left join tbl_cargaetapa c on c.etapa_id = e.id
      where v.estado = 0 and c.buque_id is not null;
  end barcazas_utilizadas;
  
  -------------------------------------------------------------------------------------------------------------
  --
  procedure corregir_barcaza(vEtapa in varchar2, vBuque in varchar2, usrid in number, vCursor out cur) is
  begin
    select * into etapa from tbl_etapa where id = vEtapa;
    
    update tbl_cargaetapa set buque_id=vBuque where etapa_id=vEtapa;
    
    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, buque_id, fecha) 
                VALUES (etapa.viaje_id, etapa.id, usrid, 25, vBuque, SYSDATE);
  
  end corregir_barcaza;
  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure descargar_barcaza(vEtapaId in varchar2, vBarcazaId in varchar2, usrid in number, vCursor out cur) is
  begin
    declare
    begin
      for carga in ( select id from tbl_cargaetapa where buque_id = vBarcazaId and etapa_id=vEtapaId)
      loop
      eliminar_carga(carga.id, 0, usrid, vCursor);
      end loop;
    end;
    
    --  ACA VA EL ID DEL TIPO DE CARGA LASTRE
    --  [412]
    select * into etapa from tbl_etapa where id = vEtapaId;
    insert into tbl_cargaetapa ( ID, TIPOCARGA_ID, CANTIDAD, CANTIDAD_INICIAL, UNIDAD_ID, ETAPA_ID, BUQUE_ID ) 
      VALUES ( carga_seq.nextval, 412, 0, 0, 0, vEtapaId, vBarcazaId) returning id into temp; 
    
    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, barcaza_id, fecha) 
    VALUES (etapa.viaje_id, vEtapaId, usrid, 21, vBarcazaId, SYSDATE);


  end descargar_barcaza;
  
  
  -------------------------------------------------------------------------------------------------------------
  --

  procedure traer_cargas( vEtapaId in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
    select tc.nombre, c.cantidad, c.cantidad_inicial, c.cantidad_entrada, c.cantidad_salida, 
           u.nombre unidad, tc.codigo, c.tipocarga_id, c.id carga_id, b.nombre barcaza, b.id_buque 
           from tbl_cargaetapa c
    join tbl_tipo_carga tc on c.tipocarga_id = tc.id
    join tbl_unidad u on c.unidad_id = u.id
    left join buques b on b.id_buque = c.buque_id
    where c.etapa_id = vEtapaId order by barcaza;
  end traer_cargas;
  
  -------------------------------------------------------------------------------------------------------------
  --

  procedure traer_cargas_nobarcazas( vEtapaId in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
    select c.etapa_id, tc.nombre, c.cantidad, c.cantidad_inicial, c.cantidad_entrada, 
    c.cantidad_salida, u.id unidad_id, u.nombre unidad, tc.codigo, c.tipocarga_id, c.id carga_id,
    c.en_transito
    from tbl_cargaetapa c
    join tbl_tipo_carga tc on c.tipocarga_id = tc.id
    join tbl_unidad u on c.unidad_id = u.id
    where c.etapa_id = vEtapaId and c.buque_id is null and c.en_transito = 0;
  end traer_cargas_nobarcazas;
  
  -------------------------------------------------------------------------------------------------------------
  --  

  procedure traer_carga_por_codigo(vCodigo in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for select * from tbl_tipo_carga where codigo = vCodigo;
  end traer_carga_por_codigo;

  -------------------------------------------------------------------------------------------------------------
  --  

  procedure traer_barcazas_de_buque(vEtapa in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
    select distinct( c.buque_id ), b.nombre from tbl_cargaetapa c
    join tbl_tipo_carga tc on c.tipocarga_id = tc.id
    join tbl_unidad u on c.unidad_id = u.id
    left join buques b on b.id_buque = c.buque_id
    where c.etapa_id = vEtapa and c.buque_id IS NOT NULL;
  end traer_barcazas_de_buque;
  
  -------------------------------------------------------------------------------------------------------------
  --  
  
  procedure transferir_barcazas(vBarcaza in varchar2, vEtapa in varchar2, usrid in number) is
  begin
      declare
        eorig number;
        edest number;
      begin
        
        --Etapa actual del viaje duen/o de la barcaza
        select max(etapa_id) into eorig from tbl_cargaetapa where buque_id=vBarcaza;
        
        --Etapa destino
        edest := vEtapa;

        --Ya estaba en mi viaje esta barcaza?
        IF edest != eorig THEN
        
          --Traigo las cargas de la etapa origen que tiene esa barcaza
          for carga in ( select id from tbl_cargaetapa where buque_id = vBarcaza and etapa_id=eorig)
          loop
            
            --Indico que a este viaje se le fueron estas barcazas
            select * into etapa from tbl_etapa where id = eorig;
            insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, barcaza_id, carga_id, fecha)
            VALUES (etapa.viaje_id, etapa.id, usrid, 11, vBarcaza, carga.id, SYSDATE);
            
            --Indico que este viaje recibio estas barcazas
            select * into etapa from tbl_etapa where id = edest;
            insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, barcaza_id, carga_id, fecha)
            VALUES (etapa.viaje_id, etapa.id, usrid, 10, vBarcaza, carga.id, SYSDATE);
          
          END LOOP;
          
          --Paso las barcazas
          UPDATE tbl_cargaetapa ce set etapa_id = edest 
          where etapa_id=eorig and buque_id=vBarcaza;

        END IF;
        
      END;

      
      -- a este viaje (vEtapa.viaje) se le agregp la carga (vCarga)

  end transferir_barcazas;
  
  -------------------------------------------------------------------------------------------------------------
  --  

  procedure transferir_cargas(vEtapa in varchar2, vCarga in varchar2, vCantidad in varchar2, vUnidad in varchar2, vTipo in varchar2, vModo in varchar2, vOriginal in varchar2, vRecEmi in varchar2, usrid in number) is
  begin
      DECLARE

      BEGIN
        --traemos la etapa
        select * into etapa from tbl_etapa where id=vEtapa;
      
        IF vModo = 'add' THEN
          insert into tbl_cargaetapa ( ID, TIPOCARGA_ID, CANTIDAD, UNIDAD_ID, ETAPA_ID, EN_TRANSITO, CANTIDAD_INICIAL ) 
          VALUES ( carga_seq.nextval, vTipo, vCantidad, vUnidad, vEtapa, 0, vCantidad) returning id into temp; 
          
          -- log usrid id in number  
          insert into tbl_evento ( usuario_id , viaje_id , etapa_id , tipo_id , fecha, carga_id ) 
          VALUES ( usrid, etapa.viaje_id , etapa.id , 26, SYSDATE, temp );
          
        END IF;
        IF vModo = 'upd' THEN
          update tbl_cargaetapa set CANTIDAD = vCantidad where ID=vCarga;
          
          if vRecEmi = 'ree' THEN
            -- log usrid vCarga in number  
            insert into tbl_evento ( usuario_id , viaje_id , etapa_id , tipo_id , fecha, carga_id ) 
            VALUES ( usrid, etapa.viaje_id , etapa.id , 26, SYSDATE, vCarga );
          ELSE
            -- log usrid vCarga in number  
            insert into tbl_evento ( usuario_id , viaje_id , etapa_id , tipo_id , fecha, carga_id ) 
            VALUES ( usrid, etapa.viaje_id , etapa.id , 27, SYSDATE, vCarga );
          END IF;

        END IF;
        IF vModo = 'del' THEN
          delete from tbl_cargaetapa where ID=vCarga;
          -- log usrid id in number  
          insert into tbl_evento ( usuario_id , viaje_id , etapa_id , tipo_id , fecha, carga_id ) 
          VALUES ( usrid, etapa.viaje_id , etapa.id , 27, SYSDATE, vCarga );
          
        END IF;
      END;

  end transferir_cargas;
  
  -------------------------------------------------------------------------------------------------------------
  --  

  procedure traer_unidades(usrid in number, vCursor out cur) is
  begin
    open vCursor for select * from tbl_unidad;
    
  end traer_unidades;
  
  -------------------------------------------------------------------------------------------------------------
  --  
  
  procedure insertar_carga( vEtapa in varchar2, vCarga in varchar2, vCantidad in varchar2, vUnidad in varchar2, vBuque in varchar2,  vEnTransito in varchar2, usrid in number, vCursor out cur) is
  begin
      
    --  ACA VA EL ID DEL TIPO DE CARGA LASTRE
    --  [412]
    IF vBuque is not null THEN
      delete from tbl_cargaetapa where etapa_id=vEtapa and TIPOCARGA_ID=412 and buque_id=vBuque;
    ELSE
      delete from tbl_cargaetapa where etapa_id=vEtapa and TIPOCARGA_ID=412;
    END IF;

    -- CAMBIAR ACA EN PREFECTURA CAST(REPLACE(____,'.',',') AS NUMBER);

    select * into etapa from tbl_etapa where id = vEtapa;
    
    insert into tbl_cargaetapa ( ID, TIPOCARGA_ID, CANTIDAD, UNIDAD_ID, ETAPA_ID, BUQUE_ID, EN_TRANSITO, CANTIDAD_INICIAL ) 
    VALUES ( carga_seq.nextval, vCarga, vCantidad, vUnidad, vEtapa, vBuque, vEnTransito, vCantidad) returning id into temp; 
    
    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, carga_id, fecha) VALUES (etapa.viaje_id, etapa.id, usrid, 4, temp, SYSDATE);
    
  end insertar_carga;  
  
  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure modificar_carga(vCarga in varchar2, vCantidadEntrada in varchar2, vCantidadSalida in varchar2, usrid in number, vCursor out cur) is
  begin
    
    -- CAMBIAR ACA EN PREFECTURA CAST(REPLACE(____,'.',',') AS NUMBER);
    temp  := vCantidadEntrada;
    temp2 := vCantidadSalida;
    
    select * into etapa from tbl_etapa where id = (select etapa_id from tbl_cargaetapa where id=vCarga);
    select * into cetapa from tbl_cargaetapa where id=vCarga;
    update tbl_cargaetapa set 
      cantidad_entrada = temp, 
      cantidad_salida  = temp2, 
      cantidad         = (cetapa.cantidad_inicial + temp - temp2) 
    where id = vCarga returning id into temp;
      
    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, carga_id, fecha) VALUES (etapa.viaje_id, etapa.id, usrid, 5, temp, SYSDATE);
  end modificar_carga;

  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure check_empty(vEtapaId in number, vBuqueId in number) is
  begin
    select count(*) into temp from tbl_cargaetapa where etapa_id = vEtapaId and buque_id=vBuqueId;
    IF temp = 0 THEN
      insert into tbl_cargaetapa ( ID, TIPOCARGA_ID, CANTIDAD_INICIAL, CANTIDAD, UNIDAD_ID, ETAPA_ID, BUQUE_ID ) 
      VALUES ( carga_seq.nextval, 412, 0, 0, 0, cetapa.etapa_id, cetapa.buque_id) returning id into temp; 
    END IF;
  end check_empty;

  procedure adjuntar_barcazas(vEtapaId in number, vViajeId in number, usrid in number) is
  begin
    
    --for i in 1 .. vViajeId.count
    --loop
      --id del viaje falso
      --temp := vViajeId(i);
      temp := vViajeId;
      
      --Traigo la unica etapa del viaje falso que tenia a la barcaza como cargas
      select * into etapa from tbl_etapa where viaje_id=temp;
      
      --Cambio las cargas al nuevo viaje (etapa actual = vEtapaId)
      update tbl_cargaetapa set etapa_id=vEtapaId where etapa_id=etapa.id;
      
      --Borro el viaje falso y la etapa falsa (todo lo relativo a viaje_id)
      delete from tbl_etapa where viaje_id=temp;
      delete from tbl_viaje where id=temp;
    
      --Traemos la etapa actual (la que se lleva las barcazas)
      select * into etapa from tbl_etapa where id=vEtapaId;
      
      -- Logueamos
      insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, barcaza_id, fecha) 
      VALUES (etapa.viaje_id, etapa.id, usrid, 23, viaje.buque_id, SYSDATE);
    
    --end loop;
    
  end adjuntar_barcazas;
  
  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure fondear_barcaza(vEtapaId in number, vBarcazaId in number, vRioCanalKM in varchar2, vLat in number, vLon in number, vFecha in varchar2, usrid in number, vCursor out cur) is
  begin
  
    -- Traigo el viaje original que esta dejando la barcaza fondeada
    select * into viaje from tbl_viaje where id = (select viaje_id from tbl_etapa where id=vEtapaId);
    select * into etapa from tbl_etapa where id = vEtapaId;
    
    tempdate := sysdate;
    
    -- Creo viaje ficticio para mover las cargas ahi (n)
    insert into tbl_viaje (id  , fecha_salida                             , etapa_actual, estado, viaje_padre , latitud, longitud, created_at, created_by, updated_at, updated_by, rios_canales_km_id, riokm_actual, buque_id)  
    values                (null, TO_DATE(vFecha      , 'DD-MM-yy HH24:mi'), 0           , 100   , viaje.id    , vLat   , vLon    , tempdate  , usrid,      tempdate,   usrid,      vRioCanalKM,        vRioCanalKM,  vBarcazaId) 
    returning id into temp;
      
    -- Creo una etapa
    insert into tbl_etapa ( viaje_id, actual_id, nro_etapa, sentido, created_at, created_by ) 
    VALUES ( temp, etapa.actual_id, 0, 1, tempdate, usrid ) returning id into temp2;
    
    -- Muevo las cargas a la etapa 0 el viaje ficticio recien creado
    update tbl_cargaetapa set etapa_id=temp2 where etapa_id=vEtapaId and buque_id=vBarcazaId;
   
    -- Logueamos
    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, barcaza_id, fecha, rios_canales_km_id, latitud, longitud) 
    VALUES (viaje.id, vEtapaId, usrid, 22, vBarcazaId, tempdate, vRioCanalKM, vLat, vLon);
   
  end fondear_barcaza;

  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure eliminar_carga(vCarga in varchar2, checkempty in number, usrid in number, vCursor out cur) is
  begin
    select * into cetapa from tbl_cargaetapa where id=vCarga;
    select * into etapa from tbl_etapa where id = cetapa.etapa_id;
    
    delete from tbl_cargaetapa where id = vCarga;
    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, carga_id, fecha) VALUES (etapa.viaje_id, etapa.id, usrid, 6, vCarga, SYSDATE);

    -- Ver si tiene mas cargas esta barcaza, sino, ponerle un lastre
    IF checkempty != 0 AND cetapa.buque_id is not null THEN
      check_empty(cetapa.etapa_id, cetapa.buque_id);
    END IF;
     
  end eliminar_carga;

  -------------------------------------------------------------------------------------------------------------
  --
 
  procedure detalles_tecnicos( vShipId in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for 
      select *
      from buques b 
      where id_buque = vShipId;
  end detalles_tecnicos;
  
  -------------------------------------------------------------------------------------------------------------
  --  

  procedure autocomplete_barcazas(vEtapaId in varchar2, vQuery in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for 
      --Todas las barcazas
      select id_buque, nombre from buques b where ( UPPER(TIPO_BUQUE) like 'BARCAZA%' or UPPER(TIPO_BUQUE) like 'BALSA%' )
                                              and   UPPER(nombre) like '%'||UPPER(vQuery)||'%' 
      --Que no sean las ...
      and UPPER(id_buque) not in (
        
        ---Barcazas usadas en la ultima etapa por los otros viajes
        select c.buque_id
          from tbl_viaje v   
            join tbl_etapa e on v.id = e.viaje_id and v.estado = 0 and v.etapa_actual = e.nro_etapa and e.id != vEtapaId
            join tbl_cargaetapa c on e.id = c.etapa_id and c.buque_id is not null 
        union
        
        ---Ni barcazas fondeadas
        select v.buque_id from tbl_viaje v where estado=100
      ) and rownum < 6 order by nombre ;
  end autocomplete_barcazas;

  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure autocompleter(vVista in varchar2, vQuery in varchar2, usrid in number, vCursor out cur) is
  begin
    sql_stmt := 'select * from ' || vVista || ' where upper(nombre) like upper(:vQuery) and rownum <= 6';
    open vCursor for sql_stmt USING vQuery;
  end autocompleter;
  -------------------------------------------------------------------------------------------------------------
  --
  procedure autocomplete_muelles(vQuery in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for 
      select m.ID, m.DESCRIPCION
      from tbl_muelles m 
      where upper(m.DESCRIPCION) like '%'||UPPER(vQuery)||'%'
      and rownum < 6;
  end autocomplete_muelles;
  -------------------------------------------------------------------------------------------------------------
  --
  procedure autocomplete_cargas(vQuery in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for 
      select tc.ID, tc.NOMBRE, tc.CODIGO, tc.UNIDAD_ID, un.NOMBRE UNOMBRE
      from tbl_tipo_carga tc left join tbl_unidad un on tc.unidad_id=un.id
      where ( upper(tc.nombre) like '%'||UPPER(vQuery)||'%' or upper(tc.codigo) like '%'||UPPER(vQuery)||'%'  )
      and rownum < 6;
  end autocomplete_cargas;
  -------------------------------------------------------------------------------------------------------------
  --

  procedure autocompletebactivos(vQuery in varchar2, usrid in number, vCursor out cur) is
  begin
    sql_stmt := 'select v.id, v.buque_id, viaje_id, e.id etapa_id, b.nombre, b.sdist, b.nro_omi from buques b 
                        left join tbl_viaje v on v.buque_id = b.ID_BUQUE 
                        left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual) 
                        where v.estado=0 and (upper(b.nombre) like upper(:vQuery) or 
                            upper(b.bandera) like upper(:vQuery) or 
                            upper(b.matricula) like upper(:vQuery) or 
                            upper(b.nro_omi) like upper(:vQuery) or 
                            upper(b.nro_ismm) like upper(:vQuery)) and 
                            rownum <= 6 ';
    open vCursor for sql_stmt USING vQuery,vQuery,vQuery,vQuery,vQuery;
  end autocompletebactivos;
  
  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure autocompleterioscanales(vQuery in varchar2, usrid in number, vCursor out cur) is
  begin
  
    select upper(SUBSTR(vQuery, 1 ,INSTR(vQuery,' ', 1, 1)-1)) || '%' into strtemp1  from dual;
    select upper('%' || SUBSTR(vQuery, INSTR(vQuery,' ', 1, 1)+1, INSTR(vQuery,' ',1,2)-INSTR(vQuery,' ',1,1)-1) || '%') into strtemp2  from dual;
    select '%' || upper(SUBSTR(vQuery, INSTR(vQuery,' ', -1, 1)+1)) into strtemp3 from dual;
    
    --TRUNC(rck.LATITUD)+(rck.LATITUD-TRUNC(rck.LATITUD))*0.6,TRUNC(rck.LONGITUD)+(rck.LONGITUD-TRUNC(rck.LONGITUD))*0.6
    temp3 := 'select rck.ID, rck.KM, rck.UNIDAD, rc.NOMBRE, TRUNC(rck.LATITUD)+(rck.LATITUD-TRUNC(rck.LATITUD))*0.6 LATITUD,TRUNC(rck.LONGITUD)+(rck.LONGITUD-TRUNC(rck.LONGITUD))*0.6 LONGITUD from rios_canales_km rck left join rios_canales rc on rck.id_rio_canal = rc.id
                    where
                      upper(rck.KM) like upper(''' || vQuery || ''') or 
                      upper(rck.UNIDAD) like upper(''' || vQuery || ''') or 
                      upper(rc.NOMBRE) like upper(''' || vQuery || ''') or
                      upper(rck.UNIDAD || ''' || ' ' || ''' || rck.km) like upper(''' || vQuery || ''') or
                      ( upper(rc.NOMBRE) like ''' || strtemp1 || ''' and upper(rck.km) like ''' || strtemp3 || ''' ) or
                      ( upper(rck.KM) like ''' || strtemp1 || ''' and upper(rc.nombre) like ''' || strtemp3 || ''' ) or
                      (
                        upper(rck.UNIDAD) like ''' || strtemp1 || ''' and 
                        upper(rck.KM) like ''' || strtemp2 || ''' and
                        upper(rc.nombre) like ''' || strtemp3 || ''' 
                      ) 
                    order by KM asc,NOMBRE asc';
                    
    
    mbpc.paginator(temp3, 10, 1, sql_stmt);
    open vCursor for sql_stmt;
    
    --open vCursor for sql_stmt USING vQuery, vQuery, vQuery,' ',vQuery, strtemp1, strtemp3, strtemp1, strtemp3, strtemp1, strtemp2, strtemp3;
  end autocompleterioscanales; 
  
  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure autocompleterbnacionales(vQuery in varchar2, usrid in number, vCursor out cur) is
  begin
    --VERIFICAR TIPO_BUQUE     'nacional'
    --VERIFICAR TIPO_SERVICIO  'REMOLCADOR' 'EMPUJADOR' otros...
    
    sql_stmt := 'select NVL(z.cuatrigrama,'''') costera, b.id_buque, b.matricula, b.nro_omi, b.nombre, b.bandera, b.nro_ismm, b.tipo, b.sdist
                    from buques b 
                    where
                    --Que no sea un barco en viaje
                    --b.id_buque not in (
                    --  select buque_id from tbl_viaje where estado=0 and buque_id is not null
                    --)
                    --and
                    --Que no sea un barco acompanando
                    --b.id_buque not in (
                    --  select acompanante_id from tbl_etapa e join tbl_viaje v 
                    --  on e.viaje_id=v.id and v.estado=0 and v.etapa_actual=e.nro_etapa and e.acompanante_id is not null
                    --  union
                    --  select acompanante2_id from tbl_etapa e join tbl_viaje v 
                    --  on e.viaje_id=v.id and v.estado=0 and v.etapa_actual=e.nro_etapa and e.acompanante2_id is not null
                    --  union
                    --  select acompanante3_id from tbl_etapa e join tbl_viaje v 
                    --  on e.viaje_id=v.id and v.estado=0 and v.etapa_actual=e.nro_etapa and e.acompanante3_id is not null
                    --  union
                    --  select acompanante4_id from tbl_etapa e join tbl_viaje v 
                    --  on e.viaje_id=v.id and v.estado=0 and v.etapa_actual=e.nro_etapa and e.acompanante4_id is not null
                    --)
                    --and 
                    (upper(b.nombre) like upper(:vQuery) or 
                    upper(b.matricula) like upper(:vQuery) or 
                    upper(b.nro_omi) like upper(:vQuery) or 
                    upper(b.nro_ismm) like upper(:vQuery)) 
                    and b.bandera = ''ARGENTINA'' and rownum <= 6';
    
    open vCursor for sql_stmt USING vQuery,vQuery,vQuery,vQuery; 
  end autocompleterbnacionales;

  -------------------------------------------------------------------------------------------------------------
  --
  procedure autocompleterbdisponibles(vQuery in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
    select NVL(z.cuatrigrama,'') costera, b.id_buque, b.matricula, b.nro_omi, b.nombre, b.bandera, b.nro_ismm, b.tipo, b.sdist
    from buques b
      left join tbl_viaje v on b.id_buque           = v.buque_id and v.estado = 0
      left join tbl_etapa e on v.id                 = e.viaje_id and v.etapa_actual = e.nro_etapa
      left join tbl_puntodecontrol p on e.actual_id = p.id 
      left join tbl_zonas z on p.zona_id            = z.id
    where
      (upper(b.nombre) like upper(vQuery) or 
      upper(b.bandera) like upper(vQuery) or 
      upper(b.sdist) like upper(vQuery) or 
      upper(b.matricula) like upper(vQuery) or 
      upper(b.nro_omi) like upper(vQuery) or 
      upper(b.nro_ismm) like upper(vQuery)) and rownum <= 6;

  end autocompleterbdisponibles;
  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure autocompleterb(vQuery in varchar2, usrid in number, vCursor out cur) is
  begin
    mbpc.autocompleterball(vQuery, '0', usrid, vCursor); 
  end autocompleterb;
  
  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure autocompleterball(vQuery in varchar2, vEstado in varchar2, usrid in number, vCursor out cur) is
  begin
    --sql_stmt := 'select * from view_buques left join tbl_viaje on tbl_viaje.buque_id = view_buques.matricula where (upper(nombre) like upper(:vQuery) or upper(bandera) like upper(:vQuery) or upper(matricula) like upper(:vQuery) or upper(nro_omi) like upper(:vQuery)) and rownum <= 6';
    sql_stmt := 'select b.id_buque, b.matricula, b.nro_omi, b.sdist, b.nombre, b.bandera, b.nro_ismm, b.tipo , 
                  case when (b.id_buque, in 
                    (select v.buque_id from tbl_viaje v where v.estado = :vEstado 
                      union 
                      select e.acompanante_id from tbl_viaje v 
                        left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual) 
                        where v.estado = :vEstado
                      union 
                      select e.acompanante2_id from tbl_viaje v 
                        left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual) 
                        where v.estado = :vEstado
                      union 
                      select e.acompanante3_id from tbl_viaje v 
                        left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual) 
                        where v.estado = :vEstado
                      union 
                      select e.acompanante4_id from tbl_viaje v 
                        left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual) 
                        where v.estado = :vEstado
                    )
                    )
                    then 1 else 0 end as en_viaje 
                    from view_buques b
                    where (upper(b.nombre) like upper(:vQuery) or 
                    upper(b.bandera) like upper(:vQuery) or 
                    upper(b.matricula) like 
                    upper(:vQuery) or upper(b.nro_omi) like upper(:vQuery) or upper(b.nro_ismm) like upper(:vQuery)) and rownum <= 6';
    open vCursor for sql_stmt USING vEstado, vEstado, vQuery,vQuery,vQuery,vQuery,vQuery; 
  end autocompleterball;

  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure autocompleterestados(vQuery in varchar2, usrid in number, vCursor out cur) is
  begin
    sql_stmt := 'select * from ( select a.*, ROWNUM rnum from (
                    select COD,RESUMEN,ESTADO,AGRUPA, case when upper(cod) like upper(:vQuery) then 1 else 0 end as groovy from tbl_bq_estados 
                    order by groovy desc  ) a
                  where upper(cod) like upper(:vQuery) or
                        upper(estado) like upper(:vQuery) or 
                        upper(resumen) like upper(:vQuery) )
                  where rnum <= 10';
    open vCursor for sql_stmt using vQuery, vQuery, vQuery, vQuery;
  end autocompleterestados;
  
  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure autocompleterbenzona(vQuery in varchar2, vZonaId in varchar2, usrid in number, vCursor out cur) is
  begin
    --sql_stmt := 'select * from view_buques left join tbl_viaje on tbl_viaje.buque_id = view_buques.matricula where (upper(nombre) like upper(:vQuery) or upper(bandera) like upper(:vQuery) or upper(matricula) like upper(:vQuery) or upper(nro_omi) like upper(:vQuery)) and rownum <= 6';
    sql_stmt := 'select b.id_buque, b.matricula, b.nro_omi, b.sdist, b.nombre, b.bandera, b.nro_ismm, b.tipo , 
                  case when (b.id_buque in 
                    (select v.buque_id from tbl_viaje v where v.estado = 0 
                      union 
                      select e.acompanante_id from tbl_viaje v 
                        left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual) where v.estado = 0
                      union 
                      select e.acompanante2_id from tbl_viaje v 
                        left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual) where v.estado = 0
                      union 
                      select e.acompanante3_id from tbl_viaje v 
                        left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual) where v.estado = 0
                      union 
                      select e.acompanante4_id from tbl_viaje v 
                        left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual) where v.estado = 0
                    ))
                    then 1 else 0 end as en_viaje 
                    from view_buques b
                    where (upper(b.nombre) like upper(:vQuery) or 
                    upper(b.bandera) like upper(:vQuery) or 
                    upper(b.matricula) like 
                    upper(:vQuery) or upper(b.nro_omi) like upper(:vQuery)) and rownum <= 6';
    open vCursor for sql_stmt USING vQuery,vQuery,vQuery,vQuery; 
  end autocompleterbenzona;  

  -------------------------------------------------------------------------------------------------------------
  --
  procedure autocompleterm(vQuery in varchar2, usrid in number, vCursor out cur) is
  begin
    sql_stmt := 'select * from ( select a.*, ROWNUM rnum from (
                    select COD,PUERTO,LAT,LON,PAIS, case when upper(cod) like upper(:vQuery) then 1 else 0 end as groovy from tbl_kstm_puertos 
                    order by groovy desc  ) a
                  where upper(cod) like upper(:vQuery) or
                        upper(puerto) like upper(:vQuery) )
                  where rnum <= 10';
    open vCursor for sql_stmt using vQuery, vQuery, vQuery;
  end autocompleterm;  
  -------------------------------------------------------------------------------------------------------------
  --
  procedure crear_buque(vMatricula in varchar2, vNombre in varchar2, vSDist in varchar2, vServicio in varchar2, vMMSI in varchar2, usrid in number, vCursor out cur) is
  begin
    insert into buques (ID_BUQUE, MATRICULA, NOMBRE, BANDERA, ANIO_CONSTRUCCION, TIPO_BUQUE, TIPO_SERVICIO, SDIST, NRO_ISMM) 
      VALUES ( SQ_FLUVIAL_ID.nextval, vMatricula, vNombre, 'ARGENTINA', 0, vServicio, vServicio, vSDist, vMMSI )
    returning ID_BUQUE,MATRICULA,NRO_OMI,NOMBRE,BANDERA,ANIO_CONSTRUCCION,NRO_ISMM,ASTILL_PARTIC,REGISTRO,TIPO_BUQUE,TIPO_SERVICIO,TIPO_EXPLOTACION,ARBOLADURA,SDIST,VELOCIDAD,ESLORA,MANGA,PUNTAL,ARQUEO_TOTAL,CALADO_MAX,PUERTO_ASIENTO,MATERIAL,SOCIEDADCLASIF,ARQUEO_NETO,DOTACION_MINIMA,TIPO into var_buque;
    
    insert into tbl_evento (usuario_id, tipo_id, buque_id, fecha) VALUES (usrid, 2, var_buque.ID_BUQUE, SYSDATE);
    open vCursor for 
      select * from buques where id_buque=var_buque.ID_BUQUE;
  end crear_buque;
  
  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure crear_buque_int(vMatricula in varchar2, vNombre in varchar2, vSDist in varchar2, vBandera in varchar2, vServicio in varchar2, vMMSI in varchar2, usrid in number, vCursor out cur) is
  begin
    insert into buques ( ID_BUQUE, MATRICULA, NOMBRE, BANDERA, ANIO_CONSTRUCCION, TIPO_BUQUE, TIPO_SERVICIO, SDIST, NRO_OMI, NRO_ISMM)
      VALUES ( SQ_FLUVIAL_ID.nextval, 'n/a', vNombre,  vBandera, 0, vServicio, vServicio, vSDist, vMatricula, vMMSI)
    returning ID_BUQUE,MATRICULA,NRO_OMI,NOMBRE,BANDERA,ANIO_CONSTRUCCION,NRO_ISMM,ASTILL_PARTIC,REGISTRO,TIPO_BUQUE,TIPO_SERVICIO,TIPO_EXPLOTACION,ARBOLADURA,SDIST,VELOCIDAD,ESLORA,MANGA,PUNTAL,ARQUEO_TOTAL,CALADO_MAX,PUERTO_ASIENTO,MATERIAL,SOCIEDADCLASIF,ARQUEO_NETO,DOTACION_MINIMA,TIPO into var_buque;
      
    insert into tbl_evento (usuario_id, tipo_id, buque_id, fecha) VALUES (usrid, 2, var_buque.ID_BUQUE, SYSDATE);
    open vCursor for 
      select * from buques where id_buque=var_buque.ID_BUQUE;
    
  end crear_buque_int;
  
  -------------------------------------------------------------------------------------------------------------
  --  
  
  procedure traer_puertos(usrid in number, vCursor out cur) is
  begin
    open vCursor for select * from tbl_kstm_puertos;
  end traer_puertos;

  -------------------------------------------------------------------------------------------------------------
  --
  
  --procedure traer_instports(vPuerto in varchar2, usrid in number, vCursor out cur) is
  --begin
  --  open vCursor for select * from tbl_insta_puert where puerto_id = vPuerto;
  --end traer_instports;

  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure crear_puerto(vCod in varchar2, vPuerto in varchar2, vPais in varchar2, usrid in number, vCursor out cur) is
  begin
    insert into tbl_kstm_puertos ( COD,PUERTO,PAIS ) VALUES ( vCod , vPuerto, vPais);
    open vCursor for select COD,PUERTO from tbl_kstm_puertos where cod = vCod and rownum=1;
    --insert into tbl_evento (usuario_id, tipo_id, muelle_id, fecha) VALUES (usrid, 3, vId, SYSDATE);
  end crear_puerto;

  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure crear_usuario(vNdoc in varchar2, vPassword in varchar2, vApellido in varchar2, vNombres in varchar2, vDestino in varchar2, vFechavenc in varchar2, vTedirecto in varchar2, vTeinterno in varchar2, vEmail in varchar2, vEstado in varchar2, vSeccion in varchar2, vNdoc_admin in varchar2, vFecha_audit in varchar2, vNombredeusuario in varchar2, vUsuario_id in varchar2, usrid in number, vCursor out cur) is
  begin
    insert into int_usuarios VALUES ( vNdoc, vPassword, vApellido, vNombres, vDestino, TO_DATE(vFechavenc, 'DD-MM-yy HH24:mi'), vTedirecto, vTeinterno, vEmail, vEstado, vSeccion, vNdoc_admin, TO_DATE(vFecha_audit, 'DD-MM-yy HH24:mi'), vNombredeusuario, vUsuario_id);
    --insert into tbl_evento (usuario_id, tipo_id, buque_id, fecha) VALUES (usrid, 2, vMatricula, SYSDATE);
  end crear_usuario;

  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure update_usuario(vNdoc in varchar2, vPassword in varchar2, vApellido in varchar2, vNombres in varchar2, vDestino in varchar2, vFechavenc in varchar2, vTedirecto in varchar2, vTeinterno in varchar2, vEmail in varchar2, vEstado in varchar2, vSeccion in varchar2, vNdoc_admin in varchar2, vFecha_audit in varchar2, vNombredeusuario in varchar2, vUsuario_id in varchar2, usrid in number, vCursor out cur) is
  begin
    update int_usuarios set NDOC = vNdoc, PASSWORD = vPassword, APELLIDO = vApellido, NOMBRES = vNombres, DESTINO = vDestino, FECHAVENC = TO_DATE(vFechavenc, 'DD-MM-yy HH24:mi'), TEDIRECTO = vTedirecto, TEINTERNO = vTeinterno, EMAIL = vEmail, ESTADO = vEstado, SECCION = vSeccion, NDOC_ADMIN = vNdoc_admin, FECHA_AUDIT = TO_DATE(vFecha_audit, 'DD-MM-yy HH24:mi'), NOMBREDEUSUARIO = vNombredeusuario where USUARIO_ID = vUsuario_id;
    --insert into tbl_evento (usuario_id, tipo_id, buque_id, fecha) VALUES (usrid, 2, vMatricula, SYSDATE);
  end update_usuario;

  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure crear_practico(vNombre in varchar2, usrid in number, vCursor out cur) is
  begin
    insert into tbl_practico ( NOMBRE ) 
      VALUES ( vNombre);
    --insert into tbl_evento (usuario_id, tipo_id, buque_id, fecha) VALUES (usrid, 2, vMatricula, SYSDATE);
  end crear_practico;

  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure update_practico(vNombre in varchar2, usrid in number, vCursor out cur) is
  begin
    update tbl_practico set NOMBRE = vNombre;
    --insert into tbl_evento (usuario_id, tipo_id, buque_id, fecha) VALUES (usrid, 2, vMatricula, SYSDATE);
  end update_practico;
 
  -------------------------------------------------------------------------------------------------------------
  --
 
  procedure asignar_pdc(vUsuario in varchar2, vPdc in varchar2, usrid in number) is
  begin
    insert into tbl_puntodecontrolusuario(PUNTODECONTROL, USUARIO) VALUES (vPdc, vUsuario);
  end asignar_pdc;

  -------------------------------------------------------------------------------------------------------------
  --
 
  procedure columnas_de(vTabla in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
      SELECT COLUMN_NAME, NULLABLE FROM all_tab_cols WHERE TABLE_name=vTabla order by COLUMN_ID asc;
  end columnas_de;

  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure pager(vTabla in varchar2, vOrderBy in varchar2, vCantidad in number, vDesde in number, usrid in number, vCursor out cur ) is
  begin
    sql_stmt := 'SELECT *
        FROM (SELECT a.*, ROWNUM rnum
                FROM (SELECT *
                        FROM '  || vTabla || '
                       ORDER BY ' || NVL(vOrderBy,1) || ') a  
                     WHERE ROWNUM < :ul)
       WHERE rnum >= :ll';
    open vCursor for sql_stmt USING vDesde + vCantidad, vDesde;
  end pager;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure paginator(p_statment in varchar2, p_offset in number, p_count in number, sqlquery out varchar2) is
  begin
    sqlquery := 'SELECT *
        FROM (SELECT a.*, ROWNUM rnum
                FROM (' || p_statment || ') a  
                     WHERE ROWNUM < ' || p_offset || ')
       WHERE rnum >= ' || p_count;
  end paginator;

  -------------------------------------------------------------------------------------------------------------
  --
 
  
  procedure count_rows(vTabla in varchar2, number_of_rows out number) as
  begin
    sql_stmt := 'SELECT count(*) FROM '  || vTabla;
    execute immediate sql_stmt into number_of_rows;
  end count_rows;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure traer_banderas(usrid in number, vCursor out cur) is
  begin
    open vCursor for
      SELECT DESCRIPCION FROM TBL_PAISES_CIALA;
  end traer_banderas;

  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure reporte_lista(usrid in number, vCursor out cur) is
  begin
    open vCursor for 
      SELECT ID, NOMBRE, DESCRIPCION, CONSULTA_SQL FROM TBL_REPORTE;
  end reporte_lista;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure reporte_obtener_parametros(vReporte in number, usrid in number, vCursor out cur) is
  begin
    open vCursor for 
      SELECT INDICE,NOMBRE,TIPO_DATO FROM TBL_REPORTE_PARAM WHERE REPORTE_ID=vReporte ORDER BY INDICE;
  
  end reporte_obtener_parametros;
  -------------------------------------------------------------------------------------------------------------
  --

  procedure reporte_obtener_parametros_str(vNombre in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for 
      SELECT p.INDICE, p.NOMBRE, p.TIPO_DATO FROM TBL_REPORTE_PARAM p
      JOIN TBL_REPORTE r on p.REPORTE_ID=r.ID and r.NOMBRE=vNombre
      ORDER BY INDICE;
  
  end reporte_obtener_parametros_str;
  -------------------------------------------------------------------------------------------------------------
  --

  procedure reporte_obtener(vReporte in number, usrid in number, vCursor out cur) is
  begin
    open vCursor for 
      SELECT ID, NOMBRE, DESCRIPCION, FECHA_CREACION, CONSULTA_SQL 
      FROM TBL_REPORTE WHERE ID=vReporte;
  
  end reporte_obtener;
  -------------------------------------------------------------------------------------------------------------
  --

  procedure reporte_obtener_str(vNombre in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for 
      SELECT ID, NOMBRE, DESCRIPCION, FECHA_CREACION, CONSULTA_SQL 
      FROM TBL_REPORTE WHERE NOMBRE=vNombre;
  
  end reporte_obtener_str;
  
  
  
  
end;
/


