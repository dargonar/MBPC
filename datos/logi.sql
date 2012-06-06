PROMPT CREATE OR REPLACE PACKAGE dev_mbpc
CREATE OR REPLACE package dev_mbpc as
  type cur is ref cursor;
  type posdepdc is record (lat number, lon number, uso number, riokm number);
  type viaje_pos_t is record (lat number, lon number, pto number);
  posicion posdepdc;
  viajepos viaje_pos_t;
  logged number(1,0);
  var_buque buques_new%ROWTYPE;
  var_puerto tbl_kstm_puertos%ROWTYPE;
  usuario2 vw_int_usuarios%ROWTYPE;
  etapa tbl_etapa%ROWTYPE;
  etapa2 tbl_etapa%ROWTYPE;
  cetapa tbl_cargaetapa%ROWTYPE;
  practicoviaje tbl_practicoviaje%ROWTYPE;
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
  --procedure login( vid in varchar2, vpassword in varchar2, logged out number);
  procedure login2( vid in varchar2, vpassword in varchar2, logged out number);
  procedure login_usuario(vDummy in varchar2, usrid in number, vCursor out cur );
  procedure logout_usuario(vDummy in varchar2, usrid in number, vCursor out cur );
  procedure login_usuario_ext(vUsuario in varchar2, vPassword in varchar2, usrid in number, vCursor out cur);

  procedure grupos_del_usuario( vId in varchar2, usrid in number, vCursor out cur);
  procedure zonas_del_grupo( vId in varchar2, usrid in number, vCursor out cur);
  procedure grupo_de_zona( vZonaId in varchar2, usrid in number, vCursor out cur);
  
  procedure barcazas_en_zona( vZonaId in varchar2, usrid in number, vCursor out cur);
  procedure barcos_en_zona( vZonaId in varchar2, usrid in number, vCursor out cur);
  procedure barcos_entrantes( vZonaId in varchar2, usrid in number, vCursor out cur);
  procedure barcos_salientes( vZonaId in varchar2, usrid in number, vCursor out cur);

  procedure barcos_en_zona_old( vZonaId in varchar2, usrid in number, vCursor out cur);
  procedure barcos_entrantes_old( vZonaId in varchar2, usrid in number, vCursor out cur);
  procedure barcos_salientes_old( vZonaId in varchar2, usrid in number, vCursor out cur);

  procedure info_viaje( vViaje in varchar2, usrid in number, vCursor out cur);


  procedure reporte_diario (vGrupo in varchar2, vFecha in varchar2, usrid in number, vCursor out cur);
  procedure datos_del_usuario(vid in varchar2, usrid in number, vCursor out cur );
  procedure todos_los_pdc(usrid in number, vCursor out cur);
  --Viaje
  procedure crear_viaje(vBuque in varchar2, vOrigen in varchar2, vDestino in varchar2, vInicio in varchar2, vEta in varchar2, vZoe in varchar2, vZona in varchar, vProx in varchar, vInternacional in number, vLat in number, vLon in number, vRiocanal in varchar2, vCodigoMalvinas in INTEGER, usrid in number, vCursor out cur);
  procedure confirma_viaje(vViaje in varchar2, vConfirma in varchar2, usrid in number, vCursor out cur);
  procedure editar_viaje(vViaje in varchar2, vBuque in varchar2, vInicio in varchar2, vEta in varchar2, vZoe in varchar2, vZona in varchar, vProx in varchar, vInternacional in number, vLat in number, vLon in number, vRiocanal in varchar2, usrid in number, vCursor out cur);
  procedure editar_viaje2(vViaje in varchar2, vBuque in varchar2, vInicio in varchar2, vEta in varchar2, vZoe in varchar2, vZona in varchar, vProx in varchar, vInternacional in number, vLat in number, vLon in number, vRiocanal in varchar2, vCodigoMalvinasInicio in varchar2, usrid in number, vCursor out cur);
  procedure traer_viaje(vViaje in varchar2, usrid in number, vCursor out cur);
  procedure terminar_viaje(vViajeId in number, vFecha in varchar2, vEscalas in varchar2, vCodigoMalvinas in INTEGER, usrid in number, vCursor out cur);
  procedure viajes_terminados(vZona in number, usrid in number, vCursor out cur);
  procedure reactivar_viaje(vViajeId in number , usrid in number, vCursor out cur);
  procedure traer_pbip(vViaje in varchar2, usrid in number, vCursor out cur);
  procedure modificar_pbip(vViaje in varchar2, vPuertoDeMatricula in varchar2, vNroInmarsat in varchar2, vArqueoBruto in varchar2, vCompania in varchar2, vContactoOCPM in varchar2, vObjetivo in varchar2, usrid in number, vCursor out cur);
  procedure traer_notas(vViaje in varchar2, usrid in number, vCursor out cur);
  procedure guardar_notas(vViaje in varchar2, vNotas in varchar2, usrid in number, vCursor out cur);
  procedure editar_acompanante(vFecha in varchar2, vEtapa in varchar2, vBuque in varchar2, vBuque2 in varchar2, vBuque3 in varchar2, vBuque4 in varchar2, usrid in number, vCursor out cur);
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
  procedure actualizar_listado_de_barcazas(  vEtapa in varchar2, usrid in number, vCursor out cur);
  procedure modificar_fecha_viaje(vViaje in varchar2, vFecha in varchar2, usrid in number, vCursor out cur);
  procedure traer_barco_recien_liberado(vViaje in varchar2, usrid in number, vCursor out cur);
  procedure barcos_similares(vNombre in VARCHAR2, usrid in number, vCursor out cur);
  procedure barcazas_similares(vNombre in VARCHAR2, usrid in number, vCursor out cur);
  --Etapas
  procedure id_ultima_etapa(vViaje in number, usrid in number, vCursor out cur);
  procedure indicar_proximo(vViajeId in number, vZonaId in number, usrid in number, vCursor out cur);
  procedure pasar_barco(vViajeId in varchar2, vZonaId in varchar2, vEta in varchar2, vLlegada in varchar2, vVelocidad in number, vRumbo in number, usrid in number, vCursor out cur);
  procedure zonas_adyacentes(vZonaId in varchar2, usrid in number, vCursor out cur);
  procedure traer_etapa(vViaje in varchar2, usrid in number, vCursor out cur);
  procedure descripcion_punto_control( vPuntoControlId in varchar2, usrid in number, vCursor out cur);
  procedure editar_etapa(vEtapa in varchar2, vOrigen in varchar2, vDestino in varchar2, vCaladoProa in varchar2, vCaladoPopa in varchar2, vCaladoInformado in varchar2, vHPR in varchar2, vETA in varchar2, vFechaSalida in varchar2, vCantidadTripulantes in varchar2, vCantidadPasajeros in varchar2, vCapitan in varchar2, vVelocidad in number, vRumbo in number, usrid in number, vCursor out cur);
  procedure traer_buque_de_etapa(vEtapa in varchar2, usrid in number, vCursor out cur);
  procedure traer_practicos(vEtapa in varchar2, usrid in number, vCursor out cur);
  procedure agregar_practico(vEtapa in varchar2, vPractico in varchar2, vFecha in varchar2, usrid in number, vCursor out cur);
  procedure activar_practico(vPractico in varchar2, vEtapa in varchar2, vFecha in varchar2, usrid in number, vCursor out cur);
  procedure bajar_practico(vPractico in varchar2, vEtapa in varchar2, vFecha in varchar2, usrid in number, vCursor out cur);
  procedure traer_etapa_viaje(vEtapa in varchar2, usrid in number, vCursor out cur);
  procedure modificar_extremos_etapa(vEtapa in varchar2, vOrigen in varchar2, vDestino in varchar2, usrid in number, vCursor out cur);
  procedure modificar_extremos_etapa_ex(vEtapa in varchar2, vOrigen in varchar2, vDestino in varchar2,usrid in number, vCursor out cur);
  procedure modificar_fecha_etapa(vEtapa in varchar2, vFecha in varchar2, usrid in number, vCursor out cur);
  --Cargas
  procedure descargar_barcaza(vEtapaId in varchar2, vBarcazaId in varchar2, usrid in number, vCursor out cur);
  procedure descargar_barcaza_batch(vEtapaId in varchar2, vBarcazaId in varchar2, usrid in number);
  procedure corregir_barcaza(vEtapa in varchar2, vBuque in varchar2, vBarcaza in varchar2, usrid in number, vCursor out cur);
  procedure barcazas_utilizadas(usrid in number, vCursor out cur);
  procedure traer_cargas( vEtapaId in varchar2, usrid in number, vCursor out cur);
  procedure traer_carga( vCargaId in varchar2, usrid in number, vCursor out cur);
  procedure traer_cargas_nobarcazas( vEtapaId in varchar2, usrid in number, vCursor out cur);
  procedure traer_carga_por_codigo(vCodigo in varchar2, usrid in number, vCursor out cur);
  procedure traer_barcazas_de_buque(vEtapa in varchar2, usrid in number, vCursor out cur);
  procedure traer_unidades(usrid in number, vCursor out cur);
  procedure insertar_carga( vEtapa in varchar2, vCarga in varchar2, vCantidad in varchar2, vUnidad in varchar2, vBuque in varchar2, vEnTransito in varchar2, usrid in number, vCursor out cur);
  procedure crear_editar_carga(vNew in varchar, vEtapa in varchar2, vCargaId in varchar2, vTipo in varchar2, vCantidadIni in varchar2, vCantidadEnt in varchar2, vCantidadSal in varchar2, vUnidad in varchar2, vBuque in varchar2, vEnTransito in varchar2, usrid in number, vCursor out cur);
  procedure modificar_carga(vCarga in varchar2, vCantidadEntrada in varchar2, vCantidadSalida in varchar2, usrid in number, vCursor out cur);
  procedure modificar_carga_actual(vCarga in varchar2, vCantidadActual in varchar2, usrid in number, vCursor out cur);
  procedure modificar_tipo_carga(vCargaId in varchar2, vUnidadId in varchar2, vTipoCargaId in varchar2, usrid in number, vCursor out cur);
  procedure eliminar_carga(vCarga in varchar2, checkempty in number, usrid in number, vCursor out cur);
  procedure eliminar_carga_sin_cursor(vCarga in varchar2, checkempty in number, usrid in number);
  procedure check_empty(vEtapaId in number, vBuqueId in number);
  procedure adjuntar_barcazas(vEtapaId in number, vViajeId in number, usrid in number);
  procedure fondear_barcaza(vEtapaId in number, vBarcazaId in number, vRioCanalKM in varchar2, vLat in number, vLon in number, vFecha in varchar2, usrid in number, vCursor out cur);
  procedure fondear_barcaza_batch(vEtapaId in number, vBarcazaId in number, vRioCanalKM in varchar2, vLat in number, vLon in number, vFecha in varchar2, usrid in number);
  procedure transferir_cargas(vFecha in varchar2, vEtapa in varchar2, vCarga in varchar2, vCantidad in varchar2, vUnidad in varchar2, vTipo in varchar2, vModo in varchar2, vOriginal in varchar2, vRecEmi in varchar2, usrid in number);
  procedure transferir_barcazas(vFecha in varchar2, vBarcaza in varchar2, vEtapa in varchar2, usrid in number);
  ---autocompletes
  procedure autocomplete_muelles(vQuery in varchar2, usrid in number, vCursor out cur);
  procedure autocomplete_cargas(vQuery in varchar2, usrid in number, vCursor out cur);
  procedure autocomplete_practicos(vQuery in varchar2, vEtapa in varchar2, usrid in number, vCursor out cur);
  procedure autocomplete_barcazas(vEtapaId in varchar2, vQuery in varchar2, usrid in number, vCursor out cur);
  procedure autocompleter( vVista in varchar2, vQuery in varchar2, usrid in number, vCursor out cur);
  procedure autocompleterm( vQuery in varchar2, usrid in number, vCursor out cur);
  procedure autocomplete_buques_disp( vQuery in varchar2, usrid in number, vCursor out cur);
  procedure autocomplete_remolcadores( vQuery in varchar2, usrid in number, vCursor out cur);
  procedure autocompleterioscanales( vQuery in varchar2, usrid in number, vCursor out cur);
  procedure autocompleterestados( vQuery in varchar2, usrid in number, vCursor out cur);
  procedure autocompleterbenzona( vQuery in varchar2, vZonaId in varchar2, usrid in number, vCursor out cur);
  procedure autocompletebactivos( vQuery in varchar2, usrid in number, vCursor out cur);
  procedure autocomplete_viajes_grp( vQuery in varchar2, vGrupo in varchar2, usrid in number, vCursor out cur);
  procedure autocomplete_viajes_usr( vQuery in varchar2, usrid in number, vCursor out cur);
  procedure paginator(p_statment in varchar2, p_offset in number, p_count in number, sqlquery out varchar2);
 --Buque/Puertos/Muelles
  procedure detalles_tecnicos( vShipId in varchar2, usrid in number, vCursor out cur);
  procedure crear_buque(vMatricula in varchar2, vNombre in varchar2, vSDist in varchar2, vServicio in varchar2, vMMSI in varchar2, usrid in number, vCursor out cur);
  procedure crear_buque_int(vMatricula in varchar2, vNombre in varchar2, vSDist in varchar2, vBandera in varchar2, vServicio in varchar2, vMMSI in varchar2, usrid in number, vCursor out cur);
  procedure traer_puertos(usrid in number, vCursor out cur);
  procedure crear_puerto(vCod in varchar2, vPuerto in varchar2, vPais in varchar2, usrid in number, vCursor out cur);
  --procedure traer_instports(vPuerto in varchar2, usrid in number, vCursor out cur);
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
  procedure reporte_obtener_html_builded(usrid in number, vCursor out cur);
  procedure reporte_insertar(vNombre in varchar2, vDescripcion in varchar2, vCategoriaId in number, vConsultaSql in clob, vPostParams in clob, usrid in number, vCursor out cur);
  procedure reporte_insertar_params(vReporteId in number, vIndice in number, vNombre in varchar2, vTipoDato in number, usrid in number);
  procedure reporte_eliminar(vReporteId in number, usrid in number, vCursor out cur);
  procedure reporte_eliminar_params(vReporteId in number, usrid in number, vCursor out cur);
  procedure reporte_actualizar(vReporteId in number, vNombre in varchar2, vDescripcion in varchar2, vCategoriaId in number, vConsultaSql in clob, vPostParams in clob, usrid in number, vCursor out cur);
  procedure reporte_metadata(vReporteId in number, usrid in number, vCursor out cur);
  procedure obtener_reportes_para_usuario(vUsuario in varchar2, usrid in number, vCursor out cur);
  --auxiliares
  procedure posicion_viaje(vViajeId in number);

  --PBIP
  procedure pbip_nuevo(  v_viaje_id in INTEGER
    ,v_puertodematricula in VARCHAR2, v_bandera in VARCHAR2 ,v_nroinmarsat in VARCHAR2 ,v_arqueobruto in VARCHAR2 ,v_compania in VARCHAR2 ,
    v_contactoocpm in VARCHAR2 ,v_objetivo in VARCHAR2 ,v_nro_imo  in VARCHAR2 ,v_buque_nombre in VARCHAR2 ,v_tipo_buque  in VARCHAR2 ,
    v_distintivo_llamada   in VARCHAR2 ,v_nro_identif_compania in VARCHAR2 ,v_puerto_llegada in VARCHAR2 ,v_eta   in VARCHAR2 ,
    v_instalacion_portuaria   in VARCHAR2 ,v_cipb_estado in VARCHAR2 ,v_cipb_expedido_por in VARCHAR2 ,v_cipb_expiracion   in VARCHAR2 ,v_cipb_motivo_incumplimiento in VARCHAR2 ,v_proteccion_plan_aprobado in NUMBER ,v_proteccion_nivel_actual in NUMBER ,v_longitud_notif in NUMBER ,v_latitud_notif  in NUMBER ,v_plan_proteccion_mant_bab in NUMBER  ,v_plan_protec_mant_bab_desc in CLOB,
    v_carga_desc_gral   in CLOB ,v_carga_sust_peligrosas   in NUMBER  ,
    v_carga_sust_peligrosas_desc in CLOB ,v_lista_pasajeros   in NUMBER  ,
    v_lista_tripulantes  in NUMBER  ,
    v_prot_notifica_cuestion  in NUMBER  ,v_prot_notifica_polizon   in NUMBER  ,v_prot_notifica_polizon_desc in CLOB ,v_prot_notifica_rescate   in NUMBER
    , v_prot_notifica_rescate_desc in CLOB ,v_prot_notifica_otra   in NUMBER  ,v_prot_notifica_otra_desc in CLOB ,v_agente_pto_llegada_nombre  in VARCHAR2
    ,v_agente_pto_llegada_tel  in VARCHAR2 ,v_agente_pto_llegada_mail in VARCHAR2 ,v_facilitador_nombre   in VARCHAR2 ,v_facilitador_titulo_cargo in VARCHAR2
    ,v_facilitador_lugar in VARCHAR2 ,v_facilitador_fecha in VARCHAR2 , usrid in number, vCursor out cur);

  procedure pbip_nuevo_param(v_tbl_pbip_id in INTEGER, v_tipo_param in INTEGER , v_indice in INTEGER ,v_fecha_desde in VARCHAR2,v_fecha_hasta in VARCHAR2,v_descripcion in CLOB,v_nivel_proteccion in INTEGER,v_escalas_medidas_adic in INTEGER,v_escalas_medidas_adic_desc in CLOB,v_actividad_bab in CLOB, usrid in number);

  procedure pbip_eliminar(v_tbl_pbip_id in INTEGER, usrid in number, vCursor out cur);
  procedure pbip_eliminar_params(v_tbl_pbip_id in INTEGER, usrid in number, vCursor out cur);
  procedure pbip_modificar(v_id in INTEGER,  v_viaje_id in INTEGER ,v_puertodematricula in VARCHAR2, v_bandera in VARCHAR2, v_nroinmarsat in VARCHAR2 ,v_arqueobruto in VARCHAR2 ,v_compania in VARCHAR2 ,v_contactoocpm in VARCHAR2 ,v_objetivo in VARCHAR2 ,v_nro_imo  in VARCHAR2 ,v_buque_nombre in VARCHAR2 ,v_tipo_buque  in VARCHAR2 ,v_distintivo_llamada   in VARCHAR2 ,v_nro_identif_compania in VARCHAR2 ,v_puerto_llegada in VARCHAR2 ,v_eta   in VARCHAR2 ,v_instalacion_portuaria   in VARCHAR2 ,v_cipb_estado in VARCHAR2 ,v_cipb_expedido_por in VARCHAR2 ,v_cipb_expiracion   in VARCHAR2 ,v_cipb_motivo_incumplimiento in VARCHAR2 ,v_proteccion_plan_aprobado in NUMBER ,v_proteccion_nivel_actual in NUMBER ,v_longitud_notif in NUMBER ,v_latitud_notif  in NUMBER ,v_plan_proteccion_mant_bab in NUMBER  ,v_plan_protec_mant_bab_desc in CLOB ,  v_carga_desc_gral   in CLOB ,v_carga_sust_peligrosas   in NUMBER  ,v_carga_sust_peligrosas_desc in CLOB ,v_lista_pasajeros   in NUMBER  ,v_lista_tripulantes  in NUMBER  ,v_prot_notifica_cuestion  in NUMBER  ,v_prot_notifica_polizon   in NUMBER  ,v_prot_notifica_polizon_desc in CLOB ,v_prot_notifica_rescate   in NUMBER  ,v_prot_notifica_rescate_desc in CLOB ,v_prot_notifica_otra   in NUMBER  ,v_prot_notifica_otra_desc in CLOB ,v_agente_pto_llegada_nombre  in VARCHAR2 ,v_agente_pto_llegada_tel  in VARCHAR2 ,v_agente_pto_llegada_mail in VARCHAR2 ,v_facilitador_nombre   in VARCHAR2 ,v_facilitador_titulo_cargo in VARCHAR2 ,v_facilitador_lugar in VARCHAR2 ,v_facilitador_fecha in VARCHAR2 , usrid in number, vCursor out cur);

  procedure pbip_obtener(v_id in INTEGER, usrid in number, vCursor out cur);
  procedure pbip_obtener_params(v_id in INTEGER, usrid in number, vCursor out cur);

  procedure obtener_opciones_malvinas(v_va_a_malvinas in INTEGER, usrid in number, vCursor out cur);

end;




















































/

PROMPT CREATE OR REPLACE PACKAGE BODY dev_mbpc
CREATE OR REPLACE package body dev_mbpc as

---------------------------------------------------------------------------------------------------------------
-----------------------------------------Login/Home------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

-- vw_int_usuarios: usuarios internos (de Prefectura) habilitados a usar el MBPC
-- vw_int_usuarios_ext: usuarios externos (empresas u organismos) habilitados para consumir datos del MBPC
-- vw_pers_desti: personal de Prefectura con sus destinos actualizados

  -------------------------------------------------------------------------------------------------------------
  procedure login2(vid in varchar2, vpassword in varchar2, logged out number ) is

  begin

    SELECT * INTO usuario2 FROM vw_int_usuarios WHERE ndoc = vid;

    -- Vemos si coincide usuario y pass
      IF usuario2.password <> vpassword THEN
          -- usuario existe, password incorrecto
          logged := 100;
          RETURN;
      END IF;

      -- Vemos si el usuario = password
      IF usuario2.password = cast(usuario2.ndoc as varchar2) THEN
        logged := '4';
        RETURN;
      END IF;

      -- Vemos si el destino coincide
      SELECT COUNT(*) into temp FROM vw_pers_desti WHERE ndoc=vid AND destino=usuario2.destino;
      IF temp = 0 THEN
        --usuario ok / destino no
        logged := 1;
        RETURN;
      END IF;

      -- Vemos si esta vencido
      if SYSDATE > usuario2.fechavenc THEN
        --usuario ok / destino ok / fecha no
        logged := 2;
        RETURN;
      END IF;

      --usuario ok / destino ok / fecha ok
      logged := 0;

  exception when NO_DATA_FOUND THEN
    -- usuario no existe
    logged := 200;

  end login2;

  -------------------------------------------------------------------------------------------------------------
  -- Verifica que exista un registro que coincida con el ID del usuario (Legajo) y el password
  --procedure login(vid in varchar2, vpassword in varchar2, logged out number ) is

  --begin
  --  SELECT * INTO usuario FROM int_usuarios WHERE usuario_id = vid AND password = vpassword;
  --    IF sql%ROWCOUNT != 0 THEN
  --      logged := 1;
  --    ELSE
  --      logged := 0;
  --    END IF;
  --exception when NO_DATA_FOUND THEN
  --  logged := 0;
  --end login;
  -------------------------------------------------------------------------------------------------------------
  --
  procedure login_usuario(vDummy in varchar2, usrid in number, vCursor out cur ) is
  begin
      insert into tbl_registrousuario (usuario_id, login) values (usrid, 1);
  end login_usuario;
  -------------------------------------------------------------------------------------------------------------
  --
  procedure logout_usuario(vDummy in varchar2, usrid in number, vCursor out cur ) is
  begin
      insert into tbl_registrousuario (usuario_id, login) values (usrid, 0);
  end logout_usuario;
  -------------------------------------------------------------------------------------------------------------
  --
  procedure datos_del_usuario(vid in varchar2, usrid in number, vCursor out cur ) is
  begin
    open vCursor for
    SELECT * FROM vw_int_usuarios WHERE ndoc = vid;
  end datos_del_usuario;

  -------------------------------------------------------------------------------------------------------------
  --Retorna todos los grupos que tiene asignado el usuario

  procedure grupos_del_usuario( vId in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
    select gu.ID, gu.GRUPO, gu.USUARIO, g.NOMBRE
    from tbl_usuariogrupo gu
    left join tbl_grupo g on g.ID=gu.GRUPO
    WHERE gu.USUARIO=vID
    ORDER BY g.NOMBRE asc;
  end grupos_del_usuario;

  -------------------------------------------------------------------------------------------------------------
  --Retorna todos los puntos de control que el usuario tiene asignado

  procedure zonas_del_grupo( vId in varchar2, usrid in number, vCursor out cur) is
  begin
    --open vCursor for SELECT * FROM tbl_zonausuario;
    open vCursor for
    SELECT pdc.ID, pdc.USO, pdc.tipo, CUATRIGRAMA, ENTRADA, DESCRIPCION, NIVEL, DIRECCION_POSTAL, UBIC_GEOG, DEPENDENCIA, ESTADO, CODNUM, ZONA, NIVELNUM, RPV, INT, MAIL, TE, FAX, COD_CARGO, DESCENTRALIZADO, rc.nombre CANAL, rck.km KM, rck.unidad, entrada
    FROM tbl_puntodecontrol pdc
    join tbl_zonas z on pdc.zona_id = z.id
    join rios_canales_km rck on rck.id = pdc.rios_canales_km_id
    join rios_canales rc on rck.id_rio_canal = rc.id
    join tbl_grupopunto gp on gp.punto=pdc.id and gp.grupo = vId
    order by gp.orden;
    --WHERE pdc.id IN (SELECT PUNTO FROM tbl_grupopunto WHERE GRUPO = vId);
  end zonas_del_grupo;

  procedure grupo_de_zona( vZonaId in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
      SELECT grupo 
        FROM tbl_grupopunto 
        WHERE punto = vZonaId 
        AND grupo IN 
          (select gu_.GRUPO from tbl_usuariogrupo gu_ WHERE gu_.USUARIO=usrid) 
        and ROWNUM=1;
  end grupo_de_zona;
  -------------------------------------------------------------------------------------------------------------
  --Retorna todas las barcazas que esten fondeadas en el punto de control
  procedure barcazas_en_zona( vZonaId in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
      select v.id, v.buque_id, v.notas, v.latitud, v.longitud, v.barcazas_listado, b.nombre
      from tbl_viaje v
       left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual)
       left join buques_new b on v.buque_id = b.ID_BUQUE
     where e.actual_id = vZonaId and v.estado = 100
     order by b.nombre;
  end barcazas_en_zona;

  -------------------------------------------------------------------------------------------------------------
  --Retorna info para tooltip de viaje

  procedure info_viaje( vViaje in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
      select v.ID,
             e.ETA,
             st.estado ESTADO_TEXT,
             b.MATRICULA, b.NRO_OMI, b.BANDERA, b.SDIST, b.CALADO_MAX, e.CALADO_INFORMADO,
             '('||e.PUERTO_ORIGEN||') '||k1.puerto origen,
             '('||e.PUERTO_DESTINO||') '||k2.puerto destino,
             CASE WHEN rck.km <> 0 then rc.nombre||' '||rck.unidad||' '||rck.km ELSE rc.nombre||' '||rck.unidad END anterior,
             CASE WHEN rck3.km <> 0 then rc3.nombre||' '||rck3.unidad||' '||rck3.km ELSE rc3.nombre||' '||rck3.unidad END proximo,
             z.cuatrigrama costera,
             CASE WHEN e.acompanante_id is not null or e.acompanante2_id is not null or e.acompanante3_id is not null or e.acompanante4_id is not null THEN 1 ELSE 0 END tiene_acompanante

      from tbl_viaje v
       left join tbl_etapa e  on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual)
       left join buques_new b on v.buque_id=b.id_buque

       left join tbl_puntodecontrol p  on   p.id            = e.origen_id
       left join rios_canales_km rck   on rck.id            = p.rios_canales_km_id
       left join rios_canales rc       on rck.id_rio_canal  = rc.id

       left join tbl_puntodecontrol p3 on   p3.id           = e.destino_id
       left join rios_canales_km rck3  on rck3.id           = p3.rios_canales_km_id
       left join rios_canales rc3      on rck3.id_rio_canal = rc3.id

       left JOIN tbl_kstm_puertos k1   on e.PUERTO_ORIGEN   = k1.COD
       left JOIN tbl_kstm_puertos k2   on e.PUERTO_DESTINO  = k2.COD

       left join tbl_puntodecontrol p2 on p2.id             = e.actual_id
       left join tbl_zonas z           on p2.zona_id        = z.id

       left join tbl_bq_estados st on v.estado_buque = st.cod

       where v.id=vViaje;

  end info_viaje;
  -------------------------------------------------------------------------------------------------------------
  --Retorna todos los barcos que esten en el punto de control actual,
  --revisando que en todos los viajes en curso (Estado 0)
  --la etapa actual (que indica el punto de control del que viene, **donde esta**, donde se dirige y previamente calculado si esta en bajada o subida)
  --coincida con el punto de control que se este verificando

  procedure barcos_en_zona( vZonaId in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
      select v.ID, v.BUQUE_ID, v.ESTADO_BUQUE, v.BARCAZAS_LISTADO,
             b.NOMBRE, b.NRO_ISMM, b.MATRICULA, b.SDIST, b.NRO_OMI,
             e.DESTINO_ID, e.ID ETAPA_ID, e.sentido,
             st.ESTADO ESTADO_TEXT,
             CASE WHEN v.NOTAS is not null THEN 1 ELSE 0 END tiene_notas

      from tbl_viaje v
       left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual)
       left join buques_new b on v.buque_id = b.ID_BUQUE
       left join tbl_bq_estados st on v.estado_buque = st.cod

     where e.actual_id = vZonaId and v.estado = 0;
  end barcos_en_zona;

  -------------------------------------------------------------------------------------------------------------
  --


  -------------------------------------------------------------------------------------------------------------
  --Retorna todos los barcos recientemente despachados al punto de control,
  --revisando que en todos los viajes en curso (Estado 0)
  --la etapa actual (que indica el punto de control del que viene, donde esta, **donde se dirige** y previamente calculado si esta en bajada o subida)
  --coincida con el punto de control que se este verificando

  procedure barcos_entrantes( vZonaId in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
      select v.ID, v.BUQUE_ID, v.ESTADO_BUQUE, v.BARCAZAS_LISTADO,
             b.NOMBRE, b.NRO_ISMM, b.MATRICULA, b.SDIST, b.NRO_OMI,
             e.DESTINO_ID, e.ID ETAPA_ID, e.sentido2 sentido,
             st.ESTADO ESTADO_TEXT,
             CASE WHEN v.NOTAS is not null THEN 1 ELSE 0 END tiene_notas

      from tbl_viaje v
       left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual)
       left join buques_new b on v.buque_id = b.ID_BUQUE
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
      select v.ID, v.BUQUE_ID, v.ESTADO_BUQUE, v.BARCAZAS_LISTADO,
             b.NOMBRE, b.NRO_ISMM, b.MATRICULA, b.SDIST, b.NRO_OMI,
             e.DESTINO_ID, e.ID ETAPA_ID, e.sentido3 sentido,
             st.ESTADO ESTADO_TEXT,
             CASE WHEN v.NOTAS is not null THEN 1 ELSE 0 END tiene_notas

      from tbl_viaje v
       left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual)
       left join buques_new b on v.buque_id = b.ID_BUQUE
       left join tbl_bq_estados st on v.estado_buque = st.cod

     WHERE e.origen_id = vZonaId and v.estado = 0;

  end barcos_salientes;

  procedure barcos_en_zona_old( vZonaId in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
      select v.id, v.buque_id, v.notas, v.latitud, v.longitud, v.barcazas_listado,  capitan.nombre capitan, acomp.nombre acompanante,
             acomp2.nombre acompanante2, acomp3.nombre acompanante3, acomp4.nombre acompanante4,
             b.calado_max, e.calado_informado, e.origen_id, e.destino_id, e.sentido, e.eta, e.id etapa_id,
             'INS.PROV.', b.matricula, b.sdist, b.bandera, b.nombre, b.nro_omi, b.nro_ismm, b.arqueo_neto,
             b.arqueo_total, b.tipo, z.cuatrigrama, rck.km, st.estado estado_text, v.estado_buque,

             '('||e.PUERTO_ORIGEN||') '||k1.puerto origen,
             '('||e.PUERTO_DESTINO||') '||k2.puerto destino,
             CASE WHEN rck.km <> 0 then rc.nombre||' '||rck.unidad||' '||rck.km ELSE rc.nombre||' '||rck.unidad END anterior,
             CASE WHEN rck3.km <> 0 then rc3.nombre||' '||rck3.unidad||' '||rck3.km ELSE rc3.nombre||' '||rck3.unidad END proximo,
             z.cuatrigrama costera

      from tbl_viaje v
       left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual)
       left join buques_new b on v.buque_id = b.ID_BUQUE
       left join buques_new acomp on e.acompanante_id = acomp.ID_BUQUE
       left join buques_new acomp2 on e.acompanante2_id = acomp2.ID_BUQUE
       left join buques_new acomp3 on e.acompanante3_id = acomp3.ID_BUQUE
       left join buques_new acomp4 on e.acompanante4_id = acomp4.ID_BUQUE

       left join tbl_puntodecontrol p on   p.id           = e.origen_id
       left join rios_canales_km rck  on rck.id           = p.rios_canales_km_id
       left join rios_canales rc      on rck.id_rio_canal = rc.id

       left join tbl_puntodecontrol p3 on p3.id = e.destino_id
       left join rios_canales_km rck3 on rck3.id = p3.rios_canales_km_id
       left join rios_canales rc3 on rck3.id_rio_canal = rc3.id

       left join tbl_capitan capitan on e.capitan_id = capitan.id
       left join tbl_bq_estados st on v.estado_buque = st.cod

       left JOIN tbl_kstm_puertos k1 ON e.PUERTO_ORIGEN=k1.COD
       left JOIN tbl_kstm_puertos k2 ON e.PUERTO_DESTINO=k2.COD

       left join tbl_puntodecontrol p2 on p2.id = e.actual_id
       left join tbl_zonas z           on p2.zona_id = z.id


     where e.actual_id = vZonaId and v.estado = 0;
  end barcos_en_zona_old;

  procedure barcos_entrantes_old( vZonaId in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
      select v.id, v.buque_id, v.notas, v.latitud, v.longitud, v.barcazas_listado, capitan.nombre capitan, acomp.nombre acompanante,
      acomp2.nombre acompanante2, acomp3.nombre acompanante3, acomp4.nombre acompanante4,
      b.calado_max, e.calado_informado,  e.origen_id, e.destino_id, e.sentido2 sentido, e.eta, 'INSC.PROV.', b.matricula,
      b.sdist, b.bandera, b.nombre, b.nro_omi, b.nro_ismm,b.arqueo_neto, b.arqueo_total, b.tipo, z.cuatrigrama, rck.km,
      st.estado estado_text,v.estado_buque,

       '('||e.PUERTO_ORIGEN||') '||k1.puerto origen,
       '('||e.PUERTO_DESTINO||') '||k2.puerto destino,
       CASE WHEN rck.km <> 0 then rc.nombre||' '||rck.unidad||' '||rck.km ELSE rc.nombre||' '||rck.unidad END anterior,
       CASE WHEN rck3.km <> 0 then rc3.nombre||' '||rck3.unidad||' '||rck3.km ELSE rc3.nombre||' '||rck3.unidad END proximo,
       z.cuatrigrama costera


      from tbl_viaje v
        left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual)
        left join buques_new b on v.buque_id = b.ID_BUQUE
        left join buques_new acomp on e.acompanante_id = acomp.ID_BUQUE
        left join buques_new acomp2 on e.acompanante2_id = acomp2.ID_BUQUE
        left join buques_new acomp3 on e.acompanante3_id = acomp3.ID_BUQUE
        left join buques_new acomp4 on e.acompanante4_id = acomp4.ID_BUQUE

        left join tbl_puntodecontrol p on p.id = e.origen_id
        left join rios_canales_km rck on rck.id = p.rios_canales_km_id
        left join rios_canales rc on rck.id_rio_canal = rc.id

        left join tbl_puntodecontrol p3 on p3.id = e.destino_id
        left join rios_canales_km rck3 on rck3.id = p3.rios_canales_km_id
        left join rios_canales rc3 on rck3.id_rio_canal = rc3.id

        left join tbl_capitan capitan on e.capitan_id = capitan.id
        left join tbl_bq_estados st on v.estado_buque = st.cod

        left JOIN tbl_kstm_puertos k1 ON e.PUERTO_ORIGEN=k1.COD
        left JOIN tbl_kstm_puertos k2 ON e.PUERTO_DESTINO=k2.COD
        left join tbl_puntodecontrol p2 on   p2.id = e.actual_id
        left join tbl_zonas z           on   p2.zona_id = z.id

      WHERE e.destino_id = vZonaId and v.estado = 0;
  end barcos_entrantes_old;

  procedure barcos_salientes_old( vZonaId in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
      select v.id, v.buque_id, v.latitud, v.longitud, v.notas, v.barcazas_listado ,capitan.nombre capitan, acomp.nombre acompanante,
      acomp2.nombre acompanante2, acomp3.nombre acompanante3, acomp4.nombre acompanante4,
      b.calado_max, e.calado_informado, e.origen_id, e.destino_id, e.sentido3 sentido, e.eta, 'INSCR.PROV.', b.matricula,
      b.sdist, b.bandera, b.nombre, b.nro_omi, b.nro_ismm,b.arqueo_neto, b.arqueo_total,b.tipo, z.cuatrigrama, rck.km,
      st.estado estado_text,v.estado_buque,

      '('||e.PUERTO_ORIGEN||') '||k1.puerto origen,
      '('||e.PUERTO_DESTINO||') '||k2.puerto destino,
      CASE WHEN rck.km <> 0 then rc.nombre||' '||rck.unidad||' '||rck.km ELSE rc.nombre||' '||rck.unidad END anterior,
      CASE WHEN rck3.km <> 0 then rc3.nombre||' '||rck3.unidad||' '||rck3.km ELSE rc3.nombre||' '||rck3.unidad END proximo,
      z.cuatrigrama costera


      from tbl_viaje v
        left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual)
        left join buques_new b on v.buque_id = b.ID_BUQUE
        left join buques_new acomp on e.acompanante_id = acomp.ID_BUQUE
        left join buques_new acomp2 on e.acompanante2_id = acomp.ID_BUQUE
        left join buques_new acomp3 on e.acompanante3_id = acomp.ID_BUQUE
        left join buques_new acomp4 on e.acompanante4_id = acomp.ID_BUQUE

        left join tbl_puntodecontrol p on p.id = e.origen_id
        left join rios_canales_km rck on rck.id = p.rios_canales_km_id
        left join rios_canales rc on rck.id_rio_canal = rc.id

        left join tbl_puntodecontrol p3 on p3.id = e.destino_id
        left join rios_canales_km rck3 on rck3.id = p3.rios_canales_km_id
        left join rios_canales rc3 on rck3.id_rio_canal = rc3.id

        left join tbl_capitan capitan on e.capitan_id = capitan.id
        left join tbl_bq_estados st on v.estado_buque = st.cod

        left JOIN tbl_kstm_puertos k1 ON e.PUERTO_ORIGEN=k1.COD
        left JOIN tbl_kstm_puertos k2 ON e.PUERTO_DESTINO=k2.COD
        left join tbl_puntodecontrol p2 on   p2.id = e.actual_id
        left join tbl_zonas z           on   p2.zona_id = z.id

      WHERE e.origen_id = vZonaId and v.estado = 0;
  end barcos_salientes_old;

  procedure reporte_diario (vGrupo in varchar2, vFecha in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
      select p.id pdc, b.nombre, b.sdist, b.bandera band, origen.puerto fm, destino.puerto tox,
             e.calado_informado cal, e.velocidad vel, v.zoe, z.cuatrigrama, rc.nombre CANAL, rck.km KM, rck.unidad,
             to_char(e.eta,'HH24:MI') eta, to_char(e.hrp,'HH24:MI') hrp, e.sentido
      from tbl_etapa e
      left join tbl_viaje v on e.viaje_id = v.id
      left join buques_new b on v.buque_id = b.ID_BUQUE
      left join tbl_kstm_puertos origen on e.puerto_origen = origen.cod
      left join tbl_kstm_puertos destino on e.puerto_destino = destino.cod
      left join tbl_puntodecontrol p on e.actual_id = p.id
      left join tbl_zonas z on p.zona_id = z.id
      left join rios_canales_km rck on rck.id = p.rios_canales_km_id
      left join rios_canales rc on rck.id_rio_canal = rc.id

      where to_char(e.hrp, 'yyyy-mm-dd') = vFecha
      AND e.actual_id IN (SELECT punto FROM tbl_grupopunto g WHERE g.grupo = vGrupo)

      order BY v.id, e.nro_etapa desc;


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
      select rc.nombre canal, rck.km km, nro_etapa, to_char(e.created_at ,'YYDD-MM-yy HH:MI:SS') created_at, e.id 
      from tbl_etapa e
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

      --nuevo log
      posicion_viaje(evento.viaje_id);
      insert into tbl_evento ( usuario_id , viaje_id , etapa_id , tipo_id , created_at, evento_id, latviaje, lonviaje, ptoviaje)
      VALUES ( usrid, evento.viaje_id , vEtapa , 24, tempdate, evento.id, viajepos.lat, viajepos.lon, viajepos.pto);

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
      select p.id, p.fecha, p.etapa_id, p.latitud, p.longitud, p.rumbo, p.velocidad, p.comentario, e.descripcion, p.tipo_id, p.estado, rc.nombre || ' - ' || rck.unidad || ' ' || rck.km riocanal
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

    if length(vEstado) = 2 THEN
      update tbl_viaje set estado_buque = vEstado, updated_by=usrid, updated_at=tempdate where id = vViaje;
    end if;

    if vLat is not null and vLon is not null THEN
      update tbl_viaje set latitud = vLat, longitud = vLon, updated_by=usrid, updated_at=tempdate where id = vViaje;
    end if;

    --nuevo log
    posicion_viaje(vViaje);
    insert into tbl_evento (usuario_id, viaje_id, etapa_id, tipo_id, latitud, longitud, fecha, velocidad, rumbo, estado, created_at, latviaje, lonviaje, ptoviaje)
    values (usrid, vViaje, etapa.id, 19, vLat, vLon, TO_DATE(vFecha, 'DD-MM-yy HH24:mi'), vVelocidad, vRumbo, vEstado, tempdate, viajepos.lat, viajepos.lon, viajepos.pto);

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

      update tbl_viaje set estado_buque = vEstado, updated_by=usrid, updated_at=tempdate where id = etapa.viaje_id;

      IF vLat is not null and vLon is not null THEN
        update tbl_viaje set latitud = vLat, longitud=vLon where id = etapa.viaje_id;
      END IF;

      --nuevo log
      posicion_viaje(etapa.viaje_id);
      insert into tbl_evento ( usuario_id , viaje_id , etapa_id, tipo_id, fecha, comentario, latitud, longitud, estado, rios_canales_km_id, puerto_cod, created_at, latviaje, lonviaje, ptoviaje)
      VALUES ( usrid , etapa.viaje_id , vEtapa, 20 , TO_DATE(vFecha, 'DD-MM-yy HH24:mi'), vNotas, vLat, vLon, vEstado, vRiocanal, vPuerto, tempdate, viajepos.lat, viajepos.lon, viajepos.pto);

  end insertar_cambioestado;

  procedure actualizar_listado_de_barcazas(  vEtapa in varchar2, usrid in number, vCursor out cur) is
      barcazas varchar2(2000);
      total_barcazas number(6);
    begin
          /*barcazas varchar2(2000);
          total_barcazas number(6);
      cursor c1 ;
      call traer_barcazas_de_buque(vEtapa, usrid, c1);
      BEGIN*/

      barcazas := '';
      total_barcazas := 0;

      FOR barcaza in ( select distinct( c.buque_id ), b.nombre from tbl_cargaetapa c
                      join tbl_tipo_carga tc on c.tipocarga_id = tc.id
                      join tbl_unidad u on tc.unidad_id = u.id
                      left join buques_new b on b.ID_BUQUE = c.buque_id
                      where c.etapa_id = vEtapa and c.buque_id IS NOT NULL)
      LOOP
          barcazas := barcazas || ' <br/> ' || barcaza.nombre;
          total_barcazas := total_barcazas + 1 ;
      END LOOP;

      IF total_barcazas <> 0 THEN
        barcazas := barcazas || ' <br/> ( total ' || CAST(total_barcazas AS VARCHAR2) || ' barcazas ).';
      ELSE
        barcazas := NULL;
      END IF;

      UPDATE tbl_viaje set barcazas_listado = barcazas
        WHERE id in (SELECT viaje_id from tbl_etapa where tbl_etapa.id = vEtapa);

      /*open vCursor for select barcazas;*/

  end actualizar_listado_de_barcazas;


  procedure modificar_fecha_viaje(vViaje in varchar2, vFecha in varchar2, usrid in number, vCursor out cur)is
  begin

        update tbl_viaje set fecha_salida = TO_DATE(vFecha , 'DD-MM-yy HH24:mi')
        where id = vViaje;

        -- log
        UPDATE tbl_evento SET fecha = TO_DATE(vFecha, 'DD-MM-yy HH24:mi'), updated_by = usrid, updated_at = SYSDATE
        WHERE viaje_id = vViaje
              and tipo_id=1;
  end modificar_fecha_viaje;

  procedure traer_barco_recien_liberado(vViaje in varchar2, usrid in number, vCursor out cur)is
    temp_etapa_actual INTEGER;
    temp_etapa_id INTEGER;
    temp_etapa_actual_id INTEGER;
  begin
    tempdate := SYSDATE;

    select etapa_actual into temp_etapa_actual from tbl_viaje where id = vViaje;
    update tbl_viaje set etapa_actual = (temp_etapa_actual-1) WHERE id = vViaje;

    select id into temp_etapa_id from tbl_etapa where viaje_id = vViaje and nro_etapa = temp_etapa_actual ;

    delete from tbl_practicoviaje where etapa_bajada = temp_etapa_id or etapa_subida = temp_etapa_id;
    delete from tbl_cargaetapa where etapa_id = temp_etapa_id;
    delete from tbl_evento where etapa_id = temp_etapa_id;

    delete from tbl_etapa where id = temp_etapa_id;

    select id into temp_etapa_actual_id from tbl_etapa where viaje_id = vViaje and nro_etapa = (temp_etapa_actual-1);

    insert into tbl_evento ( usuario_id , viaje_id , etapa_id , tipo_id , fecha)
      VALUES ( usrid, vViaje , temp_etapa_actual_id , 28 , TO_DATE(tempdate, 'DD-MM-yy HH24:mi'));

  end traer_barco_recien_liberado;
  -------------------------------------------------------------------------------------------------------------
  --Crea un viaje, se verifica si el buque seleccionado es internacional,
  --se crea la etapa inicial,
  --registra el evento

  procedure crear_viaje(vBuque in varchar2, vOrigen in varchar2, vDestino in varchar2, vInicio in varchar2, vEta in varchar2, vZoe in varchar2, vZona in varchar, vProx in varchar, vInternacional in number, vLat in number, vLon in number, vRiocanal in varchar2, vCodigoMalvinas in INTEGER, usrid in number, vCursor out cur) is
  begin

    select latitud, longitud, uso, rios_canales_km_id into posicion
    from tbl_puntodecontrol pdc
    left join rios_canales_km rck on pdc.rios_canales_km_id = rck.id
    where pdc.id = vZona;

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

      --Informacion del buque
      SELECT b.id_buque||','||Trim(b.matricula)||','||Trim(b.matricula)||','||Trim(b.nro_omi)||
             ','||Trim(b.nombre)||','||Trim(b.bandera)||','||Trim(b.nro_ismm)||','||Trim(b.sdist)||','||b.tipo
             into temp3 FROM buques_new b where b.id_buque=vBuque;

      INSERT INTO tbl_viaje (buque_id, origen_id, destino_id, fecha_salida, eta,
                              zoe, latitud, longitud, created_at, rios_canales_km_id, riokm_actual,
                               created_by, updated_at, updated_by, buque_info, codigo_malvinas_inicio, estado )

      VALUES (vBuque, vOrigen, vDestino, TO_DATE(vInicio, 'DD-MM-yy HH24:mi'), TO_DATE(vEta, 'DD-MM-yy HH24:mi'),
              TO_DATE(vZoe, 'DD-MM-yy HH24:mi'), lat, lon, tempdate, riokm, posicion.riokm,
              usrid, tempdate, usrid, temp3, vCodigoMalvinas, 1000 ) returning id into temp;

      insert into tbl_etapa ( viaje_id, actual_id, destino_id, hrp, fecha_salida, created_at, sentido, created_by, puerto_origen, puerto_destino )
      VALUES ( temp, vZona, vProx, TO_DATE(vInicio, 'DD-MM-yy HH24:mi'), TO_DATE(vInicio, 'DD-MM-yy HH24:mi'), tempdate, null, usrid, vOrigen, vDestino ) returning id into temp2;

      --nuevo log
      insert into tbl_evento ( usuario_id , viaje_id , etapa_id , tipo_id , fecha, puntodecontrol1_id, puntodecontrol2_id, latviaje, lonviaje, ptoviaje)
      VALUES ( usrid, temp , temp2 , 1 , TO_DATE(vInicio, 'DD-MM-yy HH24:mi'), vZona, vProx, lat, lon, vZona);
    END;

    open vCursor for select * from tbl_etapa where id = temp2;
  end crear_viaje;

  ---------------------------------------------------------------------------------------------------------------
  -- Confirma la creacion del viaje
  procedure confirma_viaje(vViaje in varchar2, vConfirma in varchar2, usrid in number, vCursor out cur) is
    tmp_var_punto tbl_puntodecontrol%ROWTYPE;
  begin

      IF vConfirma = '0' THEN

        delete from tbl_evento WHERE viaje_id = vViaje;
        delete from tbl_cargaetapa WHERE etapa_id IN (SELECT id FROM tbl_etapa WHERE viaje_id = vViaje);
        delete from tbl_practicoviaje WHERE viaje_id = vViaje;
        delete from tbl_etapa WHERE viaje_id = vViaje;
        delete from tbl_pbip WHERE viaje_id = vViaje;
        delete from tbl_viaje WHERE id = vViaje;

      ELSE

        --Pasamos el viaje a estado activo
        update tbl_viaje
          set
            estado        = 0
          where id=vViaje;
        
        --Si fue creado en un punto de control 1 o 6, estado = ZR
        select pdc.* into tmp_var_punto 
        from tbl_puntodecontrol pdc 
        left join tbl_etapa e on pdc.id=e.actual_id 
        WHERE e.viaje_id=vViaje;

        IF tmp_var_punto.tipo = 1 or tmp_var_punto.tipo = 6 THEN
          update tbl_viaje
            set
              estado_buque  = 'ZR'
            where id=vViaje;
        END IF;

      END IF;

  end confirma_viaje;
  ---------------------------------------------------------------------------------------------------------------
  --Edita el viaje, se verifica si el buque seleccionado es internacional,
  --registra el evento (TODO)

  procedure editar_viaje(vViaje in varchar2, vBuque in varchar2, vInicio in varchar2, vEta in varchar2, vZoe in varchar2, vZona in varchar, vProx in varchar, vInternacional in number, vLat in number, vLon in number, vRiocanal in varchar2,usrid in number, vCursor out cur) is
  begin

    update tbl_viaje SET
      buque_id           = vBuque,
      --origen_id        = vOrigen,
      --destino_id       = vDestino,
      fecha_salida       = TO_DATE(vInicio, 'DD-MM-yy HH24:mi'),
      eta                = TO_DATE(vEta, 'DD-MM-yy HH24:mi'),
      zoe                = TO_DATE(vZoe, 'DD-MM-yy HH24:mi'),
      latitud            = vLat,
      longitud           = vLon,
      rios_canales_km_id = vRiocanal
    where id = vViaje;

    /*
    UPDATE (
      SELECT e.puerto_origen, e.puerto_destino
      FROM tbl_viaje v
      LEFT JOIN tbl_etapa e ON v.id=e.viaje_id and v.etapa_actual=e.nro_etapa
      WHERE e.viaje_id=vViaje
    ) t
    SET t.puerto_origen=vOrigen, t.puerto_destino=vDestino;
    */

  end editar_viaje;

  procedure editar_viaje2(vViaje in varchar2, vBuque in varchar2, vInicio in varchar2, vEta in varchar2, vZoe in varchar2, vZona in varchar, vProx in varchar, vInternacional in number, vLat in number, vLon in number, vRiocanal in varchar2, vCodigoMalvinasInicio in varchar2, usrid in number, vCursor out cur) is
  begin

    update tbl_viaje SET
      buque_id           = vBuque,
      --origen_id        = vOrigen,
      --destino_id       = vDestino,
      fecha_salida       = TO_DATE(vInicio, 'DD-MM-yy HH24:mi'),
      eta                = TO_DATE(vEta, 'DD-MM-yy HH24:mi'),
      zoe                = TO_DATE(vZoe, 'DD-MM-yy HH24:mi'),
      latitud            = vLat,
      longitud           = vLon,
      rios_canales_km_id = vRiocanal,
      codigo_malvinas_inicio = vCodigoMalvinasInicio
    where id = vViaje;

  end editar_viaje2;
  ---------------------------------------------------------------------------------------------------------------
  --Edita el viaje, la verificacion de si el buque es internacional o internacional esta incluida en la vista,
  --registra el evento (TODO)

  procedure traer_viaje(vViaje in varchar2, usrid in number, vCursor out cur) is
  begin
      open vCursor for
        select v.id, b.ID_BUQUE, b.nombre, b.matricula, b.tipo,
        m.cod origen_id, m.puerto origen, u.cod destino_id, u.puerto destino,
        v.fecha_salida, v.eta, v.zoe, v.notas, v.latitud, v.longitud, rc.nombre || ' - ' || rck.unidad || ' ' || rck.km riocanal,
        v.codigo_malvinas_inicio, v.estado_buque
        from tbl_viaje v
        left join tbl_etapa e ON v.id=e.viaje_id and v.etapa_actual=e.nro_etapa
        left join buques_new b on v.buque_id = b.ID_BUQUE
        left join tbl_kstm_puertos m on e.puerto_origen = m.cod
        left join tbl_kstm_puertos u on e.puerto_destino = u.cod
        left join rios_canales_km rck on v.rios_canales_km_id = rck.id
        left join rios_canales rc on rck.id_rio_canal = rc.id
        where v.id = vViaje;
  end traer_viaje;

  ---------------------------------------------------------------------------------------------------------------
  --Finaliza el viaje, (Lo pasa a estado 1)
  --Registra el evento

  procedure terminar_viaje(vViajeId in number, vFecha in varchar2, vEscalas in varchar2, vCodigoMalvinas in INTEGER, usrid in number, vCursor out cur) is
  begin

    tempdate := SYSDATE;

    update tbl_viaje set estado = 1,
           fecha_llegada = TO_DATE(vFecha, 'DD-MM-yy HH24:mi'),
           escalas = vEscalas,
           updated_by=usrid,
           updated_at=tempdate,
           codigo_malvinas_final=vCodigoMalvinas
           where id = vViajeId;

    select e.* into etapa from tbl_etapa e
    left join tbl_viaje v on e.viaje_id=v.id and e.nro_etapa=v.etapa_actual
    where v.id=vViajeId;

    --nuevo log
    posicion_viaje(vViajeId);
    insert into tbl_evento ( usuario_id , viaje_id , etapa_id, tipo_id, fecha, created_at, latviaje, lonviaje, ptoviaje)
    VALUES ( usrid , vViajeId , etapa.id, 9 , TO_DATE(vFecha, 'DD-MM-yy HH24:mi'), tempdate, viajepos.lat, viajepos.lon, viajepos.pto);
  end terminar_viaje;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure viajes_terminados(vZona in number, usrid in number, vCursor out cur) is
  begin
    open vCursor for

    SELECT * FROM (
        SELECT /*+FIRST_ROWS(10)*/ a.*, ROWNUM rnum FROM (
            select v.id, b.nombre, origen.puerto origen, destino.puerto destino, v.etapa_actual ultima_etapa, e.actual_id, v.estado
              from tbl_viaje v
              left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual)
              left join buques_new b on v.buque_id = b.ID_BUQUE
              left join tbl_kstm_puertos origen on v.origen_id = origen.cod
              left join tbl_kstm_puertos destino on v.destino_id = destino.cod
              order by updated_at DESC
            ) a
        where
        a.estado = 1 and
        a.actual_id = vZona
        )
      WHERE rnum < 10;

  end viajes_terminados;


  -------------------------------------------------------------------------------------------------------------
  --

  procedure reactivar_viaje(vViajeId in number , usrid in number, vCursor out cur) is
  begin
    tempdate := SYSDATE;

    update tbl_viaje set estado = 0, fecha_llegada = null, updated_by=usrid, updated_at=tempdate where id = vViajeId;

    --nuevo log
    posicion_viaje(vViajeId);
    insert into tbl_evento ( usuario_id , viaje_id , tipo_id, fecha, latviaje, lonviaje, ptoviaje)
    VALUES ( usrid , vViajeId , 12 , tempdate, viajepos.lat, viajepos.lon, viajepos.pto);
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

  procedure editar_acompanante(vFecha in varchar2, vEtapa in varchar2, vBuque in varchar2, vBuque2 in varchar2, vBuque3 in varchar2, vBuque4 in varchar2, usrid in number, vCursor out cur) is
    begin
      UPDATE tbl_etapa e SET
        e.acompanante_id  = vBuque,
        e.acompanante2_id = vBuque2,
        e.acompanante3_id = vBuque3,
        e.acompanante4_id = vBuque4
      WHERE e.id = vEtapa returning e.viaje_id into temp;

      --nuevo log
      posicion_viaje(temp);
      insert into tbl_evento ( usuario_id , viaje_id, etapa_id, tipo_id, fecha, acompanante_id, acompanante2_id, acompanante3_id, acompanante4_id, latviaje, lonviaje, ptoviaje )
      VALUES ( usrid , temp, vEtapa , 13 , TO_DATE(vFecha, 'DD-MM-yy HH24:mi'), vBuque, vBuque2, vBuque3, vBuque4, viajepos.lat, viajepos.lon, viajepos.pto);
  end editar_acompanante;

  procedure traer_acompanantes(vEtapa in varchar2, usrid in number, vCursor out cur) is
    begin
    open vCursor for
      select e.acompanante_id, acomp.nombre,
             e.acompanante2_id, acomp2.nombre nombre2,
             e.acompanante3_id, acomp3.nombre nombre3,
             e.acompanante4_id, acomp4.nombre nombre4
      from tbl_etapa e
        left join buques_new acomp on e.acompanante_id = acomp.ID_BUQUE
        left join buques_new acomp2 on e.acompanante2_id = acomp2.ID_BUQUE
        left join buques_new acomp3 on e.acompanante3_id = acomp3.ID_BUQUE
        left join buques_new acomp4 on e.acompanante4_id = acomp4.ID_BUQUE
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
      
      temp2 := -1;

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

      IF temp2 = -1 THEN
        open vCursor for
          select id from tbl_etapa where id = temp2;

        return;
      END IF;

      -- Modificamos la
      update tbl_etapa set
        acompanante_id = null,
        acompanante2_id = null,
        acompanante3_id = null,
        acompanante4_id = null
        where id = etapa.id;

      --nuevo log
      posicion_viaje(viaje.id);
      insert into tbl_evento ( usuario_id , viaje_id , etapa_id , tipo_id , buque_id, fecha, acompanante_id, acompanante2_id, acompanante3_id, acompanante4_id, latviaje, lonviaje, ptoviaje)
      VALUES ( usrid, viaje.id , etapa.id , 15 , viaje.buque_id, SYSDATE, etapa.acompanante_id, etapa.acompanante2_id, etapa.acompanante3_id, etapa.acompanante4_id, viajepos.lat, viajepos.lon, viajepos.pto);

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
    temp_etapa_id number;
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

    --casa
    insert into tbl_etapa ( VIAJE_ID, ORIGEN_ID, ACTUAL_ID, HRP, ETA,
                           FECHA_SALIDA, CANTIDAD_TRIPULANTES, CANTIDAD_PASAJEROS,
                           CAPITAN_ID, SENTIDO, SENTIDO2, SENTIDO3, CALADO_PROA, CALADO_POPA, CALADO_MAXIMO,
                           CALADO_INFORMADO, KM, CREATED_AT, acompanante_id, acompanante2_id,
                           acompanante3_id, acompanante4_id, VELOCIDAD, RUMBO, CREATED_BY, PUERTO_ORIGEN, PUERTO_DESTINO )

    VALUES ( etapa.viaje_id, etapa.actual_id, vZonaId, etapa.fecha_llegada, TO_DATE(vEta, 'DD-MM-yy HH24:mi'),
            etapa.fecha_llegada, etapa.cantidad_tripulantes, etapa.cantidad_pasajeros,
            etapa.capitan_id, null, null, null, etapa.calado_proa, etapa.calado_popa, etapa.calado_maximo,
            etapa.calado_informado, etapa.km, tempdate, etapa.acompanante_id, etapa.acompanante2_id,
            etapa.acompanante3_id, etapa.acompanante4_id, vVelocidad, vRumbo, usrid, etapa.PUERTO_ORIGEN, etapa.PUERTO_DESTINO )

    returning id into temp_etapa_id;
    select * into etapa from tbl_etapa where id = temp_etapa_id;

    --hack--
    --Si es la etapa 1 le pongo a la etapa 0 el sentido que tiene la 1
    --esto es para que en el reporte diario quede como que "venia andando"
    --IF etapa.nro_etapa = 1 THEN
    --  select * into etapa from tbl_etapa where id=etapa.id;
    --  update tbl_etapa set sentido=etapa.sentido where id=temp;
    --END IF;
    --end hack--

    insert into tbl_cargaetapa ( id, tipocarga_id, CANTIDAD_ENTRADA, CANTIDAD_SALIDA, CANTIDAD_INICIAL, CANTIDAD, etapa_id, buque_id )
    ( select carga_seq.nextval, tipocarga_id, 0, 0, cantidad, cantidad, replace(etapa_id, etapa_id, etapa.id), buque_id
    from tbl_cargaetapa where etapa_id = temp );

    --if posicion.uso = 0 THEN
    --  insert into tbl_evento (usuario_id, viaje_id, etapa_id, tipo_id, latitud, longitud, fecha)
    --  values (usrid, etapa.viaje_id, etapa.id, 19, posicion.lat, posicion.lon, tempdate);
    --end if;

    --BEGIN_NOTA: esto siempre? o solo para los puntos de control fluviales?
    update tbl_viaje set latitud=posicion.lat, longitud=posicion.lon, updated_at=tempdate, updated_by=usrid, riokm_actual=posicion.riokm where id=etapa.viaje_id;
    --ENDNOTA

    --nuevo log
    posicion_viaje(viaje.id);
    insert into tbl_evento (usuario_id , viaje_id , etapa_id, tipo_id, puntodecontrol1_id, puntodecontrol2_id, fecha, latviaje, lonviaje, ptoviaje)
    values ( usrid, viaje.id , etapa.id, 7, etapa.origen_id, etapa.actual_id , TO_DATE(vLlegada , 'DD-MM-yy HH24:mi'), viajepos.lat, viajepos.lon, viajepos.pto);

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
    select v.id viaje_id, e.id etapa_id, e.nro_etapa, e.origen_id, e.actual_id, e.destino_id destino_id, e.calado_proa, e.calado_popa, e.calado_maximo, e.calado_informado, e.hrp, e.eta,
      e.fecha_salida, e.fecha_llegada, e.cantidad_tripulantes, e.cantidad_pasajeros,  c.nombre capitan, c.id capitan_id, e.rumbo, e.velocidad, m.puerto origen, u.puerto destino
    from tbl_viaje v
    left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual)
    left join tbl_capitan c on (e.capitan_id = c.id)
    left join tbl_kstm_puertos m on e.puerto_origen = m.cod
    left join tbl_kstm_puertos u on e.puerto_destino = u.cod
    WHERE v.id = vViaje;




  end traer_etapa;

  ---------------------------------------------------------------------------------------------------------------
  procedure descripcion_punto_control( vPuntoControlId in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
       SELECT CASE WHEN rck.km <> 0 then rc.nombre||' '||rck.unidad||' '||rck.km ELSE rc.nombre||' '||rck.unidad END descripcion
         FROM tbl_puntodecontrol pdc
         join rios_canales_km rck on rck.id = pdc.rios_canales_km_id
         join rios_canales rc on rck.id_rio_canal = rc.id
         WHERE pdc.id = vPuntoControlId;
  end descripcion_punto_control;

  ---------------------------------------------------------------------------------------------------------------
  --Edita la informacion etapa
  --Registra el evento

  procedure editar_etapa(vEtapa in varchar2, vOrigen in varchar2, vDestino in varchar2, vCaladoProa in varchar2, vCaladoPopa in varchar2, vCaladoInformado in varchar2, vHPR in varchar2, vETA in varchar2, vFechaSalida in varchar2, vCantidadTripulantes in varchar2, vCantidadPasajeros in varchar2, vCapitan in varchar2, vVelocidad in number, vRumbo in number, usrid in number, vCursor out cur) is
  begin

      -- CAMBIAR ACA EN PREFECTURA CAST( REPLACE(____,'.',',') AS NUMBER);
      update tbl_etapa SET
        calado_proa          = CAST( REPLACE(vCaladoProa,'.',',') AS NUMBER),       --CAST(vCaladoProa AS NUMBER)
        calado_popa          = CAST( REPLACE(vCaladoPopa,'.',',') AS NUMBER),       --CAST(vCaladoPopa AS NUMBER)
        calado_informado     = CAST( REPLACE(vCaladoInformado,'.',',') AS NUMBER),  --CAST(vCaladoInformado AS NUMBER)
        hrp                  = TO_DATE(vHPR, 'DD-MM-yy HH24:mi'),
        eta                  = TO_DATE(vETA, 'DD-MM-yy HH24:mi'),
        --fecha_salida         = TO_DATE(vFechaSalida, 'DD-MM-yy HH24:mi'),
        cantidad_tripulantes = vCantidadTripulantes,
        cantidad_pasajeros = vCantidadPasajeros,
        --practico_id = vPractico,
        capitan_id = vCapitan,
        rumbo = vRumbo,
        velocidad = vVelocidad,
        puerto_origen = vOrigen,
        puerto_destino = vDestino
        --origen_id        = vOrigen,
        --destino_id       = vDestino
      where id = vEtapa;

      -- update
      /*
      UPDATE (
        SELECT e.puerto_origen, e.puerto_destino
        FROM tbl_viaje v
        LEFT JOIN tbl_etapa e ON v.id=e.viaje_id and v.etapa_actual=e.nro_etapa
        WHERE e.viaje_id=vViaje
      ) t
      SET t.puerto_origen=vOrigen, t.puerto_destino=vDestino;
      */
      --
      select * into etapa from tbl_etapa where id=vEtapa;

    --nuevo log
      posicion_viaje(etapa.viaje_id);
      insert into tbl_evento ( viaje_id, usuario_id , etapa_id, tipo_id, fecha, rumbo, velocidad, latviaje, lonviaje, ptoviaje )
      VALUES ( etapa.viaje_id, usrid, vEtapa , 8, TO_DATE(vHPR, 'DD-MM-yy HH24:mi'), vRumbo, vVelocidad, viajepos.lat, viajepos.lon, viajepos.pto);
  end editar_etapa;

  ---------------------------------------------------------------------------------------------------------------
  --

  procedure traer_buque_de_etapa(vEtapa in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
      select e.id, b.* from buques_new b
      left join tbl_viaje v on v.buque_id = b.ID_BUQUE
      left join tbl_etapa e on v.id = e.viaje_id
      where e.id = vEtapa;
  end traer_buque_de_etapa;

  ---------------------------------------------------------------------------------------------------------------
  --

  procedure traer_practicos(vEtapa in varchar2, usrid in number, vCursor out cur) is
  begin

    select * into etapa from tbl_etapa where id = vEtapa;

    open vCursor for
      SELECT pr.id, pr.nombre, pv.fecha_subida, pv.activo FROM tbl_practicoviaje pv
      LEFT JOIN tbl_practico pr ON pv.practico_id=pr.id
      WHERE pv.viaje_id=etapa.viaje_id and pv.fecha_bajada is null;

  end traer_practicos;

  ---------------------------------------------------------------------------------------------------------------
  --

  procedure agregar_practico(vEtapa in varchar2, vPractico in varchar2, vFecha in varchar2, usrid in number, vCursor out cur) is
  begin
    select * into etapa from tbl_etapa where id = vEtapa;

    --select count(*) into temp from tbl_practicoviaje where viaje_id=etapa.viaje_id and fecha_bajada is null;

    --temp2    := 1;
    --tempdate := NULL;

    --IF temp <> 0 THEN
    --temp2 := 0;
    --END IF;

    insert into tbl_practicoviaje (viaje_id, etapa_subida, practico_id, fecha_subida, activo)
    values( etapa.viaje_id, etapa.id, vPractico, TO_DATE(vFecha, 'DD-MM-yy HH24:mi'), 0);

    --nuevo log
    posicion_viaje(etapa.viaje_id);
    insert into tbl_evento (viaje_id, etapa_id, usuario_id, practico_id, tipo_id, fecha, latviaje, lonviaje, ptoviaje)
    VALUES (etapa.viaje_id, etapa.id, usrid, vPractico, 16, TO_DATE(vFecha, 'DD-MM-yy HH24:mi'), viajepos.lat, viajepos.lon, viajepos.pto);

  end agregar_practico;

  ---------------------------------------------------------------------------------------------------------------
  --
  procedure activar_practico(vPractico in varchar2, vEtapa in varchar2, vFecha in varchar2, usrid in number, vCursor out cur) is
  begin
    select * into etapa from tbl_etapa where id = vEtapa;

    --TODO: HACER SUMAS DE HORAS EN EL QUE ESTABA ACTIVO
    update tbl_practicoviaje set activo=0 where viaje_id=etapa.viaje_id;
    update tbl_practicoviaje set activo=1 where viaje_id=etapa.viaje_id and practico_id=vPractico;

    --nuevo log
    posicion_viaje(etapa.viaje_id);
    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, fecha, practico_id, latviaje, lonviaje, ptoviaje)
    VALUES (etapa.viaje_id, etapa.id, usrid, 18, TO_DATE(vFecha, 'DD-MM-yy HH24:mi'), vPractico, viajepos.lat, viajepos.lon, viajepos.pto);

  end activar_practico;

  ---------------------------------------------------------------------------------------------------------------
  --

  procedure bajar_practico(vPractico in varchar2, vEtapa in varchar2, vFecha in varchar2, usrid in number, vCursor out cur) is
  begin
    select * into etapa from tbl_etapa where id = vEtapa;

    --TODO: HACER SUMAS DE HORAS SI ESTABA ACTIVO

    update tbl_practicoviaje set
      activo=0,
      fecha_bajada=TO_DATE(vFecha, 'DD-MM-yy HH24:mi')
    where viaje_id=etapa.viaje_id and practico_id=vPractico and fecha_bajada is null;

    --nuevo log
    posicion_viaje(etapa.viaje_id);
    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, fecha, practico_id, latviaje, lonviaje, ptoviaje)
    VALUES (etapa.viaje_id, etapa.id, usrid, 17, TO_DATE(vFecha, 'DD-MM-yy HH24:mi'), vPractico, viajepos.lat, viajepos.lon, viajepos.pto);

  end bajar_practico;

  procedure traer_etapa_viaje(vEtapa in varchar2, usrid in number, vCursor out cur)is
  begin
    open vCursor for
      SELECT tbl_etapa.id, nro_etapa, viaje_id, tbl_etapa.origen_id, actual_id, tbl_etapa.destino_id, hrp, tbl_etapa.eta, tbl_etapa.fecha_salida, tbl_etapa.fecha_llegada, cantidad_tripulantes, cantidad_pasajeros, capitan_id,
        calado_proa, calado_popa, calado_maximo, calado_informado, km, tbl_etapa.created_at, acompanante_id, sentido, velocidad, rumbo, tbl_etapa.created_by, acompanante2_id, acompanante3_id,
        acompanante4_id, puerto_origen, puerto_destino , u.destino, m.puerto origen_desc, u.puerto destino_desc, v.estado_buque
      from
        tbl_etapa
        LEFT JOIN vw_int_usuarios u on created_by=u.ndoc
        left join tbl_kstm_puertos m on puerto_origen = m.cod
        left join tbl_kstm_puertos u on puerto_destino = u.cod
        left join tbl_viaje v on viaje_id = v.id
      where tbl_etapa.id = vEtapa;
  end traer_etapa_viaje;

  procedure modificar_extremos_etapa(vEtapa in varchar2, vOrigen in varchar2, vDestino in varchar2, usrid in number, vCursor out cur)is
  begin

   update tbl_etapa set puerto_destino = vDestino, puerto_origen = vOrigen
      where id = vEtapa;

  end modificar_extremos_etapa;

  procedure modificar_extremos_etapa_ex(vEtapa in varchar2, vOrigen in varchar2, vDestino in varchar2,usrid in number, vCursor out cur)is
  begin

    select * into etapa from tbl_etapa where id=vEtapa;

    update tbl_etapa set puerto_destino = vDestino, puerto_origen = vOrigen
    where viaje_id=etapa.viaje_id and nro_etapa >= etapa.nro_etapa;

  end modificar_extremos_etapa_ex;

  procedure modificar_fecha_etapa(vEtapa in varchar2, vFecha in varchar2, usrid in number, vCursor out cur)is
  begin
    -- Etapa anterior
    declare
        etapa_anterior number;
      begin

        update tbl_etapa set
            fecha_salida = TO_DATE(vFecha , 'DD-MM-yy HH24:mi'),
            hrp          = TO_DATE(vFecha , 'DD-MM-yy HH24:mi')
        where id = vEtapa;

        --Etapa actual del viaje duen/o de la barcaza
        select MAX(id) into etapa_anterior
          from tbl_etapa
          where id<vEtapa
            and viaje_id = (select viaje_id from tbl_etapa where id = vEtapa);

        --Ya estaba en mi viaje esta barcaza?
        IF etapa_anterior is not null THEN
          update tbl_etapa set fecha_llegada = TO_DATE(vFecha , 'DD-MM-yy HH24:mi') where id = etapa_anterior;
        END IF;

        -- log
        UPDATE tbl_evento SET fecha = TO_DATE(vFecha, 'DD-MM-yy HH24:mi'), updated_by = usrid, updated_at = SYSDATE
        WHERE etapa_id = vEtapa
              /*and fecha = TO_DATE(vFechaOriginal , 'DD-MM-yy HH24:mi')*/
              and tipo_id=7 and puntodecontrol2_id = (select actual_id from tbl_etapa where id = vEtapa);
      END;

  end modificar_fecha_etapa;

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
  procedure corregir_barcaza(vEtapa in varchar2, vBuque in varchar2, vBarcaza in varchar2, usrid in number, vCursor out cur) is
  begin
    select * into etapa from tbl_etapa where id = vEtapa;

    update tbl_cargaetapa set buque_id=vBuque where etapa_id=vEtapa and buque_id=vBarcaza;

    --nuevo log
    posicion_viaje(etapa.viaje_id);
    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, buque_id, barcaza_id, fecha, latviaje, lonviaje, ptoviaje)
    VALUES (etapa.viaje_id, etapa.id, usrid, 25, vBuque, vBarcaza, SYSDATE, viajepos.lat, viajepos.lon, viajepos.pto);

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
    insert into tbl_cargaetapa ( ID, TIPOCARGA_ID, CANTIDAD, CANTIDAD_INICIAL, ETAPA_ID, BUQUE_ID )
      VALUES ( carga_seq.nextval, 412, 0, 0, vEtapaId, vBarcazaId) returning id into temp;

    --nuevo log
    posicion_viaje(etapa.viaje_id);
    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, barcaza_id, fecha, latviaje, lonviaje, ptoviaje)
    VALUES (etapa.viaje_id, vEtapaId, usrid, 21, vBarcazaId, SYSDATE, viajepos.lat, viajepos.lon, viajepos.pto);


  end descargar_barcaza;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure descargar_barcaza_batch(vEtapaId in varchar2, vBarcazaId in varchar2, usrid in number) is
  begin
    declare
    begin
      for carga in ( select id from tbl_cargaetapa where buque_id = vBarcazaId and etapa_id=vEtapaId)
      loop
      eliminar_carga_sin_cursor(carga.id, 0, usrid);
      end loop;
    end;

    --  ACA VA EL ID DEL TIPO DE CARGA LASTRE
    --  [412]
    select * into etapa from tbl_etapa where id = vEtapaId;
    insert into tbl_cargaetapa ( ID, TIPOCARGA_ID, CANTIDAD, CANTIDAD_INICIAL, ETAPA_ID, BUQUE_ID )
      VALUES ( carga_seq.nextval, 412, 0, 0, vEtapaId, vBarcazaId) returning id into temp;

    --nuevo log
    posicion_viaje(etapa.viaje_id);
    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, barcaza_id, fecha, latviaje, lonviaje, ptoviaje)
    VALUES (etapa.viaje_id, vEtapaId, usrid, 21, vBarcazaId, SYSDATE, viajepos.lat, viajepos.lon, viajepos.pto);


  end descargar_barcaza_batch;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure traer_cargas( vEtapaId in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
    select tc.nombre, c.cantidad, c.cantidad_inicial, c.cantidad_entrada, c.cantidad_salida,
           u.nombre unidad, tc.codigo, c.tipocarga_id, c.id carga_id, b.nombre barcaza, b.ID_BUQUE
           from tbl_cargaetapa c
    join tbl_tipo_carga tc on c.tipocarga_id = tc.id
    join tbl_unidad u on tc.unidad_id = u.id
    left join buques_new b on b.ID_BUQUE = c.buque_id
    where c.etapa_id = vEtapaId 

    and ( c.cantidad <> 0 or ( tc.codigo = 'BAL' or tc.codigo = 'PND' ) )

    order by barcaza;
  end traer_cargas;

  procedure traer_carga( vCargaId in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
    select c.etapa_id, tc.nombre, c.cantidad, c.cantidad_inicial, c.cantidad_entrada, c.cantidad_salida,
           u.nombre unidad, tc.unidad_id, tc.codigo, c.tipocarga_id, c.id carga_id, b.nombre barcaza, b.ID_BUQUE, c.en_transito
           from tbl_cargaetapa c
    join tbl_tipo_carga tc on c.tipocarga_id = tc.id
    join tbl_unidad u on tc.unidad_id = u.id
    left join buques_new b on b.ID_BUQUE = c.buque_id
    where c.id = vCargaId order by barcaza;
  end traer_carga;



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
    join tbl_unidad u on tc.unidad_id = u.id
    where c.etapa_id = vEtapaId and c.buque_id is null and c.en_transito = 0
    and ( c.cantidad <> 0 and tc.codigo <> 'BAL' and tc.codigo <> 'PND' );
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
    join tbl_unidad u on tc.unidad_id = u.id
    left join buques_new b on b.ID_BUQUE = c.buque_id
    where c.etapa_id = vEtapa and c.buque_id IS NOT NULL;
  end traer_barcazas_de_buque;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure transferir_barcazas(vFecha in varchar2, vBarcaza in varchar2, vEtapa in varchar2, usrid in number) is
  begin
      declare
        eorig number;
        edest number;
      begin

        --Etapa actual del viaje duen/o de la barcaza
        select max(etapa_id) into eorig from tbl_cargaetapa where buque_id=vBarcaza;

        --Tomo el viaje destino

        --Etapa destino
        edest := vEtapa;

        --Ya estaba en mi viaje esta barcaza?
        IF edest != eorig THEN

          --Traigo las cargas de la etapa origen que tiene esa barcaza
          for carga in ( select id from tbl_cargaetapa where buque_id = vBarcaza and etapa_id=eorig)
          loop

            --Indico que a este viaje se le fueron estas barcazas
            select * into etapa  from tbl_etapa where id = eorig;
            select * into etapa2 from tbl_etapa where id = edest;

            --nuevo log
            posicion_viaje(etapa.viaje_id);
            insert into tbl_evento (viaje_id, viaje2_id, etapa_id, usuario_id, tipo_id, barcaza_id, carga_id, fecha, latviaje, lonviaje, ptoviaje)
            VALUES (etapa.viaje_id, etapa2.viaje_id, etapa.id, usrid, 11, vBarcaza, carga.id, TO_DATE(vFecha, 'DD-MM-yy HH24:mi'), viajepos.lat, viajepos.lon, viajepos.pto);

            --nuevo log
            posicion_viaje(etapa2.viaje_id);
            insert into tbl_evento (viaje_id, viaje2_id, etapa_id, usuario_id, tipo_id, barcaza_id, carga_id, fecha, latviaje, lonviaje, ptoviaje)
            VALUES (etapa2.viaje_id, etapa.viaje_id, etapa2.id, usrid, 10, vBarcaza, carga.id, TO_DATE(vFecha, 'DD-MM-yy HH24:mi'), viajepos.lat, viajepos.lon, viajepos.pto);

            EXIT;

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

  procedure transferir_cargas(vFecha in varchar2, vEtapa in varchar2, vCarga in varchar2, vCantidad in varchar2, vUnidad in varchar2, vTipo in varchar2, vModo in varchar2, vOriginal in varchar2, vRecEmi in varchar2, usrid in number) is
  begin
      DECLARE

      BEGIN
        --traemos la etapa
        select * into etapa from tbl_etapa where id=vEtapa;

        IF vModo = 'add' THEN
          insert into tbl_cargaetapa ( ID, TIPOCARGA_ID, CANTIDAD, ETAPA_ID, EN_TRANSITO, CANTIDAD_INICIAL )
          VALUES ( carga_seq.nextval, vTipo, vCantidad, vEtapa, 0, vCantidad) returning id into temp;

          -- log usrid id in number
          --nuevo log
          posicion_viaje(etapa.viaje_id);
          insert into tbl_evento ( usuario_id , viaje_id , etapa_id , tipo_id , fecha, carga_id, latviaje, lonviaje, ptoviaje )
          VALUES ( usrid, etapa.viaje_id , etapa.id , 26, TO_DATE(vFecha, 'DD-MM-yy HH24:mi'), temp, viajepos.lat, viajepos.lon, viajepos.pto );

        END IF;
        IF vModo = 'upd' THEN
          update tbl_cargaetapa set CANTIDAD = vCantidad where ID=vCarga;

          if vRecEmi = 'ree' THEN
            -- log usrid vCarga in number
            --nuevo log
            posicion_viaje(etapa.viaje_id);
            insert into tbl_evento ( usuario_id , viaje_id , etapa_id , tipo_id , fecha, carga_id, latviaje, lonviaje, ptoviaje )
            VALUES ( usrid, etapa.viaje_id , etapa.id , 26, TO_DATE(vFecha, 'DD-MM-yy HH24:mi'), vCarga, viajepos.lat, viajepos.lon, viajepos.pto );
          ELSE
            -- log usrid vCarga in number
            --nuevo log
            posicion_viaje(etapa.viaje_id);
            insert into tbl_evento ( usuario_id , viaje_id , etapa_id , tipo_id , fecha, carga_id, latviaje, lonviaje, ptoviaje )
            VALUES ( usrid, etapa.viaje_id , etapa.id , 27, TO_DATE(vFecha, 'DD-MM-yy HH24:mi'), vCarga, viajepos.lat, viajepos.lon, viajepos.pto );
          END IF;

        END IF;
        IF vModo = 'del' THEN
          delete from tbl_cargaetapa where ID=vCarga;
          -- log usrid id in number
          --nuevo log
          posicion_viaje(etapa.viaje_id);
          insert into tbl_evento ( usuario_id , viaje_id , etapa_id , tipo_id , fecha, carga_id, latviaje, lonviaje, ptoviaje )
          VALUES ( usrid, etapa.viaje_id , etapa.id , 27, TO_DATE(vFecha, 'DD-MM-yy HH24:mi'), vCarga, viajepos.lat, viajepos.lon, viajepos.pto);

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

  procedure crear_editar_carga(vNew in varchar, vEtapa in varchar2, vCargaId in varchar2, vTipo in varchar2, vCantidadIni in varchar2, vCantidadEnt in varchar2, vCantidadSal in varchar2, vUnidad in varchar2, vBuque in varchar2, vEnTransito in varchar2, usrid in number, vCursor out cur) is
    cantidad_ini number;
    cantidad_sal number;
    cantidad_ent number;
  begin

    cantidad_ini := CAST(REPLACE(vCantidadIni,'.',',') AS NUMBER);
    cantidad_sal := CAST(REPLACE(vCantidadSal,'.',',') AS NUMBER);
    cantidad_ent := CAST(REPLACE(vCantidadEnt,'.',',') AS NUMBER);

    IF UPPER(vNew) = 'FALSE' THEN
      update tbl_cargaetapa
        set TIPOCARGA_ID     = vTipo,
            CANTIDAD         = cantidad_ini + cantidad_ent-cantidad_sal,
            CANTIDAD_INICIAL = cantidad_ini,
            CANTIDAD_ENTRADA = cantidad_ent,
            CANTIDAD_SALIDA  = cantidad_sal,
            --UNIDAD_ID        = vUnidad,
            BUQUE_ID         = vBuque,
            EN_TRANSITO      = vEnTransito
        where ID=vCargaId;
    ELSE

      insert into tbl_cargaetapa (ID, ETAPA_ID, TIPOCARGA_ID, CANTIDAD, CANTIDAD_INICIAL, CANTIDAD_ENTRADA, CANTIDAD_SALIDA, BUQUE_ID, EN_TRANSITO)
        VALUES (carga_seq.nextval,
                vEtapa,
                vTipo,
                cantidad_ini + cantidad_ent-cantidad_sal,
                cantidad_ini,
                cantidad_ent,
                cantidad_sal,
                --vUnidad,
                vBuque,
                vEnTransito);
    END IF;
  end crear_editar_carga;


  -------------------------------------------------------------------------------------------------------------
  --

  procedure insertar_carga( vEtapa in varchar2, vCarga in varchar2, vCantidad in varchar2, vUnidad in varchar2, vBuque in varchar2,  vEnTransito in varchar2, usrid in number, vCursor out cur) is
    temp_cantidad number;
  begin

    --  ACA VA EL ID DEL TIPO DE CARGA LASTRE
    --  [412]
    IF vBuque is not null THEN
      delete from tbl_cargaetapa where etapa_id=vEtapa and TIPOCARGA_ID=412 and buque_id=vBuque;
    ELSE
      delete from tbl_cargaetapa where etapa_id=vEtapa and TIPOCARGA_ID=412;
    END IF;

    -- CAMBIAR ACA EN PREFECTURA CAST(REPLACE(____,'.',',') AS NUMBER);
    temp_cantidad := CAST(REPLACE(vCantidad,'.',',') AS NUMBER);

    select * into etapa from tbl_etapa where id = vEtapa;
    --select * into viaje from tbl_viaje where id = etapa.viaje_id;

    -- Si es la primera carga va en cantidad entrada
    --IF viaje.estado = 1000 THEN
    insert into tbl_cargaetapa ( ID, TIPOCARGA_ID, CANTIDAD, ETAPA_ID, BUQUE_ID, EN_TRANSITO, CANTIDAD_ENTRADA )
    VALUES ( carga_seq.nextval, vCarga, temp_cantidad, vEtapa, vBuque, vEnTransito, temp_cantidad) returning id into temp;
    --ELSE
    --  insert into tbl_cargaetapa ( ID, TIPOCARGA_ID, CANTIDAD, ETAPA_ID, BUQUE_ID, EN_TRANSITO, CANTIDAD_INICIAL )
    --  VALUES ( carga_seq.nextval, vCarga, temp_cantidad, vEtapa, vBuque, vEnTransito, temp_cantidad) returning id into temp;
    --END IF;

    --nuevo log
    posicion_viaje(etapa.viaje_id);
    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, carga_id, fecha, latviaje, lonviaje, ptoviaje)
    VALUES (etapa.viaje_id, etapa.id, usrid, 4, temp, SYSDATE, viajepos.lat, viajepos.lon, viajepos.pto);

  end insertar_carga;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure modificar_carga(vCarga in varchar2, vCantidadEntrada in varchar2, vCantidadSalida in varchar2, usrid in number, vCursor out cur) is
  begin

    -- CAMBIAR ACA EN PREFECTURA CAST(REPLACE(____,'.',',') AS NUMBER);
    temp  := CAST(REPLACE(vCantidadEntrada,'.',',') AS NUMBER);
    temp2 := CAST(REPLACE(vCantidadSalida,'.',',') AS NUMBER);

    select * into etapa from tbl_etapa where id = (select etapa_id from tbl_cargaetapa where id=vCarga);
    select * into cetapa from tbl_cargaetapa where id=vCarga;
    update tbl_cargaetapa set
      cantidad_entrada = temp,
      cantidad_salida  = temp2,
      cantidad         = (cetapa.cantidad_inicial + temp - temp2)
    where id = vCarga returning id into temp;

    --nuevo log
    posicion_viaje(etapa.viaje_id);
    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, carga_id, fecha, latviaje, lonviaje, ptoviaje)
    VALUES (etapa.viaje_id, etapa.id, usrid, 5, temp, SYSDATE, viajepos.lat, viajepos.lon, viajepos.pto);
  end modificar_carga;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure modificar_carga_actual(vCarga in varchar2, vCantidadActual in varchar2, usrid in number, vCursor out cur) is
  begin

    -- CAMBIAR ACA EN PREFECTURA CAST(REPLACE(____,'.',',') AS NUMBER);
    temp  := CAST(REPLACE(vCantidadActual,'.',',') AS NUMBER);

    select * into etapa from tbl_etapa where id = (select etapa_id from tbl_cargaetapa where id=vCarga);
    select * into cetapa from tbl_cargaetapa where id=vCarga;
    update tbl_cargaetapa set
      cantidad  = temp,
      cantidad_inicial = temp,
      cantidad_entrada = 0,
      cantidad_salida  = 0
    where id = vCarga returning id into temp;

    --nuevo log
    posicion_viaje(etapa.viaje_id);
    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, carga_id, fecha, latviaje, lonviaje, ptoviaje)
    VALUES (etapa.viaje_id, etapa.id, usrid, 29, temp, SYSDATE, viajepos.lat, viajepos.lon, viajepos.pto);
  end modificar_carga_actual;


  procedure modificar_tipo_carga(vCargaId in varchar2, vUnidadId in varchar2, vTipoCargaId in varchar2, usrid in number, vCursor out cur) is
  begin

    update tbl_cargaetapa set tipocarga_id = vTipoCargaId
      where id = vCargaId ;

    select * into etapa from tbl_etapa where id = (select etapa_id from tbl_cargaetapa where id=vCargaId);

    posicion_viaje(etapa.viaje_id);

    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, carga_id, fecha, latviaje, lonviaje, ptoviaje)
    VALUES (etapa.viaje_id, etapa.id, usrid, 5, vCargaId, SYSDATE, viajepos.lat, viajepos.lon, viajepos.pto);

  end modificar_tipo_carga;
  -------------------------------------------------------------------------------------------------------------
  --

  procedure check_empty(vEtapaId in number, vBuqueId in number) is
  begin
    select count(*) into temp from tbl_cargaetapa where etapa_id = vEtapaId and buque_id=vBuqueId;
    IF temp = 0 THEN
      insert into tbl_cargaetapa ( ID, TIPOCARGA_ID, CANTIDAD_INICIAL, CANTIDAD, ETAPA_ID, BUQUE_ID )
      VALUES ( carga_seq.nextval, 412, 0, 0, cetapa.etapa_id, cetapa.buque_id) returning id into temp;
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
      select * into viaje from tbl_viaje where id=temp;

      --Cambio las cargas al nuevo viaje (etapa actual = vEtapaId)
      update tbl_cargaetapa set etapa_id=vEtapaId where etapa_id=etapa.id;

      --Borro el viaje falso y la etapa falsa (todo lo relativo a viaje_id)
      delete from tbl_etapa where viaje_id=temp;
      delete from tbl_viaje where id=temp;

      --Traemos la etapa actual (la que se lleva las barcazas)
      select * into etapa from tbl_etapa where id=vEtapaId;

      -- Logueamos
      --nuevo log
      posicion_viaje(etapa.viaje_id);
      insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, barcaza_id, fecha, latviaje, lonviaje, ptoviaje)
      VALUES (etapa.viaje_id, etapa.id, usrid, 23, viaje.buque_id, SYSDATE, viajepos.lat, viajepos.lon, viajepos.pto);

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
    --nuevo log
    posicion_viaje(etapa.viaje_id);
    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, barcaza_id, fecha, rios_canales_km_id, latitud, longitud, latviaje, lonviaje, ptoviaje)
    VALUES (viaje.id, vEtapaId, usrid, 22, vBarcazaId, tempdate, vRioCanalKM, vLat, vLon, viajepos.lat, viajepos.lon, viajepos.pto);

  end fondear_barcaza;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure fondear_barcaza_batch(vEtapaId in number, vBarcazaId in number, vRioCanalKM in varchar2, vLat in number, vLon in number, vFecha in varchar2, usrid in number) is
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
    --nuevo log
    posicion_viaje(viaje.id);
    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, barcaza_id, fecha, rios_canales_km_id, latitud, longitud, latviaje, lonviaje, ptoviaje)
    VALUES (viaje.id, vEtapaId, usrid, 22, vBarcazaId, tempdate, vRioCanalKM, vLat, vLon, viajepos.lat, viajepos.lon, viajepos.pto);

  end fondear_barcaza_batch;

  -------------------------------------------------------------------------------------------------------------
  --
  procedure eliminar_carga(vCarga in varchar2, checkempty in number, usrid in number, vCursor out cur) is
  begin
    select * into cetapa from tbl_cargaetapa where id=vCarga;
    select * into etapa from tbl_etapa where id = cetapa.etapa_id;

    delete from tbl_cargaetapa where id = vCarga;

    --nuevo log
    posicion_viaje(etapa.viaje_id);
    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, carga_id, fecha, latviaje, lonviaje, ptoviaje)
    VALUES (etapa.viaje_id, etapa.id, usrid, 6, vCarga, SYSDATE, viajepos.lat, viajepos.lon, viajepos.pto);

    -- Ver si tiene mas cargas esta barcaza, sino, ponerle un lastre
    IF checkempty != 0 AND cetapa.buque_id is not null THEN
      check_empty(cetapa.etapa_id, cetapa.buque_id);
    END IF;

  end eliminar_carga;

  -------------------------------------------------------------------------------------------------------------
  --
 procedure eliminar_carga_sin_cursor(vCarga in varchar2, checkempty in number, usrid in number) is
  begin
    select * into cetapa from tbl_cargaetapa where id=vCarga;
    select * into etapa from tbl_etapa where id = cetapa.etapa_id;

    delete from tbl_cargaetapa where id = vCarga;

    --nuevo log
    posicion_viaje(etapa.viaje_id);
    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, carga_id, fecha, latviaje, lonviaje, ptoviaje)
    VALUES (etapa.viaje_id, etapa.id, usrid, 6, vCarga, SYSDATE, viajepos.lat, viajepos.lon, viajepos.pto);

    -- Ver si tiene mas cargas esta barcaza, sino, ponerle un lastre
    IF checkempty != 0 AND cetapa.buque_id is not null THEN
      check_empty(cetapa.etapa_id, cetapa.buque_id);
    END IF;

  end eliminar_carga_sin_cursor;

  -------------------------------------------------------------------------------------------------------------
  --
  procedure detalles_tecnicos( vShipId in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
      select *
      from buques_new b
      where b.ID_BUQUE = vShipId;
  end detalles_tecnicos;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure autocomplete_barcazas(vEtapaId in varchar2, vQuery in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
            select b.id_buque, b.nombre, b.bandera, bi.viaje_fondeada, Nvl(bi.info,'0') info, bi.etapa_id-vEtapaId etapa

      FROM buques_new b
      LEFT JOIN VW_BARCAZAS_EN_VIAJE bi ON b.id_buque = bi.buque_id


      where ( UPPER(b.TIPO_BUQUE) like 'BARCAZA%'
           or UPPER(b.TIPO_BUQUE) like 'BALSA%'
           or UPPER(b.TIPO_SERVICIO) like 'BARCAZA%'
           or UPPER(TIPO_SERVICIO) like 'BALSA%' )
      and   UPPER(nombre) like '%'||UPPER(vQuery)||'%'

      and rownum < 12 order by nombre ;
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
      and rownum < 12;
  end autocomplete_muelles;
  -------------------------------------------------------------------------------------------------------------
  --
  procedure autocomplete_cargas(vQuery in varchar2, usrid in number, vCursor out cur) is
  begin
    sql_stmt := 'select * from ( select a.*, ROWNUM rnum from (
                    select COD,RESUMEN,ESTADO,AGRUPA, case when upper(cod) like upper(:vQuery) then 1 else 0 end as groovy from tbl_bq_estados
                    order by groovy desc  ) a
                  where upper(cod) like upper(:vQuery) or
                        upper(estado) like upper(:vQuery) or
                        upper(resumen) like upper(:vQuery) )
                  where rnum <= 10';


  open vCursor for
      select * from( select a.*, ROWNUM rnum from (
        select tc.ID, tc.NOMBRE||' ('||tc.codigo||')' NOMBRE, tc.CODIGO, tc.UNIDAD_ID, un.NOMBRE UNOMBRE, case when upper(tc.codigo) like '%'||UPPER(vQuery)||'%' then 1 else 0 end as groovy
        from tbl_tipo_carga tc left join tbl_unidad un on tc.unidad_id=un.id order by groovy desc) a
      where ( upper(a.nombre) like '%'||UPPER(vQuery)||'%' or upper(a.codigo) like '%'||UPPER(vQuery)||'%'  ) )
      where rnum < 12;
  end autocomplete_cargas;
  -------------------------------------------------------------------------------------------------------------
  --

  procedure autocomplete_practicos(vQuery in varchar2, vEtapa in varchar2, usrid in number, vCursor out cur) is
  begin

    select * into etapa from tbl_etapa where id=vEtapa;

    open vCursor for
      select p.ID, p.NOMBRE
      from tbl_practico p
      where
        upper(p.NOMBRE) like '%'||UPPER(vQuery)||'%'
      and
        p.id not in (SELECT practico_id FROM tbl_practicoviaje WHERE viaje_id=etapa.viaje_id and fecha_bajada is null)
      and rownum < 12;
  end autocomplete_practicos;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure autocompletebactivos(vQuery in varchar2, usrid in number, vCursor out cur) is
  begin
    sql_stmt := 'select v.id, v.buque_id, viaje_id, e.id etapa_id, b.nombre, b.sdist, b.nro_omi from buques_new b
                        left join tbl_viaje v on v.buque_id = b.ID_BUQUE
                        left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual)
                        where v.estado=0 and (upper(b.nombre) like upper(:vQuery) or
                            upper(b.bandera) like upper(:vQuery) or
                            upper(b.matricula) like upper(:vQuery) or
                            upper(b.nro_omi) like upper(:vQuery) or
                            upper(b.nro_ismm) like upper(:vQuery)) and
                            rownum <= 12 ';
    open vCursor for sql_stmt USING vQuery,vQuery,vQuery,vQuery,vQuery;
  end autocompletebactivos;

  -------------------------------------------------------------------------------------------------------------
  --
  procedure autocomplete_viajes_grp( vQuery in varchar2, vGrupo in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for

      SELECT b.nombre||' ('||
      CASE WHEN rck.km <> 0 then rc.nombre||' '||rck.unidad||' '||rck.km ELSE rc.nombre||' '||rck.unidad END
      ||')' descripcion, pdc.id, v.id viaje

      FROM tbl_viaje v
      LEFT JOIN tbl_etapa e ON v.id=e.viaje_id AND v.etapa_actual=e.nro_etapa

      left JOIN tbl_puntodecontrol pdc ON pdc.id=e.actual_id
      left JOIN rios_canales_km rck on rck.id = pdc.rios_canales_km_id
      left JOIN rios_canales rc on rck.id_rio_canal = rc.id

      left JOIN buques_new b ON v.buque_id=b.id_buque

      WHERE e.actual_id IN (SELECT punto FROM tbl_grupopunto WHERE grupo = vGrupo)
      AND v.estado=0
      AND (
            upper(b.nombre) like upper('%'||vQuery||'%') or
            upper(b.bandera) like upper('%'||vQuery||'%') or
            upper(b.sdist) like upper('%'||vQuery||'%') or
            upper(b.matricula) like upper('%'||vQuery||'%') or
            upper(b.nro_omi) like upper('%'||vQuery||'%') or
            upper(b.nro_ismm) like upper('%'||vQuery||'%')
            )
            AND ( b.TIPO_BUQUE IS NULL OR not (
              UPPER(b.TIPO_BUQUE) like 'BARCAZA%' or UPPER(b.TIPO_BUQUE) like 'BALSA%'
            ))
            and rownum <= 12;


  end autocomplete_viajes_grp;
  -------------------------------------------------------------------------------------------------------------
  --

  procedure autocomplete_viajes_usr( vQuery in varchar2, usrid in number, vCursor out cur) is
    begin
    open vCursor for
    SELECT b.nombre||' ('||
      CASE WHEN rck.km <> 0 then rc.nombre||' '||rck.unidad||' '||rck.km ELSE rc.nombre||' '||rck.unidad END
      ||')' descripcion, pdc.id, v.id viaje

      FROM tbl_viaje v
      LEFT JOIN tbl_etapa e ON v.id=e.viaje_id AND v.etapa_actual=e.nro_etapa

      left JOIN tbl_puntodecontrol pdc ON pdc.id=e.actual_id
      left JOIN rios_canales_km rck on rck.id = pdc.rios_canales_km_id
      left JOIN rios_canales rc on rck.id_rio_canal = rc.id

      left JOIN buques_new b ON v.buque_id=b.id_buque

      WHERE e.actual_id IN 
        (SELECT punto FROM tbl_grupopunto WHERE grupo IN (
            select gu_.GRUPO from tbl_usuariogrupo gu_ WHERE gu_.USUARIO=usrid
          )
        )
      AND v.estado=0
      AND (
            upper(b.nombre) like upper('%'||vQuery||'%') or
            upper(b.bandera) like upper('%'||vQuery||'%') or
            upper(b.sdist) like upper('%'||vQuery||'%') or
            upper(b.matricula) like upper('%'||vQuery||'%') or
            upper(b.nro_omi) like upper('%'||vQuery||'%') or
            upper(b.nro_ismm) like upper('%'||vQuery||'%')
            )
            AND ( b.TIPO_BUQUE IS NULL OR not (
              UPPER(b.TIPO_BUQUE) like 'BARCAZA%' or UPPER(b.TIPO_BUQUE) like 'BALSA%'
            ))
            and rownum <= 12;
  end autocomplete_viajes_usr;
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


    paginator(temp3, 12, 1, sql_stmt);
    open vCursor for sql_stmt;

    --open vCursor for sql_stmt USING vQuery, vQuery, vQuery,' ',vQuery, strtemp1, strtemp3, strtemp1, strtemp3, strtemp1, strtemp2, strtemp3;
  end autocompleterioscanales;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure autocomplete_remolcadores(vQuery in varchar2, usrid in number, vCursor out cur) is
  begin
    --VERIFICAR TIPO_BUQUE     'nacional'
    --VERIFICAR TIPO_SERVICIO  'REMOLCADOR' 'EMPUJADOR' otros...

    open vCursor for
    select b.ID_BUQUE, b.matricula, b.nro_omi, b.nombre, b.bandera, b.nro_ismm, b.tipo, b.sdist
    from buques_new b

    where
      --b.ID not in (
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
      (
      upper(b.nombre) like upper('%'||vQuery||'%') or
      upper(b.sdist) like upper('%'||vQuery||'%') or
      upper(b.matricula) like upper('%'||vQuery||'%') or
      upper(b.nro_omi) like upper('%'||vQuery||'%') or
      upper(b.nro_ismm) like upper('%'||vQuery||'%')
      )
    and b.bandera = 'ARGENTINA' and rownum <= 12;

  end autocomplete_remolcadores;

  -------------------------------------------------------------------------------------------------------------
  --
  procedure autocomplete_buques_disp(vQuery in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
    select NVL(z.cuatrigrama,'') costera, b.ID_BUQUE, b.matricula, b.nro_omi, b.nombre, b.bandera, b.nro_ismm, b.tipo, b.sdist
    from buques_new b

      --left JOIN tbl_paises_ciala pc ON b.bandera    = pc.DESCRIPCION
      left join tbl_viaje v on b.ID_BUQUE           = v.buque_id and v.estado = 0
      left join tbl_etapa e on v.id                 = e.viaje_id and v.etapa_actual = e.nro_etapa
      left join tbl_puntodecontrol p on e.actual_id = p.id
      left join tbl_zonas z on p.zona_id            = z.id
    where
      (
      --upper(pc.codalfabetico) like upper('%'||vQuery||'%') or
      upper(b.nombre) like upper('%'||vQuery||'%') or
      upper(b.bandera) like upper('%'||vQuery||'%') or
      upper(b.sdist) like upper('%'||vQuery||'%') or
      upper(b.matricula) like upper('%'||vQuery||'%') or
      upper(b.nro_omi) like upper('%'||vQuery||'%') or
      upper(b.nro_ismm) like upper('%'||vQuery||'%')
      )
      AND ( b.TIPO_BUQUE IS NULL OR not (
        UPPER(b.TIPO_BUQUE) like 'BARCAZA%' or UPPER(b.TIPO_BUQUE) like 'BALSA%'
      ))


      and rownum <= 12;

  end autocomplete_buques_disp;

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
                  where rnum <= 12';
    open vCursor for sql_stmt using vQuery, vQuery, vQuery, vQuery;
  end autocompleterestados;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure autocompleterbenzona(vQuery in varchar2, vZonaId in varchar2, usrid in number, vCursor out cur) is
  begin
    --sql_stmt := 'select * from view_buques left join tbl_viaje on tbl_viaje.buque_id = view_buques.matricula where (upper(nombre) like upper(:vQuery) or upper(bandera) like upper(:vQuery) or upper(matricula) like upper(:vQuery) or upper(nro_omi) like upper(:vQuery)) and rownum <= 6';
    sql_stmt := 'select b.ID_BUQUE, b.matricula, b.nro_omi, b.sdist, b.nombre, b.bandera, b.nro_ismm, b.tipo ,
                  case when (b.ID_BUQUE in
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
                    from view_buques_new b
                    where (upper(b.nombre) like upper(:vQuery) or
                    upper(b.bandera) like upper(:vQuery) or
                    upper(b.matricula) like
                    upper(:vQuery) or upper(b.nro_omi) like upper(:vQuery)) and rownum <= 12';
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
                  where rnum <= 12';
    open vCursor for sql_stmt using vQuery, vQuery, vQuery;
  end autocompleterm;
  -------------------------------------------------------------------------------------------------------------
  --
  procedure crear_buque(vMatricula in varchar2, vNombre in varchar2, vSDist in varchar2, vServicio in varchar2, vMMSI in varchar2, usrid in number, vCursor out cur) is
  begin

  tempdate := sysdate;

  insert into tmp_buques (ID_BUQUE, MATRICULA, NOMBRE, BANDERA, ANIO_CONSTRUCCION, TIPO_BUQUE, TIPO_SERVICIO, SDIST, NRO_ISMM, CREATED_BY, CREATED_AT)
      VALUES ( SQ_FLUVIAL_ID.nextval, vMatricula, vNombre, 'ARGENTINA', 0, vServicio, vServicio, vSDist, vMMSI, usrid, tempdate )

  returning ID_BUQUE,MATRICULA,NRO_OMI,NOMBRE,BANDERA,ANIO_CONSTRUCCION,NRO_ISMM,ASTILL_PARTIC,REGISTRO,TIPO_BUQUE,TIPO_SERVICIO,TIPO_EXPLOTACION,ARBOLADURA,SDIST,VELOCIDAD,ESLORA,MANGA,PUNTAL,ARQUEO_TOTAL,CALADO_MAX,PUERTO_ASIENTO,MATERIAL,SOCIEDADCLASIF,ARQUEO_NETO,DOTACION_MINIMA,TIPO into var_buque;

  insert into tbl_evento (usuario_id, tipo_id, buque_id, fecha) VALUES (usrid, 2, var_buque.ID_BUQUE, tempdate);

  open vCursor for
    select * from buques_new b where b.id_buque=var_buque.ID_BUQUE;
  end crear_buque;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure crear_buque_int(vMatricula in varchar2, vNombre in varchar2, vSDist in varchar2, vBandera in varchar2, vServicio in varchar2, vMMSI in varchar2, usrid in number, vCursor out cur) is
  begin
  tempdate := sysdate;

    insert into tmp_buques ( ID_BUQUE, MATRICULA, NOMBRE, BANDERA, ANIO_CONSTRUCCION, TIPO_BUQUE, TIPO_SERVICIO, SDIST, NRO_OMI, NRO_ISMM, CREATED_BY, CREATED_AT)
      VALUES ( SQ_FLUVIAL_ID.nextval, 'n/a', vNombre,  vBandera, 0, vServicio, vServicio, vSDist, vMatricula, vMMSI, usrid, tempdate)
    returning ID_BUQUE,MATRICULA,NRO_OMI,NOMBRE,BANDERA,ANIO_CONSTRUCCION,NRO_ISMM,ASTILL_PARTIC,REGISTRO,TIPO_BUQUE,TIPO_SERVICIO,TIPO_EXPLOTACION,ARBOLADURA,SDIST,VELOCIDAD,ESLORA,MANGA,PUNTAL,ARQUEO_TOTAL,CALADO_MAX,PUERTO_ASIENTO,MATERIAL,SOCIEDADCLASIF,ARQUEO_NETO,DOTACION_MINIMA,TIPO into var_buque;

    insert into tbl_evento (usuario_id, tipo_id, buque_id, fecha) VALUES (usrid, 2, var_buque.ID_BUQUE, tempdate);
    open vCursor for
      select * from buques_new b where b.id_buque=var_buque.ID_BUQUE;

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
      SELECT r.ID, r.NOMBRE, r.DESCRIPCION, r.CONSULTA_SQL , rc.NOMBRE CATEGORIA
      FROM TBL_REPORTE r
      LEFT JOIN TBL_REPORTECATEGORIA rc on r.categoria_id=rc.id
      ORDER BY rc.NOMBRE;
  end reporte_lista;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure reporte_obtener_parametros(vReporte in number, usrid in number, vCursor out cur) is
  begin
    open vCursor for
      SELECT INDICE,NOMBRE,TIPO_DATO FROM TBL_REPORTE_PARAM WHERE REPORTE_ID=vReporte AND IS_PARAM IS NULL ORDER BY INDICE;

  end reporte_obtener_parametros;
  -------------------------------------------------------------------------------------------------------------
  --

  procedure reporte_obtener_parametros_str(vNombre in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for
      SELECT p.INDICE, p.NOMBRE, p.TIPO_DATO FROM TBL_REPORTE_PARAM p
      JOIN TBL_REPORTE r on p.REPORTE_ID=r.ID and r.NOMBRE=vNombre
      WHERE  IS_PARAM IS NULL
      ORDER BY INDICE;

  end reporte_obtener_parametros_str;
  -------------------------------------------------------------------------------------------------------------
  --

  procedure reporte_obtener(vReporte in number, usrid in number, vCursor out cur) is
  begin
    open vCursor for
      SELECT ID, NOMBRE, DESCRIPCION, FECHA_CREACION, CONSULTA_SQL , POST_PARAMS
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

  -------------------------------------------------------------------------------------------------------------
  --

  procedure reporte_obtener_html_builded(usrid in number, vCursor out cur)is
  begin
    open vCursor for
      SELECT ID, NOMBRE, DESCRIPCION, FECHA_CREACION, CONSULTA_SQL ,  POST_PARAMS
      FROM TBL_REPORTE WHERE POST_PARAMS is not null;

  end reporte_obtener_html_builded;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure reporte_insertar(vNombre in varchar2, vDescripcion in varchar2, vCategoriaId in number, vConsultaSql in clob, vPostParams in clob, usrid in number , vCursor out cur) is
  begin
    insert into tbl_reporte (nombre , descripcion , categoria_id , consulta_sql , post_params)
      values (vNombre , vDescripcion , vCategoriaId , vConsultaSql , vPostParams ) returning id into temp;

    open vCursor for select temp from dual;

  end reporte_insertar;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure reporte_insertar_params(vReporteId in number, vIndice in number, vNombre in varchar2, vTipoDato in number, usrid in number) is
  begin
      insert into tbl_reporte_param(reporte_id , indice , nombre , tipo_dato )
      values(vReporteId , vIndice , vNombre , vTipoDato );

  end reporte_insertar_params;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure reporte_eliminar(vReporteId in number, usrid in number, vCursor out cur) is
  begin
    delete from tbl_reporte_param where reporte_id = vReporteId;
    delete from tbl_reporte where id = vReporteId;
  end reporte_eliminar;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure reporte_eliminar_params(vReporteId in number, usrid in number, vCursor out cur) is
  begin
    delete from tbl_reporte_param where reporte_id = vReporteId;
  end reporte_eliminar_params;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure reporte_actualizar(vReporteId in number, vNombre in varchar2, vDescripcion in varchar2, vCategoriaId in number, vConsultaSql in clob, vPostParams in clob, usrid in number, vCursor out cur) is
  begin
    update tbl_reporte set
      nombre = vNombre, descripcion = vDescripcion, categoria_id = vCategoriaId , consulta_sql = vConsultaSql
      , post_params = vPostParams
    where id = vReporteId;

  end reporte_actualizar;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure reporte_metadata(vReporteId in number, usrid in number, vCursor out cur) is
  begin
    open vCursor for

      SELECT a.reporte_id reporte_id, a.tipo entidad_tipo, a.entity entidad_entidad, a.xml_id entidad_xml_id, a.orden entidad_orden,
        b.tipo, b.entity, b.xml_id, b.operador, b.valor, b.orden, b.is_param
      FROM tbl_reporte_param a LEFT JOIN tbl_reporte_param b on a.reporte_id = b.reporte_id
      WHERE
        a.reporte_id = vReporteId
        AND a.nombre is NULL
        AND b.nombre is NULL
        AND a.entity = b.entity
        AND a.tipo = 'entidad'
        /*AND b.tipo != 'entidad'*/
      ORDER by a.orden asc, b.tipo desc,  b.orden ASC      ;

  end reporte_metadata;

  procedure posicion_viaje(vViajeId in number) is
  begin
    select v.latitud, v.longitud, e.actual_id INTO viajepos
    from tbl_viaje v
    left JOIN tbl_etapa e ON v.id=e.viaje_id AND v.etapa_actual=e.nro_etapa
    where v.id=vViajeId;
  END posicion_viaje;


  -------------------------------------------------------------------------------------------------------------
  --

  procedure pbip_nuevo(  v_viaje_id in INTEGER
    ,v_puertodematricula in VARCHAR2, v_bandera in VARCHAR2 ,v_nroinmarsat in VARCHAR2 ,v_arqueobruto in VARCHAR2 ,v_compania in VARCHAR2 ,
    v_contactoocpm in VARCHAR2 ,v_objetivo in VARCHAR2 ,v_nro_imo  in VARCHAR2 ,v_buque_nombre in VARCHAR2 ,v_tipo_buque  in VARCHAR2 ,
    v_distintivo_llamada   in VARCHAR2 ,v_nro_identif_compania in VARCHAR2 ,v_puerto_llegada in VARCHAR2 ,v_eta   in VARCHAR2 ,
    v_instalacion_portuaria   in VARCHAR2 ,v_cipb_estado in VARCHAR2 ,v_cipb_expedido_por in VARCHAR2 ,v_cipb_expiracion   in VARCHAR2
    ,v_cipb_motivo_incumplimiento in VARCHAR2 ,v_proteccion_plan_aprobado in NUMBER ,v_proteccion_nivel_actual in NUMBER ,v_longitud_notif in NUMBER ,
    v_latitud_notif  in NUMBER ,v_plan_proteccion_mant_bab in NUMBER  ,v_plan_protec_mant_bab_desc in CLOB,
    v_carga_desc_gral   in CLOB ,v_carga_sust_peligrosas   in NUMBER  ,
    v_carga_sust_peligrosas_desc in CLOB ,v_lista_pasajeros   in NUMBER  ,
    v_lista_tripulantes  in NUMBER  ,
    v_prot_notifica_cuestion  in NUMBER  ,v_prot_notifica_polizon   in NUMBER  ,v_prot_notifica_polizon_desc in CLOB ,v_prot_notifica_rescate   in NUMBER  ,
    v_prot_notifica_rescate_desc in CLOB ,v_prot_notifica_otra   in NUMBER  ,v_prot_notifica_otra_desc in CLOB ,v_agente_pto_llegada_nombre  in VARCHAR2 ,
    v_agente_pto_llegada_tel  in VARCHAR2 ,v_agente_pto_llegada_mail in VARCHAR2 ,v_facilitador_nombre   in VARCHAR2 ,v_facilitador_titulo_cargo in VARCHAR2 ,
    v_facilitador_lugar in VARCHAR2 ,v_facilitador_fecha in VARCHAR2 , usrid in number, vCursor out cur)is
    begin

      INSERT INTO tbl_pbip (viaje_id, puertodematricula, bandera, nroinmarsat, arqueobruto, compania, contactoocpm, objetivo, nro_imo
      , buque_nombre, tipo_buque , distintivo_llamada  , nro_identif_compania, puerto_llegada, eta
      , instalacion_portuaria  , cipb_estado, cipb_expedido_por, cipb_expiracion  , cipb_motivo_incumplimiento
      , proteccion_plan_aprobado, proteccion_nivel_actual
     , plan_proteccion_mant_bab, plan_proteccion_mant_bab_desc,  carga_desc_gral  , carga_sust_peligrosas
     , carga_sust_peligrosas_desc,  lista_pasajeros  , lista_tripulantes , prot_notifica_cuestion , prot_notifica_polizon
     , prot_notifica_polizon_desc,  prot_notifica_rescate  , prot_notifica_rescate_desc,  prot_notifica_otra
     , prot_notifica_otra_desc,  agente_pto_llegada_nombre , agente_pto_llegada_tel , agente_pto_llegada_mail, facilitador_nombre
     , facilitador_titulo_cargo, facilitador_lugar, facilitador_fecha, created_by, created_at )

      VALUES (v_viaje_id, v_puertodematricula, v_bandera, v_nroinmarsat, v_arqueobruto, v_compania, v_contactoocpm, v_objetivo,
        v_nro_imo , v_buque_nombre, v_tipo_buque , v_distintivo_llamada  , v_nro_identif_compania, v_puerto_llegada,
        TO_DATE(v_eta, 'DD-MM-yy')  , v_instalacion_portuaria  , v_cipb_estado, v_cipb_expedido_por,
        TO_DATE(v_cipb_expiracion, 'DD-MM-yy')  , v_cipb_motivo_incumplimiento
        , v_proteccion_plan_aprobado, v_proteccion_nivel_actual
        , v_plan_proteccion_mant_bab, v_plan_protec_mant_bab_desc,  v_carga_desc_gral  ,
        v_carga_sust_peligrosas  , v_carga_sust_peligrosas_desc,  v_lista_pasajeros  , v_lista_tripulantes ,
        v_prot_notifica_cuestion , v_prot_notifica_polizon  , v_prot_notifica_polizon_desc, v_prot_notifica_rescate  ,
        v_prot_notifica_rescate_desc,  v_prot_notifica_otra  , v_prot_notifica_otra_desc,  v_agente_pto_llegada_nombre ,
        v_agente_pto_llegada_tel , v_agente_pto_llegada_mail, v_facilitador_nombre  , v_facilitador_titulo_cargo, v_facilitador_lugar,
        TO_DATE(v_facilitador_fecha, 'DD-MM-yy'), usrid, SYSDATE ) returning id into temp;


      IF v_longitud_notif is not null and v_latitud_notif is not null THEN
        UPDATE tbl_pbip SET longitud_notif = v_longitud_notif , latitud_notif  = v_latitud_notif WHERE id = temp;
      END IF;

      open vCursor for select temp from dual;
  end pbip_nuevo;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure pbip_nuevo_param(v_tbl_pbip_id in INTEGER, v_tipo_param in INTEGER , v_indice in INTEGER ,v_fecha_desde in VARCHAR2,v_fecha_hasta in VARCHAR2,v_descripcion in CLOB,v_nivel_proteccion in INTEGER,v_escalas_medidas_adic in INTEGER,v_escalas_medidas_adic_desc in CLOB,v_actividad_bab in CLOB, usrid in number) is
  begin
    INSERT INTO tbl_pbip_params (tbl_pbip_id , tipo_param  , indice  ,fecha_desde ,fecha_hasta ,descripcion ,nivel_proteccion ,escalas_medidas_adic ,escalas_medidas_adic_desc ,actividad_bab )
    VALUES (v_tbl_pbip_id , v_tipo_param  , v_indice, TO_DATE(v_fecha_desde, 'DD-MM-yy') , TO_DATE(v_fecha_hasta, 'DD-MM-yy') ,v_descripcion ,v_nivel_proteccion ,v_escalas_medidas_adic ,v_escalas_medidas_adic_desc ,v_actividad_bab);

  end pbip_nuevo_param;

  -------------------------------------------------------------------------------------------------------------
  --

  procedure pbip_eliminar(v_tbl_pbip_id in INTEGER, usrid in number, vCursor out cur) is
  begin
    delete from tbl_pbip_params where tbl_pbip_id  =v_tbl_pbip_id ;
    delete from tbl_pbip where id  = v_tbl_pbip_id ;
  end pbip_eliminar;
  -------------------------------------------------------------------------------------------------------------
  --

  procedure pbip_eliminar_params(v_tbl_pbip_id in INTEGER, usrid in number, vCursor out cur) is
  begin
    delete from tbl_pbip_params where tbl_pbip_id  =v_tbl_pbip_id ;
  end pbip_eliminar_params;
  -------------------------------------------------------------------------------------------------------------
  --

  procedure pbip_modificar(v_id in INTEGER, v_viaje_id in INTEGER ,v_puertodematricula in VARCHAR2 ,v_bandera in VARCHAR2, v_nroinmarsat in VARCHAR2 ,v_arqueobruto in VARCHAR2 ,v_compania in VARCHAR2 ,v_contactoocpm in VARCHAR2 ,v_objetivo in VARCHAR2 ,v_nro_imo  in VARCHAR2 ,v_buque_nombre in VARCHAR2 ,v_tipo_buque  in VARCHAR2 ,v_distintivo_llamada   in VARCHAR2 ,v_nro_identif_compania in VARCHAR2 ,v_puerto_llegada in VARCHAR2 ,v_eta   in VARCHAR2 ,v_instalacion_portuaria   in VARCHAR2 ,v_cipb_estado in VARCHAR2 ,v_cipb_expedido_por in VARCHAR2, v_cipb_expiracion   in VARCHAR2 ,v_cipb_motivo_incumplimiento in VARCHAR2 ,v_proteccion_plan_aprobado in NUMBER ,v_proteccion_nivel_actual in NUMBER ,v_longitud_notif in NUMBER ,v_latitud_notif  in NUMBER ,v_plan_proteccion_mant_bab in NUMBER  , v_plan_protec_mant_bab_desc in CLOB, v_carga_desc_gral   IN CLOB ,v_carga_sust_peligrosas   in NUMBER  ,v_carga_sust_peligrosas_desc IN CLOB ,v_lista_pasajeros   in NUMBER  ,v_lista_tripulantes  in NUMBER  ,v_prot_notifica_cuestion  in NUMBER  ,v_prot_notifica_polizon   in NUMBER  ,v_prot_notifica_polizon_desc IN CLOB ,v_prot_notifica_rescate   in NUMBER  ,v_prot_notifica_rescate_desc IN CLOB ,v_prot_notifica_otra   in NUMBER  ,v_prot_notifica_otra_desc IN CLOB ,v_agente_pto_llegada_nombre  in VARCHAR2 ,v_agente_pto_llegada_tel  in VARCHAR2 ,v_agente_pto_llegada_mail in VARCHAR2 ,v_facilitador_nombre   in VARCHAR2 ,v_facilitador_titulo_cargo in VARCHAR2 ,v_facilitador_lugar in VARCHAR2 ,v_facilitador_fecha in VARCHAR2 , usrid in number, vCursor out cur) is
  begin
    UPDATE tbl_pbip SET viaje_id = v_viaje_id ,
      puertodematricula = v_puertodematricula ,   bandera =v_bandera,  nroinmarsat = v_nroinmarsat ,     arqueobruto = v_arqueobruto ,      compania = v_compania ,
      contactoocpm = v_contactoocpm ,      objetivo = v_objetivo ,      nro_imo  = v_nro_imo  ,      buque_nombre = v_buque_nombre ,
      tipo_buque  = v_tipo_buque  ,      distintivo_llamada   = v_distintivo_llamada   ,      nro_identif_compania = v_nro_identif_compania ,
      puerto_llegada = v_puerto_llegada ,     eta = TO_DATE(v_eta, 'DD-MM-yy')   ,      instalacion_portuaria   = v_instalacion_portuaria   ,      cipb_estado = v_cipb_estado ,
      cipb_expedido_por = v_cipb_expedido_por ,      cipb_expiracion   = TO_DATE(v_cipb_expiracion, 'DD-MM-yy')   ,      cipb_motivo_incumplimiento = v_cipb_motivo_incumplimiento ,
      proteccion_plan_aprobado = v_proteccion_plan_aprobado ,      proteccion_nivel_actual = v_proteccion_nivel_actual ,  plan_proteccion_mant_bab = v_plan_proteccion_mant_bab , plan_proteccion_mant_bab_desc = v_plan_protec_mant_bab_desc,
      carga_desc_gral   = v_carga_desc_gral   ,      carga_sust_peligrosas   = v_carga_sust_peligrosas   ,      carga_sust_peligrosas_desc = v_carga_sust_peligrosas_desc ,
       lista_pasajeros   = v_lista_pasajeros   ,      lista_tripulantes  = v_lista_tripulantes  ,      prot_notifica_cuestion  = v_prot_notifica_cuestion  ,
      prot_notifica_polizon   = v_prot_notifica_polizon   ,      prot_notifica_polizon_desc = v_prot_notifica_polizon_desc ,       prot_notifica_rescate   = v_prot_notifica_rescate   ,
      prot_notifica_rescate_desc = v_prot_notifica_rescate_desc ,       prot_notifica_otra   = v_prot_notifica_otra   ,      prot_notifica_otra_desc = v_prot_notifica_otra_desc ,
       agente_pto_llegada_nombre  = v_agente_pto_llegada_nombre  ,      agente_pto_llegada_tel  = v_agente_pto_llegada_tel  ,      agente_pto_llegada_mail = v_agente_pto_llegada_mail ,
      facilitador_nombre   = v_facilitador_nombre   ,      facilitador_titulo_cargo = v_facilitador_titulo_cargo ,      facilitador_lugar = v_facilitador_lugar ,
      facilitador_fecha= TO_DATE(v_facilitador_fecha, 'DD-MM-yy'), updated_at=SYSDATE, updated_by=usrid
      WHERE id = v_id;

    IF v_longitud_notif is not null and v_latitud_notif is not null THEN
      UPDATE tbl_pbip SET longitud_notif = v_longitud_notif , latitud_notif  = v_latitud_notif WHERE id = v_id;
    END IF;

  end pbip_modificar;

  procedure pbip_obtener(v_id in INTEGER, usrid in number, vCursor out cur) is
  begin
    open vCursor for

    SELECT
      p.id, p.viaje_id ,p.puertodematricula, p.bandera ,p.nroinmarsat ,p.arqueobruto ,p.compania ,p.contactoocpm ,p.objetivo ,p.nro_imo,p.buque_nombre,
      p.tipo_buque,p.distintivo_llamada ,p.nro_identif_compania,p.puerto_llegada,p.eta,p.instalacion_portuaria,p.cipb_estado,
      p.cipb_expedido_por,p.cipb_expiracion,p.cipb_motivo_incumplimiento,p.proteccion_plan_aprobado,p.proteccion_nivel_actual,
      p.longitud_notif,p.latitud_notif,p.plan_proteccion_mant_bab,p.plan_proteccion_mant_bab_desc,p.carga_desc_gral,p.carga_sust_peligrosas,
      p.carga_sust_peligrosas_desc,p.lista_pasajeros,p.lista_tripulantes,p.prot_notifica_cuestion,p.prot_notifica_polizon,
      p.prot_notifica_polizon_desc,p.prot_notifica_rescate,p.prot_notifica_rescate_desc,p.prot_notifica_otra,p.prot_notifica_otra_desc,
      p.agente_pto_llegada_nombre,p.agente_pto_llegada_tel,p.agente_pto_llegada_mail,p.facilitador_nombre,p.facilitador_titulo_cargo,
      p.facilitador_lugar,p.facilitador_fecha, u.destino
      FROM TBL_PBIP p
      LEFT JOIN vw_int_usuarios u on p.created_by=u.ndoc
      WHERE p.id = v_id;

  end pbip_obtener;

  procedure pbip_obtener_params(v_id in INTEGER, usrid in number, vCursor out cur) is
  begin
    open vCursor for

    SELECT
      tbl_pbip_id , tipo_param  , indice  ,fecha_desde ,fecha_hasta ,descripcion ,nivel_proteccion ,escalas_medidas_adic ,escalas_medidas_adic_desc ,actividad_bab
      FROM TBL_PBIP_PARAMS
      WHERE tbl_pbip_id = v_id
      order by tipo_param asc, indice asc;

  end pbip_obtener_params;

  procedure obtener_opciones_malvinas(v_va_a_malvinas in INTEGER, usrid in number, vCursor out cur)is
  begin
    open vCursor for

    SELECT
      id, codigo, descripcion, tipo
      FROM TBL_CODIGO_MALVINAS
      /*WHERE tipo = v_va_a_malvinas*/
      order by tipo asc, descripcion asc, codigo asc;

  end obtener_opciones_malvinas;

  procedure barcos_similares(vNombre in VARCHAR2, usrid in number, vCursor out cur) is
  begin

    open vCursor for

    SELECT * FROM (
      SELECT a.*, ROWNUM rnum FROM (
        SELECT /*+ FIRST_ROWS(10) */ b.nombre, b.bandera, b.nro_omi, b.matricula, b.sdist,
          case when Upper(b.nombre) LIKE '%'||Upper(vNombre)||'%' then 1 else 0 end as glike,
          case when soundex(b.nombre) = soundex(vNombre) then 1 else 0 end as gsound,
          case when Upper(b.nombre) = Upper(vNombre) then 1 else 0 end as gequal
          FROM buques_new b
          WHERE ( b.TIPO_BUQUE IS NULL OR not (
                  UPPER(b.TIPO_BUQUE) like 'BARCAZA%' or UPPER(b.TIPO_BUQUE) like 'BALSA%'
                ))
          ORDER BY gequal desc,glike desc,gsound DESC
        ) a
      )
    WHERE
    (
      Upper(nombre) = Upper(vNombre) OR
      soundex(nombre)=SoundEx(vNombre) OR
      Upper(nombre) LIKE '%'||Upper(vNombre)||'%'
    )
    AND
      rnum < 10;

  end barcos_similares;

  ------------------------------------------------------------------------------------------------------
  ------------

  procedure barcazas_similares(vNombre in VARCHAR2, usrid in number, vCursor out cur) is
  begin

    open vCursor for

    SELECT * FROM (
      SELECT a.*, ROWNUM rnum FROM (
        SELECT /*+ FIRST_ROWS(10) */ b.nombre, b.bandera, b.nro_omi, b.matricula, b.sdist,
          case when Upper(b.nombre) LIKE '%'||Upper(vNombre)||'%' then 1 else 0 end as glike,
          case when soundex(b.nombre) = soundex(vNombre) then 1 else 0 end as gsound,
          case when Upper(b.nombre) = Upper(vNombre) then 1 else 0 end as gequal
          FROM buques_new b
          WHERE UPPER(b.TIPO_BUQUE) like 'BARCAZA%' or UPPER(b.TIPO_BUQUE) like 'BALSA%'
          ORDER BY gequal desc,glike desc,gsound DESC
        ) a
      )
    WHERE
    (
      Upper(nombre) = Upper(vNombre) OR
      soundex(nombre)=SoundEx(vNombre) OR
      Upper(nombre) LIKE '%'||Upper(vNombre)||'%'
    )
    AND
      rnum < 10;

  end barcazas_similares;

  ------------------------------------------------------------------------------------------------------
  ------------

  procedure obtener_reportes_para_usuario(vUsuario in varchar2, usrid in number, vCursor out cur) is
  begin

    open vCursor for

      SELECT r.* FROM tbl_reporte_usuario_ext ru
      LEFT JOIN tbl_reporte r ON ru.reporte_id=r.id
      WHERE ru.usuario=vUsuario;

  end obtener_reportes_para_usuario;

  procedure login_usuario_ext(vUsuario in varchar2, vPassword in varchar2, usrid in number, vCursor out cur) is
  begin
    open vCursor for

      SELECT ue.* FROM vw_int_usuarios_ext ue
      WHERE ue.nombredeusuario=vUsuario AND
      ue.password=vPassword;

  end login_usuario_ext;

end;
/

