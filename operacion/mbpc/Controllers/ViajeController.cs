﻿using System;
using System.Text;
using System.Collections;
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
    public enum BarcosDataView
    {
      FULL,
      EN_ZONA,
      EN_LIMITES
    }

    public class ViajeController : MyController
    {
      

      static public SelectList MalvinasOptions(bool to_malvinas)
      {
        return MalvinasOptions2(to_malvinas, "");
      }

      static public SelectList MalvinasOptions2(bool to_malvinas, string selected)
      {
        int va_a_malvinas = to_malvinas ? 1 : 0;
        List<object> malvinas= DaoLib.obtener_opciones_malvinas(va_a_malvinas);
        List<object> newList = new List<object>();
        
        foreach (object obj in malvinas)
        {
          Dictionary<string, string> option = (Dictionary<string, string>)obj;
          newList.Add(new
            {
              id = Convert.ToString(option["ID"]),
              nombre = Convert.ToString(option["DESCRIPCION"]) + " (" + Convert.ToString(option["CODIGO"]) + ")"
            });
          if (selected == "")
            selected = Convert.ToString(option["ID"]);
        }
        return new SelectList(newList, "id", "nombre", selected);  
      }

      public ActionResult barcos_similares(string nombre)
      {
        var datos = DaoLib.barcos_similares(nombre);
        ViewData["similares"] = datos;
        return View();
      }

      public ActionResult barcazas_similares(string nombre)
      {
        var datos = DaoLib.barcazas_similares(nombre);
        ViewData["similares"] = datos;
        ViewData["barcaza"] = true;
        return View("barcos_similares");
      }

      public ActionResult Tooltip(string viaje_id)
      {
        //System.Threading.Thread.Sleep(2000);
        var datos = DaoLib.info_viaje(viaje_id);
        return View("_info_viaje", datos);
      }

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
            return BuildResponse();
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
          return BuildResponse();
        }


        public ActionResult quitarAcompanante(string id)
        {
          DaoLib.quitar_acompanante(id);
          return BuildResponse();
        }
        
        public ActionResult traerBarcoRecienLiberado(string id){
          DaoLib.traer_barco_recien_liberado(id);
          return BuildResponse();
        }

        public ActionResult indicarProximo(string viaje_id, string id2)
        {
          DaoLib.indicar_proximo(viaje_id, id2);
          return BuildResponse();
        }

        public ActionResult traerBarcosEnLimites()
        {
          Session["barcos_data"] = BarcosDataView.FULL;
          return BuildResponse();
        }

        private ActionResult BuildResponse()
        {
          if (Session["uso_punto"].ToString() == "0")
          {
            barcos_data(Session["punto"].ToString());

            return View("columnas");
          }
          
          return Content("nop");
        }

        public ActionResult pasarBarco(string viaje_id, string id2, string eta, string fecha, string velocidad, string rumbo)
        {
          DaoLib.pasar_barco(viaje_id, id2, eta, fecha, velocidad, rumbo);
          return BuildResponse();
        }

        public ActionResult nuevo()
        {
          ViewData["zonas"] = DaoLib.zonas_adyacentes(Session["punto"].ToString());
          return View();
        }

        public ActionResult agregarReporte(string id, string nombre)
        {
          var now = DateTime.Now;
          ViewData["fecha"] = now.ToString("dd-MM-yy");
          ViewData["viaje_id"] = id;
          ViewData["nombre_buque"] = nombre;
          return View();
        }

        public ActionResult insertarReporte(string viaje_id, string pos, string rumbo, string velocidad, string estado, string fecha)
        {
            var latlon = DaoLib.parsePos(pos);
            DaoLib.insertar_reporte(viaje_id, latlon[0], latlon[1], velocidad, rumbo, estado, fecha);
            return BuildResponse();
        }


        public ActionResult crear(string buque_id, string desde_id, string hasta_id, string partida, string eta, string zoe, string proximo_punto, string internacional, string pos, string riocanal, string codigo_malvinas)
        {
          //decimal[] latlon = new decimal[2];
          decimal?[] latlon = new decimal?[2];
          if (pos != "")
          {
            latlon = DaoLib.parsePos(pos);
          }
          List<object> autoeditaretapa = DaoLib.crear_viaje(buque_id, desde_id, hasta_id, partida, eta, zoe, Session["punto"].ToString(), proximo_punto, internacional, latlon[0], latlon[1], riocanal, Convert.ToInt32(codigo_malvinas));
          ViewData["AutoEditarEtapa"] = autoeditaretapa;

          //---------------en caso de vista maritima--------------
          if (Session["uso_punto"].ToString() != "0")
          {
            var tmp = autoeditaretapa[0] as Dictionary<string,string>;
            return Content( "nop," + tmp["ID"] +","+ tmp["VIAJE_ID"]);
          }

          return BuildResponse();
        }

        public ActionResult confirmaViaje(string viaje, string confirma)
        {
          DaoLib.confirma_viaje(viaje, confirma);
          return Content("ok");
        }

        public ActionResult editar(string id)
        {
          ViewData["zonas"] = DaoLib.zonas_adyacentes(Session["punto"].ToString());
          ViewData["viajedata"] = DaoLib.traer_viaje(id);

          return View();
        }

        //public ActionResult modificar(string viaje_id, string buque_id, string desde_id, string hasta_id, string partida, string eta, string zoe, string proximo_punto, string internacional, string pos, string riocanal, string rumbo, string velocidad)
        public ActionResult modificar(string viaje_id, string buque_id, string partida, string eta, string zoe, string proximo_punto, string internacional, string pos, string riocanal, string rumbo, string velocidad, string codigo_malvinas_inicio)
        {
            decimal?[] latlon = {null, null};
            if (pos != "")
            {
              latlon = DaoLib.parsePos(pos);
            }

            //DaoLib.editar_viaje(viaje_id, buque_id, desde_id, hasta_id, partida, eta, zoe, Session["punto"].ToString(), proximo_punto, internacional, latlon[0], latlon[1], riocanal);
            DaoLib.editar_viaje(viaje_id, buque_id, partida, eta, zoe, Session["punto"].ToString(), proximo_punto, internacional, latlon[0], latlon[1], riocanal, codigo_malvinas_inicio);
            return BuildResponse();
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

          if( id2 == "terminarviaje")
          {
            var tmp = DaoLib.traer_cargas(int.Parse(etapa_id["ID"]));
            if (tmp.Count != 0)
            {
              ViewData["tiene_carga"] = true;
            }
          }

          return View();
        }

        public ActionResult terminar(string viaje_id, string fecha, string escalas, string codigo_malvinas)
        {

          var tipo = tipo_punto(Session["punto"].ToString());
          var viaje = DaoLib.traer_viaje(viaje_id)[0] as Dictionary<string,string>;

          if ((tipo == "1" || tipo == "6") && viaje["ESTADO_BUQUE"] != "PU")
            throw new Exception("Para finalizar el viaje en este punto debe tener estado PU");

          DaoLib.terminar_viaje(viaje_id, fecha, escalas, Convert.ToInt32(codigo_malvinas));
          return BuildResponse();
        }

        public ActionResult terminados()
        {
          ViewData["viajes"] = DaoLib.viajes_terminados(Session["punto"].ToString());
          return View();
        }

        public ActionResult reactivar(string id)
        {
          DaoLib.reactivar_viaje(id);
          return BuildResponse();
        }

        public ActionResult editarEtapa(string viaje_id, string id2, string refresh_viajes)
        {
          ViewData["zonas"] = DaoLib.zonas_adyacentes(Session["punto"].ToString());
          ViewData["viajedata"] = DaoLib.traer_viaje(viaje_id);

          ViewData["etapa"] = DaoLib.traer_etapa_viaje(int.Parse(id2));
          ViewData["viaje_id"] = viaje_id;

          string pto_control_id = (ViewData["etapa"] as Dictionary<string, string>)["DESTINO_ID"];
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

          ViewData["refresh_viajes"] = refresh_viajes;
          return View();
        }

        public ActionResult modificarEtapa(string etapa_id, string desde_id, string hasta_id, string calado_proa, string calado_popa, string calado_informado, string hrp, string eta, string fecha_salida, string cantidad_tripulantes, string cantidad_pasajeros, string activo, string practico0, string practico1, string practico2, string capitan_id, string velocidad, string rumbo, string latitud, string longitud)
        {
          if (calado_proa != null && (calado_proa == "" || calado_proa.LastIndexOf("_") != -1) ) calado_proa = null;
          if (calado_popa != null && (calado_popa == "" || calado_popa.LastIndexOf("_") != -1)) calado_popa = null;
          if (calado_informado != null && (calado_informado == "" || calado_informado.LastIndexOf("_") != -1)) calado_informado = null;

          DaoLib.editar_etapa(etapa_id, desde_id, hasta_id, calado_proa, calado_popa, calado_informado, hrp, eta, fecha_salida, cantidad_tripulantes, cantidad_pasajeros, capitan_id, rumbo, velocidad);
          return BuildResponse();
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
          return BuildResponse();
        }

        public ActionResult modificarPBIP(string puertodematricula, string numeroinmarsat, string arqueobruto,  string compania,  string contactoOCPM, string objetivo, string viaje )
        {
          ViewData["pbip"] = DaoLib.modificar_pbip(puertodematricula, numeroinmarsat, arqueobruto, compania, contactoOCPM, objetivo, viaje);
          return View();
        }

        public ActionResult ListJSON(string sidx, string sord, int page, int rows)
        {
          var columns = new Dictionary<string,string> { 
            {"PID","i"},
            {"ID","i"},
            {"COSTERA","s"},
            {"ETAPA","i"},
            {"PROXDEST","i"},
            {"ID_BUQUE","i"},
            {"NOMBRE","s"},
            {"NRO_OMI","s"},
            {"MATRICULA","s"},
            {"SDIST","s"},
            {"BANDERA","s"},
            {"LATITUD","f"},
            {"LONGITUD","f"},
            {"ORIGEN","s"},
            {"DESTINO","s"},
            {"ESTADO","s"},
            {"ULTIMO","i"},
            {"VESTADO","i"}
          };

          //Agregamos a mano el filtro
          var tmp = JQGrid.JQGridUtils.PaginageS1("VW_VIAJES_MARITIMOS", Request.Params, columns, 
                        page, rows, sidx, sord);

          var cmdcount = new OracleCommand((string)tmp[2]);
          int cnt = int.Parse(((Dictionary<string, string>)DaoLib.doSQL(cmdcount)[0])["TOTAL"]);

          var cmd = new OracleCommand((string)tmp[0]);
          cmd.Parameters.AddRange((OracleParameter[])tmp[1]);
          var items = DaoLib.doSQL(cmd);

          var coso = JQGrid.JQGridUtils.PaginateS2(items, columns, cnt, page, rows);

        return Json(coso, JsonRequestBehavior.AllowGet);
      }

    }
}
