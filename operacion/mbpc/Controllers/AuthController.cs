using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace mbpc.Controllers
{
    public class AuthController : MyController
    {
        public ActionResult ShowForm()
        {
            return View();
        }

        public ActionResult Login2()
        {
          if (TempData.ContainsKey("error"))
          {
            ViewData["error"] = TempData["error"];
            return View("ShowForm");
          }

          //numerico?
          int dummy = 0;
          if( int.TryParse(Request.Form["username"], out dummy) == false )
          {
              ViewData["error"] = "Combinacion de usuario / contraseña invalida"; 
              return View("ShowForm");
          }

          //Validar usuario
          //  1:  usuario ok / destino ok / fecha ok
          //  2:  usuario ok / destino no
          //  3:  usuario o pass invalido
          //  4:  usuario ok / destino ok / fecha no
          int result = DaoLib.loguser2(Request.Form["username"], Request.Form["password"]);
          if (result == 1)
          {
            //Marcar sesion logeado
            Session["logged"] = 1;
            Session["usuario"] = Request.Form["username"];
            return Redirect(Url.Content("~/"));
          }

          ViewData["error"] = "Error desconocido";
          if (result == 2) ViewData["error"] = "Usuario no autorizado, cambio de destino.<br><a href=\"http://192.168.10.231/Dise%F1o%20Estandar/solica_usu/default.asp\">Revalidar cuenta</a>";
          if (result == 3) ViewData["error"] = "Combinacion de usuario / contraseña invalida"; 
          if (result == 4) ViewData["error"] = "Usuario con cuenta vencida.<br><a href=\"http://192.168.10.231/Dise%F1o%20Estandar/solica_usu/default.asp\">Revalidar cuenta</a>";

          return View("ShowForm");
        }
        
      public ActionResult Login()
      {
          //Validar usuario

          bool logok = DaoLib.loguser(Request.Form["username"], Request.Form["password"]);
          if (logok == false)
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

          if (Session["toreports"] != null)
          {
            Session["toreports"] = null;
            return RedirectToAction("Index", "Reporte");
          }

          return Redirect(Url.Content("~/"));
        }


        public ActionResult Logout()
        {
          //Marcar sesion deslogeado
          Session["logged"] = 0;
          Session.Abandon();
          return Redirect(Url.Content("~/"));
        }
    }
}
