create or replace package mbpc as

  type cur is ref cursor;
  logged number(1,0);
  usuario int_usuarios%ROWTYPE;
  etapa tbl_etapa%ROWTYPE;
  cetapa tbl_cargaetapa%ROWTYPE;
  practicoetapa tbl_practicoetapa%ROWTYPE;
  viaje tbl_viaje%ROWTYPE;
  pbipp tbl_pbip%ROWTYPE;
  sql_stmt varchar2(1000);
  temp number;
  temp2 number;
  temp3 varchar2(100);
  
  --Login/Home
  procedure login( vid in varchar2, vpassword in varchar2, logged out number);
  procedure zonas_del_usuario( vId in varchar2, vCursor out cur);
  procedure barcos_en_zona( vZonaId in varchar2, vCursor out cur);
  procedure barcos_entrantes( vZonaId in varchar2, vCursor out cur);
  procedure barcos_salientes( vZonaId in varchar2, vCursor out cur);
  procedure reporte_diario (vUsuario in varchar2, vCursor out cur);
  procedure datos_del_usuario(vid in varchar2, vCursor out cur );
  procedure todos_los_pdc(vCursor out cur);

  --Viaje
  procedure crear_viaje(vBuque in varchar2, vOrigen in varchar2, vDestino in varchar2, vInicio in date, vEta in date, vZoe in date, vZona in varchar, vProx in varchar, vInternacional in number, vCursor out cur);
  procedure editar_viaje(vViaje in varchar2, vBuque in varchar2, vOrigen in varchar2, vDestino in varchar2, vInicio in date, vEta in date, vZoe in date, vZona in varchar, vProx in varchar, vInternacional in number, vCursor out cur);
  procedure traer_viaje(vViaje in varchar2, vCursor out cur);
  procedure terminar_viaje(vViajeId in number , vCursor out cur);
  procedure viajes_terminados(vZona in number, vCursor out cur);
  procedure reactivar_viaje(vViajeId in number , vCursor out cur);
  procedure traer_pbip(vViaje in varchar2, vCursor out cur);
  procedure modificar_pbip(vViaje in varchar2, vPuertoDeMatricula in varchar2, vNroInmarsat in varchar2, vArqueoBruto in varchar2, vCompania in varchar2, vContactoOCPM in varchar2, vObjetivo in varchar2, vCursor out cur);
  procedure traer_notas(vViaje in varchar2, vCursor out cur);
  procedure guardar_notas(vViaje in varchar2, vNotas in varchar2, vCursor out cur);
  procedure editar_acompanante(vEtapa in varchar2, vBuque in varchar2, vCursor out cur);
  procedure quitar_acompanante(vEtapa in varchar2, vCursor out cur);
  procedure separar_convoy(vViaje in varchar2, vCursor out cur);
  procedure hist_rvp(vViaje in varchar2, vCursor out cur);

  --Etapas
  procedure indicar_proximo(vViajeId in number, vZonaId in number, vCursor out cur);  
  procedure pasar_barco(vViajeId in number, vZonaId in number, vCursor out cur);
  procedure zonas_adyacentes(vZonaId in varchar2, vCursor out cur);
  procedure traer_etapa(vViaje in varchar2, vCursor out cur);
  procedure editar_etapa(vEtapa in varchar2, vCaladoProa in varchar2, vCaladoPopa in varchar2, vHPR in date, vETA in date, vFechaSalida in date, vFechaLlegada in date, vCantidadTripulantes in varchar2, vCantidadPasajeros in varchar2, vCapitan in varchar2, vVelocidad in varchar2, vRumbo in varchar2, vLatitud in varchar2, vLongitud in varchar2, vCursor out cur);
  procedure traer_buque_de_etapa(vEtapa in varchar2, vCursor out cur);
  procedure traer_practicos(vEtapa in varchar2, vCursor out cur);
  procedure agregar_practicos(vPractico in varchar2, vEtapa in varchar2, vActivo in varchar2);
  procedure eliminar_practicos(vEtapa in varchar2, vCursor out cur);

  --Cargas  
  procedure barcazas_utilizadas(vCursor out cur);
  procedure traer_cargas( vEtapaId in varchar2, vCursor out cur);
  procedure traer_carga_por_codigo(vCodigo in varchar2, vCursor out cur);
  procedure traer_barcazas(vCursor out cur);
  procedure traer_barcazas_de_buque(vEtapa in varchar2, vCursor out cur);
  procedure traer_unidades(vCursor out cur);
  procedure insertar_carga( vEtapa in varchar2, vCarga in varchar2, vCantidad in varchar2, vUnidad in varchar2, vBuque in varchar2, vCursor out cur);
  procedure modificar_carga(vCarga in varchar2, vCantidad in varchar2, vCursor out cur);
  procedure eliminar_carga(vCarga in varchar2, vCursor out cur);--
  procedure transferir_barcazas(vCarga in varchar2, vEtapa in varchar2);
  
  --Buque/Puertos/Muelles
  procedure detalles_tecnicos( vShipId in varchar2, vCursor out cur);
  procedure autocompleter(vVista in varchar2, vQuery in varchar2, vCursor out cur);
  procedure autocompleterm( vQuery in varchar2, vCursor out cur);
  procedure autocompleterb( vQuery in varchar2, vCursor out cur);
  procedure crear_buque(vMatricula in varchar2, vNombre in varchar2, vSDist in varchar2, vServicio in varchar2, vCursor out cur);
  procedure crear_buque_int(vMatricula in varchar2, vNombre in varchar2, vSDist in varchar2, vBandera in varchar2, vCursor out cur);
  procedure crear_muelle(vPuerto in varchar2, vInstPort in varchar2, vNombre in varchar2, vId out number, vCursor out cur);  
  procedure traer_puertos(vCursor out cur);
  procedure traer_instports(vPuerto in varchar2, vCursor out cur);
  procedure crear_usuario(vNdoc in varchar2, vPassword in varchar2, vApellido in varchar2, vNombres in varchar2, vDestino in varchar2, vFechavenc in varchar2, vTedirecto in varchar2, vTeinterno in varchar2, vEmail in varchar2, vEstado in varchar2, vSeccion in varchar2, vNdoc_admin in varchar2, vFecha_audit in varchar2, vNombredeusuario in varchar2, vUsuario_id in varchar2, vCursor out cur);
  procedure update_usuario(vNdoc in varchar2, vPassword in varchar2, vApellido in varchar2, vNombres in varchar2, vDestino in varchar2, vFechavenc in varchar2, vTedirecto in varchar2, vTeinterno in varchar2, vEmail in varchar2, vEstado in varchar2, vSeccion in varchar2, vNdoc_admin in varchar2, vFecha_audit in varchar2, vNombredeusuario in varchar2, vUsuario_id in varchar2, vCursor out cur);  
  procedure crear_practico(vNombre in varchar2, vCursor out cur);
  procedure update_practico(vNombre in varchar2, vCursor out cur);
  procedure asignar_pdc(vUsuario in varchar2, vPdc in varchar2);
  procedure columnas_de(vTabla in varchar2, vCursor out cur);
  procedure pager(vTabla in varchar2, vOrderBy in varchar2, vCantidad in number, vDesde in number, vCursor out cur );
  procedure count_rows(vTabla in varchar2, number_of_rows out number);
end;
/
















create or replace package body mbpc as

---------------------------------------------------------------------------------------------------------------
-----------------------------------------Login/Home------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

  -------------------------------------------------------------------------------------------------------------
  --Verifica que exista un registro que coincida con el ID del usuario (Legajo) y el password  
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
  procedure datos_del_usuario(vid in varchar2, vCursor out cur ) is
  begin
    open vCursor for
    SELECT * FROM int_usuarios WHERE usuario_id = vid;
  end datos_del_usuario;
  
  
  -------------------------------------------------------------------------------------------------------------
  --Retorna todos los puntos de control que el usuario tiene asignado  
  
  procedure zonas_del_usuario( vId in varchar2, vCursor out cur) is
  begin 
    --open vCursor for SELECT * FROM tbl_zonausuario;
    open vCursor for SELECT pdc.ID, CUATRIGRAMA, DESCRIPCION, NIVEL, DIRECCION_POSTAL, UBIC_GEOG, DEPENDENCIA, ESTADO, CODNUM, ZONA, NIVELNUM, RPV, INT, MAIL, TE, FAX, COD_CARGO, DESCENTRALIZADO, CANAL, KM 
    FROM tbl_puntodecontrol pdc join tbl_zonas z on pdc.zona_id = z.id WHERE pdc.id IN (SELECT puntodecontrol FROM tbl_puntodecontrolusuario WHERE usuario = vId);
  end zonas_del_usuario;
  
  -------------------------------------------------------------------------------------------------------------  
  --Retorna todos los barcos que esten en el punto de control actual, 
  --revisando que en todos los viajes en curso (Estado 0) 
  --la etapa actual (que indica el punto de control del que viene, **donde esta**, donde se dirige y previamente calculado si esta en bajada o subida)
  --coincida con el punto de control que se este verificando
  
  procedure barcos_en_zona( vZonaId in varchar2, vCursor out cur) is
  begin 
    open vCursor for 
      select v.id, v.buque_id, v.notas, capitan.nombre capitan,e.velocidad, acomp.nombre acompanante, e.calado_maximo, e.calado_informado, e.latitud, e.longitud, e.origen_id, e.destino_id, e.sentido, e.eta, e.id etapa_id, b.inscrip_provisoria, b.matricula, b.sdist, b.bandera, b.nombre, b.nro_omi, b.nro_ismm, b.arqueo_neto, b.arqueo_total, b.tipo_buque, z.cuatrigrama, p.km
      from tbl_viaje v
       left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual)
       left join view_buques b on nvl(v.buque_id, v.buque_int_id) = b.matricula 
       left join view_buques acomp on e.acompanante_id = acomp.matricula
       left join tbl_puntodecontrol p on p.id = e.destino_id
       left join tbl_zonas z on p.zona_id = z.id
       left join tbl_capitan capitan on e.capitan_id = capitan.id
     where e.actual_id = vZonaId and v.estado = 0;
  end barcos_en_zona;

  -------------------------------------------------------------------------------------------------------------  
  --Retorna todos los barcos recientemente despachados al punto de control, 
  --revisando que en todos los viajes en curso (Estado 0) 
  --la etapa actual (que indica el punto de control del que viene, donde esta, **donde se dirige** y previamente calculado si esta en bajada o subida)
  --coincida con el punto de control que se este verificando
  
  procedure barcos_entrantes( vZonaId in varchar2, vCursor out cur) is
  begin
    open vCursor for
      select v.id, v.buque_id, v.notas,capitan.nombre capitan, e.velocidad, acomp.nombre acompanante, e.calado_maximo, e.calado_informado, e.latitud, e.longitud,  e.origen_id, e.destino_id, e.sentido, e.eta, b.inscrip_provisoria, b.matricula, b.sdist, b.bandera, b.nombre, b.nro_omi, b.nro_ismm,b.arqueo_neto, b.arqueo_total, b.tipo_buque, z.cuatrigrama, p.km
      from tbl_viaje v
        left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual)
        left join view_buques b on nvl(v.buque_id, v.buque_int_id) = b.matricula
        left join view_buques acomp on e.acompanante_id = acomp.matricula        
        left join tbl_puntodecontrol p on p.id = e.destino_id
        left join tbl_zonas z on p.zona_id = z.id
        left join tbl_capitan capitan on e.capitan_id = capitan.id
      WHERE e.destino_id = vZonaId and v.estado = 0;
  end barcos_entrantes;
  
  ---------------------------------------------------------------------------------------------------------------  
  --Retorna todos los barcos por ingresar al punto de control, 
  --revisando que en todos los viajes en curso (Estado 0) 
  --la etapa actual (que indica el punto de control **del que viene**, donde esta, donde se dirige y previamente calculado si esta en bajada o subida)
  --coincida con el punto de control que se este verificando
  --NOTA: Sólo aparece si, desde el punto de control procedente, indicaron el punto de control actual como Proximo Destino
  
  procedure barcos_salientes( vZonaId in varchar2, vCursor out cur) is
  begin
    open vCursor for
      select v.id, v.buque_id, v.notas,capitan.nombre capitan, e.velocidad, acomp.nombre acompanante, e.calado_maximo, e.calado_informado, e.latitud, e.longitud,  e.origen_id, e.destino_id, e.sentido, e.eta, b.inscrip_provisoria, b.matricula, b.sdist, b.bandera, b.nombre, b.nro_omi, b.nro_ismm,b.arqueo_neto, b.arqueo_total,b.tipo_buque, z.cuatrigrama, p.km
      from tbl_viaje v
        left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual)
        left join view_buques b on nvl(v.buque_id, v.buque_int_id) = b.matricula
        left join view_buques acomp on e.acompanante_id = acomp.matricula        
        left join tbl_puntodecontrol p on p.id = e.destino_id
        left join tbl_zonas z on p.zona_id = z.id
        left join tbl_capitan capitan on e.capitan_id = capitan.id
      WHERE e.origen_id = vZonaId and v.estado = 0;
  end barcos_salientes;
  
  procedure reporte_diario (vUsuario in varchar2, vCursor out cur) is
  begin
    open vCursor for
      select p.id pdc, b.nombre, b.sdist, b.bandera band, origen.descripcion fm, destino.descripcion tox, e.velocidad, e.calado_proa cal, e.velocidad vel, v.zoe, 'KM. ' || p.km zona, to_char(e.eta,'HH:MM') eta, to_char(e.hrp,'HH:MM') hrp, e.sentido
      from tbl_etapa e
      left join tbl_viaje v on e.viaje_id = v.id
      left join view_buques b on nvl(v.buque_id, v.buque_int_id) = b.matricula
      left join tbl_muelles origen on v.origen_id = origen.id
      left join tbl_muelles destino on v.destino_id = destino.id
      left join tbl_puntodecontrol p on e.actual_id = p.id
      where to_char(e.hrp, 'YYYY-MM-DD')= to_char(sysdate, 'YYYY-MM-DD')
      and e.actual_id in (select puntodecontrol from tbl_puntodecontrolusuario where usuario = vUsuario) order by nombre, p.km;
  end reporte_diario;

  procedure todos_los_pdc(vCursor out cur) is
  begin
    open vCursor for
      select * from tbl_puntodecontrol;
  end todos_los_pdc;
  
  
---------------------------------------------------------------------------------------------------------------
-----------------------------------------Viaje-----------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------


  -------------------------------------------------------------------------------------------------------------  
  --

  procedure hist_rvp(vViaje in varchar2, vCursor out cur) is
  begin
    open vCursor for
      select pdc.canal, pdc.km, nro_etapa, rumbo, velocidad, latitud, longitud, to_char(created_at ,'YYYY-MM-DD HH:MI:SS') created_at from tbl_etapa 
        left join tbl_puntodecontrol pdc on actual_id = pdc.id where viaje_id = vViaje order by created_at desc;
  end hist_rvp;




  -------------------------------------------------------------------------------------------------------------  
  --Crea un viaje, se verifica si el buque seleccionado es internacional, 
  --se crea la etapa inicial, 
  --registra el evento

  procedure crear_viaje(vBuque in varchar2, vOrigen in varchar2, vDestino in varchar2, vInicio in date, vEta in date, vZoe in date, vZona in varchar, vProx in varchar, vInternacional in number, vCursor out cur) is
  begin
    IF vInternacional = 0 THEN
                       --Sacar ID de esta lista cuando se habilite el sequence para los viajes
      insert into tbl_viaje ( id, buque_id, origen_id, destino_id, fecha_salida, eta, zoe ) VALUES ( id_cargas.nextval, vBuque, vOrigen, vDestino, vInicio, vEta, vZoe ) returning id into temp ;
    ELSE               --Sacar ID de esta lista cuando se habilite el sequence para los viajes
      insert into tbl_viaje ( id, buque_int_id, origen_id, destino_id, fecha_salida, eta, zoe) VALUES ( id_cargas.nextval, vBuque, vOrigen, vDestino, vInicio, vEta, vZoe ) returning id into temp;
    END IF;
    insert into tbl_etapa ( viaje_id, actual_id, destino_id ) VALUES ( temp, vZona, vProx ) returning id into temp2;
    insert into tbl_evento ( usuario_id , viaje_id , etapa_id , tipo_id , fecha) VALUES ( usuario.usuario_id, temp , temp2 , 1 , SYSDATE );
  end crear_viaje;

  ---------------------------------------------------------------------------------------------------------------
  --Edita el viaje, se verifica si el buque seleccionado es internacional, 
  --registra el evento (TODO)
  
  procedure editar_viaje(vViaje in varchar2, vBuque in varchar2, vOrigen in varchar2, vDestino in varchar2, vInicio in date, vEta in date, vZoe in date, vZona in varchar, vProx in varchar, vInternacional in number, vCursor out cur) is
  begin
    IF vInternacional = 0 THEN
                       --Sacar ID de esta lista cuando se habilite el sequence para los viajes
      update tbl_viaje SET  buque_id = vBuque, origen_id = vOrigen, destino_id = vDestino, fecha_salida = vInicio, eta = vEta, zoe = vZoe where id = vViaje ;
    ELSE               --Sacar ID de esta lista cuando se habilite el sequence para los viajes
      update tbl_viaje SET  buque_int_id = vBuque, origen_id = vOrigen, destino_id = vDestino, fecha_salida = vInicio, eta = vEta, zoe = vZoe where id = vViaje;
    END IF;
  end editar_viaje;

  ---------------------------------------------------------------------------------------------------------------
  --Edita el viaje, la verificacion de si el buque es internacional o internacional esta incluida en la vista, 
  --registra el evento (TODO)

  procedure traer_viaje(vViaje in varchar2, vCursor out cur) is
  begin
      open vCursor for select v.id, b.nombre, b.matricula, b.tipo, m.id origen_id, m.nombre_m origen, u.id destino_id, u.nombre_m destino, v.fecha_salida, v.eta, v.zoe, v.notas from tbl_viaje v 
      join view_buques b on nvl(v.buque_id, v.buque_int_id) = b.matricula
      join view_muelles m on v.origen_id = m.id
      join view_muelles u on v.destino_id = u.id
      where v.id = vViaje;
  end traer_viaje;

  ---------------------------------------------------------------------------------------------------------------
  --Finaliza el viaje, (Lo pasa a estado 1)
  --Registra el evento
  
  procedure terminar_viaje(vViajeId in number , vCursor out cur) is
  begin
    update tbl_viaje set estado = 1, fecha_llegada = SYSDATE where id = vViajeId;
    insert into tbl_evento ( usuario_id , viaje_id , tipo_id, fecha) VALUES ( usuario.usuario_id , vViajeId , 9 , SYSDATE);
  end terminar_viaje;

  -------------------------------------------------------------------------------------------------------------
  --  

  procedure viajes_terminados(vZona in number, vCursor out cur) is
  begin
    open vCursor for
      select v.id, b.nombre, origen.descripcion origen, destino.descripcion destino,  v.etapa_actual ultima_etapa, e.actual_id 
        from tbl_viaje v
        left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual)
        join view_buques b on nvl(v.buque_id, v.buque_int_id) = b.matricula
        join tbl_muelles origen on v.origen_id = origen.id
        join tbl_muelles destino on v.destino_id = destino.id
        where ROWNUM <= 10 and v.estado = 1 and e.actual_id = vZona;
 end viajes_terminados;
  
  
  -------------------------------------------------------------------------------------------------------------
  --  
  
  procedure reactivar_viaje(vViajeId in number , vCursor out cur) is
  begin
    update tbl_viaje set estado = 0, fecha_llegada = SYSDATE where id = vViajeId;
    insert into tbl_evento ( usuario_id , viaje_id , tipo_id, fecha) VALUES ( usuario.usuario_id , vViajeId , 12 , SYSDATE);
  end reactivar_viaje;
  
  
  -------------------------------------------------------------------------------------------------------------
  --  
  
  procedure traer_pbip(vViaje in varchar2, vCursor out cur) is
  begin
      open vCursor for 
        select * from view_pbip where viaje = vViaje;
  end traer_pbip;
  
  -------------------------------------------------------------------------------------------------------------
  --  puertodematricula, numeroinmarsat, arqueobruto, compania, contactoOCPM, objetivo
  
  procedure modificar_pbip(vViaje in varchar2, vPuertoDeMatricula in varchar2, vNroInmarsat in varchar2, vArqueoBruto in varchar2, vCompania in varchar2, vContactoOCPM in varchar2, vObjetivo in varchar2, vCursor out cur) is
  begin
    insert into tbl_pbip (viaje_id, puertodematricula, nroinmarsat, arqueobruto, compania, contactoOCPM, objetivo ) VALUES (vViaje, vPuertoDeMatricula, vNroInmarsat, vArqueoBruto, vCompania, vContactoOCPM, vObjetivo );
  exception
    WHEN DUP_VAL_ON_INDEX THEN
    UPDATE tbl_pbip b SET puertodematricula = vPuertoDeMatricula,  nroinmarsat = vNroInmarsat,  arqueobruto = vArqueoBruto, compania = vCompania, contactoOCPM = vContactoOCPM, objetivo = vObjetivo where b.viaje_id = vViaje ;
  end modificar_pbip;

  procedure guardar_notas(vViaje in varchar2, vNotas in varchar2, vCursor out cur) is
  begin
    UPDATE tbl_viaje v SET v.notas = vNotas where v.id = vViaje ;
  end guardar_notas;

  procedure traer_notas(vViaje in varchar2, vCursor out cur) is
  begin
    open vCursor for 
      select notas from tbl_viaje where id = vViaje;
  end traer_notas;

  procedure editar_acompanante(vEtapa in varchar2, vBuque in varchar2, vCursor out cur) is
    begin
      UPDATE tbl_etapa e SET e.acompanante_id = vBuque where e.id = vEtapa returning e.viaje_id into temp;
      insert into tbl_evento ( usuario_id , viaje_id, etapa_id, tipo_id, fecha, acompanante_id ) VALUES ( usuario.usuario_id , temp, vEtapa , 13 , SYSDATE, vBuque);
  end editar_acompanante;
  
  procedure quitar_acompanante(vEtapa in varchar2, vCursor out cur) is
    begin
      UPDATE tbl_etapa e SET e.acompanante_id = NULL where e.id = vEtapa returning e.viaje_id into temp;
      insert into tbl_evento ( usuario_id , viaje_id, etapa_id, tipo_id, fecha, acompanante_id ) VALUES ( usuario.usuario_id , temp, vEtapa , 14 , SYSDATE, NULL);
  end quitar_acompanante;  
  
  procedure separar_convoy(vViaje in varchar2, vCursor out cur) is
    begin
      select * into viaje from tbl_viaje where id = vViaje;
      select * into etapa from tbl_etapa e where (viaje.id = e.viaje_id and e.nro_etapa = viaje.etapa_actual);
      update tbl_etapa set acompanante_id = null where id = etapa.id;
      insert into tbl_viaje ( id, buque_id, origen_id, destino_id, fecha_salida, eta, zoe, viaje_padre ) VALUES ( id_cargas.nextval, etapa.acompanante_id, viaje.origen_id, viaje.destino_id, SYSDATE, viaje.eta, viaje.zoe, viaje.id ) returning id into temp ;
      insert into tbl_etapa ( nro_etapa, viaje_id, actual_id, sentido ) VALUES ( 0, temp, etapa.actual_id, etapa.sentido) returning id into temp2;
      insert into tbl_evento ( usuario_id , viaje_id , etapa_id , tipo_id , buque_id, fecha, acompanante_id) VALUES ( usuario.usuario_id, viaje.id , etapa.id , 14 , viaje.buque_id, SYSDATE, etapa.acompanante_id );
      open vCursor for 
        select id from tbl_etapa where id = temp2;
  end separar_convoy;
  
  ---------------------------------------------------------------------------------------------------------------
  -----------------------------------------Etapa-----------------------------------------------------------------
  ---------------------------------------------------------------------------------------------------------------  

  ---------------------------------------------------------------------------------------------------------------
  --Indica tentativamente cual sera el proximo punto de control
  --Trae el viaje, trae la etapa
  --Actualiza la etapa indicando el punto de control como destino
  
  procedure indicar_proximo(vViajeId in number, vZonaId in number, vCursor out cur) is
  begin
    select * into viaje from tbl_viaje where id = vViajeId;
    select * into etapa from tbl_etapa where nro_etapa = viaje.etapa_actual and viaje_id = viaje.id;
    temp := etapa.id;
    update tbl_etapa set destino_id = vZonaId where id = etapa.id;
    --insert into tbl_evento (      usuario_id , viaje_id , etapa_id, tipo_id, fecha, comentario)
    --values ( usuario.usuario_id, viaje.id , etapa.id, 1, SYSDATE, 'de ' || etapa.origen_id || ' a ' || etapa.actual_id);
  end indicar_proximo;

  ---------------------------------------------------------------------------------------------------------------
  --Pasa un barco de un punto de control a otro
  --Trae el viaje, trae la ultima etapa del viaje, actualiza el proximo destino en la ultima etapa  
  --Crea una etapa nueva (copia de la ultima etapa),   
  --Copia las cargas de la etapa anterior en la recien creada,
  --Registra el evento
  
  procedure pasar_barco(vViajeId in number, vZonaId in number, vCursor out cur) is
  begin

    select * into viaje from tbl_viaje where id = vViajeId;
    select * into etapa from tbl_etapa where nro_etapa = viaje.etapa_actual and viaje_id = viaje.id;
    update tbl_etapa set destino_id = vZonaId where id = etapa.id;
   
    temp := etapa.id;
    insert into tbl_etapa (   VIAJE_ID,       ORIGEN_ID,        ACTUAL_ID,               VELOCIDAD,       HRP,        ETA,          FECHA_SALIDA,        FECHA_LLEGADA,          CANTIDAD_TRIPULANTES,       CANTIDAD_PASAJEROS,         CAPITAN_ID,      SENTIDO,        CALADO_PROA,         CALADO_POPA,       CALADO_MAXIMO,       CALADO_INFORMADO,      LATITUD, LONGITUD, KM, RUMBO, ACOMPANANTE_ID, CREATED_AT ) 
    VALUES (                  etapa.viaje_id, etapa.actual_id,  vZonaId,                 etapa.velocidad, etapa.hrp,  etapa.eta,    etapa.fecha_salida,  etapa.fecha_llegada,    etapa.cantidad_tripulantes, etapa.cantidad_pasajeros,    etapa.capitan_id, null,           etapa.calado_proa,   etapa.calado_popa,  etapa.calado_maximo, etapa.calado_informado, etapa.latitud, etapa.longitud, etapa.km, etapa.rumbo, etapa.acompanante_id, sysdate) 
    returning ID, NRO_ETAPA, VIAJE_ID,        ORIGEN_ID,        ACTUAL_ID, DESTINO_ID,  VELOCIDAD,        HRP,        ETA,         FECHA_SALIDA,        FECHA_LLEGADA,          CANTIDAD_TRIPULANTES,       CANTIDAD_PASAJEROS,          CAPITAN_ID,       SENTIDO,       CALADO_PROA,         CALADO_POPA,        CALADO_MAXIMO,       CALADO_INFORMADO,       LATITUD, LONGITUD, KM, RUMBO, ACOMPANANTE_ID, CREATED_AT                            
    into etapa ;
    
    insert into tbl_cargaetapa ( id, tipocarga_id, cantidad, unidad_id, etapa_id, buque_id ) ( select carga_seq.nextval, tipocarga_id, cantidad, unidad_id, replace(etapa_id, etapa_id, etapa.id), buque_id from tbl_cargaetapa where etapa_id = temp );

    insert into tbl_evento (usuario_id , viaje_id , etapa_id, tipo_id, puntodecontrol1_id, puntodecontrol2_id, fecha)
    values ( usuario.usuario_id, viaje.id , etapa.id, 7, etapa.origen_id, etapa.actual_id , SYSDATE  );
  end pasar_barco;

  ---------------------------------------------------------------------------------------------------------------
  --Procedimiento auxiliar utilizado por los dos anteriores para crear los menues de los puntos de control a los que es posible pasar el buque
  --usando la matriz. Ignora si el buque esta en bajada o subida
  
  procedure zonas_adyacentes( vZonaId in varchar2, vCursor out cur) is
  begin
    open vCursor for 
      select unique(p.id), CUATRIGRAMA, KM from tbl_puntodecontrol p
      inner join tbl_conexionpuntodecontrol cxz on p.id = cxz.puntodecontrol1 or p.id = cxz.puntodecontrol2
      inner join tbl_zonas z on p.zona_id = z.id
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
  
  procedure traer_etapa(vViaje in varchar2, vCursor out cur) is
  begin
    open vCursor for 
    select v.id viaje_id, e.id etapa_id, e.nro_etapa, e.origen_id, e.actual_id, e.destino_id, e.calado_proa, e.calado_popa, e.hrp, e.eta, e.fecha_salida, e.fecha_llegada, e.cantidad_tripulantes, e.cantidad_pasajeros, e.velocidad, e.rumbo, e.latitud, e.longitud, c.nombre capitan, c.id capitan_id
    from tbl_viaje v 
    left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual) 
    left join tbl_capitan c on (e.capitan_id = c.id)
    WHERE v.id = vViaje;  
  end traer_etapa;

  ---------------------------------------------------------------------------------------------------------------
  --Edita la informacion etapa
  --Registra el evento

  procedure editar_etapa(vEtapa in varchar2, vCaladoProa in varchar2, vCaladoPopa in varchar2, vHPR in date, vETA in date, vFechaSalida in date, vFechaLlegada in date, vCantidadTripulantes in varchar2, vCantidadPasajeros in varchar2, vCapitan in varchar2, vVelocidad in varchar2, vRumbo in varchar2, vLatitud in varchar2, vLongitud in varchar2, vCursor out cur) is
  begin
      update tbl_etapa SET
        calado_proa = vCaladoProa,
        calado_popa = vCaladoPopa,
        hrp = vHPR,
        eta = vETA,
        fecha_salida = vFechaSalida,
        fecha_llegada = vFechaLlegada,
        cantidad_tripulantes = vCantidadTripulantes,
        cantidad_pasajeros = vCantidadPasajeros,
        --practico_id = vPractico,
        capitan_id = vCapitan,
        velocidad = vVelocidad,
        rumbo = vRumbo,
        latitud = vLatitud,
        longitud = vLongitud
      where id = vEtapa;
      select * into etapa from tbl_etapa where id=vEtapa;
      insert into tbl_evento ( viaje_id, usuario_id , etapa_id, tipo_id, fecha ) VALUES ( etapa.viaje_id, usuario.usuario_id, vEtapa , 8, SYSDATE);
  end editar_etapa;    
  
  procedure traer_buque_de_etapa(vEtapa in varchar2, vCursor out cur) is
  begin
    open vCursor for
      select * from view_buques b
      left join tbl_viaje v on nvl(v.buque_id, v.buque_int_id) = b.matricula
      left join tbl_etapa e on v.id = e.viaje_id
      where e.id = vEtapa;
  end traer_buque_de_etapa;


  procedure traer_practicos(vEtapa in varchar2, vCursor out cur) is
  begin
    open vCursor for
      select * from tbl_practicoetapa pe 
        left join tbl_practico p on p.id = pe.practico_id
        where pe.etapa_id = vEtapa;
  end traer_practicos;
  
  procedure eliminar_practicos(vEtapa in varchar2, vCursor out cur) is
  begin
    delete from tbl_practicoetapa where etapa_id = vEtapa;
  end eliminar_practicos;
  
  procedure agregar_practicos(vPractico in varchar2, vEtapa in varchar2, vActivo in varchar2) is
  begin
    --select id into temp from tbl_evento, where practico_id = vPractico and etapa_id = vEtapa and tipo_id = 16;
    ---IF SQL%NOTFOUND THEN
    --  insert into tbl_evento 
    --END IF;
      insert into tbl_practicoetapa VALUES (vPractico, vEtapa, vActivo);

  end agregar_practicos;
  
---------------------------------------------------------------------------------------------------------------
---------------------------------------------Cargas------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
  -------------------------------------------------------------------------------------------------------------
  --

  procedure barcazas_utilizadas(vCursor out cur) is
  begin
    open vCursor for
      select unique(c.buque_id) from tbl_viaje v 
      left join tbl_etapa e on e.viaje_id = v.id
      left join tbl_cargaetapa c on c.etapa_id = e.id
      where v.estado = 0 and c.buque_id is not null;
  end barcazas_utilizadas;
  
  -------------------------------------------------------------------------------------------------------------
  --

  procedure traer_cargas( vEtapaId in varchar2, vCursor out cur) is
  begin
    open vCursor for
    select tc.nombre, c.cantidad, u.nombre unidad, tc.codigo, c.id carga_id, c.buque_id barcaza from tbl_cargaetapa c
    join tbl_tipo_carga tc on c.tipocarga_id = tc.id
    join tbl_unidad u on c.unidad_id = u.id
    where c.etapa_id = vEtapaId;
  end traer_cargas;
  
  -------------------------------------------------------------------------------------------------------------
  --  

  procedure traer_carga_por_codigo(vCodigo in varchar2, vCursor out cur) is
  begin
    open vCursor for select * from tbl_tipo_carga where codigo = vCodigo;
  end traer_carga_por_codigo;

  -------------------------------------------------------------------------------------------------------------
  --  

  procedure traer_barcazas(vCursor out cur) is
  begin
    open vCursor for 
      --select matricula, nombre from view_buques b where UPPER(nombre) like 'BARCAZA%'
      select matricula, nombre from view_buques b where tipo_servicio = 99
      and UPPER(matricula) not in (
      select unique( UPPER(c.buque_id)) from tbl_viaje v 
      left join tbl_etapa e on e.viaje_id = v.id
      left join tbl_cargaetapa c on c.etapa_id = e.id
      where v.estado = 0 and c.buque_id is not null
      ); 
  end traer_barcazas;
  
  -------------------------------------------------------------------------------------------------------------
  --  

  procedure traer_barcazas_de_buque(vEtapa in varchar2, vCursor out cur) is
  begin
    open vCursor for
    select tc.nombre, c.cantidad, u.nombre unidad, tc.codigo, c.id carga_id, c.buque_id barcaza from tbl_cargaetapa c
    join tbl_tipo_carga tc on c.tipocarga_id = tc.id
    join tbl_unidad u on c.unidad_id = u.id
    where c.etapa_id = vEtapa and c.buque_id IS NOT NULL;
  end traer_barcazas_de_buque;
  
  -------------------------------------------------------------------------------------------------------------
  --  
  
  procedure transferir_barcazas(vCarga in varchar2, vEtapa in varchar2) is
  begin
      -- a este viaje (vCarga.etapa.viaje) se le fue la carga (vCarga)
      select * into cetapa from tbl_cargaetapa where id = vCarga;
      select * into etapa from tbl_etapa where id = cetapa.etapa_id;
      insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, barcaza_id, carga_id, fecha) VALUES (etapa.viaje_id, etapa.id, usuario.usuario_id, 11, cetapa.buque_id, vCarga, SYSDATE);
  
      -- a este viaje (vEtapa.viaje) se le agregp la carga (vCarga)
      select * into etapa from tbl_etapa where id = vEtapa;
      insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, barcaza_id, carga_id, fecha) VALUES (etapa.viaje_id, etapa.id, usuario.usuario_id, 10, cetapa.buque_id, vCarga, SYSDATE);
 
      UPDATE tbl_cargaetapa ce set etapa_id = vEtapa where id = vCarga returning id, etapa_id, buque_id into temp, temp2, temp3;

  end transferir_barcazas;
  
  -------------------------------------------------------------------------------------------------------------
  --  

  procedure traer_unidades(vCursor out cur) is
  begin
    open vCursor for select * from tbl_unidad;
    
  end traer_unidades;
  
  -------------------------------------------------------------------------------------------------------------
  --  
  
  procedure insertar_carga( vEtapa in varchar2, vCarga in varchar2, vCantidad in varchar2, vUnidad in varchar2, vBuque in varchar2, vCursor out cur) is
  begin
    select * into etapa from tbl_etapa where id = vEtapa;
    insert into tbl_cargaetapa ( ID, TIPOCARGA_ID, CANTIDAD, UNIDAD_ID, ETAPA_ID, BUQUE_ID ) VALUES ( carga_seq.nextval, vCarga, vCantidad, vUnidad, vEtapa, vBuque) returning id into temp; 
    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, carga_id, fecha) VALUES (etapa.viaje_id, etapa.id, usuario.usuario_id, 4, temp, SYSDATE);
  end insertar_carga;  
  
  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure modificar_carga(vCarga in varchar2, vCantidad in varchar2, vCursor out cur) is
  begin
    select * into etapa from tbl_etapa where id = (select etapa_id from tbl_cargaetapa where id=vCarga);
    update tbl_cargaetapa set cantidad = vCantidad where id = vCarga returning id into temp;
    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, carga_id, fecha) VALUES (etapa.viaje_id, etapa.id, usuario.usuario_id, 5, temp, SYSDATE);
  end modificar_carga;

  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure eliminar_carga(vCarga in varchar2, vCursor out cur) is
  begin
    select * into etapa from tbl_etapa where id = (select etapa_id from tbl_cargaetapa where id=vCarga);
    delete from tbl_cargaetapa where id = vCarga;
    insert into tbl_evento (viaje_id, etapa_id, usuario_id, tipo_id, carga_id, fecha) VALUES (etapa.viaje_id, etapa.id, usuario.usuario_id, 6, vCarga, SYSDATE);
  end eliminar_carga;

  -------------------------------------------------------------------------------------------------------------
  --
 
  procedure detalles_tecnicos( vShipId in varchar2, vCursor out cur) is
  begin
    open vCursor for 
      select *
      from view_buques b 
      where matricula = vShipId;
  end detalles_tecnicos;
  
  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure autocompleter(vVista in varchar2, vQuery in varchar2, vCursor out cur) is
  begin
    sql_stmt := 'select * from ' || vVista || ' where upper(nombre) like upper(:vQuery) and rownum <= 6';
    open vCursor for sql_stmt USING vQuery;
  end autocompleter;
  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure autocompleterb(vQuery in varchar2, vCursor out cur) is
  begin
    --sql_stmt := 'select * from view_buques left join tbl_viaje on tbl_viaje.buque_id = view_buques.matricula where (upper(nombre) like upper(:vQuery) or upper(bandera) like upper(:vQuery) or upper(matricula) like upper(:vQuery) or upper(nro_omi) like upper(:vQuery)) and rownum <= 6';
    sql_stmt := 'select b.matricula, b.nro_omi, b.nombre, b.bandera, b.nro_ismm, b.tipo , 
                  case when (b.matricula in 
                    (select buque_id from tbl_viaje v where v.estado = 0 
                      union 
                      select e.acompanante_id from tbl_viaje v 
                        left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual) where v.estado = 0))
                    then 1 else 0 end as en_viaje 
                    from view_buques b
                    where (upper(b.nombre) like upper(:vQuery) or 
                    upper(b.bandera) like upper(:vQuery) or 
                    upper(b.matricula) like 
                    upper(:vQuery) or upper(b.nro_omi) like upper(:vQuery)) and rownum <= 6';
    open vCursor for sql_stmt USING vQuery,vQuery,vQuery,vQuery; 
  end autocompleterb;


  -------------------------------------------------------------------------------------------------------------
  --
  
  procedure autocompleterm( vQuery in varchar2, vCursor out cur) is
  begin
    sql_stmt := 'select * from view_muelles where nombre_m like :vQuery or nombre_ip like :vQuery or nombre_p like :vQuery and rownum <= 6';
    open vCursor for sql_stmt USING vQuery, vQuery, vQuery; 
  end autocompleterm;
  
  -------------------------------------------------------------------------------------------------------------
  --
  procedure crear_buque(vMatricula in varchar2, vNombre in varchar2, vSDist in varchar2, vServicio in varchar2, vCursor out cur) is
  begin
    insert into tbl_bq_buques (MATRICULA, NOMBRE, BANDERA_ID, INSCRIP_PROVISORIA, TIPO_SERVICIO, SDIST ) 
      VALUES ( vMatricula, vNombre, 100, 'PROVISORIA', vServicio, vSDist );
      
    insert into tbl_evento (usuario_id, tipo_id, buque_id, fecha) VALUES (usuario.usuario_id, 2, vMatricula, SYSDATE);
  end crear_buque;
  
  -------------------------------------------------------------------------------------------------------------
  --
  procedure crear_buque_int(vMatricula in varchar2, vNombre in varchar2, vSDist in varchar2, vBandera in varchar2, vCursor out cur) is
  begin
    insert into tbl_bq_internac ( NOMBRE, BANDERA, SDIST,MMSI,INSCRIP_PROVISORIA) 
      VALUES (  vNombre,  vBandera, vSDist, vMatricula, 'PROVISORIA');
      
    insert into tbl_evento (usuario_id, tipo_id, buque_id, fecha) VALUES (usuario.usuario_id, 2, vMatricula, SYSDATE);
  end crear_buque_int;
  
  -------------------------------------------------------------------------------------------------------------
  --  
  procedure traer_puertos(vCursor out cur) is
  begin
    open vCursor for select * from tbl_puertos;
  end traer_puertos;

  procedure traer_instports(vPuerto in varchar2, vCursor out cur) is
  begin
    open vCursor for select * from tbl_insta_puert where puerto_id = vPuerto;
  end traer_instports;

  procedure crear_muelle(vPuerto in varchar2, vInstPort in varchar2, vNombre in varchar2, vId out number, vCursor out cur) is
  begin
    insert into tbl_muelles ( PUERTO_ID, INSTA_PORT, TIPO_NAV_ID, TIPO_CARG_ID, DESCRIPCION ) VALUES ( vPuerto , vInstPort, muelle_seq.nextval , muelle_seq.nextval, vNombre) returning id into vId;
    insert into tbl_evento (usuario_id, tipo_id, muelle_id, fecha) VALUES (usuario.usuario_id, 3, vId, SYSDATE);
  end crear_muelle;

  -------------------------------------------------------------------------------------------------------------
  --
  procedure crear_usuario(vNdoc in varchar2, vPassword in varchar2, vApellido in varchar2, vNombres in varchar2, vDestino in varchar2, vFechavenc in varchar2, vTedirecto in varchar2, vTeinterno in varchar2, vEmail in varchar2, vEstado in varchar2, vSeccion in varchar2, vNdoc_admin in varchar2, vFecha_audit in varchar2, vNombredeusuario in varchar2, vUsuario_id in varchar2, vCursor out cur) is
  begin
    insert into int_usuarios VALUES ( vNdoc, vPassword, vApellido, vNombres, vDestino, vFechavenc, vTedirecto, vTeinterno, vEmail, vEstado, vSeccion, vNdoc_admin, vFecha_audit, vNombredeusuario, vUsuario_id);
    --insert into tbl_evento (usuario_id, tipo_id, buque_id, fecha) VALUES (usuario.usuario_id, 2, vMatricula, SYSDATE);
  end crear_usuario;

  procedure update_usuario(vNdoc in varchar2, vPassword in varchar2, vApellido in varchar2, vNombres in varchar2, vDestino in varchar2, vFechavenc in varchar2, vTedirecto in varchar2, vTeinterno in varchar2, vEmail in varchar2, vEstado in varchar2, vSeccion in varchar2, vNdoc_admin in varchar2, vFecha_audit in varchar2, vNombredeusuario in varchar2, vUsuario_id in varchar2, vCursor out cur) is
  begin
    update int_usuarios set NDOC = vNdoc, PASSWORD = vPassword, APELLIDO = vApellido, NOMBRES = vNombres, DESTINO = vDestino, FECHAVENC = vFechavenc, TEDIRECTO = vTedirecto, TEINTERNO = vTeinterno, EMAIL = vEmail, ESTADO = vEstado, SECCION = vSeccion, NDOC_ADMIN = vNdoc_admin, FECHA_AUDIT = vFecha_audit, NOMBREDEUSUARIO = vNombredeusuario, USUARIO_ID = vUsuario_id;
    --insert into tbl_evento (usuario_id, tipo_id, buque_id, fecha) VALUES (usuario.usuario_id, 2, vMatricula, SYSDATE);
  end update_usuario;

  
  procedure crear_practico(vNombre in varchar2, vCursor out cur) is
  begin
    insert into tbl_practico ( NOMBRE ) 
      VALUES ( vNombre);
    --insert into tbl_evento (usuario_id, tipo_id, buque_id, fecha) VALUES (usuario.usuario_id, 2, vMatricula, SYSDATE);
  end crear_practico;

  
  procedure update_practico(vNombre in varchar2, vCursor out cur) is
  begin
    update tbl_practico set NOMBRE = vNombre;
    --insert into tbl_evento (usuario_id, tipo_id, buque_id, fecha) VALUES (usuario.usuario_id, 2, vMatricula, SYSDATE);
  end update_practico;
 

 
  procedure asignar_pdc(vUsuario in varchar2, vPdc in varchar2) is
  begin
    insert into tbl_puntodecontrolusuario(PUNTODECONTROL, USUARIO) VALUES (vPdc, vUsuario);
  end asignar_pdc;

  
 
  procedure columnas_de(vTabla in varchar2, vCursor out cur) is
  begin
    open vCursor for
      SELECT COLUMN_NAME, NULLABLE FROM all_tab_cols WHERE TABLE_name=vTabla order by COLUMN_ID asc;
  end columnas_de;
 
  procedure pager(vTabla in varchar2, vOrderBy in varchar2, vCantidad in number, vDesde in number, vCursor out cur ) is
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

  procedure count_rows(vTabla in varchar2, number_of_rows out number) as
  begin
    sql_stmt := 'SELECT count(*) FROM '  || vTabla;
    execute immediate sql_stmt into number_of_rows;
  end count_rows;

  
end;
/