using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace mbpc.Controllers
{
    public class HomeController : MyController
    {
      public static string VERSION = "1.24";
      
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

          Session["zonas"] = DaoLib.zonas_del_grupo(int.Parse(((Session["grupos"] as List<object>)[0] as Dictionary<string,string>)["GRUPO"]));

          string id = ((Session["zonas"] as List<object>)[0] as Dictionary<string, string>)["ID"];
          Session["zona"] = id;

          
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

        public void recalcular_barcos_para_punto(string id)
        {
          ViewData["barcos_en_zona"] = DaoLib.barcos_en_zona(id);
          ViewData["barcos_salientes"] = DaoLib.barcos_salientes(id);
          ViewData["barcos_entrantes"] = DaoLib.barcos_entrantes(id);
          ViewData["barcazas_en_zona"] = DaoLib.barcazas_en_zona(id);

          ViewData["cuatrigrama"] = costera_de_zona(id);

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
          recalcular_barcos_para_punto(id);

          return View("columnas");
        }


        public ActionResult CambiarGrupo(int grupo)
        {
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
          ViewData["reporte"] = DaoLib.reporte_diario(Session["usuario"] as string);


          List<object> zonas = Session["zonas"] as List<object>;
          zonas.Sort(dictsort);

          for (var i = 0; i < zonas.Count; i++)
          {
            if ((zonas[i] as Dictionary<string, string>)["ID"] == Session["zona"].ToString())
            {
              ViewData["entrada"] = ((Dictionary<string, string>)zonas[i])["ENTRADA"];
            }
          }
          
          ViewData["zonas"] = zonas;
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
          System.Threading.Thread.Sleep(1500);
          return Json(HomeController.VERSION, JsonRequestBehavior.AllowGet);
        }

    }
}
