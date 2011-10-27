using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Globalization;

namespace mbpc.Controllers
{
    public class ReporteController : Controller
    {
        //
        // GET: /Reporte/

        public ActionResult Index()
        {
          if (Session["logged"] == null || int.Parse(Session["logged"].ToString()) == 0)
            return this.RedirectToAction("ShowForm", "Auth");
          
          ViewData["datos_del_usuario"] = DaoLib.datos_del_usuario(Session["usuario"].ToString());

          ViewData["reportes"] = DaoLib.reporte_lista();
          return View();
        }

        public ActionResult ParamsFor(int id)
        {
          ViewData["params"] = DaoLib.reporte_obtener_parametros(id);
          return View("_params");
        }

        public ActionResult VerReporte()
        { 
          return View("Index");
        }
    }
}
