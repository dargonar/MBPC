using System;
using System.Data;
using System.Collections.Generic;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Configuration;
using System.Globalization;
using System.Threading;


public static class DaoLib
{
    public static decimal?[] parsePos(string pos)
    {
      decimal?[] latlon = { decimal.Parse(pos.Substring(0, 4).Insert(2, ",")) * -1 , decimal.Parse(pos.Substring(5, 5).Insert(3, ",")) * -1 }; 
      return latlon;
    }


  public static bool loguser(string username, string password)
  {

    string constr = ConfigurationManager.ConnectionStrings["default"].ConnectionString;
    bool retVal = false;
    decimal test;

    decimal.TryParse(username, out test);

    if (test == 0)
      return retVal;

    using (OracleConnection con = new OracleConnection(constr))
    {

      con.Open();

      OracleCommand cmd = new OracleCommand();

      cmd.Connection = con;
      cmd.CommandText = "mbpc.login";
      cmd.CommandType = CommandType.StoredProcedure;
      cmd.Parameters.Add("vid", OracleDbType.Varchar2, username, System.Data.ParameterDirection.Input);
      cmd.Parameters.Add("vpassword", OracleDbType.Varchar2, password, System.Data.ParameterDirection.Input);

      OracleParameter param = cmd.Parameters.Add("logged", OracleDbType.Decimal, DBNull.Value, System.Data.ParameterDirection.Output);

      OracleDataReader reader = cmd.ExecuteReader();
      retVal = int.Parse(param.Value.ToString()) != 0 ? true : false;

      cmd.Dispose();
      con.Close();

    }

    return retVal;

  }

  public static int row_count(string tabla)
  {

    string constr = ConfigurationManager.ConnectionStrings["default"].ConnectionString;
    int retVal = 0;

    using (OracleConnection con = new OracleConnection(constr))
    {

      con.Open();

      OracleCommand cmd = new OracleCommand();

      cmd.Connection = con;
      cmd.CommandText = "mbpc.count_rows";
      cmd.CommandType = CommandType.StoredProcedure;
      cmd.Parameters.Add("vTabla", OracleDbType.Varchar2, tabla, System.Data.ParameterDirection.Input);

      OracleParameter param = cmd.Parameters.Add("number_of_rows", OracleDbType.Decimal, DBNull.Value, System.Data.ParameterDirection.Output);
      OracleDataReader reader = cmd.ExecuteReader();
      retVal = int.Parse(param.Value.ToString());

      cmd.Dispose();
      con.Close();

    }

    return retVal;

  }

  public static List<object> hist_evt(string viaje)
  {

    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViaje", OracleDbType.Varchar2, viaje, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.hist_evt", parameters);
  }


  public static List<object> id_ultima_etapa(string viaje)
  {

    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViaje", OracleDbType.Varchar2, viaje, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.id_ultima_etapa", parameters);
  }




  public static List<object> hist_pos(string viaje)
  {

    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViaje", OracleDbType.Varchar2, viaje, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.hist_pos", parameters);
  }


  public static List<object> eventos_usuario()
  {

    var parameters = new OracleParameter[] 
    { 
        
    };

      return doCall("mbpc.eventos_usuario", parameters);
  }


  public static List<object> traer_banderas()
  {

    var parameters = new OracleParameter[] 
    { 
        
    };

    return doCall("mbpc.traer_banderas", parameters);
  }


  public static List<object> insertar_cambioestado(string etapa_id, string notas, decimal? latitud, decimal? longitud, DateTime fecha, string estado, string riocanal)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapa", OracleDbType.Varchar2, etapa_id, System.Data.ParameterDirection.Input),
        //new OracleParameter("vTipoEvento", OracleDbType.Varchar2, tipoevento, System.Data.ParameterDirection.Input),
        new OracleParameter("vNotas", OracleDbType.Varchar2, notas, System.Data.ParameterDirection.Input),
        new OracleParameter("vLat", OracleDbType.Decimal, latitud, System.Data.ParameterDirection.Input),
        new OracleParameter("vLon", OracleDbType.Decimal, longitud, System.Data.ParameterDirection.Input),
        new OracleParameter("vFecha", OracleDbType.Date, fecha, System.Data.ParameterDirection.Input),
        new OracleParameter("vEstado", OracleDbType.Varchar2, estado, System.Data.ParameterDirection.Input),
        new OracleParameter("vRiocanal", OracleDbType.Varchar2, riocanal, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.insertar_cambioestado", parameters);

  }



  public static List<object> hist_rvp(string viaje)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViaje", OracleDbType.Varchar2, viaje, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.hist_rvp", parameters);
  }

  public static List<object> insertar_reporte(string viaje_id, decimal? lat, decimal? lon, string velocidad, string rumbo, string estado, DateTime fecha)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViaje", OracleDbType.Varchar2, viaje_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vLat", OracleDbType.Decimal, lat, System.Data.ParameterDirection.Input),
        new OracleParameter("vLon", OracleDbType.Decimal, lon, System.Data.ParameterDirection.Input),
        new OracleParameter("vVelocidad", OracleDbType.Varchar2, velocidad, System.Data.ParameterDirection.Input),
        new OracleParameter("vRumbo", OracleDbType.Varchar2, rumbo, System.Data.ParameterDirection.Input),
        new OracleParameter("vEstado", OracleDbType.Varchar2, estado, System.Data.ParameterDirection.Input),
        new OracleParameter("vFecha", OracleDbType.Date, fecha, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.insertar_reporte", parameters);
  }


  public static List<object> separar_convoy(string viaje, DateTime fecha)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViaje", OracleDbType.Varchar2, viaje, System.Data.ParameterDirection.Input),
        new OracleParameter("vPartida", OracleDbType.Date, fecha, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.separar_convoy", parameters);
  }

  public static List<object> posicion_de_puntodecontrol(string zona)
  {
      var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vPdc", OracleDbType.Varchar2, zona, System.Data.ParameterDirection.Input)
    };

      return doCall("mbpc.posicion_de_puntodecontrol", parameters);
  }


  public static List<object> todos_los_pdc()
  {
    var parameters = new OracleParameter[] 
    { 
        
    };

    return doCall("mbpc.todos_los_pdc", parameters);
  }

  public static List<object> pager(string tabla, string orderby, int cantidad, int desde)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vTabla", OracleDbType.Varchar2, tabla, System.Data.ParameterDirection.Input),
        new OracleParameter("vOrderBy", OracleDbType.Varchar2, orderby, System.Data.ParameterDirection.Input),
        new OracleParameter("vCantidad", OracleDbType.Varchar2, cantidad, System.Data.ParameterDirection.Input),
        new OracleParameter("vDesde", OracleDbType.Varchar2, desde, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.pager", parameters);
  }

  public static List<object> viajes_terminados(string zona)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vZona", OracleDbType.Varchar2, zona.ToString(), System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.viajes_terminados", parameters);
  }

  public static List<object> reactivar_viaje(string viaje)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vUsuario", OracleDbType.Varchar2, viaje.ToString(), System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.reactivar_viaje", parameters);
  }


  public static List<object> datos_del_usuario(string usuario)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vid", OracleDbType.Varchar2, usuario, System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.datos_del_usuario", parameters);
  }

  public static List<object> reporte_diario(string usuario)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vUsuario", OracleDbType.Varchar2, usuario.ToString(), System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.reporte_diario", parameters);
  }

  public static List<object> editar_acompanante(string vEtapa, string vBuque)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapa", OracleDbType.Varchar2, vEtapa, System.Data.ParameterDirection.Input),
        new OracleParameter("vBuque", OracleDbType.Varchar2, vBuque, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.editar_acompanante", parameters);
  }


  public static List<object> quitar_acompanante(string vViaje)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViaje", OracleDbType.Varchar2, vViaje, System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.quitar_acompanante", parameters);
  }

  public static List<object> zonas_del_usuario(int usuario)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vId", OracleDbType.Varchar2, usuario.ToString(), System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.zonas_del_usuario", parameters);
  }

  public static List<object> barcos_en_zona(string zona)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vZonaId", OracleDbType.Varchar2, zona.ToString(), System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.barcos_en_zona", parameters);
  }


  public static List<object> barcos_entrantes(string zona)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vZonaId", OracleDbType.Varchar2, zona.ToString(), System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.barcos_entrantes", parameters);
  }

  public static List<object> barcos_salientes(string zona)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vZonaId", OracleDbType.Varchar2, zona.ToString(), System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.barcos_salientes", parameters);
  }

  public static List<object> zonas_adyacentes(string zona)
  {
    var parameters = new OracleParameter[]
    { 
        new OracleParameter("vZonaId", OracleDbType.Varchar2, zona.ToString(), System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.zonas_adyacentes", parameters);
  }

  public static List<object> pasar_barco(string viajeId, string zonaId, DateTime? eta, DateTime fecha)
  {
    var parameters = new OracleParameter[]
    { 
        new OracleParameter("vViajeId", OracleDbType.Varchar2, decimal.Parse(viajeId), System.Data.ParameterDirection.Input),
        new OracleParameter("vZonaId", OracleDbType.Varchar2, decimal.Parse(zonaId), System.Data.ParameterDirection.Input),
        new OracleParameter("vEta", OracleDbType.Date, eta, System.Data.ParameterDirection.Input),
        new OracleParameter("vLlegada", OracleDbType.Date, fecha, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.pasar_barco", parameters);
  }

  public static List<object> indicar_proximo(string viajeId, string zonaId)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViajeId", OracleDbType.Varchar2, decimal.Parse(viajeId), System.Data.ParameterDirection.Input),
        new OracleParameter("vZonaId", OracleDbType.Varchar2, decimal.Parse(zonaId), System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.indicar_proximo", parameters);
  }

  public static List<object> detalles_tecnicos(string shipId)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vShipId", OracleDbType.Varchar2, shipId, System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.detalles_tecnicos", parameters);
  }

  public static List<object> crear_practico(string nombre)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vNombre", OracleDbType.Varchar2, nombre, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.crear_practico", parameters);
  }

  public static List<object> crear_usuario(string NDOC, string PASSWORD, string APELLIDO, string NOMBRES, string DESTINO, string FECHAVENC, string TEDIRECTO, string TEINTERNO, string EMAIL, string ESTADO, string SECCION, string NDOC_ADMIN, string FECHA_AUDIT, string NOMBREDEUSUARIO, string USUARIO_ID)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vNdoc", OracleDbType.Varchar2, NDOC, System.Data.ParameterDirection.Input),
        new OracleParameter("vPassword", OracleDbType.Varchar2, PASSWORD, System.Data.ParameterDirection.Input),
        new OracleParameter("vApellido", OracleDbType.Varchar2, APELLIDO, System.Data.ParameterDirection.Input),
        new OracleParameter("vNombres", OracleDbType.Varchar2, NOMBRES, System.Data.ParameterDirection.Input),
        new OracleParameter("vDestino", OracleDbType.Varchar2, DESTINO, System.Data.ParameterDirection.Input),
        new OracleParameter("vFechavenc", OracleDbType.Varchar2, FECHAVENC, System.Data.ParameterDirection.Input),
        new OracleParameter("vTedirecto", OracleDbType.Varchar2, TEDIRECTO, System.Data.ParameterDirection.Input),
        new OracleParameter("vTeinterno", OracleDbType.Varchar2, TEINTERNO, System.Data.ParameterDirection.Input),
        new OracleParameter("vEmail", OracleDbType.Varchar2, EMAIL, System.Data.ParameterDirection.Input),
        new OracleParameter("vEstado", OracleDbType.Varchar2, ESTADO, System.Data.ParameterDirection.Input),
        new OracleParameter("vSeccion", OracleDbType.Varchar2, SECCION, System.Data.ParameterDirection.Input),
        new OracleParameter("vNdoc_admin", OracleDbType.Varchar2, NDOC_ADMIN, System.Data.ParameterDirection.Input),
        new OracleParameter("vFecha_audit", OracleDbType.Varchar2, FECHA_AUDIT, System.Data.ParameterDirection.Input),
        new OracleParameter("vNombredeusuario", OracleDbType.Varchar2, NOMBREDEUSUARIO, System.Data.ParameterDirection.Input),
        new OracleParameter("vUsuario_id", OracleDbType.Varchar2, USUARIO_ID, System.Data.ParameterDirection.Input),
        
    };

    return doCall("mbpc.crear_usuario", parameters);
  }


  public static List<object> crear_viaje(string buque, string origen, string destino, DateTime inicio, DateTime? eta, DateTime? zoe, string zona, string proximo_punto, string intl, decimal? lat, decimal? lon, string riocanal)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vBuque", OracleDbType.Varchar2, buque, System.Data.ParameterDirection.Input),
        new OracleParameter("vOrigen", OracleDbType.Varchar2, origen, System.Data.ParameterDirection.Input),
        new OracleParameter("vDestino", OracleDbType.Varchar2, destino, System.Data.ParameterDirection.Input),
        new OracleParameter("vInicio", OracleDbType.Date, inicio, System.Data.ParameterDirection.Input),
        new OracleParameter("vEta", OracleDbType.Date, eta, System.Data.ParameterDirection.Input),
        new OracleParameter("vZoe", OracleDbType.Date, zoe, System.Data.ParameterDirection.Input),
        new OracleParameter("vZona", OracleDbType.Varchar2, zona, System.Data.ParameterDirection.Input),
        new OracleParameter("vProx", OracleDbType.Varchar2, proximo_punto, System.Data.ParameterDirection.Input),
        new OracleParameter("vInternacional", OracleDbType.Varchar2, decimal.Parse(intl), System.Data.ParameterDirection.Input),
        new OracleParameter("vLat", OracleDbType.Decimal, lat, System.Data.ParameterDirection.Input),
        new OracleParameter("vLon", OracleDbType.Decimal, lon, System.Data.ParameterDirection.Input),
        new OracleParameter("vRiocanal", OracleDbType.Decimal, riocanal, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.crear_viaje", parameters);
  }

  public static List<object> editar_viaje(string viaje, string buque, string origen, string destino, DateTime inicio, DateTime eta, DateTime? zoe, string zona, string proximo_punto, string intl, decimal? lat, decimal? lon, string riocanal)
  {
    var parameters = new OracleParameter[]
    { 
        new OracleParameter("vViaje", OracleDbType.Varchar2, viaje, System.Data.ParameterDirection.Input),
        new OracleParameter("vBuque", OracleDbType.Varchar2, buque, System.Data.ParameterDirection.Input),
        new OracleParameter("vOrigen", OracleDbType.Varchar2, origen, System.Data.ParameterDirection.Input),
        new OracleParameter("vDestino", OracleDbType.Varchar2, destino, System.Data.ParameterDirection.Input),
        new OracleParameter("vInicio", OracleDbType.Date, inicio, System.Data.ParameterDirection.Input),
        new OracleParameter("vEta", OracleDbType.Date, eta, System.Data.ParameterDirection.Input),
        new OracleParameter("vZoe", OracleDbType.Date, zoe, System.Data.ParameterDirection.Input),
        new OracleParameter("vZona", OracleDbType.Varchar2, zona, System.Data.ParameterDirection.Input),
        new OracleParameter("vProx", OracleDbType.Varchar2, proximo_punto, System.Data.ParameterDirection.Input),
        new OracleParameter("vInternacional", OracleDbType.Varchar2, decimal.Parse(intl), System.Data.ParameterDirection.Input),
        new OracleParameter("vLat", OracleDbType.Decimal, lat, System.Data.ParameterDirection.Input),
        new OracleParameter("vLon", OracleDbType.Decimal, lon, System.Data.ParameterDirection.Input),
        new OracleParameter("vRiocanal", OracleDbType.Varchar2, riocanal, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.editar_viaje", parameters);
  }

  public static List<object> traer_etapa(string viaje)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViaje", OracleDbType.Varchar2, viaje, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.traer_etapa", parameters);
  }

  public static List<object> traer_buque_de_etapa(string etapa)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapa", OracleDbType.Varchar2, etapa, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.traer_buque_de_etapa", parameters);
  }


  public static List<object> traer_pbip(string viaje)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViaje", OracleDbType.Varchar2, viaje, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.traer_pbip", parameters);
  }

  public static List<object> traer_notas(string viaje)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViaje", OracleDbType.Varchar2, viaje, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.traer_notas", parameters);
  }

  public static List<object> guardar_notas(string viaje, string notas)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViaje", OracleDbType.Varchar2, viaje, System.Data.ParameterDirection.Input),
        new OracleParameter("vNotas", OracleDbType.Varchar2, notas, System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.guardar_notas", parameters);
  }



  public static List<object> modificar_pbip(string puertodematricula, string numeroinmarsat, string arqueobruto,
                                            string compania, string contactoOCPM, string objetivo, string viaje)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViaje", OracleDbType.Varchar2, viaje, System.Data.ParameterDirection.Input),
        new OracleParameter("vPuertoDeMatricula", OracleDbType.Varchar2, puertodematricula, System.Data.ParameterDirection.Input),
        new OracleParameter("vNumeroInmarsat", OracleDbType.Varchar2, numeroinmarsat, System.Data.ParameterDirection.Input),
        new OracleParameter("vArqueoBruto", OracleDbType.Varchar2, arqueobruto, System.Data.ParameterDirection.Input),
        new OracleParameter("vCompania", OracleDbType.Varchar2, compania, System.Data.ParameterDirection.Input),
        new OracleParameter("vContactoOCPM", OracleDbType.Varchar2, contactoOCPM, System.Data.ParameterDirection.Input),
        new OracleParameter("vFechaLlegada", OracleDbType.Varchar2, objetivo, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.modificar_pbip", parameters);
  }

  public static List<object> editar_etapa(string etapa, string calado_proa, string calado_popa, DateTime? hrp, DateTime? eta, DateTime? fecha_salida, string cantidad_tripulantes, string cantidad_pasajeros, string capitan)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapa", OracleDbType.Varchar2, etapa, System.Data.ParameterDirection.Input),
        new OracleParameter("vCaladoProa", OracleDbType.Varchar2, calado_proa, System.Data.ParameterDirection.Input),
        new OracleParameter("vCaladoPopa", OracleDbType.Varchar2, calado_popa, System.Data.ParameterDirection.Input),
        new OracleParameter("vHPR", OracleDbType.Date, hrp, System.Data.ParameterDirection.Input),
        new OracleParameter("vETA", OracleDbType.Date, eta, System.Data.ParameterDirection.Input),
        new OracleParameter("vFechaSalida", OracleDbType.Date, fecha_salida, System.Data.ParameterDirection.Input),
        new OracleParameter("vCantidadTripulantes", OracleDbType.Varchar2, cantidad_tripulantes, System.Data.ParameterDirection.Input),
        new OracleParameter("vCantidadPasajeros", OracleDbType.Varchar2, cantidad_pasajeros, System.Data.ParameterDirection.Input),
        new OracleParameter("vCapitan", OracleDbType.Varchar2, capitan, System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.editar_etapa", parameters);
  }
  
  public static List<object> traer_viaje(string viaje)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViaje", OracleDbType.Varchar2, viaje, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.traer_viaje", parameters);
  }

  public static List<object> terminar_viaje(string viajeId, DateTime fecha)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViajeId", OracleDbType.Varchar2, decimal.Parse(viajeId), System.Data.ParameterDirection.Input),
        new OracleParameter("vFecha", OracleDbType.Date, fecha, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.terminar_viaje", parameters);
  }

  public static List<object> traer_cargas(string viaje)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViajeId", OracleDbType.Varchar2, viaje, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.traer_cargas", parameters);
  }

  public static List<object> modificar_carga(string carga, string cantidad)
  {

    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vCarga", OracleDbType.Varchar2, carga, System.Data.ParameterDirection.Input),
        new OracleParameter("vCantidad", OracleDbType.Varchar2, cantidad, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.modificar_carga", parameters);
  }

  public static List<object> eliminar_carga(string carga)
  {

    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vCarga", OracleDbType.Varchar2, carga, System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.eliminar_carga", parameters);
  }

  public static List<object> traer_por_codigo(string codigo)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vCodigo", OracleDbType.Varchar2, codigo, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.traer_carga_por_codigo", parameters);
  }

  public static List<object> insertar_carga(string etapa_id, string carga_id, string cantidad, string unidad_id, string buque_id)
  {

    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapa", OracleDbType.Varchar2, etapa_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vCarga", OracleDbType.Varchar2, carga_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vCantidad", OracleDbType.Varchar2, cantidad, System.Data.ParameterDirection.Input),
        new OracleParameter("vUnidad", OracleDbType.Varchar2, unidad_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vBuque", OracleDbType.Varchar2, buque_id, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.insertar_carga", parameters);
  }



  public static List<object> crear_buque(string nombre, string matricula, string sdist, string servicio)
  {
    string matri = string.Empty;

    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vMatricula", OracleDbType.Varchar2, matricula, System.Data.ParameterDirection.Input),
        new OracleParameter("vNombre", OracleDbType.Varchar2, nombre, System.Data.ParameterDirection.Input),
        new OracleParameter("vSDist", OracleDbType.Varchar2, sdist, System.Data.ParameterDirection.Input),
        new OracleParameter("vServicio", OracleDbType.Varchar2, servicio, System.Data.ParameterDirection.Input),
        //new OracleParameter("vOutMatricula", OracleDbType.Varchar2, matri , System.Data.ParameterDirection.Output)
    };

    doCall("mbpc.crear_buque", parameters);

    List<object> lista = new List<object>();
    Dictionary<string, string> vv = new Dictionary<string, string>();
     lista.Add(vv);
    return lista;

  }


  public static List<object> crear_buque_int(string nombre, string matricula, string sdist, string bandera)
  {
    string matri = string.Empty;

    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vMatricula", OracleDbType.Varchar2, matricula, System.Data.ParameterDirection.Input),
        new OracleParameter("vNombre", OracleDbType.Varchar2, nombre, System.Data.ParameterDirection.Input),
        new OracleParameter("vSDist", OracleDbType.Varchar2, sdist, System.Data.ParameterDirection.Input),
        new OracleParameter("vBandera", OracleDbType.Varchar2, bandera, System.Data.ParameterDirection.Input)
        //new OracleParameter("vOutMatricula", OracleDbType.Varchar2, matri , System.Data.ParameterDirection.Output)
    };

    doCall("mbpc.crear_buque_int", parameters);

    List<object> lista = new List<object>();
    Dictionary<string, string> vv = new Dictionary<string, string>();
    lista.Add(vv);
    return lista;

  }

  public static List<object> barcazas_utilizadas()
  {
    var parameters = new OracleParameter[] { };

    return doCall("mbpc.barcazas_utilizadas", parameters);
  }

  public static List<object> traer_puertos()
  {
    var parameters = new OracleParameter[]   {    };

    return doCall("mbpc.traer_puertos", parameters);
  }

  public static List<object> traer_unidades()
  {
    var parameters = new OracleParameter[] { };

    return doCall("mbpc.traer_unidades", parameters);
  }
    

  public static List<object> traer_instport(string puerto)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vPuerto", OracleDbType.Varchar2, puerto, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.traer_instports", parameters);
  }

  public static List<object> traer_barcazas()
  {
    OracleParameter[] parameters = new OracleParameter[]{};

    return doCall("mbpc.traer_barcazas", parameters);
  }

  public static List<object> traer_barcazas(string etapa)
  {

    OracleParameter[] parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapa", OracleDbType.Varchar2, etapa, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.traer_barcazas_de_buque", parameters);
  }


  public static List<object> asignar_pdc(string[] usuarios, string[] pdcs)
  {
    OracleParameter[] parameters = new OracleParameter[] 
    { 
        new OracleParameter("vUsario", OracleDbType.Varchar2, usuarios, System.Data.ParameterDirection.Input),
        new OracleParameter("vPdcs", OracleDbType.Varchar2, pdcs, System.Data.ParameterDirection.Input),
    };

    var arraybindcount = pdcs.Length;

    return doCall2("mbpc.asignar_pdc", parameters, arraybindcount);
  }


  public static List<object> transferir_barcazas(string[] cargas, string[] etapas)
  {
    OracleParameter[] parameters = new OracleParameter[] 
    { 
        new OracleParameter("vCargas", OracleDbType.Varchar2, cargas, System.Data.ParameterDirection.Input),
        new OracleParameter("vEtapas", OracleDbType.Varchar2, etapas, System.Data.ParameterDirection.Input),
    };

    var arraybindcount = cargas.Length;

    return doCall2("mbpc.transferir_barcazas", parameters, arraybindcount);
  }

  public static List<object> agregar_practicos(string[] practicos, string[] etapas, string[] activos)
  {
    OracleParameter[] parameters = new OracleParameter[] 
    { 
        new OracleParameter("vPractico", OracleDbType.Varchar2, practicos, System.Data.ParameterDirection.Input),
        new OracleParameter("vEtapa", OracleDbType.Varchar2, etapas, System.Data.ParameterDirection.Input),
        new OracleParameter("vActivo", OracleDbType.Varchar2, activos, System.Data.ParameterDirection.Input)
    };

    var arraybindcount = practicos.Length;

    return doCall2("mbpc.agregar_practicos", parameters, arraybindcount);
  }

  public static List<object> columnas_de(string tabla)
  {

    OracleParameter[] parameters = new OracleParameter[] 
    { 
      new OracleParameter("vTabla", OracleDbType.Varchar2, tabla, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.columnas_de", parameters);
  }



  public static List<object> eliminar_practicos(string etapa)
  {

    OracleParameter[] parameters = new OracleParameter[] 
    { 
      new OracleParameter("vEtapa", OracleDbType.Varchar2, etapa, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.eliminar_practicos", parameters);
  }


  public static List<object> traer_practicos(string etapa)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapa", OracleDbType.Varchar2, etapa, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.traer_practicos", parameters);
  }

  public static List<object> crear_muelle(string puerto, string instport, string nombre)
  {
    decimal muelle_id = 0;

    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vPuerto", OracleDbType.Varchar2, puerto, System.Data.ParameterDirection.Input),
        new OracleParameter("vInstPort", OracleDbType.Varchar2, instport, System.Data.ParameterDirection.Input),
        new OracleParameter("vNombre", OracleDbType.Varchar2, nombre, System.Data.ParameterDirection.Input),
        new OracleParameter("vId", OracleDbType.Decimal, muelle_id, System.Data.ParameterDirection.Output)
    };

    doCall("mbpc.crear_muelle", parameters);

    List<object> lista = new List<object>();
    Dictionary<string, string> vv = new Dictionary<string, string>();
    vv["muelle_id"] = parameters[3].Value.ToString();
    lista.Add(vv);
    return lista;
  }

  public static List<object> autocomplete(string tabla, string query)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vVista", OracleDbType.Varchar2, tabla, System.Data.ParameterDirection.Input),
        new OracleParameter("vQuery", OracleDbType.Varchar2, query, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.autocompleter", parameters);
  }

  public static List<object> autocompletebnacionales(string query)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vQuery", OracleDbType.Varchar2, query, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.autocompleterbnacionales", parameters);
  }

  public static List<object> autocompleterioscanales(string query)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vQuery", OracleDbType.Varchar2, query, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.autocompleterioscanales", parameters);
  }




  public static List<object> autocompletebactivos(string query)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vQuery", OracleDbType.Varchar2, query, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.autocompletebactivos", parameters);
  }

  public static List<object> autocompleterestados(string query)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vQuery", OracleDbType.Varchar2, query, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.autocompleterestados", parameters);
  }

  public static List<object> autocompleterb(string query)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vQuery", OracleDbType.Varchar2, query, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.autocompleterbdisponibles", parameters);
  }


  public static List<object> autocompletem(string query)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vQuery", OracleDbType.Varchar2, query, System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.autocompleterm", parameters);
  }




  private static List<object> doCall2(string functionName, OracleParameter[] parameters, int arraybindcount)
  {
    string constr = ConfigurationManager.ConnectionStrings["default"].ConnectionString;
    List<object> retVal = new List<object>();

    using (OracleConnection con = new OracleConnection(constr))
    {
      con.Open();

      OracleCommand cmd = new OracleCommand();

      cmd.Connection = con;
      cmd.CommandText = functionName;
      cmd.CommandType = CommandType.StoredProcedure;
      foreach (OracleParameter param in parameters)
      {
        cmd.Parameters.Add(param);
      }

      cmd.ArrayBindCount = arraybindcount;


      OracleDataReader reader = cmd.ExecuteReader();

      while (reader.Read())
      {
        Dictionary<string, string> vv = new Dictionary<string, string>();
        for (int i = 0; i < reader.FieldCount; i++)
        {
          vv[reader.GetName(i).ToString()] = reader.GetValue(i).ToString();
        }
        retVal.Add(vv);
      }

      cmd.Dispose();
      con.Close();
    }

    return retVal;
  }

  private static List<object> doCall(string functionName, OracleParameter[] parameters)
  {
    string constr = ConfigurationManager.ConnectionStrings["default"].ConnectionString;
    List<object> retVal = new List<object>();

    using (OracleConnection con = new OracleConnection(constr))
    {
      con.Open();

      OracleCommand cmd = new OracleCommand();

      cmd.Connection = con;
      cmd.CommandText = functionName;
      cmd.CommandType = CommandType.StoredProcedure;
      foreach (OracleParameter param in parameters)
      {
        cmd.Parameters.Add(param);
      }

      cmd.Parameters.Add("vCursor", OracleDbType.RefCursor, DBNull.Value, System.Data.ParameterDirection.Output);

      OracleDataReader reader = cmd.ExecuteReader();

      Type typetemp = typeof(Boolean);
      
      while (reader.Read())
      {
        
        Dictionary<string, string> vv = new Dictionary<string, string>();
        for (int i = 0; i < reader.FieldCount; i++)
        {
          typetemp = typeof(Boolean);
          typetemp = reader.GetFieldType(i);

          var val = reader.GetValue(i);
          
          if (typetemp == typeof(DateTime))
          {
              if (val.GetType() == typeof(DBNull))
              {
                vv[reader.GetName(i).ToString()] = "";
                vv[reader.GetName(i).ToString() + "_fmt"] = "";
              }
              else
              {
                vv[reader.GetName(i).ToString()] = DateTime.Parse(val.ToString()).ToString("u", DateTimeFormatInfo.InvariantInfo).Substring(0, 16);
                vv[reader.GetName(i).ToString() + "_fmt"] = string.Format("{0:dd-MM-yy HH:mm}", (DateTime)val);
              }
            continue;
          }
          vv[reader.GetName(i).ToString()] = reader.GetValue(i).ToString();
        }

        //Lat/Long de float a string
        if (vv.ContainsKey("LATITUD") && vv.ContainsKey("LONGITUD"))
        {
            if (vv["LATITUD"] != "" || vv["LONGITUD"] != "")
            {
                double lat = 0.0;
                double lon = 0.0;

                double.TryParse(vv["LATITUD"], out lat);
                double.TryParse(vv["LONGITUD"], out lon);

                vv["LATLONG_fmt"] = string.Format("{0:00}{1:00}{2}{3:000}{4:00}{5}",
                                        Math.Abs((int)lat), Math.Abs((int)((lat - Math.Truncate(lat)) * 100.0f)),
                                        Math.Sign(lat) > 0 ? 'N' : 'S',
                                        Math.Abs((int)lon), Math.Abs((int)((lon - Math.Truncate(lon)) * 100.0f)),
                                        Math.Sign(lon) > 0 ? 'E' : 'W');
            }
            else vv["LATLONG_fmt"] = "";
        }

        retVal.Add(vv);
      }

      cmd.Dispose();
      con.Close();
    }

    return retVal;
  }

}