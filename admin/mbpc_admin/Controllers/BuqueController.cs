using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Objects;
using mbpc_admin.Models;
using Oracle.DataAccess.Client;

namespace mbpc_admin.Controllers
{
    public class BuqueController : MyController
    {
        public ActionResult List()
        {
            return View();
        }

        public ActionResult ListJSON(string sidx, string sord, int page, int rows)
        {
          var columns = new string[] { "ID_BUQUE", "NOMBRE", "TIPO_SERVICIO", "TIPO_BUQUE", "REGISTRO", "NRO_ISMM", "ANIO_CONSTRUCCION", "BANDERA", "NRO_OMI", "MATRICULA", "SDIST" };

          var tmp = JQGrid.Helper.PaginageS1<BUQUES_NEW>(Request.Params, columns, page, rows, sidx, sord);

          var items = context.ExecuteStoreQuery<BUQUES_NEW>((string)tmp[0], (ObjectParameter[])tmp[1]);

          return Json(JQGrid.Helper.PaginateS2<BUQUES_NEW>(
              items.ToArray(),
              columns, context.BUQUES_NEW.Count(), page, rows
              ), JsonRequestBehavior.AllowGet);
        }

    }
}
