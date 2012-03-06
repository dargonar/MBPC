using System;
using System.Text;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Globalization;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;


namespace mbpc.Controllers
{
    public class ViajeController : MyController
    {
      public ActionResult practicos(string id)
      {

        ViewData["etapa_id"] = id;
        ViewData["results"] = DaoLib.traer_practicos(id);
        return View("practicos");
      }

      public ActionResult nuevo_practico(string etapa_id)
      {
        ViewData["etapa_id"] = etapa_id;
        return View();
      }

      public ActionResult agregar_practico(string etapa_id, string practico_id, string fecha_subida)
      {
        DaoLib.agregar_practico(etapa_id, practico_id, fecha_subida);
        return practicos(etapa_id);
      }

      public ActionResult bajar_practico(string practico_id, string etapa_id, string fecha)
      {
        DaoLib.bajar_practico(etapa_id, practico_id, fecha);
        return practicos(etapa_id);
      }

      public ActionResult activar_practico(string practico_id, string etapa_id, string fecha)
      {
        DaoLib.activar_practico(etapa_id, practico_id, fecha);
        return practicos(etapa_id);
      }

      public ActionResult bajar_practico_fecha(string etapa_id, string practico_id)
      {
        ViewData["action"] = "bajar_practico_fecha";
        ViewData["etapa_id"] = etapa_id;
        ViewData["practico_id"] = practico_id;
        return View("practico_fecha");
      }

      public ActionResult activar_practico_fecha(string etapa_id, string practico_id)
      {
        ViewData["action"] = "activar_practico_fecha";
        ViewData["etapa_id"] = etapa_id;
        ViewData["practico_id"] = practico_id;
        return View("practico_fecha");
      }

      public ActionResult borrar_evento(string etapa_id, string id)
      {
        DaoLib.eliminar_evento(id, etapa_id);
        ViewData["refresh_viajes"] = "1";
        return histRVP(etapa_id);
      }

        public ActionResult histRVP(string etapa_id)
        {
          ViewData["historial"] = DaoLib.hist_rvp(etapa_id);
          ViewData["eventos"] = DaoLib.hist_evt(etapa_id);
          ViewData["etapa_id"]  = etapa_id;
          return View("histRVP");
        }

        public ActionResult cambiarEstado(string id)
        {
            var now = DateTime.Now;
            ViewData["fecha"] = now.ToString("dd-MM-yy HH:mm");
            ViewData["etapa_id"] = id;
            //ViewData["eventos"] = DaoLib.eventos_usuario();
            return View();
        }

        public ActionResult insertarEventoCambioEstado(string etapa_id, string notas, string pos, string fecha, string estado, string riocanal, string muelle)
        {
            decimal?[] latlon = new decimal?[2];
            if (pos != "")
            {
              latlon = DaoLib.parsePos(pos);
            }
            DaoLib.insertar_cambioestado(etapa_id, notas, latlon[0], latlon[1], fecha, estado, riocanal, muelle);

            ViewData["barcos_en_zona"] = DaoLib.barcos_en_zona(Session["zona"].ToString());
            ViewData["barcos_salientes"] = DaoLib.barcos_salientes(Session["zona"].ToString());
            ViewData["barcos_entrantes"] = DaoLib.barcos_entrantes(Session["zona"].ToString());
            ViewData["barcazas_en_zona"] = DaoLib.barcazas_en_zona(Session["zona"].ToString());
            return View("columnas");
        }

        public ActionResult Acompanantes(string id)
        {
          var acomps = ((Dictionary<string, string>)DaoLib.traer_acompanantes(id)[0]);

          ViewData["ACOMPANANTE_ID"] = acomps["ACOMPANANTE_ID"];
          ViewData["ACOMPANANTE2_ID"] = acomps["ACOMPANANTE2_ID"];
          ViewData["ACOMPANANTE3_ID"] = acomps["ACOMPANANTE3_ID"];
          ViewData["ACOMPANANTE4_ID"] = acomps["ACOMPANANTE4_ID"];

          ViewData["NOMBRE"] = acomps["NOMBRE"];
          ViewData["NOMBRE2"] = acomps["NOMBRE2"];
          ViewData["NOMBRE3"] = acomps["NOMBRE3"];
          ViewData["NOMBRE4"] = acomps["NOMBRE4"];

          ViewData["etapa_id"] = id;
          return View();
        }

        public ActionResult editarAcompanantes(string etapa_id, string buque_id, string buque2_id, string buque3_id, string buque4_id)
        {

          DaoLib.editar_acompanante(etapa_id, buque_id, buque2_id, buque3_id, buque4_id);

          ViewData["barcos_en_zona"] = DaoLib.barcos_en_zona(Session["zona"].ToString());
          ViewData["barcos_salientes"] = DaoLib.barcos_salientes(Session["zona"].ToString());
          ViewData["barcos_entrantes"] = DaoLib.barcos_entrantes(Session["zona"].ToString());
          ViewData["barcazas_en_zona"] = DaoLib.barcazas_en_zona(Session["zona"].ToString());

          return View("columnas");
        }


        public ActionResult quitarAcompanante(string id)
        {
          DaoLib.quitar_acompanante(id);

          ViewData["barcos_en_zona"] = DaoLib.barcos_en_zona(Session["zona"].ToString());
          ViewData["barcos_salientes"] = DaoLib.barcos_salientes(Session["zona"].ToString());
          ViewData["barcos_entrantes"] = DaoLib.barcos_entrantes(Session["zona"].ToString());
          ViewData["barcazas_en_zona"] = DaoLib.barcazas_en_zona(Session["zona"].ToString());

          return View("columnas");
        }

        public ActionResult indicarProximo(string viaje_id, string id2)
        {
          DaoLib.indicar_proximo(viaje_id, id2);
          
          ViewData["barcos_en_zona"] = DaoLib.barcos_en_zona(Session["zona"].ToString());
          ViewData["barcos_salientes"] = DaoLib.barcos_salientes(Session["zona"].ToString());
          ViewData["barcos_entrantes"] = DaoLib.barcos_entrantes(Session["zona"].ToString());
          ViewData["barcazas_en_zona"] = DaoLib.barcazas_en_zona(Session["zona"].ToString());

          return View("columnas");
        }

        public ActionResult pasarBarco(string viaje_id, string id2, string eta, string fecha, string velocidad, string rumbo)
        {
          DaoLib.pasar_barco(viaje_id, id2, eta, fecha, velocidad, rumbo);

          ViewData["barcos_en_zona"] = DaoLib.barcos_en_zona(Session["zona"].ToString());
          ViewData["barcos_salientes"] = DaoLib.barcos_salientes(Session["zona"].ToString());
          ViewData["barcos_entrantes"] = DaoLib.barcos_entrantes(Session["zona"].ToString());
          ViewData["barcazas_en_zona"] = DaoLib.barcazas_en_zona(Session["zona"].ToString());

          return View("columnas");
        }

        public ActionResult nuevo()
        {
          ViewData["zonas"] = DaoLib.zonas_adyacentes(Session["zona"].ToString());
          return View();
        }

        public ActionResult agregarReporte()
        {
          var now = DateTime.Now;
          ViewData["fecha"] = now.ToString("dd-MM-yy");
          return View();
        }

        public ActionResult insertarReporte(string viaje_id, string pos, string rumbo, string velocidad, string estado, string fecha)
        {
            var latlon = DaoLib.parsePos(pos);
            //DaoLib.insertar_posicion(viaje_id, lat.Replace('.',','), lon.Replace('.',','));
            DaoLib.insertar_reporte(viaje_id, latlon[0], latlon[1], velocidad, rumbo, estado, fecha);
            ViewData["barcos_en_zona"] = DaoLib.barcos_en_zona(Session["zona"].ToString());
            ViewData["barcos_salientes"] = DaoLib.barcos_salientes(Session["zona"].ToString());
            ViewData["barcos_entrantes"] = DaoLib.barcos_entrantes(Session["zona"].ToString());
            ViewData["barcazas_en_zona"] = DaoLib.barcazas_en_zona(Session["zona"].ToString());

            return View("columnas");
        }


        public ActionResult crear(string buque_id, string desde_id, string hasta_id, string partida, string eta, string zoe, string proximo_punto, string internacional, string pos, string riocanal)
        {
          //decimal[] latlon = new decimal[2];
          decimal?[] latlon = new decimal?[2];
          if (pos != "")
          {
            latlon = DaoLib.parsePos(pos);
          }
          List<object> autoeditaretapa = DaoLib.crear_viaje(buque_id, desde_id, hasta_id, partida, eta, zoe, Session["zona"].ToString(), proximo_punto, internacional, latlon[0], latlon[1], riocanal);
          ViewData["AutoEditarEtapa"] = autoeditaretapa;

          ViewData["barcos_en_zona"] = DaoLib.barcos_en_zona(Session["zona"].ToString());
          ViewData["barcos_salientes"] = DaoLib.barcos_salientes(Session["zona"].ToString());
          ViewData["barcos_entrantes"] = DaoLib.barcos_entrantes(Session["zona"].ToString());
          ViewData["barcazas_en_zona"] = DaoLib.barcazas_en_zona(Session["zona"].ToString());

          return View("columnas");
        }

        public ActionResult editar(string id)
        {
          ViewData["zonas"] = DaoLib.zonas_adyacentes(Session["zona"].ToString());
          ViewData["viajedata"] = DaoLib.traer_viaje(id);

          return View();
        }

        public ActionResult modificar(string viaje_id, string buque_id, string desde_id, string hasta_id, string partida, string eta, string zoe, string proximo_punto, string internacional, string pos, string riocanal, string rumbo, string velocidad)
        {
            decimal?[] latlon = {null, null};
            if (pos != "")
            {
              latlon = DaoLib.parsePos(pos);
            }

            DaoLib.editar_viaje(viaje_id, buque_id, desde_id, hasta_id, partida, eta, zoe, Session["zona"].ToString(), proximo_punto, internacional, latlon[0], latlon[1], riocanal);

            ViewData["barcos_en_zona"] = DaoLib.barcos_en_zona(Session["zona"].ToString());
            ViewData["barcos_salientes"] = DaoLib.barcos_salientes(Session["zona"].ToString());
            ViewData["barcos_entrantes"] = DaoLib.barcos_entrantes(Session["zona"].ToString());
            ViewData["barcazas_en_zona"] = DaoLib.barcazas_en_zona(Session["zona"].ToString());

            return View("columnas");
        }


        public ActionResult preguntarFecha(string viaje_id, string id2)
        {
          var now = DateTime.Now;
          ViewData["fecha"] = now.ToString("dd-MM-yy HH:mm");
          // aksdfklasjd;flkadf para que toda la estructura quede mas o menos igual
          List<object> etapa_id_list = DaoLib.id_ultima_etapa(viaje_id);
          Dictionary<string, string> etapa_id = etapa_id_list[0] as Dictionary<string, string>;
          ViewData["etapa_id"] = etapa_id["ID"];
          ViewData["viaje_id"] = viaje_id;
          ViewData["action"] = id2;
          return View();
        }

        public ActionResult terminar(string viaje_id, string fecha, string escalas)
        {
          DaoLib.terminar_viaje(viaje_id, fecha, escalas);

          ViewData["barcos_en_zona"] = DaoLib.barcos_en_zona(Session["zona"].ToString());
          ViewData["barcos_salientes"] = DaoLib.barcos_salientes(Session["zona"].ToString());
          ViewData["barcos_entrantes"] = DaoLib.barcos_entrantes(Session["zona"].ToString());
          ViewData["barcazas_en_zona"] = DaoLib.barcazas_en_zona(Session["zona"].ToString());

          return View("columnas");
        }

        public ActionResult terminados()
        {
          ViewData["viajes"] = DaoLib.viajes_terminados(Session["zona"].ToString());
          return View();
        }

        public ActionResult reactivar(string id)
        {
          DaoLib.reactivar_viaje(id);

          ViewData["barcos_en_zona"] = DaoLib.barcos_en_zona(Session["zona"].ToString());
          ViewData["barcos_salientes"] = DaoLib.barcos_salientes(Session["zona"].ToString());
          ViewData["barcos_entrantes"] = DaoLib.barcos_entrantes(Session["zona"].ToString());
          ViewData["barcazas_en_zona"] = DaoLib.barcazas_en_zona(Session["zona"].ToString());

          return View("columnas");
        }

        public ActionResult editarEtapa(string viaje_id, string id2)
        {
          ViewData["zonas"] = DaoLib.zonas_adyacentes(Session["zona"].ToString());
          ViewData["viajedata"] = DaoLib.traer_viaje(viaje_id);

          ViewData["etapa"] = DaoLib.traer_etapa(viaje_id);
          ViewData["viaje_id"] = viaje_id;

          string pto_control_id = ((ViewData["etapa"] as List<object>)[0] as Dictionary<string, string>)["DESTINO_ID"];
          //ViewData["DESTINO_ID"] = pto_control_id; 

          if (!String.IsNullOrEmpty(pto_control_id))
          {
            var data = DaoLib.descripcion_punto_control(pto_control_id);
            ViewData["punto_control_desc"] = (data[0] as Dictionary<string, string>)["DESCRIPCION"];
          }
          else
          {
            ViewData["punto_control_desc"] = "N/D";
          }

          return View();
        }

        public ActionResult modificarEtapa(string etapa_id, string calado_proa, string calado_popa, string calado_informado, string hrp, string eta, string fecha_salida, string cantidad_tripulantes, string cantidad_pasajeros, string activo, string practico0, string practico1, string practico2, string capitan_id, string velocidad, string rumbo, string latitud, string longitud)
        {
          if (calado_proa != null && (calado_proa == "" || calado_proa.LastIndexOf("_") != -1) ) calado_proa = null;
          if (calado_popa != null && (calado_popa == "" || calado_popa.LastIndexOf("_") != -1)) calado_popa = null;
          if (calado_informado != null && (calado_informado == "" || calado_informado.LastIndexOf("_") != -1)) calado_informado = null;

          DaoLib.editar_etapa(etapa_id, calado_proa, calado_popa, calado_informado, hrp, eta, fecha_salida, cantidad_tripulantes, cantidad_pasajeros, capitan_id, rumbo, velocidad);

          ViewData["barcos_en_zona"] = DaoLib.barcos_en_zona(Session["zona"].ToString());
          ViewData["barcos_salientes"] = DaoLib.barcos_salientes(Session["zona"].ToString());
          ViewData["barcos_entrantes"] = DaoLib.barcos_entrantes(Session["zona"].ToString());
          ViewData["barcazas_en_zona"] = DaoLib.barcazas_en_zona(Session["zona"].ToString());

          return View("columnas");
        }

        public ActionResult editarPbip(string id)
        {
          ViewData["viaje_id"] = id;
          ViewData["pbip"] = DaoLib.traer_pbip(id);
          return View();
        }

        public ActionResult editarNotas(string id)
        {
          ViewData["NOTAS"] = DaoLib.traer_notas(id);
          ViewData["VIAJE"] = id;
          return View();
        }

        public ActionResult guardarNotas(string id, string notas)
        {
          DaoLib.guardar_notas(id, notas);

          ViewData["barcos_en_zona"] = DaoLib.barcos_en_zona(Session["zona"].ToString());
          ViewData["barcos_salientes"] = DaoLib.barcos_salientes(Session["zona"].ToString());
          ViewData["barcos_entrantes"] = DaoLib.barcos_entrantes(Session["zona"].ToString());
          ViewData["barcazas_en_zona"] = DaoLib.barcazas_en_zona(Session["zona"].ToString());

          return View("columnas");
        }

        public ActionResult modificarPBIP(string puertodematricula, string numeroinmarsat, string arqueobruto,  string compania,  string contactoOCPM, string objetivo, string viaje )
        {
          ViewData["pbip"] = DaoLib.modificar_pbip(puertodematricula, numeroinmarsat, arqueobruto, compania, contactoOCPM, objetivo, viaje);
          return View();
        }

        /*
        public ActionResult ListJSON(string sidx, string sord, int page, int rows)
        {
          //i:integer
          //s:string
          //f:float
          //d:date
          /*
          var columns = new string[] { "i|v.ID", 
                                       "s|b.NOMBRE", 
                                       "s|b.NRO_OMI", 
                                       "s|b.MATRICULA", 
                                       "s|b.SDIST",
                                       "s|b.BANDERA",
                                       "f|v.LATITUD", 
                                       "f|v.LONGITUD", 
                                       "s|e.ORIGEN_ID", 
                                       "s|e.DESTINO_ID", 
                                       "s|ST.ESTADO", 
                                       "i|TRUNC(SYSDATE-v.updated_at,2)|ULTIMO" };
          var sqlfrom = @" tbl_viaje v
                            left join tbl_etapa e on (v.id = e.viaje_id and e.nro_etapa = v.etapa_actual)
                            left join buques b on v.buque_id = b.ID_BUQUE
                            left join tbl_puntodecontrol p on p.id = e.destino_id
                            left join tbl_bq_estados st on v.estado_buque = st.cod";

          var tmp = PaginageS1(Request.Params, columns, page, rows, sidx, sord);

          var items = context.ExecuteStoreQuery<INT_USUARIOS>((string)tmp[0], (ObjectParameter[])tmp[1]);

          var coso = PaginateS2(
            items.ToArray(),
            columns, context.INT_USUARIOS.Count(), page, rows
            )

          return Json(coso, JsonRequestBehavior.AllowGet);
        }
        
      public static object[] PaginageS1(NameValueCollection req, string[] columns, string precond, int page, int rows, string sidx, string sord)
      {
        int pageIndex = Convert.ToInt32(page) - 1;
        int pageSize = rows;

        int offset = (pageIndex * pageSize) + 1;

        var tmp = buildWhere2(req, columns, precond);

        string where = (string)tmp[0];
        OracleParameter[] vals = (OracleParameter[])tmp[1];


        string sql_stmt = String.Format(

          @"SELECT *
            FROM (SELECT a.*, ROWNUM rnum
                  FROM (SELECT {2}
                          FROM {3} 
                          WHERE {4}
                         ORDER BY {5} {6}) a  
                       WHERE ROWNUM < {7})
            WHERE rnum >= {8}"
         , columns_c.ToString(), columns_a.ToString(), columns_b.ToString(), typeof(T).Name, where, sidx, sord, offset + rows, offset);


        //System.Diagnostics.Debug.WriteLine("==========================\r\n" + sql_stmt +"\r\noffset:"+ offset +"\r\nrows:"+ rows);

        return new object[] { sql_stmt, vals };
      }

    private static DateTime[] getDatesFromString(string str)
    {
      var dates = new List<DateTime>();
      foreach(var s in str.Split(';'))
      {
        DateTime d;
        if (DateTime.TryParse(s, out d) == true)
          dates.Add(d);
      }

      return dates.ToArray();
    }


    public static object[] buildWhere2(NameValueCollection req, string[] columnsraw, string precond)
    {
      var values = new List<OracleParameter>();
      var predicate = new StringBuilder();

      if (!String.IsNullOrEmpty(precond))
        predicate.Append(precond);

      List<string> columns = new List<string>();
      foreach (var s in columnsraw)
      {
        var parts = s.Split('|');
        if (parts.Length == 2)
          columns.Add(parts[1].Substring(parts[1].LastIndexOf('.') + 1));
        else
          columns.Add(parts[2]);
      }
          
      foreach (string key in req.AllKeys)
      {
        if (!columns.Contains(key))
          continue;

        if (predicate.Length != 0) predicate.Append(" and ");

        //string
        if (typeof(T).GetProperty(key).PropertyType == typeof(string))
        {
          //marca 1
          predicate.Append(string.Format("upper(b.{0}) like upper(\'%{1}%\')", key, req[key]));
        }
        //datetime
        else if (typeof(T).GetProperty(key).PropertyType == typeof(Nullable<DateTime>)
              || typeof(T).GetProperty(key).PropertyType == typeof(DateTime))
        {
          DateTime[] dates = getDatesFromString(req[key]);
          if (dates.Length == 0)
          {
            //remove "and"
            predicate.Remove(predicate.Length - 5, 5);
            continue;
          }

          //TODO: hace GETDATE(datetime) para que compare solo fecha y no fecha+hora
          if (dates.Length == 1)
          {
            //marca 2
            predicate.Append(string.Format("to_date(b.{0}) = to_date(\'{1}\', \'MM/DD/YYYY\')", key,  dates[0].ToShortDateString()));
          }

          if (dates.Length == 2)
          {
            //marca 3
            var tmp = values.Count;
            predicate.Append(string.Format("to_date(b.{0}) >= to_date(\'{1} 00:00\', \'MM/DD/YYYY HH24:MI\') and to_date(b.{0}) <= to_date(\'{2} 23:59\', \'MM/DD/YYYY HH24:MI\')", key, dates[0].ToShortDateString(), dates[1].Date.ToShortDateString()));
          }
        }
        //cualquier otro
        else
        {
          //marca 4
          //(1,2,3,4)
          if (req[key].StartsWith("("))
          {
            predicate.Append(string.Format("b.{0} in {1}", key, req[key]));
          }
          else
            predicate.Append(string.Format("b.{0} = {1}", key, req[key]));
        }
      }

      //Hack-o-matic
      //if (values.Count == 0)
      if (predicate.Length == 0)
        predicate.Append("1 = 1");

      return new object[] { predicate.ToString(), values.ToArray() };
    }
          

      */
    }
}
