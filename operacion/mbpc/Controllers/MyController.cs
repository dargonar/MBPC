using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcMiniProfiler;
using System.Threading.Tasks;

namespace mbpc.Controllers
{
  public class MyController : Controller
  {
    protected override void OnActionExecuting(ActionExecutingContext ctx) {

      if (Session != null && Session["usuario"] != null)
        DaoLib.userid = int.Parse(Session["usuario"].ToString());
      
      //get request and response 
      var request = ctx.HttpContext.Request;
      var response = ctx.HttpContext.Response;

      //get requested encoding 
      if (!string.IsNullOrEmpty(request.Headers["Accept-Encoding"]))
      {
        string enc = request.Headers["Accept-Encoding"].ToUpperInvariant();

        //preferred: gzip or wildcard 
        if (enc.Contains("GZIP") || enc.Contains("*"))
        {
          response.AppendHeader("Content-encoding", "gzip");
          response.Filter = new mbpc.Models.WebCompressionFilter(response.Filter, Models.CompressionType.GZip);
        }

        //deflate 
        else if (enc.Contains("DEFLATE"))
        {
          response.AppendHeader("Content-encoding", "deflate");
          response.Filter = new mbpc.Models.WebCompressionFilter(response.Filter, Models.CompressionType.Deflate);
        }
      }
      
      if (Session["should_profile"] != null)
        MvcMiniProfiler.MiniProfiler.Start();

      base.OnActionExecuting(ctx);
    }

    public static string URLPara(string para, System.Web.HttpRequest req)
    {
      string url = string.Format("http://{0}:8889/Viaje/List",req.ServerVariables["LOCAL_ADDR"]);

      if (para == "carga_link")
        url += "?alone=2";

      if (para == "lista_viaje")
        url += "?alone=1";

      return url;
    }

    public void barcos_data(string id)
    {
      var newProfiler = new MiniProfiler[]{
              new MiniProfiler("-task1 (tiempo invalido=>)", ProfileLevel.Verbose),
              new MiniProfiler("-task2 (tiempo invalido=>)", ProfileLevel.Verbose),
              new MiniProfiler("-task3 (tiempo invalido=>)", ProfileLevel.Verbose),
              new MiniProfiler("-task4 (tiempo invalido=>)", ProfileLevel.Verbose),
            };

      Task[] tasks = new Task[4]
            {
                Task.Factory.StartNew(() => ViewData["barcos_en_zona"]   = DaoLib.barcos_en_zona(id, newProfiler[0]) ),
                Task.Factory.StartNew(() => ViewData["barcos_salientes"] = DaoLib.barcos_salientes(id, newProfiler[1]) ),
                Task.Factory.StartNew(() => ViewData["barcos_entrantes"] = DaoLib.barcos_entrantes(id, newProfiler[2]) ),
                Task.Factory.StartNew(() => ViewData["barcazas_en_zona"] = DaoLib.barcazas_en_zona(id, newProfiler[3]) )
            };

      //Block until all tasks complete.
      Task.WaitAll(tasks);

      MiniProfiler.Current.AddProfilerResults(newProfiler[0]);
      MiniProfiler.Current.AddProfilerResults(newProfiler[1]);
      MiniProfiler.Current.AddProfilerResults(newProfiler[2]);
      MiniProfiler.Current.AddProfilerResults(newProfiler[3]);

    }

  }
}