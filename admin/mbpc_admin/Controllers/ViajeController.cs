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
            ViewData["MUELLES"] = (from d in context.TBL_MUELLES select new { id = d.ID, nombre = d.DESCRIPCION}).ToDictionary(f => f.id, f => f.nombre);
            ViewData["menu"] = "viaje";  
          return View();
        }

        public ActionResult ListJSON(string sidx, string sord, int page, int rows)
        {
          var columns = new string[] { "ID", "ORIGEN_ID", "DESTINO_ID", "BUQUE_ID", "FECHA_SALIDA", "FECHA_LLEGADA", "ETA", "ZOE", "ETAPA_ACTUAL", "ESTADO", "NOTAS", "VIAJE_PADRE", "LATITUD", "LONGITUD", "CREATED_AT" };

          var tmp = JQGrid.Helper.PaginageS1<TBL_VIAJE>(Request.Params, columns, page, rows, sidx, sord);
          
          var items = context.ExecuteStoreQuery<TBL_VIAJE>((string)tmp[0], (ObjectParameter[])tmp[1]);

          return Json(JQGrid.Helper.PaginateS2<TBL_VIAJE>(
            items.ToArray(),
            columns, context.TBL_VIAJE.Count(), page, rows
            ), JsonRequestBehavior.AllowGet);
        }
    }
}
