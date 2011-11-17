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
  }
}