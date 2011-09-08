using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace mbpc.Controllers
{
    public class AuthController : Controller
    {
        public ActionResult ShowForm()
        {
            return View();
        }

        public ActionResult Login()
        {
          //Validar usuario

          bool logok = DaoLib.loguser(Request.Form["username"], Request.Form["password"]);
          if( logok == false )
          {
            if (!TempData.ContainsKey("error")) 
              ViewData["error"] = "Usuario / Password invalido";
            else
              ViewData["error"] = TempData["error"];
            return View("ShowForm");
          }

          //Marcar sesion logeado
          Session["logged"] = 1;
          Session["usuario"] = Request.Form["username"];
          return Redirect( Url.Content("~/") );

        }

        public ActionResult Logout()
        {
          //Marcar sesion deslogeado
          Session["logged"] = 0;
          return Redirect(Url.Content("~/"));
        }
    }
}
