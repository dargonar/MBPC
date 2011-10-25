using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Globalization;

namespace mbpc.Controllers
{
    public class ViajeController : Controller
    {

        public ActionResult histRVP(string id)
        {
          ViewData["historial"] = DaoLib.hist_rvp(id);
          ViewData["eventos"] = DaoLib.hist_evt(id);
          return View();
        }

        public ActionResult cambiarEstado(string id)
        {
            var now = DateTime.Now;
            ViewData["fecha"] = now.ToString("dd-MM-yy HH:mm");
            ViewData["etapa_id"] = id;
            //ViewData["eventos"] = DaoLib.eventos_usuario();
            return View();
        }

        public ActionResult insertarEventoCambioEstado(string etapa_id, string notas, string pos, string fecha, string estado, string riocanal)
        {
            decimal?[] latlon = new decimal?[2];
            if (pos != "")
            {
              latlon = DaoLib.parsePos(pos);
            }
            DaoLib.insertar_cambioestado(etapa_id, notas, latlon[0], latlon[1], fecha, estado, riocanal);

            ViewData["barcos_en_zona"] = DaoLib.barcos_en_zona(Session["zona"].ToString());
            ViewData["barcos_salientes"] = DaoLib.barcos_salientes(Session["zona"].ToString());
            ViewData["barcos_entrantes"] = DaoLib.barcos_entrantes(Session["zona"].ToString());
            ViewData["barcazas_en_zona"] = DaoLib.barcazas_en_zona(Session["zona"].ToString());
            return View("columnas");
        }

        public ActionResult elegirAcompanante(string id)
        {
          ViewData["etapa_id"] = id;
          return View();
        }

        public ActionResult editarAcompanante(string etapa_id, string buque_id)
        {

          DaoLib.editar_acompanante(etapa_id, buque_id);

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

        public ActionResult terminar(string viaje_id, string fecha)
        {
          DaoLib.terminar_viaje(viaje_id, fecha);

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

          //ViewData["zonas"] = DaoLib.zonas_adyacentes(Session["zona"].ToString());
          ViewData["etapa"] = DaoLib.traer_etapa(viaje_id);
          ViewData["practicos"] = DaoLib.traer_practicos(id2);
          ViewData["viaje_id"] = viaje_id;

          return View();
        }

        public ActionResult modificarEtapa(string etapa_id, string calado_proa, string calado_popa, string calado_informado, string hrp, string eta, string fecha_salida, string cantidad_tripulantes, string cantidad_pasajeros, string activo, string practico0, string practico1, string practico2, string capitan_id, string velocidad, string rumbo, string latitud, string longitud)
        {
          
          if (activo != null) 
          {
            List<string> practicos = new List<string>();
            List<string> etapas = new List<string>();
            List<string> activos = new List<string>();
            if (practico0 != "") { practicos.Add(practico0); }
            if (practico1 != "") { practicos.Add(practico1); }
            if (practico2 != "") { practicos.Add(practico2); }

            foreach (var pr in practicos)
            {
              etapas.Add(etapa_id);
              activos.Add(activo == pr ? "1" : "0");
            }


            DaoLib.eliminar_practicos(etapa_id);
            DaoLib.agregar_practicos(practicos.ToArray(), etapas.ToArray(), activos.ToArray());
          }

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
    }
}
