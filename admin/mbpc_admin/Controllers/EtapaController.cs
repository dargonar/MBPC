using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Text;
using System.Linq.Dynamic;
using JQGrid;
using System.Data.Objects;

namespace mbpc_admin.Controllers
{
    public class EtapaController : MyController
    {
        //
        // GET: /Etapa/

        public ActionResult List(string id)
        {
          var decid = decimal.Parse(id);
          var viaje = (from d in context.TBL_VIAJE where d.ID == decid select d).SingleOrDefault();

          ViewData["pdcs"] = (from c in context.VPUNTO_DE_CONTROL select new { id = c.ID, value = c.CANAL }).ToArray(); 

          
          //ViewData["titulo"] = String.Format("viaje {0} (Buque {1} de muelle {2} a {3})", id,viaje.BUQUE_ID != null ? 'ddd' : 'ddddi', viaje.DESTINO_ID .DESCRIPCION ,viaje.TBL_MUELLES1.DESCRIPCION);
            
          if (id != null)
            ViewData["referenceId"] = id;

          return View();
        }

        public ActionResult ListJSON(string sidx, string sord, int page, int rows)
        {
            var columns = new string[] { "ID", "NRO_ETAPA", "ORIGEN_ID", "ACTUAL_ID", "DESTINO_ID", "HRP", "ETA", "FECHA_SALIDA", "FECHA_LLEGADA", "CREATED_AT" };

            var tmp = JQGrid.Helper.PaginageS1<TBL_ETAPA>(Request.Params, columns, page, rows, sidx, sord);

          var items = context.ExecuteStoreQuery<TBL_ETAPA>((string)tmp[0], (ObjectParameter[])tmp[1]);

          return Json(JQGrid.Helper.PaginateS2<TBL_ETAPA>(
            items.ToArray(),
            columns, context.TBL_ETAPA.Count(), page, rows
            ), JsonRequestBehavior.AllowGet);
        }
    }
}
