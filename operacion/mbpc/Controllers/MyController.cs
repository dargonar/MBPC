using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace mbpc.Controllers
{
  public class MyController : Controller
  {
    protected override void OnActionExecuting(ActionExecutingContext ctx) {
        base.OnActionExecuting(ctx);
        if (Session != null && Session["usuario"] != null)
          DaoLib.userid = int.Parse(Session["usuario"].ToString());
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
  }
}