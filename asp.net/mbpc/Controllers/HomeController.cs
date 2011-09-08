using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace mbpc.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/
        public ActionResult Index()
        {
          if ( Session["logged"] == null || int.Parse( Session["logged"].ToString() ) == 0 )
            return this.RedirectToAction("ShowForm", "Auth");

          Session["zonas"] = DaoLib.zonas_del_usuario(int.Parse(Session["usuario"].ToString()));

          if ((Session["zonas"] as List<object>).Count == 0)
          {
            //Session["logged"] = null;
            TempData["error"] = "Debe pedir el alta en el sistema";
            return RedirectToAction("Login", "Auth");
          }

          string id = ((Session["zonas"] as List<object>)[0] as Dictionary<string, string>)["ID"];
          Session["zona"] = id;

          ViewData["datos_del_usuario"] = DaoLib.datos_del_usuario(Session["usuario"].ToString());
          ViewData["barcos_en_zona"] = DaoLib.barcos_en_zona(id);
          ViewData["barcos_salientes"] = DaoLib.barcos_salientes(id);
          ViewData["barcos_entrantes"] = DaoLib.barcos_entrantes(id);

          return View();
        }

        public ActionResult RefrescarColumnas()
        {
          ViewData["barcos_en_zona"] = DaoLib.barcos_en_zona(Session["zona"].ToString());
          ViewData["barcos_salientes"] = DaoLib.barcos_salientes(Session["zona"].ToString());
          ViewData["barcos_entrantes"] = DaoLib.barcos_entrantes(Session["zona"].ToString());

          return View("_columnas");
        }

        
        public ActionResult cambiarZona(string id)
        {
          //TODO:
          //if (Session["logged"] == null || int.Parse(Session["logged"].ToString()) == 0)
          //return Action

          Session["zona"] = id;
          
          ViewData["barcos_en_zona"] = DaoLib.barcos_en_zona(id);
          ViewData["barcos_salientes"] = DaoLib.barcos_salientes(id);
          ViewData["barcos_entrantes"] = DaoLib.barcos_entrantes(id);

          return View("columnas");
        }

        public ActionResult zonasAdyacentes(string zona, string viaje, string pasar)
        {
          var now = DateTime.Now;
          ViewData["fecha"] = now.ToString("dd-MM-yy HH:mm");

          ViewData["zonas"] = DaoLib.zonas_adyacentes(zona);
          ViewData["viaje"] = viaje;
          ViewData["pasar"] = pasar;
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

    }
}
