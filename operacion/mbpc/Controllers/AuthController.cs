using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace mbpc.Controllers
{
    public class AuthController : MyController
    {
        public ActionResult ShowForm(string msg)
        {
          ViewData["msg"] = msg;
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

          //  Validar usuario
          //  100:  usuario o pass invalido             [INVALID USERNAME]

          //  0:  usuario ok / destino ok / fecha ok    [TODO OK]
          //  1:  usuario ok / destino no               [DESTINO]
          //  2:  usuario ok / destino ok / fecha no    [VENCIDO]
          //  3:  no dni                                [NO DNI]
          //  4:  usuario ok / destino ok / fecha ok    [SAME USR/PASS]

          var usr = Request.Form["username"];
          var pass = Request.Form["password"];

          int result = DaoLib.loguser2(usr, pass);
          
          //[TODO OK]
          if (result == 0)
          {
            //Marcar sesion logeado
            Session["logged"] = 1;
            Session["usuario"] = Request.Form["username"];
            return Redirect(Url.Content("~/"));
          }

          //[INVALID USR/PASS]
          if (result == 100)
          {
            ViewData["error"] = "Combinacion de usuario / contraseña invalida";
            return View("ShowForm");
          }

          string urlOK  = string.Format("http://{0}/auth/ShowForm?msg=Vuelva a ingresar sus datos", Request.ServerVariables["SERVER_NAME"]);
          string urlERR = string.Format("http://{0}/auth/ShowForm?msg=La operacion no pudo realizarse", Request.ServerVariables["SERVER_NAME"]);

          string url = string.Format("http://192.168.10.231/intermedio.asp?errcod={0}&usr={1}&pass={2}&syscod=DICO_026&urlok={3}&urlerr={4}",result,usr,pass,urlOK,urlERR);
          return Redirect(url);

          //ViewData["error"] = "Error desconocido";
          //if (result == 2) ViewData["error"] = "Usuario no autorizado, cambio de destino.<br><a href=\"http://192.168.10.231/Dise%F1o%20Estandar/solica_usu/default.asp\">Revalidar cuenta</a>";
          //if (result == 3) ViewData["error"] = "Combinacion de usuario / contraseña invalida"; 
          //if (result == 4) ViewData["error"] = "Usuario con cuenta vencida.<br><a href=\"http://192.168.10.231/Dise%F1o%20Estandar/solica_usu/default.asp\">Revalidar cuenta</a>";
          //return View("ShowForm");
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

          //Agregar evento
          DaoLib.userid = int.Parse(Session["usuario"].ToString());
          DaoLib.login_usuario("dummy");

          if (Session["toreports"] != null)
          {
            Session["toreports"] = null;
            return RedirectToAction("Index", "Reporte");
          }

          return Redirect(Url.Content("~/"));
        }


        public ActionResult Logout()
        {
          
          DaoLib.logout_usuario("dummy");

          //Marcar sesion deslogeado
          Session["logged"] = 0;
          Session.Abandon();
          return Redirect(Url.Content("~/"));
        }
    }
}
