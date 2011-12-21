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
            var columns = new string[] { "BUQUE_ID", "TIPO_SERVICIO", "TIPO_BUQUE", "ELIMINACION", "REGISTRO", "ACTUALIZACION_FECHA", "ACTUALIZACION_USUARIO", "VALOR", "INSCRIP_PROVISORIA", "FECHA_INSCRIP", "NRO_ISMM", "ANIO_CONSTRUCCION", "BANDERA_ID", "NOMBRE", "NRO_OMI", "MATRICULA", "SDIST" };

            var tmp = JQGrid.Helper.PaginageS1<BUQUE>(Request.Params, columns, page, rows, sidx, sord);

            var items = context.ExecuteStoreQuery<BUQUE>((string)tmp[0], (ObjectParameter[])tmp[1]);

            return Json(JQGrid.Helper.PaginateS2<BUQUE>(
              items.ToArray(),
              columns, context.BUQUES.Count(), page, rows
              ), JsonRequestBehavior.AllowGet);
        }

    }
}
