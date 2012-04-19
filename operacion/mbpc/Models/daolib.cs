using System;
using System.Configuration;
using System.Data;
using System.Collections.Generic;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Configuration;
using System.Globalization;
using System.Threading;
using mbpc.Models;
using System.Web.Mvc;
using MvcMiniProfiler;

public static class DaoLib
{
  public static int userid;

  public static decimal?[] parsePos(string pos)
  {
    decimal?[] latlon = {
          -1 * (decimal.Parse(pos.Substring(0, 2)) + decimal.Parse(pos.Substring(2, 2)) / 60.0m),
          -1 * (decimal.Parse(pos.Substring(5, 3)) + decimal.Parse(pos.Substring(8, 2)) / 60.0m)
    };

    //decimal?[] latlon = { decimal.Parse(pos.Substring(0, 4).Insert(2, ",")) * -1 , decimal.Parse(pos.Substring(5, 5).Insert(3, ",")) * -1 }; 
    return latlon;
  }

  public static int loguser2(string username, string password)
  {
    string constr = ConfigurationManager.ConnectionStrings["default"].ConnectionString;
    int result = -1;

    using (OracleConnection con = new OracleConnection(constr))
    {

      con.Open();

      OracleCommand cmd = new OracleCommand();

      cmd.Connection = con;
      cmd.CommandText = "mbpc.login2";
      cmd.CommandType = CommandType.StoredProcedure;
      cmd.Parameters.Add("vid", OracleDbType.Varchar2, username, System.Data.ParameterDirection.Input);
      cmd.Parameters.Add("vpassword", OracleDbType.Varchar2, password, System.Data.ParameterDirection.Input);

      OracleParameter param = cmd.Parameters.Add("logged", OracleDbType.Decimal, DBNull.Value, System.Data.ParameterDirection.Output);

      OracleDataReader reader = cmd.ExecuteReader();
      result = int.Parse(param.Value.ToString());

      cmd.Dispose();
      con.Close();
    }

    return result;
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
  
  public static List<object> eliminar_evento(string id, string etapa_id)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEvento", OracleDbType.Varchar2, id, System.Data.ParameterDirection.Input),
        new OracleParameter("vEtapa" , OracleDbType.Varchar2, etapa_id, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.eliminar_evento", parameters);
  }

  public static List<object> hist_evt(string etapa_id)
  {

    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapa", OracleDbType.Varchar2, etapa_id, System.Data.ParameterDirection.Input)
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

  public static List<object> login_usuario(string dummy)
  {

    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vDummy", OracleDbType.Varchar2, dummy, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.login_usuario", parameters);
  }

  public static List<object> logout_usuario(string dummy)
  {

    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vDummy", OracleDbType.Varchar2, dummy, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.logout_usuario", parameters);
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


  public static List<object> insertar_cambioestado(string etapa_id, string notas, decimal? latitud, decimal? longitud, string fecha, string estado, string riocanal, string muelle)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapa", OracleDbType.Varchar2, etapa_id, System.Data.ParameterDirection.Input),
        //new OracleParameter("vTipoEvento", OracleDbType.Varchar2, tipoevento, System.Data.ParameterDirection.Input),
        new OracleParameter("vNotas", OracleDbType.Varchar2, notas, System.Data.ParameterDirection.Input),
        new OracleParameter("vLat", OracleDbType.Decimal, latitud, System.Data.ParameterDirection.Input),
        new OracleParameter("vLon", OracleDbType.Decimal, longitud, System.Data.ParameterDirection.Input),
        new OracleParameter("vFecha", OracleDbType.Varchar2, fecha, System.Data.ParameterDirection.Input),
        new OracleParameter("vEstado", OracleDbType.Varchar2, estado, System.Data.ParameterDirection.Input),
        new OracleParameter("vRiocanal", OracleDbType.Varchar2, riocanal, System.Data.ParameterDirection.Input),
        new OracleParameter("vMuelle", OracleDbType.Varchar2, muelle, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.insertar_cambioestado", parameters);

  }



  public static List<object> hist_rvp(string etapa_id)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapa", OracleDbType.Varchar2, etapa_id, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.hist_rvp", parameters);
  }

  public static List<object> insertar_reporte(string viaje_id, decimal? lat, decimal? lon, string velocidad, string rumbo, string estado, string fecha)
  {
    decimal d_velocidad = Hlp.toDecimal(velocidad);
    decimal d_rumbo = Hlp.toDecimal(rumbo);

    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViaje", OracleDbType.Varchar2, viaje_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vLat", OracleDbType.Decimal, lat, System.Data.ParameterDirection.Input),
        new OracleParameter("vLon", OracleDbType.Decimal, lon, System.Data.ParameterDirection.Input),
        new OracleParameter("vVelocidad", OracleDbType.Decimal, d_velocidad, System.Data.ParameterDirection.Input),
        new OracleParameter("vRumbo", OracleDbType.Decimal, d_rumbo, System.Data.ParameterDirection.Input),
        new OracleParameter("vEstado", OracleDbType.Varchar2, estado, System.Data.ParameterDirection.Input),
        new OracleParameter("vFecha", OracleDbType.Varchar2, fecha, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.insertar_reporte", parameters);
  }


  public static List<object> separar_convoy(string viaje, string fecha)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViaje", OracleDbType.Varchar2, viaje, System.Data.ParameterDirection.Input),
        new OracleParameter("vPartida", OracleDbType.Varchar2, fecha, System.Data.ParameterDirection.Input)
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

  public static List<object> reporte_diario(string grupo)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vGrupo", OracleDbType.Varchar2, grupo, System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.reporte_diario", parameters);
  }

  public static List<object> editar_acompanante(string vEtapa, string vBuque, string vBuque2, string vBuque3, string vBuque4)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapa", OracleDbType.Varchar2, vEtapa, System.Data.ParameterDirection.Input),
        new OracleParameter("vBuque", OracleDbType.Varchar2, vBuque, System.Data.ParameterDirection.Input),
        new OracleParameter("vBuque2", OracleDbType.Varchar2, vBuque2, System.Data.ParameterDirection.Input),
        new OracleParameter("vBuque3", OracleDbType.Varchar2, vBuque3, System.Data.ParameterDirection.Input),
        new OracleParameter("vBuque4", OracleDbType.Varchar2, vBuque4, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.editar_acompanante", parameters);
  }

  public static List<object> traer_acompanantes(string vEtapa)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapa", OracleDbType.Varchar2, vEtapa, System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.traer_acompanantes", parameters);
  }


  public static List<object> quitar_acompanante(string vViaje)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViaje", OracleDbType.Varchar2, vViaje, System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.quitar_acompanante", parameters);
  }

  public static List<object> zonas_del_grupo(int grupo)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vId", OracleDbType.Varchar2, grupo.ToString(), System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.zonas_del_grupo", parameters);
  }

  public static List<object> grupos_del_usuario(int usuario)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vId", OracleDbType.Varchar2, usuario.ToString(), System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.grupos_del_usuario", parameters);
  }

  public static List<object> barcos_en_zona(string zona, MiniProfiler p)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vZonaId", OracleDbType.Varchar2, zona.ToString(), System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.barcos_en_zona", parameters, p);
  }

  public static List<object> corregir_barcaza(int etapa_id, int buque_id, int barcaza_id)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapa", OracleDbType.Varchar2, etapa_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vBuque", OracleDbType.Varchar2, buque_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vBarcaza", OracleDbType.Varchar2, barcaza_id, System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.corregir_barcaza", parameters);
  }

  
  public static List<object> barcazas_en_zona(string zona, MiniProfiler p)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vZonaId", OracleDbType.Varchar2, zona.ToString(), System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.barcazas_en_zona", parameters, p);
  }
  
  public static List<object> adjuntar_barcazas(int[] etapas_id, int[] barcazas)
  {
    OracleParameter[] parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapaId", OracleDbType.Varchar2, etapas_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vBarcazas", OracleDbType.Varchar2, barcazas, System.Data.ParameterDirection.Input)
    };

    return doCall2("mbpc.adjuntar_barcazas", parameters, barcazas.Length);
  }



  public static List<object> barcos_entrantes(string zona, MiniProfiler p)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vZonaId", OracleDbType.Varchar2, zona.ToString(), System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.barcos_entrantes", parameters, p);
  }

  public static List<object> barcos_salientes(string zona, MiniProfiler p)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vZonaId", OracleDbType.Varchar2, zona.ToString(), System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.barcos_salientes", parameters, p);
  }

  public static List<object> zonas_adyacentes(string zona)
  {
    var parameters = new OracleParameter[]
    { 
        new OracleParameter("vZonaId", OracleDbType.Varchar2, zona.ToString(), System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.zonas_adyacentes", parameters);
  }

  public static List<object> pasar_barco(string viajeId, string zonaId, string eta, string fecha, string velocidad, string rumbo)
  {
    decimal d_velocidad = Hlp.toDecimal(velocidad);
    decimal d_rumbo     = Hlp.toDecimal(rumbo);

    var parameters = new OracleParameter[]
    { 
        new OracleParameter("vViajeId", OracleDbType.Varchar2, decimal.Parse(viajeId), System.Data.ParameterDirection.Input),
        new OracleParameter("vZonaId", OracleDbType.Varchar2, decimal.Parse(zonaId), System.Data.ParameterDirection.Input),
        new OracleParameter("vEta", OracleDbType.Varchar2, eta, System.Data.ParameterDirection.Input),
        new OracleParameter("vLlegada", OracleDbType.Varchar2, fecha, System.Data.ParameterDirection.Input),
        new OracleParameter("vVelocidad", OracleDbType.Decimal , d_velocidad, System.Data.ParameterDirection.Input),
        new OracleParameter("vRumbo", OracleDbType.Decimal, d_rumbo, System.Data.ParameterDirection.Input)
        
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


  public static List<object> crear_viaje(string buque, string origen, string destino, string inicio, string eta, string zoe, string zona, string proximo_punto, string intl, decimal? lat, decimal? lon, string riocanal, int codigo_malvinas)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vBuque", OracleDbType.Varchar2, buque, System.Data.ParameterDirection.Input),
        new OracleParameter("vOrigen", OracleDbType.Varchar2, origen, System.Data.ParameterDirection.Input),
        new OracleParameter("vDestino", OracleDbType.Varchar2, destino, System.Data.ParameterDirection.Input),
        new OracleParameter("vInicio", OracleDbType.Varchar2, inicio, System.Data.ParameterDirection.Input),
        new OracleParameter("vEta", OracleDbType.Varchar2, eta, System.Data.ParameterDirection.Input),
        new OracleParameter("vZoe", OracleDbType.Varchar2, zoe, System.Data.ParameterDirection.Input),
        new OracleParameter("vZona", OracleDbType.Varchar2, zona, System.Data.ParameterDirection.Input),
        new OracleParameter("vProx", OracleDbType.Varchar2, proximo_punto, System.Data.ParameterDirection.Input),
        new OracleParameter("vInternacional", OracleDbType.Varchar2, 0, System.Data.ParameterDirection.Input),
        new OracleParameter("vLat", OracleDbType.Decimal, lat, System.Data.ParameterDirection.Input),
        new OracleParameter("vLon", OracleDbType.Decimal, lon, System.Data.ParameterDirection.Input),
        new OracleParameter("vRiocanal", OracleDbType.Decimal, riocanal, System.Data.ParameterDirection.Input),
        new OracleParameter("vCodigoMalvinas", OracleDbType.Decimal, codigo_malvinas, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.crear_viaje", parameters);
  }

  /*public static List<object> editar_viaje(string viaje, string buque, string origen, string destino, string inicio, string eta, string zoe, string zona, string proximo_punto, string intl, decimal? lat, decimal? lon, string riocanal)
  {
    var parameters = new OracleParameter[]
    { 
        new OracleParameter("vViaje", OracleDbType.Varchar2, viaje, System.Data.ParameterDirection.Input),
        new OracleParameter("vBuque", OracleDbType.Varchar2, buque, System.Data.ParameterDirection.Input),
        new OracleParameter("vOrigen", OracleDbType.Varchar2, origen, System.Data.ParameterDirection.Input),
        new OracleParameter("vDestino", OracleDbType.Varchar2, destino, System.Data.ParameterDirection.Input),
        new OracleParameter("vInicio", OracleDbType.Varchar2, inicio, System.Data.ParameterDirection.Input),
        new OracleParameter("vEta", OracleDbType.Varchar2, eta, System.Data.ParameterDirection.Input),
        new OracleParameter("vZoe", OracleDbType.Varchar2, zoe, System.Data.ParameterDirection.Input),
        new OracleParameter("vZona", OracleDbType.Varchar2, zona, System.Data.ParameterDirection.Input),
        new OracleParameter("vProx", OracleDbType.Varchar2, proximo_punto, System.Data.ParameterDirection.Input),
        new OracleParameter("vInternacional", OracleDbType.Varchar2, decimal.Parse(intl), System.Data.ParameterDirection.Input),
        new OracleParameter("vLat", OracleDbType.Decimal, lat, System.Data.ParameterDirection.Input),
        new OracleParameter("vLon", OracleDbType.Decimal, lon, System.Data.ParameterDirection.Input),
        new OracleParameter("vRiocanal", OracleDbType.Varchar2, riocanal, System.Data.ParameterDirection.Input)       
    };

    return doCall("mbpc.editar_viaje", parameters);
  }*/
  public static List<object> editar_viaje(string viaje, string buque, string inicio, string eta, string zoe, string zona, string proximo_punto, string intl, decimal? lat, decimal? lon, string riocanal)
  {
    var parameters = new OracleParameter[]
    { 
        new OracleParameter("vViaje", OracleDbType.Varchar2, viaje, System.Data.ParameterDirection.Input),
        new OracleParameter("vBuque", OracleDbType.Varchar2, buque, System.Data.ParameterDirection.Input),
        new OracleParameter("vInicio", OracleDbType.Varchar2, inicio, System.Data.ParameterDirection.Input),
        new OracleParameter("vEta", OracleDbType.Varchar2, eta, System.Data.ParameterDirection.Input),
        new OracleParameter("vZoe", OracleDbType.Varchar2, zoe, System.Data.ParameterDirection.Input),
        new OracleParameter("vZona", OracleDbType.Varchar2, zona, System.Data.ParameterDirection.Input),
        new OracleParameter("vProx", OracleDbType.Varchar2, proximo_punto, System.Data.ParameterDirection.Input),
        new OracleParameter("vInternacional", OracleDbType.Varchar2, decimal.Parse(intl), System.Data.ParameterDirection.Input),
        new OracleParameter("vLat", OracleDbType.Decimal, lat, System.Data.ParameterDirection.Input),
        new OracleParameter("vLon", OracleDbType.Decimal, lon, System.Data.ParameterDirection.Input),
        new OracleParameter("vRiocanal", OracleDbType.Varchar2, riocanal, System.Data.ParameterDirection.Input)       
    };

    return doCall("mbpc.editar_viaje", parameters);
  }

  /// <summary>
  /// Trae viaje con la última etapa.
  /// </summary>
  /// <param name="viaje"></param>
  /// <returns></returns>
  public static List<object> traer_etapa(string viaje)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViaje", OracleDbType.Varchar2, viaje, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.traer_etapa", parameters);
  }


  public static List<object> descripcion_punto_control(string pto_control_id)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViaje", OracleDbType.Varchar2, pto_control_id, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.descripcion_punto_control", parameters);
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

  public static List<object> editar_etapa(string etapa, string origen, string destino, string calado_proa, string calado_popa, string calado_informado, string hrp, string eta, string fecha_salida, string cantidad_tripulantes, string cantidad_pasajeros, string capitan, string rumbo, string velocidad)
  {
    decimal d_velocidad = Hlp.toDecimal(velocidad);
    decimal d_rumbo = Hlp.toDecimal(rumbo);

    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapa", OracleDbType.Varchar2, etapa, System.Data.ParameterDirection.Input),
        new OracleParameter("vOrigen", OracleDbType.Varchar2, origen, System.Data.ParameterDirection.Input),
        new OracleParameter("vDestino", OracleDbType.Varchar2, destino, System.Data.ParameterDirection.Input),
        new OracleParameter("vCaladoProa", OracleDbType.Varchar2, calado_proa, System.Data.ParameterDirection.Input),
        new OracleParameter("vCaladoPopa", OracleDbType.Varchar2, calado_popa, System.Data.ParameterDirection.Input),
        new OracleParameter("vCaladoInformado", OracleDbType.Varchar2, calado_informado, System.Data.ParameterDirection.Input),
        new OracleParameter("vHPR", OracleDbType.Varchar2, hrp, System.Data.ParameterDirection.Input),
        new OracleParameter("vETA", OracleDbType.Varchar2, eta, System.Data.ParameterDirection.Input),
        new OracleParameter("vFechaSalida", OracleDbType.Varchar2, fecha_salida, System.Data.ParameterDirection.Input),
        new OracleParameter("vCantidadTripulantes", OracleDbType.Varchar2, cantidad_tripulantes, System.Data.ParameterDirection.Input),
        new OracleParameter("vCantidadPasajeros", OracleDbType.Varchar2, cantidad_pasajeros, System.Data.ParameterDirection.Input),
        new OracleParameter("vCapitan", OracleDbType.Varchar2, capitan, System.Data.ParameterDirection.Input),
        new OracleParameter("vVelocidad", OracleDbType.Decimal, d_velocidad, System.Data.ParameterDirection.Input),
        new OracleParameter("vRumbo", OracleDbType.Decimal, d_rumbo, System.Data.ParameterDirection.Input)

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

  public static List<object> terminar_viaje(string viajeId, string fecha, string escalas, int codigo_malvinas)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViajeId", OracleDbType.Varchar2, decimal.Parse(viajeId), System.Data.ParameterDirection.Input),
        new OracleParameter("vFecha", OracleDbType.Varchar2, fecha, System.Data.ParameterDirection.Input),
        new OracleParameter("vEscalas", OracleDbType.Varchar2, escalas, System.Data.ParameterDirection.Input),
        new OracleParameter("vCodigoMalvinas", OracleDbType.Decimal, codigo_malvinas, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.terminar_viaje", parameters);
  }

  public static List<object> descargar_barcaza(int etapa_id, int barcaza_id)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapaId", OracleDbType.Varchar2, etapa_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vBarcazaId", OracleDbType.Varchar2, barcaza_id, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.descargar_barcaza", parameters);
  }

  public static List<object> descargar_multiples_barcazas(int[] barcazas, int[] etapas)
  {
    OracleParameter[] parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapaId", OracleDbType.Varchar2, etapas, System.Data.ParameterDirection.Input),
        new OracleParameter("vBarcazaId", OracleDbType.Varchar2, barcazas, System.Data.ParameterDirection.Input),
    };

    var arraybindcount = barcazas.Length;

    return doCall2("mbpc.descargar_barcaza_batch", parameters, arraybindcount);
  }

  
  public static List<object> fondear_barcaza(int etapa_id, int barcaza_id, string riocanal, decimal? lat, decimal? lon, string fecha)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapaId", OracleDbType.Varchar2, etapa_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vBarcazaId", OracleDbType.Varchar2, barcaza_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vRioCanalKM", OracleDbType.Varchar2, riocanal, System.Data.ParameterDirection.Input),
        new OracleParameter("vLat", OracleDbType.Decimal, lat, System.Data.ParameterDirection.Input),
        new OracleParameter("vLon", OracleDbType.Decimal, lon, System.Data.ParameterDirection.Input),
        new OracleParameter("vFecha", OracleDbType.Varchar2, fecha, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.fondear_barcaza", parameters);
  }

  public static List<object> fondear_barcazas_multiple(int[] etapas_id, int[] barcazas_id, string[] riocanal, decimal?[] lat, decimal?[] lon, string[] fecha)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapaId", OracleDbType.Varchar2, etapas_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vBarcazaId", OracleDbType.Varchar2, barcazas_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vRioCanalKM", OracleDbType.Varchar2, riocanal, System.Data.ParameterDirection.Input),
        new OracleParameter("vLat", OracleDbType.Decimal, lat, System.Data.ParameterDirection.Input),
        new OracleParameter("vLon", OracleDbType.Decimal, lon, System.Data.ParameterDirection.Input),
        new OracleParameter("vFecha", OracleDbType.Varchar2, fecha, System.Data.ParameterDirection.Input)
    };

    var arraybindcount = barcazas_id.Length;

    return doCall2("mbpc.fondear_barcaza_batch", parameters, arraybindcount);
  }

  public static List<object> traer_cargas_nobarcazas(int etapa_id)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapaId", OracleDbType.Varchar2, etapa_id, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.traer_cargas_nobarcazas", parameters);
  }

  public static List<object> traer_cargas(int etapa_id)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapaId", OracleDbType.Varchar2, etapa_id, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.traer_cargas", parameters);
  }

  public static List<object> modificar_carga(int carga_id, string cantidad_entrada, string cantidad_salida)
  {

    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vCarga", OracleDbType.Varchar2, carga_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vCantidadEntrada", OracleDbType.Varchar2, cantidad_entrada, System.Data.ParameterDirection.Input),
        new OracleParameter("vCantidadSalida", OracleDbType.Varchar2, cantidad_salida, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.modificar_carga", parameters);
  }

  public static List<object> eliminar_carga(int carga)
  {

    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vCarga", OracleDbType.Varchar2, carga, System.Data.ParameterDirection.Input),
        new OracleParameter("checkempty", OracleDbType.Varchar2, 1, System.Data.ParameterDirection.Input),
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

  public static List<object> insertar_carga(int etapa_id, int carga_id, string cantidad, int unidad_id, string buque_id, int en_transito)
  {

    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapa", OracleDbType.Varchar2, etapa_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vCarga", OracleDbType.Varchar2, carga_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vCantidad", OracleDbType.Varchar2, cantidad, System.Data.ParameterDirection.Input),
        new OracleParameter("vUnidad", OracleDbType.Varchar2, unidad_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vBuque", OracleDbType.Varchar2, buque_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vEnTransito", OracleDbType.Int32, en_transito, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.insertar_carga", parameters);
  }



  public static List<object> crear_buque(string nombre, string matricula, string sdist, string servicio, string mmsi)
  {
    string matri = string.Empty;

    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vMatricula", OracleDbType.Varchar2, matricula, System.Data.ParameterDirection.Input),
        new OracleParameter("vNombre", OracleDbType.Varchar2, nombre, System.Data.ParameterDirection.Input),
        new OracleParameter("vSDist", OracleDbType.Varchar2, sdist, System.Data.ParameterDirection.Input),
        new OracleParameter("vServicio", OracleDbType.Varchar2, servicio, System.Data.ParameterDirection.Input),
        new OracleParameter("vMMSI", OracleDbType.Varchar2, mmsi, System.Data.ParameterDirection.Input),

    };

    return doCall("mbpc.crear_buque", parameters);
  }


  public static List<object> crear_buque_int(string nombre, string matricula, string sdist, string bandera, string servicio, string mmsi)
  {
    string matri = string.Empty;

    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vMatricula", OracleDbType.Varchar2, matricula, System.Data.ParameterDirection.Input),
        new OracleParameter("vNombre", OracleDbType.Varchar2, nombre, System.Data.ParameterDirection.Input),
        new OracleParameter("vSDist", OracleDbType.Varchar2, sdist, System.Data.ParameterDirection.Input),
        new OracleParameter("vBandera", OracleDbType.Varchar2, bandera, System.Data.ParameterDirection.Input),
        new OracleParameter("vServicio", OracleDbType.Varchar2, servicio, System.Data.ParameterDirection.Input),
        new OracleParameter("vMMSI", OracleDbType.Varchar2, mmsi, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.crear_buque_int", parameters);
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

  public static List<object> actualizar_listado_de_barcazas(string etapa)
  {
    OracleParameter[] parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapaId", OracleDbType.Varchar2, etapa, System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.actualizar_listado_de_barcazas", parameters);
  }

  public static List<object> transferir_barcazas(string[] barcazas, string[] etapas)
  {
    OracleParameter[] parameters = new OracleParameter[] 
    { 
        new OracleParameter("vBarcazas", OracleDbType.Varchar2, barcazas, System.Data.ParameterDirection.Input),
        new OracleParameter("vEtapas", OracleDbType.Varchar2, etapas, System.Data.ParameterDirection.Input),
    };

    var arraybindcount = barcazas.Length;

    return doCall2("mbpc.transferir_barcazas", parameters, arraybindcount);
  }

  public static List<object> transferir_cargas(string[] etapa_id, string[] carga_id, string[] cantidad, string[] unidad_id, string[] tipo_id, string[] modo, string[] original, string[] recibeemite)
  {
    OracleParameter[] parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapa", OracleDbType.Varchar2, etapa_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vCarga", OracleDbType.Varchar2, carga_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vCantidad", OracleDbType.Varchar2, cantidad, System.Data.ParameterDirection.Input),
        new OracleParameter("vUnidad", OracleDbType.Varchar2, unidad_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vTipo", OracleDbType.Varchar2, tipo_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vModo", OracleDbType.Varchar2, modo, System.Data.ParameterDirection.Input),
        new OracleParameter("vOriginal", OracleDbType.Varchar2, original, System.Data.ParameterDirection.Input),
        new OracleParameter("vRecEmi", OracleDbType.Varchar2, recibeemite, System.Data.ParameterDirection.Input)
    };

    var arraybindcount = etapa_id.Length;

    return doCall2("mbpc.transferir_cargas", parameters, arraybindcount);
  }

  public static List<object> agregar_practico(string etapa_id, string practico_id, string fecha_subida)
  {
    OracleParameter[] parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapa", OracleDbType.Varchar2, etapa_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vPractico", OracleDbType.Varchar2, practico_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vFecha", OracleDbType.Varchar2, fecha_subida, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.agregar_practico", parameters);
  }

  public static List<object> bajar_practico(string practico_id, string etapa_id, string fecha)
  {
    OracleParameter[] parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapa", OracleDbType.Varchar2, etapa_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vPractico", OracleDbType.Varchar2, practico_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vFecha", OracleDbType.Varchar2, fecha, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.bajar_practico", parameters);
  }

  public static List<object> activar_practico(string practico_id, string etapa_id, string fecha)
  {
    OracleParameter[] parameters = new OracleParameter[] 
    { 
        new OracleParameter("vEtapa", OracleDbType.Varchar2, etapa_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vPractico", OracleDbType.Varchar2, practico_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vFecha", OracleDbType.Varchar2, fecha, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.activar_practico", parameters);
  }


  public static List<object> activar_practico(string id)
  {
    OracleParameter[] parameters = new OracleParameter[] 
    { 
        new OracleParameter("vPractico", OracleDbType.Varchar2, id, System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.activar_practico", parameters);
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


  public static List<object> traer_practicos(string id)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vViaje", OracleDbType.Varchar2, id, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.traer_practicos", parameters);
  }

  public static List<object> crear_muelle(string cod, string puerto, string pais)
  {
    decimal muelle_id = 0;

    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vCod", OracleDbType.Varchar2, cod, System.Data.ParameterDirection.Input),
        new OracleParameter("vPuerto", OracleDbType.Varchar2, puerto, System.Data.ParameterDirection.Input),
        new OracleParameter("vPais", OracleDbType.Varchar2, pais, System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.crear_puerto", parameters);
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

  public static List<object> autocomplete_remolcadores(string query)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vQuery", OracleDbType.Varchar2, query, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.autocomplete_remolcadores", parameters);
  }

  public static List<object> autocomplete_cargas(string query)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vQuery", OracleDbType.Varchar2, query, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.autocomplete_cargas", parameters);
  }

  public static List<object> autocomplete_practicos(string query, string etapa_id)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vQuery", OracleDbType.Varchar2, query, System.Data.ParameterDirection.Input),
        new OracleParameter("vEtapa", OracleDbType.Varchar2, etapa_id, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.autocomplete_practicos", parameters);
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

  public static List<object> autocomplete_muelles(string query)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vQuery", OracleDbType.Varchar2, query, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.autocomplete_muelles", parameters);
  }

  

  public static List<object> autocompleterestados(string query)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vQuery", OracleDbType.Varchar2, query, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.autocompleterestados", parameters);
  }

  public static List<object> autocomplete_barcazas(string etapa_id, string query)
  {
    var parameters = new OracleParameter[]
    { 
      new OracleParameter("vEtapaId", OracleDbType.Varchar2, etapa_id, System.Data.ParameterDirection.Input),
      new OracleParameter("vQuery", OracleDbType.Varchar2, query, System.Data.ParameterDirection.Input)
      
    };

    return doCall("mbpc.autocomplete_barcazas", parameters);
  }

  public static List<object> autocomplete_buques_disponibles(string query)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vQuery", OracleDbType.Varchar2, query, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.autocomplete_buques_disp", parameters);
  }


  public static List<object> autocompletem(string query)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vQuery", OracleDbType.Varchar2, query, System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.autocompleterm", parameters);
  }

  /// <summary>
  /// Nuevo metodo para obtener listado reportes
  /// </summary>
  /// <param name="functionName"></param>
  /// <param name="parameters"></param>
  /// <param name="arraybindcount"></param>
  /// <returns></returns>
  public static List<object> reporte_lista()
  {
    var parameters = new OracleParameter[0];

    return doCall("mbpc.reporte_lista", parameters);
  }

  public static List<object> reporte_obtener_parametros(int id)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vReporte", OracleDbType.Varchar2, id, System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.reporte_obtener_parametros", parameters);
  }

  public static List<object> reporte_obtener_parametros_str(string nombre)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vNombre", OracleDbType.Varchar2, nombre, System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.reporte_obtener_parametros_str", parameters);
  }

  public static object reporte_obtener(int id)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vReporte", OracleDbType.Varchar2, id, System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.reporte_obtener", parameters)[0];
  }

  public static object reporte_obtener_str(string nombre)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vReporte", OracleDbType.Varchar2, nombre, System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.reporte_obtener_str", parameters)[0];
  }

  public static List<object> reporte_obtener_html_builded()
  {
    var parameters = new OracleParameter[] 
    { 
    };

    return doCall("mbpc.reporte_obtener_html_builded", parameters);
  }

  public static List<object> reporte_insertar(string nombre, string descripcion, int categoria_id, string consulta_sql, string post_params) //FECHA_CREACION
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vNombre", OracleDbType.Varchar2, nombre, System.Data.ParameterDirection.Input),
        new OracleParameter("vDescripcion", OracleDbType.Varchar2, descripcion, System.Data.ParameterDirection.Input),
        new OracleParameter("vCategoriaId", OracleDbType.Varchar2, categoria_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vConsultaSql", OracleDbType.Varchar2, consulta_sql, System.Data.ParameterDirection.Input),
        new OracleParameter("vPostParams", OracleDbType.Varchar2, post_params, System.Data.ParameterDirection.Input),
        
    };

    return doCall("mbpc.reporte_insertar", parameters);
  }

  public static List<object> reporte_insertar_params(int[] reporte_id, int[] indice, string[] nombre, int[] tipo_dato)
  {
    OracleParameter[] parameters = new OracleParameter[] 
    { 
        new OracleParameter("vReporteId", OracleDbType.Varchar2, reporte_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vIndice", OracleDbType.Varchar2, indice, System.Data.ParameterDirection.Input),
        new OracleParameter("vNombre", OracleDbType.Varchar2, nombre, System.Data.ParameterDirection.Input),
        new OracleParameter("vTipoDato", OracleDbType.Varchar2, tipo_dato, System.Data.ParameterDirection.Input)
    };

    return doCall2("mbpc.reporte_insertar_params", parameters, reporte_id.Length);
  }

  public static List<object> reporte_eliminar(int reporte_id)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vReporteId", OracleDbType.Varchar2, reporte_id, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.reporte_eliminar", parameters);
  }

  public static List<object> reporte_eliminar_params(int reporte_id)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vReporteId", OracleDbType.Varchar2, reporte_id, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.reporte_eliminar_params", parameters);
  }

  public static List<object> reporte_actualizar(int reporte_id, string nombre, string descripcion, int categoria_id, string consulta_sql, string post_params) //FECHA_CREACION
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vReporteId", OracleDbType.Varchar2, reporte_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vNombre", OracleDbType.Varchar2, nombre, System.Data.ParameterDirection.Input),
        new OracleParameter("vDescripcion", OracleDbType.Varchar2, descripcion, System.Data.ParameterDirection.Input),
        new OracleParameter("vCategoriaId", OracleDbType.Varchar2, categoria_id, System.Data.ParameterDirection.Input),
        new OracleParameter("vConsultaSql", OracleDbType.Varchar2, consulta_sql, System.Data.ParameterDirection.Input),
        new OracleParameter("vPostParams", OracleDbType.Varchar2, post_params, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.reporte_actualizar", parameters);
  }

  public static List<object> reporte_metadata(int reporte_id)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vReporteId", OracleDbType.Varchar2, reporte_id, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.reporte_metadata", parameters);
  }

  public static List<object> pbip_nuevo(int? v_viaje_id ,string v_puertodematricula, string v_bandera, string v_nroinmarsat ,string v_arqueobruto 
    , string v_compania ,string v_contactoocpm ,string v_objetivo ,string v_nro_imo  ,string v_buque_nombre ,string v_tipo_buque  
    , string v_distintivo_llamada ,string v_nro_identif_compania ,string v_puerto_llegada ,string v_eta   ,string v_instalacion_portuaria
    , string v_cipb_estado ,string v_cipb_expedido_por ,string v_cipb_expiracion,
    string v_cipb_motivo_incumplimiento,int v_proteccion_plan_aprobado ,int v_proteccion_nivel_actual ,decimal? v_longitud_notif ,decimal? v_latitud_notif,
    int v_plan_proteccion_mant_bab ,string v_plan_prot_mant_bab_desc ,
    string v_carga_desc_gral   ,int v_carga_sust_peligrosas   ,string v_carga_sust_peligrosas_desc ,int v_lista_pasajeros,int v_lista_tripulantes,int v_prot_notifica_cuestion  ,
    int v_prot_notifica_polizon ,string v_prot_notifica_polizon_desc ,int v_prot_notifica_rescate,string v_prot_notifica_rescate_desc,int v_prot_notifica_otra,
    string v_prot_notifica_otra_desc ,
    string v_agente_pto_llegada_nombre,string v_agente_pto_llegada_tel  ,string v_agente_pto_llegada_mail ,string v_facilitador_nombre ,string v_facilitador_titulo_cargo ,
    string v_facilitador_lugar ,    string v_facilitador_fecha)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("v_viaje_id", OracleDbType.Varchar2,  "1" /*v_viaje_id*/, System.Data.ParameterDirection.Input),
        new OracleParameter("v_puertodematricula", OracleDbType.Varchar2,  v_puertodematricula , System.Data.ParameterDirection.Input),
        new OracleParameter("v_bandera", OracleDbType.Varchar2,  v_bandera , System.Data.ParameterDirection.Input),
        new OracleParameter("v_nroinmarsat", OracleDbType.Varchar2,  v_nroinmarsat , System.Data.ParameterDirection.Input),
        new OracleParameter("v_arqueobruto", OracleDbType.Varchar2,  v_arqueobruto , System.Data.ParameterDirection.Input),
        new OracleParameter("v_compania", OracleDbType.Varchar2,  v_compania , System.Data.ParameterDirection.Input),
        new OracleParameter("v_contactoocpm", OracleDbType.Varchar2,  v_contactoocpm , System.Data.ParameterDirection.Input),
        new OracleParameter("v_objetivo", OracleDbType.Varchar2,  v_objetivo , System.Data.ParameterDirection.Input),
        new OracleParameter("v_nro_imo", OracleDbType.Varchar2,  v_nro_imo  , System.Data.ParameterDirection.Input),
        new OracleParameter("v_buque_nombre", OracleDbType.Varchar2,  v_buque_nombre , System.Data.ParameterDirection.Input),
        new OracleParameter("v_tipo_buque", OracleDbType.Varchar2,  v_tipo_buque  , System.Data.ParameterDirection.Input),
        new OracleParameter("v_distintivo_llamada", OracleDbType.Varchar2,  v_distintivo_llamada , System.Data.ParameterDirection.Input),
        new OracleParameter("v_nro_identif_compania", OracleDbType.Varchar2,  v_nro_identif_compania , System.Data.ParameterDirection.Input),
        new OracleParameter("v_puerto_llegada", OracleDbType.Varchar2,  v_puerto_llegada , System.Data.ParameterDirection.Input),
        new OracleParameter("v_eta", OracleDbType.Varchar2,  v_eta   , System.Data.ParameterDirection.Input),
        new OracleParameter("v_instalacion_portuaria", OracleDbType.Varchar2,  v_instalacion_portuaria, System.Data.ParameterDirection.Input),
        new OracleParameter("v_cipb_estado", OracleDbType.Varchar2,  v_cipb_estado , System.Data.ParameterDirection.Input),
        new OracleParameter("v_cipb_expedido_por", OracleDbType.Varchar2,  v_cipb_expedido_por , System.Data.ParameterDirection.Input),
        new OracleParameter("v_cipb_expiracion", OracleDbType.Varchar2,  v_cipb_expiracion, System.Data.ParameterDirection.Input),
        new OracleParameter("v_cipb_motivo_incumplimiento", OracleDbType.Varchar2,  v_cipb_motivo_incumplimiento, System.Data.ParameterDirection.Input),
        new OracleParameter("v_proteccion_plan_aprobado", OracleDbType.Varchar2,  v_proteccion_plan_aprobado , System.Data.ParameterDirection.Input),
        new OracleParameter("v_proteccion_nivel_actual", OracleDbType.Varchar2,  v_proteccion_nivel_actual , System.Data.ParameterDirection.Input),
        new OracleParameter("v_longitud_notif", OracleDbType.Decimal, v_longitud_notif, System.Data.ParameterDirection.Input),
        new OracleParameter("v_latitud_notif", OracleDbType.Decimal,  v_latitud_notif, System.Data.ParameterDirection.Input),
        new OracleParameter("v_plan_proteccion_mant_bab", OracleDbType.Varchar2,  v_plan_proteccion_mant_bab , System.Data.ParameterDirection.Input),
        new OracleParameter("v_plan_prot_mant_bab_desc", OracleDbType.Varchar2,  v_plan_prot_mant_bab_desc , System.Data.ParameterDirection.Input),
        new OracleParameter("v_carga_desc_gral", OracleDbType.Varchar2,  v_carga_desc_gral   , System.Data.ParameterDirection.Input),
        new OracleParameter("v_carga_sust_peligrosas", OracleDbType.Varchar2,  v_carga_sust_peligrosas   , System.Data.ParameterDirection.Input),
        new OracleParameter("v_carga_sust_peligrosas_desc", OracleDbType.Varchar2,  v_carga_sust_peligrosas_desc , System.Data.ParameterDirection.Input),
        new OracleParameter("v_lista_pasajeros", OracleDbType.Varchar2,  v_lista_pasajeros, System.Data.ParameterDirection.Input),
        new OracleParameter("v_lista_tripulantes", OracleDbType.Varchar2,  v_lista_tripulantes, System.Data.ParameterDirection.Input),
        new OracleParameter("v_prot_notifica_cuestion", OracleDbType.Varchar2,  v_prot_notifica_cuestion  , System.Data.ParameterDirection.Input),
        new OracleParameter("v_prot_notifica_polizon", OracleDbType.Varchar2,  v_prot_notifica_polizon , System.Data.ParameterDirection.Input),
        new OracleParameter("v_prot_notifica_polizon_desc", OracleDbType.Varchar2,  v_prot_notifica_polizon_desc , System.Data.ParameterDirection.Input),
        new OracleParameter("v_prot_notifica_rescate", OracleDbType.Varchar2,  v_prot_notifica_rescate, System.Data.ParameterDirection.Input),
        new OracleParameter("v_prot_notifica_rescate_desc", OracleDbType.Varchar2,  v_prot_notifica_rescate_desc, System.Data.ParameterDirection.Input),
        new OracleParameter("v_prot_notifica_otra", OracleDbType.Varchar2,  v_prot_notifica_otra, System.Data.ParameterDirection.Input),
        new OracleParameter("v_prot_notifica_otra_desc", OracleDbType.Varchar2,  v_prot_notifica_otra_desc , System.Data.ParameterDirection.Input),
        new OracleParameter("v_agente_pto_llegada_nombre", OracleDbType.Varchar2,  v_agente_pto_llegada_nombre, System.Data.ParameterDirection.Input),
        new OracleParameter("v_agente_pto_llegada_tel", OracleDbType.Varchar2,  v_agente_pto_llegada_tel  , System.Data.ParameterDirection.Input),
        new OracleParameter("v_agente_pto_llegada_mail", OracleDbType.Varchar2,  v_agente_pto_llegada_mail , System.Data.ParameterDirection.Input),
        new OracleParameter("v_facilitador_nombre", OracleDbType.Varchar2,  v_facilitador_nombre , System.Data.ParameterDirection.Input),
        new OracleParameter("v_facilitador_titulo_cargo", OracleDbType.Varchar2,  v_facilitador_titulo_cargo , System.Data.ParameterDirection.Input),
        new OracleParameter("v_facilitador_lugar", OracleDbType.Varchar2,  v_facilitador_lugar , System.Data.ParameterDirection.Input),
        new OracleParameter("v_facilitador_fecha", OracleDbType.Varchar2,  v_facilitador_fecha , System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.pbip_nuevo", parameters);
  }

  public static List<object> pbip_modificar(int v_id, int? v_viaje_id, string v_puertodematricula, string v_bandera, string v_nroinmarsat, string v_arqueobruto, string v_compania, string v_contactoocpm, string v_objetivo, string v_nro_imo, string v_buque_nombre, string v_tipo_buque, string v_distintivo_llamada, string v_nro_identif_compania, string v_puerto_llegada, string v_eta, string v_instalacion_portuaria, string v_cipb_estado, string v_cipb_expedido_por, string v_cipb_expiracion,
    string v_cipb_motivo_incumplimiento,int v_proteccion_plan_aprobado ,int v_proteccion_nivel_actual ,decimal? v_longitud_notif ,decimal? v_latitud_notif,int v_plan_proteccion_mant_bab ,string v_plan_prot_mant_bab_desc ,
    string v_carga_desc_gral   ,int v_carga_sust_peligrosas   ,string v_carga_sust_peligrosas_desc ,int v_lista_pasajeros,int v_lista_tripulantes,int v_prot_notifica_cuestion  ,int v_prot_notifica_polizon ,string v_prot_notifica_polizon_desc ,int v_prot_notifica_rescate,string v_prot_notifica_rescate_desc,int v_prot_notifica_otra,string v_prot_notifica_otra_desc ,
    string v_agente_pto_llegada_nombre,string v_agente_pto_llegada_tel  ,string v_agente_pto_llegada_mail ,string v_facilitador_nombre ,string v_facilitador_titulo_cargo ,string v_facilitador_lugar ,
    string v_facilitador_fecha)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("v_id", OracleDbType.Varchar2,  v_id, System.Data.ParameterDirection.Input),
        new OracleParameter("v_viaje_id", OracleDbType.Varchar2,  v_viaje_id, System.Data.ParameterDirection.Input),
        new OracleParameter("v_puertodematricula", OracleDbType.Varchar2,  v_puertodematricula , System.Data.ParameterDirection.Input),
        new OracleParameter("v_bandera", OracleDbType.Varchar2,  v_bandera , System.Data.ParameterDirection.Input),
        new OracleParameter("v_nroinmarsat", OracleDbType.Varchar2,  v_nroinmarsat , System.Data.ParameterDirection.Input),
        new OracleParameter("v_arqueobruto", OracleDbType.Varchar2,  v_arqueobruto , System.Data.ParameterDirection.Input),
        new OracleParameter("v_compania", OracleDbType.Varchar2,  v_compania , System.Data.ParameterDirection.Input),
        new OracleParameter("v_contactoocpm", OracleDbType.Varchar2,  v_contactoocpm , System.Data.ParameterDirection.Input),
        new OracleParameter("v_objetivo", OracleDbType.Varchar2,  v_objetivo , System.Data.ParameterDirection.Input),
        new OracleParameter("v_nro_imo", OracleDbType.Varchar2,  v_nro_imo  , System.Data.ParameterDirection.Input),
        new OracleParameter("v_buque_nombre", OracleDbType.Varchar2,  v_buque_nombre , System.Data.ParameterDirection.Input),
        new OracleParameter("v_tipo_buque", OracleDbType.Varchar2,  v_tipo_buque  , System.Data.ParameterDirection.Input),
        new OracleParameter("v_distintivo_llamada", OracleDbType.Varchar2,  v_distintivo_llamada , System.Data.ParameterDirection.Input),
        new OracleParameter("v_nro_identif_compania", OracleDbType.Varchar2,  v_nro_identif_compania , System.Data.ParameterDirection.Input),
        new OracleParameter("v_puerto_llegada", OracleDbType.Varchar2,  v_puerto_llegada , System.Data.ParameterDirection.Input),
        new OracleParameter("v_eta", OracleDbType.Varchar2,  v_eta   , System.Data.ParameterDirection.Input),
        new OracleParameter("v_instalacion_portuaria", OracleDbType.Varchar2,  v_instalacion_portuaria, System.Data.ParameterDirection.Input),
        new OracleParameter("v_cipb_estado", OracleDbType.Varchar2,  v_cipb_estado , System.Data.ParameterDirection.Input),
        new OracleParameter("v_cipb_expedido_por", OracleDbType.Varchar2,  v_cipb_expedido_por , System.Data.ParameterDirection.Input),
        new OracleParameter("v_cipb_expiracion", OracleDbType.Varchar2,  v_cipb_expiracion, System.Data.ParameterDirection.Input),
        new OracleParameter("v_cipb_motivo_incumplimiento", OracleDbType.Varchar2,  v_cipb_motivo_incumplimiento, System.Data.ParameterDirection.Input),
        new OracleParameter("v_proteccion_plan_aprobado", OracleDbType.Varchar2,  v_proteccion_plan_aprobado , System.Data.ParameterDirection.Input),
        new OracleParameter("v_proteccion_nivel_actual", OracleDbType.Varchar2,  v_proteccion_nivel_actual , System.Data.ParameterDirection.Input),
        new OracleParameter("v_longitud_notif", OracleDbType.Decimal,  v_longitud_notif , System.Data.ParameterDirection.Input),
        new OracleParameter("v_latitud_notif", OracleDbType.Decimal,  v_latitud_notif, System.Data.ParameterDirection.Input),
        new OracleParameter("v_plan_proteccion_mant_bab", OracleDbType.Varchar2,  v_plan_proteccion_mant_bab , System.Data.ParameterDirection.Input),
        new OracleParameter("v_plan_prot_mant_bab_desc", OracleDbType.Varchar2,  v_plan_prot_mant_bab_desc , System.Data.ParameterDirection.Input),
        new OracleParameter("v_carga_desc_gral", OracleDbType.Varchar2,  v_carga_desc_gral   , System.Data.ParameterDirection.Input),
        new OracleParameter("v_carga_sust_peligrosas", OracleDbType.Varchar2,  v_carga_sust_peligrosas   , System.Data.ParameterDirection.Input),
        new OracleParameter("v_carga_sust_peligrosas_desc", OracleDbType.Varchar2,  v_carga_sust_peligrosas_desc , System.Data.ParameterDirection.Input),
        new OracleParameter("v_lista_pasajeros", OracleDbType.Varchar2,  v_lista_pasajeros, System.Data.ParameterDirection.Input),
        new OracleParameter("v_lista_tripulantes", OracleDbType.Varchar2,  v_lista_tripulantes, System.Data.ParameterDirection.Input),
        new OracleParameter("v_prot_notifica_cuestion", OracleDbType.Varchar2,  v_prot_notifica_cuestion  , System.Data.ParameterDirection.Input),
        new OracleParameter("v_prot_notifica_polizon", OracleDbType.Varchar2,  v_prot_notifica_polizon , System.Data.ParameterDirection.Input),
        new OracleParameter("v_prot_notifica_polizon_desc", OracleDbType.Varchar2,  v_prot_notifica_polizon_desc , System.Data.ParameterDirection.Input),
        new OracleParameter("v_prot_notifica_rescate", OracleDbType.Varchar2,  v_prot_notifica_rescate, System.Data.ParameterDirection.Input),
        new OracleParameter("v_prot_notifica_rescate_desc", OracleDbType.Varchar2,  v_prot_notifica_rescate_desc, System.Data.ParameterDirection.Input),
        new OracleParameter("v_prot_notifica_otra", OracleDbType.Varchar2,  v_prot_notifica_otra, System.Data.ParameterDirection.Input),
        new OracleParameter("v_prot_notifica_otra_desc", OracleDbType.Varchar2,  v_prot_notifica_otra_desc , System.Data.ParameterDirection.Input),
        new OracleParameter("v_agente_pto_llegada_nombre", OracleDbType.Varchar2,  v_agente_pto_llegada_nombre, System.Data.ParameterDirection.Input),
        new OracleParameter("v_agente_pto_llegada_tel", OracleDbType.Varchar2,  v_agente_pto_llegada_tel  , System.Data.ParameterDirection.Input),
        new OracleParameter("v_agente_pto_llegada_mail", OracleDbType.Varchar2,  v_agente_pto_llegada_mail , System.Data.ParameterDirection.Input),
        new OracleParameter("v_facilitador_nombre", OracleDbType.Varchar2,  v_facilitador_nombre , System.Data.ParameterDirection.Input),
        new OracleParameter("v_facilitador_titulo_cargo", OracleDbType.Varchar2,  v_facilitador_titulo_cargo , System.Data.ParameterDirection.Input),
        new OracleParameter("v_facilitador_lugar", OracleDbType.Varchar2,  v_facilitador_lugar , System.Data.ParameterDirection.Input),
        new OracleParameter("v_facilitador_fecha", OracleDbType.Varchar2,  v_facilitador_fecha , System.Data.ParameterDirection.Input),
    };

    return doCall("mbpc.pbip_modificar", parameters);
  }

  public static List<object> pbip_nuevo_param(int[] v_tbl_pbip_id, int[] v_tipo_param, int[] v_indice, string[] v_fecha_desde,
    string[] v_fecha_hasta, string[] v_descripcion, int[] v_nivel_proteccion, int[] v_escalas_medidas_adic, string[] v_escalas_medidas_adic_desc
    , string[] v_actividad_bab) 
  {
    OracleParameter[] parameters = new OracleParameter[] 
    { 
        new OracleParameter("v_tbl_pbip_id", OracleDbType.Varchar2,  v_tbl_pbip_id, System.Data.ParameterDirection.Input),
        new OracleParameter("v_tipo_param", OracleDbType.Varchar2,  v_tipo_param, System.Data.ParameterDirection.Input),
        new OracleParameter("v_indice", OracleDbType.Varchar2,  v_indice, System.Data.ParameterDirection.Input),
        new OracleParameter("v_fecha_desde", OracleDbType.Varchar2,  v_fecha_desde, System.Data.ParameterDirection.Input),
        new OracleParameter("v_fecha_hasta", OracleDbType.Varchar2,  v_fecha_hasta, System.Data.ParameterDirection.Input),
        new OracleParameter("v_descripcion", OracleDbType.Varchar2,  v_descripcion, System.Data.ParameterDirection.Input),
        new OracleParameter("v_nivel_proteccion", OracleDbType.Varchar2,  v_nivel_proteccion, System.Data.ParameterDirection.Input),
        new OracleParameter("v_escalas_medidas_adic", OracleDbType.Varchar2,  v_escalas_medidas_adic, System.Data.ParameterDirection.Input),
        new OracleParameter("v_escalas_medidas_adic_desc", OracleDbType.Varchar2,  v_escalas_medidas_adic_desc , System.Data.ParameterDirection.Input),
        new OracleParameter("v_actividad_bab", OracleDbType.Varchar2,  v_actividad_bab , System.Data.ParameterDirection.Input)
    };

    return doCall2("mbpc.pbip_nuevo_param", parameters, v_tbl_pbip_id.Length);
  }

  public static List<object> pbip_eliminar(int v_tbl_pbip_id)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("v_tbl_pbip_id", OracleDbType.Varchar2, v_tbl_pbip_id, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.pbip_eliminar", parameters);
  }

  public static List<object> pbip_eliminar_params(int v_tbl_pbip_id)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("v_tbl_pbip_id", OracleDbType.Varchar2, v_tbl_pbip_id, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.pbip_eliminar_params", parameters);
  }

  public static object pbip_obtener(int v_pbp_id )
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("v_id", OracleDbType.Varchar2, v_pbp_id, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.pbip_obtener", parameters)[0];
  }

  public static List<object> pbip_obtener_params(int v_pbp_id)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("v_id", OracleDbType.Varchar2, v_pbp_id, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.pbip_obtener_params", parameters);
  }

  public static List<object> obtener_opciones_malvinas(int va_a_malvinas)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("v_va_a_malvinas", OracleDbType.Varchar2, va_a_malvinas, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.obtener_opciones_malvinas", parameters);
  }

  public static List<object> barcos_similares(string nombre)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vNombre", OracleDbType.Varchar2, nombre, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.barcos_similares", parameters);
  }

  public static List<object> obtener_reportes_para_usuario(string usuario)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vUsuario", OracleDbType.Varchar2, usuario, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.obtener_reportes_para_usuario", parameters);
  }

  public static List<object> login_usuario_ext(string usuario, string password)
  {
    var parameters = new OracleParameter[] 
    { 
        new OracleParameter("vUsuario", OracleDbType.Varchar2, usuario, System.Data.ParameterDirection.Input),
        new OracleParameter("vPassword", OracleDbType.Varchar2, password, System.Data.ParameterDirection.Input)
    };

    return doCall("mbpc.login_usuario_ext", parameters);
  }

  

  private static List<object> doCall2(string functionName, OracleParameter[] parameters, int arraybindcount)
  {
    if (System.Configuration.ConfigurationManager.AppSettings["dev_server"] == "true")
      functionName = "dev_" + functionName;

    var profiler = MiniProfiler.Current;
    using(profiler.Step(string.Format("SQL2:{0}", functionName)))
    {
      string constr = ConfigurationManager.ConnectionStrings["default"].ConnectionString;
      List<object> retVal = new List<object>();
    
      using (OracleConnection con = new OracleConnection(constr))
      {
        using(profiler.Step("Connect"))
        {
          con.Open();
        }
        OracleDataReader reader = null;
        OracleCommand cmd = null;
        
        using(profiler.Step("Execute"))
        {

          cmd = new OracleCommand();

          cmd.Connection = con;
          cmd.CommandText = functionName;
          cmd.CommandType = CommandType.StoredProcedure;
          foreach (OracleParameter param in parameters)
          {
            cmd.Parameters.Add(param);
          }
      
          var userids = new List<string>();
          for(int i=0; i<arraybindcount; i++)
            userids.Add(DaoLib.userid.ToString());

          cmd.Parameters.Add("usrid", OracleDbType.Decimal, userids.ToArray(), System.Data.ParameterDirection.Input);

          cmd.ArrayBindCount = arraybindcount;

          reader = cmd.ExecuteReader();
        }
        
        using (profiler.Step("Read"))
        {
          while (reader.Read())
          {
            Dictionary<string, string> vv = new Dictionary<string, string>();
            for (int i = 0; i < reader.FieldCount; i++)
            {
              vv[reader.GetName(i).ToString()] = reader.GetValue(i).ToString();
            }
            retVal.Add(vv);
          }
        }

        using (profiler.Step("Disconnect"))
        {
          cmd.Dispose();
          con.Close();
        }
      }

      return retVal;
    }
  }
  private static List<object> doCall(string functionName, OracleParameter[] parameters)
  {
    return doCall(functionName, parameters, null);
  }

  private static List<object> doCall(string functionName, OracleParameter[] parameters, MiniProfiler p)
  {
    if (System.Configuration.ConfigurationManager.AppSettings["dev_server"] == "true")
      functionName = "dev_" + functionName;

    var profiler = p != null ? p : MiniProfiler.Current;
    using (profiler.Step(string.Format("SQL:{0}",functionName)))
    {
      string constr = ConfigurationManager.ConnectionStrings["default"].ConnectionString;
      List<object> retVal = new List<object>();

      using (OracleConnection con = new OracleConnection(constr))
      {
        using (profiler.Step("Connect"))
        {
          con.Open();
        }

        OracleDataReader reader = null;
        OracleCommand cmd = null;

        using (profiler.Step("Execute"))
        {
          cmd = new OracleCommand();

          cmd.Connection = con;
          cmd.CommandText = functionName;
          cmd.CommandType = CommandType.StoredProcedure;
          foreach (OracleParameter param in parameters)
          {
            cmd.Parameters.Add(param);
          }

          cmd.Parameters.Add("usrid", OracleDbType.Decimal, userid, System.Data.ParameterDirection.Input);
          cmd.Parameters.Add("vCursor", OracleDbType.RefCursor, DBNull.Value, System.Data.ParameterDirection.Output);

          reader = cmd.ExecuteReader();
        }

        using (profiler.Step("Read"))
        {
          while (reader.Read())
          {
            Dictionary<string, string> vv = new Dictionary<string, string>();
            for (int i = 0; i < reader.FieldCount; i++)
            {
              var typetemp = reader.GetFieldType(i);

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
        }

        using (profiler.Step("Disconnect"))
        {
          cmd.Dispose();
          con.Close();
        }
      }

      return retVal;
    }
  }

  public static List<object> doSQL(OracleCommand cmd)
  {
    var profiler = MiniProfiler.Current; // it's ok if this is null
    using (profiler.Step("rawSQL"))
    {
      string constr = ConfigurationManager.ConnectionStrings["default"].ConnectionString;
      List<object> retVal = new List<object>();

      using (OracleConnection con = new OracleConnection(constr))
      {
        using (profiler.Step("Connect"))
        {
          con.Open();
        }

        OracleDataReader reader = null;
        
        using (profiler.Step("Execute"))
        {
          cmd.Connection = con;
          cmd.Prepare();
          reader = cmd.ExecuteReader();
        }

        using (profiler.Step("Read"))
        {
          while (reader.Read())
          {
            Dictionary<string, string> vv = new Dictionary<string, string>();
            for (int i = 0; i < reader.FieldCount; i++)
            {
              var typetemp = reader.GetFieldType(i);
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
        }
        
        using (profiler.Step("Disconnect"))
        {
          cmd.Dispose();
          con.Close();
        }
      }

      return retVal;
    }
  }


}