using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Globalization;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.IO;

namespace mbpc.Controllers
{
    public class ReporteController : MyController
    {
        //
        // GET: /Reporte/

        public ActionResult Index()
        {
          Session["grupos"] = null;

          if (Session["logged"] == null || int.Parse(Session["logged"].ToString()) == 0)
          {
            if(Request.UrlReferrer == null)
              Session["toreports"] = "true";

            return this.RedirectToAction("ShowForm", "Auth");
          }
          
          ViewData["datos_del_usuario"] = DaoLib.datos_del_usuario(Session["usuario"].ToString());
          ViewData["reportes"] = DaoLib.reporte_lista();

          return View();
        }

        public ActionResult ParamsFor(int id)
        {
          ViewData["params"] = DaoLib.reporte_obtener_parametros(id);
          return View("_params");
        }

        public ActionResult Ver(int reporte_id, int count, string print_me)
        {
          var rep     = DaoLib.reporte_obtener(reporte_id) as Dictionary<string, string>;
          var _params = DaoLib.reporte_obtener_parametros(reporte_id);

          var lparams = new List<OracleParameter>();

          for (int i = 0; i < count; i++)
          {
            var param = _params.Find( o => (o as Dictionary<string,string>)["INDICE"] == (i+1).ToString() ) as Dictionary<string,string>;

            object value = Request.Params["param" + (i + 1).ToString()];

            string pname = ":p" + (i + 1).ToString();

            string tmp=rep["CONSULTA_SQL"];
            int qcount = tmp.Select((c, j) => tmp.Substring(j)).Count(sub => sub.StartsWith(pname));
            for (int k = 0; k < qcount; k++)
            {
              if (param["TIPO_DATO"] == "0")
                lparams.Add(new OracleParameter(pname, OracleDbType.Varchar2, value, System.Data.ParameterDirection.Input));

              if (param["TIPO_DATO"] == "1")
                lparams.Add(new OracleParameter(pname, OracleDbType.Varchar2, value, System.Data.ParameterDirection.Input));

              if (param["TIPO_DATO"] == "2")
                lparams.Add(new OracleParameter(pname, OracleDbType.Varchar2, value, System.Data.ParameterDirection.Input));

              if (param["TIPO_DATO"] == "3")
                lparams.Add(new OracleParameter(pname, OracleDbType.Varchar2, value, System.Data.ParameterDirection.Input));
            }
          }

          var cmd = new OracleCommand(rep["CONSULTA_SQL"]);
          cmd.Parameters.AddRange(lparams.ToArray());

          var rs = DaoLib.doSQL(cmd);

          //Print?
          if (print_me != null)
          {
            StringWriter sw = new StringWriter();

            //First line for column names
            var first = true;
            
            foreach(Dictionary<string, string> item in rs) 
            {
              if (first) 
              {
                string tmp = string.Empty;
                foreach(var kv in item) 
                {
                  if(kv.Key.EndsWith("_fmt")) continue;
                  tmp = tmp + "\"" + kv.Key + "\",";
                }

                first = false;
                sw.WriteLine(tmp.Substring(0,tmp.Length-1));
              }

              string tmp2 = string.Empty;
              foreach(var kv in item) 
              {
                if(kv.Key.EndsWith("_fmt")) continue;
                tmp2 = tmp2 + "\"" + kv.Value + "\",";
              }
              
              sw.WriteLine(tmp2.Substring(0,tmp2.Length-1));
            }

            Response.AddHeader("Content-Disposition", "attachment; filename=test.csv");
            Response.ContentType = "text/csv";
            Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Response.Write(sw);
            Response.End();

            return null;
          }

          if (rs.Count == 0)
            return View("_result_empty");

          ViewData["result"]  = rs;
          ViewData["reporte"] = rep;

          return View("_result");
        }
    }
}
