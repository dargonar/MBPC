using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using mbpc_admin;

namespace mbpc_admin.Controllers
{
  public class MyController : Controller
  {
    public static int _HACKID_ = 9999999;

    private NewEntities _context = null;

    public NewEntities context
    {
      get
      {
        if (_context == null)
        {
          _context = new NewEntities();
        }

        return _context;
      }
    }

    protected override void OnResultExecuted(ResultExecutedContext filterContext)
    {
      if (_context != null)
      {
        _context.Dispose();
      }
      //checkFlash();
    }
    protected override void OnActionExecuting(ActionExecutingContext filterContext)
    {
      if (Request.Params.HasKeys() && Request.Params.Get("alone") != null)
      {
        ViewData["alone"] = "1";
      }

      base.OnActionExecuting(filterContext);
    }

    protected void checkFlash() {
      Dictionary<string, string> flash = Session["flash"] as Dictionary<string, string>;
      if (flash != null)
      {
        this.Flash(flash);
        Session.Remove("flash");
      }
    }

    public void FlashOK(string msg)
    {
      ViewData["flash"] = msg;
      ViewData["flash_type"] = "success";
    }

    public void FlashError(string error)
    {
      ViewData["flash"] = error;
      ViewData["flash_type"] = "error";
    }

    public void Flash(Dictionary<string, string> flash)
    {
      ViewData["flash"] = flash["flash"];
      ViewData["flash_type"] = flash["flash_type"];
    }

    public void FlashOKIntraSession(string msg)
    {
      var o = new Dictionary<string, string>();
      o.Add("flash", msg);
      o.Add("flash_type" , "success");
      this.Session.Add("flash", o);
    }

    public void FlashErrorIntraSession(string error)
    {
      var o = new Dictionary<string, string>();
      o.Add("flash", error);
      o.Add("flash_type", "error");
      this.Session.Add("flash", o);
    }
  }
}
