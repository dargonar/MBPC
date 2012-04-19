using System;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using mbpc.Models;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Globalization;

namespace mbpc_wsreport
{
  public class ReportParam
  {
    public static string VERSION = "1.3";

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
      return GetReport2("oldarmada", "passarmada", report_name, report_params);
    }

    [WebMethod]
    public DataSet GetReport2(string username, string password, string report_name, List<ReportParam> report_params)
    {
      //HACK: hasta que este llena vw_int_usuarios_ext
      if (ConfigurationManager.AppSettings["validate_users_ext"] == "yes")
      {
        var usr = DaoLib.login_usuario_ext(username, password);
        if (usr.Count == 0)
        {
          throw new InvalidOperationException("Usuario/Password invalido, por favor contactese con el administrador.");
        }
      }
      else
      {
        if (username != "oldarmada" || password != "passarmada")
        {
          throw new InvalidOperationException("Usuario/Password invalido, por favor contactese con el administrador.");
        }
      }

      //Verificar que tiene permisos para ejecutar el reporte
      var reportes = DaoLib.obtener_reportes_para_usuario(username);
      var reporte = reportes.Find(o => (o as Dictionary<string, string>)["NOMBRE"] == report_name) as Dictionary<string, string>;
      if (reporte == null)
      {
        throw new UnauthorizedAccessException(string.Format("No tiene permisos para ejecutar el reporte [{0}]", report_name));
      }

      var rep = DaoLib.reporte_obtener_str(report_name) as Dictionary<string, string>;
      var _params = DaoLib.reporte_obtener_parametros_str(report_name);

      var lparams = new List<OracleParameter>();

      foreach(var report_param in report_params)
      {
        var param = _params.Find(o => (o as Dictionary<string, string>)["NOMBRE"].ToLower() == report_param.nombre.ToLower()) as Dictionary<string, string>;

        object value = report_param.valor;
        var pname = ":p" + param["INDICE"].ToString();

        string tmp = rep["CONSULTA_SQL"];
        int qcount = tmp.Select((c, j) => tmp.Substring(j)).Count(sub => sub.StartsWith(pname));
        
        for (int k = 0; k < qcount; k++)
        {
          if (param["TIPO_DATO"] == "0")
            lparams.Add(new OracleParameter(pname, OracleDbType.Date, DateTime.ParseExact(value.ToString(), "dd-MM-yy", CultureInfo.InvariantCulture), System.Data.ParameterDirection.Input));

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
