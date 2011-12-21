using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using mbpc.Models;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Configuration;

namespace mbpc_wsreport
{

  public class ReportParam
  {
    ReportParam()
    {

    }

    ReportParam(string nombre, string valor)
    {
      this.nombre = nombre;
      this.valor = valor;
    }

    public string nombre;
    public object valor;
  }

  /// <summary>
  /// Summary description for reports
  /// </summary>
  [WebService(Namespace = "http://tempuri.org/")]
  [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
  [System.ComponentModel.ToolboxItem(false)]
  // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
  // [System.Web.Script.Services.ScriptService]
  public class reports : System.Web.Services.WebService
  {
    [WebMethod]
    public DataSet GetReport(string key, string report_name, List<ReportParam> report_params)
    {
      var rep = DaoLib.reporte_obtener_str(report_name) as Dictionary<string, string>;
      var _params = DaoLib.reporte_obtener_parametros_str(report_name);

      var lparams = new List<OracleParameter>();

      foreach(var report_param in report_params)
      {
        var param = _params.Find(o => (o as Dictionary<string, string>)["NOMBRE"] == report_param.nombre) as Dictionary<string, string>;

        object value = report_param.valor;

        if (param["TIPO_DATO"] == "0")
          lparams.Add(new OracleParameter(":p" + param["INDICE"].ToString(), OracleDbType.Varchar2, value, System.Data.ParameterDirection.Input));

        if (param["TIPO_DATO"] == "1")
          lparams.Add(new OracleParameter(":p" + param["INDICE"].ToString(), OracleDbType.Varchar2, value, System.Data.ParameterDirection.Input));

        if (param["TIPO_DATO"] == "2")
          lparams.Add(new OracleParameter(":p" + param["INDICE"].ToString(), OracleDbType.Varchar2, value, System.Data.ParameterDirection.Input));

        if (param["TIPO_DATO"] == "3")
          lparams.Add(new OracleParameter(":p" + param["INDICE"].ToString(), OracleDbType.Varchar2, value, System.Data.ParameterDirection.Input));
      }

      var cmd = new OracleCommand(rep["CONSULTA_SQL"]);
      cmd.Parameters.AddRange(lparams.ToArray());
      
      string constr = ConfigurationManager.ConnectionStrings["default"].ConnectionString;

      DataSet dataset = new DataSet();
      using (OracleConnection con = new OracleConnection(constr))
      {
        con.Open();
        cmd.Connection = con;
        var adapter = new OracleDataAdapter(cmd);
        adapter.Fill(dataset);
      }

      return dataset;
    }
  }
}
