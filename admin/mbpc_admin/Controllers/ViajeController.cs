using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Text;
using System.Linq.Dynamic;
using System.Data.Objects;
using JQGrid;

namespace mbpc_admin.Controllers
{
    public class ViajeController : MyController
    {
        //
        // GET: /Viaje/

        public ActionResult List()
        {
          //ViewData["MUELLES"] = (from d in context.TBL_MUELLES select new { id = d.ID, nombre = d.DESCRIPCION}).ToDictionary(f => f.id, f => f.nombre);
          ViewData["menu"] = "viaje";

          return View();
        }

        public ActionResult ListJSON(string sidx, string sord, int page, int rows)
        {
          var columns = new string[] { 
            "ACTUAL", "ID", "NOMBRE", "NRO_OMI", "MATRICULA", 
            "SDIST", "BANDERA", "ORIGEN", "DESTINO", "FECHA_SALIDA", 
            "FECHA_LLEGADA", "NOTAS", "ESTADO"
          };

          var tmp = JQGrid.Helper.PaginageS1<VW_VIAJES_MARITIMOS>(Request.Params, columns, page, rows, sidx, sord);

          var items = context.ExecuteStoreQuery<VW_VIAJES_MARITIMOS>((string)tmp[0], (ObjectParameter[])tmp[1]);

          var todos = items.ToArray();
          var xx = todos.Length;

          return Json(JQGrid.Helper.PaginateS2<VW_VIAJES_MARITIMOS>(
            todos,
            columns, context.VW_VIAJES_MARITIMOS.Count(), page, rows
            ), JsonRequestBehavior.AllowGet);
        }
    }
}
