using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace mbpc.Controllers
{
    public class HomeController : MyController
    {
      public static string VERSION = "1.26";
      
        //
        // GET: /Home/
        public ActionResult Index()
        {
          if ( Session["logged"] == null || int.Parse( Session["logged"].ToString() ) == 0 )
            return this.RedirectToAction("ShowForm", "Auth");

          Session["grupos"] = DaoLib.grupos_del_usuario(int.Parse(Session["usuario"].ToString()));
          if ((Session["grupos"] as List<object>).Count == 0)
          {
            TempData["error"] = "Sin grupos.<br/>Debe pedir el alta en el sistema";
            return RedirectToAction("Login", "Auth");
          }

          
          var datos = DaoLib.datos_del_usuario(Session["usuario"].ToString());
          ViewData["datos_del_usuario"] = datos;

          //HACK: Hasta que haya sistema de usuarios
          if((datos[0] as Dictionary<string,string>)["APELLIDO"].Contains("*"))
          {
            return RedirectToAction("Index", "Reporte");
          }

          int grp = int.Parse(((Session["grupos"] as List<object>)[0] as Dictionary<string, string>)["GRUPO"]);
          Session["grupo"] = grp;
          Session["zonas"] = DaoLib.zonas_del_grupo(grp);

          string id = ((Session["zonas"] as List<object>)[0] as Dictionary<string, string>)["ID"];
          Session["zona"] = id;

          ViewData["tipo_punto"] = tipo_zona(id);
          recalcular_barcos_para_punto(id);

          return View();
        }

        public string costera_de_zona(string id)
        {
          foreach( var x in Session["zonas"] as List<object>)
          {
            var t = x as Dictionary<string,string>;
            if (t["ID"] == id)
              return t["CUATRIGRAMA"];
          }

          return "";
        }

        public string tipo_zona(string id)
        {
          string tipo = string.Empty;

          foreach (var x in Session["zonas"] as List<object>)
          {
            var t = x as Dictionary<string, string>;
            if (t["ID"] == id)
            {
              tipo = t["USO"];
              break;
            }
          }

          return tipo;
        }

        public void recalcular_barcos_para_punto(string id)
        {
          //0 - fluvial
          //1 - maritimo

          if (tipo_zona(id) == "0")
          {
            ViewData["barcos_en_zona"] = DaoLib.barcos_en_zona(id);
            ViewData["barcos_salientes"] = DaoLib.barcos_salientes(id);
            ViewData["barcos_entrantes"] = DaoLib.barcos_entrantes(id);
            ViewData["barcazas_en_zona"] = DaoLib.barcazas_en_zona(id);
          }

        }

        public ActionResult RefrescarColumnas()
        {
          string id = Session["zona"].ToString();
          recalcular_barcos_para_punto(id);

          return View("_columnas");
        }

        
        public ActionResult cambiarZona(string id)
        {
          Session["zona"] = id;
          ViewData["tipo_punto"] = tipo_zona(id);

          recalcular_barcos_para_punto(id);

          return View("columnas");
        }


        public ActionResult CambiarGrupo(int grupo)
        {
          Session["grupo"] = grupo;
          Session["zonas"] = DaoLib.zonas_del_grupo(grupo);

          string id = ((Session["zonas"] as List<object>)[0] as Dictionary<string, string>)["ID"];
          
          Session["zona"] = id;
          recalcular_barcos_para_punto(id);

          return View("columnas");
        }

        public ActionResult zonasAdyacentes(string zona, string viaje, string pasar)
        {
          var now = DateTime.Now;
          ViewData["fecha"] = now.ToString("dd-MM-yy HH:mm");
          ViewData["zonas"] = DaoLib.zonas_adyacentes(zona);
          ViewData["viaje"] = viaje;
          ViewData["pasar"] = pasar;

          if (!String.IsNullOrEmpty(pasar))
          {
            var ultima_etapa_viaje = DaoLib.traer_etapa(viaje)[0] as Dictionary<string, string>;
            ViewData["VELOCIDAD"] = Convert.ToString(ultima_etapa_viaje["VELOCIDAD"]).Replace(",", ".");
            ViewData["RUMBO"] = ultima_etapa_viaje["RUMBO"];
            ViewData["DESTINO_ID"] = ultima_etapa_viaje["DESTINO_ID"];
          }

          return View();
        }

        public ActionResult detallesTecnicos(string id)
        {
          ViewData["barco"] = DaoLib.detalles_tecnicos(id);
          return View();
        }

        public ActionResult reporteDiario()
        {
          obtenerZonas();
          return View();
        }

        public ActionResult reporteDiarioPrint()
        {
          obtenerZonas();
          return View();
        }

        private void obtenerZonas()
        {
          var tmp = DaoLib.reporte_diario(Session["grupo"] as string);

          var reporte_arriba = new Dictionary<string, Dictionary<string,string>>();
          var reporte_abajo  = new Dictionary<string, Dictionary<string, string>>();

          Dictionary<string, Dictionary<string, string>> handler = null;

          foreach (Dictionary<string, string> d in tmp)
          {
            //Elijo el repote en fincion del sentido del row (aguas arriba/aguas abajo)
            handler = reporte_arriba;
            if (d["SENTIDO"] == "0")
              handler = reporte_abajo;

            //Si no esta este barco para este sentido, lo creo y le asigno el row completo de la data
            if (!handler.ContainsKey(d["NOMBRE"]))
              handler[d["NOMBRE"]] = d;

            //Luego le creo una key con el ETA y HRP de esa etapa
            handler[d["NOMBRE"]]["ETA" + d["PDC"]] = d["ETA"];
            handler[d["NOMBRE"]]["HRP" + d["PDC"]] = d["HRP"];
          }

          
          ViewData["reporte_arriba"] = reporte_arriba;
          ViewData["reporte_abajo"] = reporte_abajo;

          ViewData["zonas"] = Session["zonas"];
        }

        private static int dictsort(Object aa, Object bb) 
        {
          var a = (Dictionary<string, string>)aa;
          var b = (Dictionary<string, string>)bb;

          float km1 = float.Parse(a["KM"]);
          float km2 = float.Parse(b["KM"]);
     
          if (km1 == km2)
            return 0;
          if (km1 > km2)       
            return 1;
          if (km1 < km2)       
            return -1;
     
          return 0;       
        }

        public JsonResult Version()
        {
          return Json(HomeController.VERSION, JsonRequestBehavior.AllowGet);
        }

    }
}
