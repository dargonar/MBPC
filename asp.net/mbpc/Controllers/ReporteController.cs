using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Globalization;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace mbpc.Controllers
{
    public class ReporteController : MyController
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

        public ActionResult Ver(int reporte_id, int count)
        {
          var rep     = DaoLib.reporte_obtener(reporte_id) as Dictionary<string, string>;
          var _params = DaoLib.reporte_obtener_parametros(reporte_id);

          var lparams = new List<OracleParameter>();

          for (int i = 0; i < count; i++)
          {
            var param = _params.Find( o => (o as Dictionary<string,string>)["INDICE"] == (i+1).ToString() ) as Dictionary<string,string>;

            object value = Request.Params["param" + (i + 1).ToString()];
            
            if (param["TIPO_DATO"] == "0")
              lparams.Add( new OracleParameter(":p" + (i + 1).ToString(), OracleDbType.Varchar2, value, System.Data.ParameterDirection.Input));
            
            if (param["TIPO_DATO"] == "1")
              lparams.Add( new OracleParameter(":p" + (i + 1).ToString(), OracleDbType.Varchar2, value, System.Data.ParameterDirection.Input));
            
            if (param["TIPO_DATO"] == "2")
              lparams.Add( new OracleParameter(":p" + (i + 1).ToString(), OracleDbType.Varchar2, value, System.Data.ParameterDirection.Input));
            
            if (param["TIPO_DATO"] == "3")
              lparams.Add( new OracleParameter(":p" + (i + 1).ToString(), OracleDbType.Varchar2, value, System.Data.ParameterDirection.Input));
          }

          var cmd = new OracleCommand(rep["CONSULTA_SQL"]);
          cmd.Parameters.AddRange(lparams.ToArray());

          var rs = DaoLib.doSQL(cmd);
          if (rs.Count == 0)
            return View("_result_empty");

          ViewData["result"]  = rs;
          ViewData["reporte"] = rep;
          return View("_result");
        }
    }
}
