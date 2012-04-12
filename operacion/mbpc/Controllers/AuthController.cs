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

          var usr = Request.Form["username"];
          var pass = Request.Form["password"];

          //numerico?
          int dummy = 0;
          if( int.TryParse(Request.Form["username"], out dummy) == false )
          {
            usr = "0";
          }

          //Hack: no pass? te pongo uno cualquiera
          if (String.IsNullOrWhiteSpace(pass))
            pass = "String.IsNullOrWhiteSpace(pass)";

          //  Validar usuario
          //-  200:  usr no existe                       [USUARIO NO EXISTE]
          //-  100:  pass invalido                       [INVALID PASS]

          //-  0:  usuario ok / destino ok / fecha ok    [TODO OK]
          //-  1:  usuario ok / destino no               [DESTINO DISTINTO]
          //-  2:  usuario ok / destino ok / fecha no    [CUENTA VENCIDA]
          //-  4:  usuario ok / destino ok / fecha ok    [MISMO USR/PASS]

          int result = DaoLib.loguser2(usr, pass);
          
          //[TODO OK]
          if (result == 0)
          {
            var datos = DaoLib.datos_del_usuario(Request.Form["username"]);
            var acceso = (datos[0] as Dictionary<string, string>)["NIVACC"];
            
            if (String.IsNullOrWhiteSpace(acceso))
              acceso = "1";

            //Marcar sesion logeado
            Session["logged"] = 1;
            Session["usuario"] = Request.Form["username"];
            Session["acceso"] = acceso;
            return Redirect(Url.Content("~/"));
          }

          //[USUARIO NO EXISTE]
          if (result == 200)
          {
            ViewData["error"] = "El usuario no existe.<br/>Solicite acceso al sistema o nuevo usuario a través de la intranet y/o comunicarse con el int 2940.";
            return View("ShowForm");
          }

          //[INVALID USR/PASS]
          if (result == 100)
          {
            ViewData["error"] = "La contraseña es incorrecta";
            return View("ShowForm");
          }

          //[DESTINO DISTINTO]]
          if (result == 1)
          {
            ViewData["error"] = "Cambio de destino.<br/>Solicite reactivación de cuenta a través de la pagina inicial de intranet y/o comunicarse con el int 2940.";
            return View("ShowForm");
          }

          //[CUENTA VENCIDA]
          if (result == 2)
          {
            ViewData["error"] = "Cuenta vencida.<br/>Solicite reactivación de cuenta a través de la pagina inicial de intranet y/o comunicarse con el int 2940.";
            return View("ShowForm");
          }

          // 4: [MISMO USR/PASS]
          ViewData["ndoc"] = usr;
          return View("SelectNewPass");
        }

        public ActionResult cambiarPassword(string ndoc, string password, string password2)
        {
          ViewData["ndoc"] = ndoc;

          if (String.IsNullOrEmpty(password) || String.IsNullOrEmpty(password2))
          {
            ViewData["error"] = "Complete los dos campos con el misma password";
            return View("SelectNewPass");
          }

          if (password != password2)
          {
            ViewData["error"] = "Las contraseñas no coinciden";
            return View("SelectNewPass");
          }

          if (password == ndoc)
          {
            ViewData["error"] = "Las contraseña debe ser distinta al usuario.";
            return View("SelectNewPass");
          }

          string urlOK = string.Format("http://{0}/auth/ShowForm?msg=La contraseña fue actualizada, ingrese sus datos nuevamente.", Request.ServerVariables["SERVER_NAME"]);
          string urlERR = string.Format("http://{0}/auth/ShowForm?msg=La operacion no pudo realizarse", Request.ServerVariables["SERVER_NAME"]);

          string url = string.Format("http://192.168.10.231/intermedio_mbpc.asp?action=1&usr={0}&pass={1}&pagina={2}&pagina_err={3}", ndoc, password, urlOK, urlERR);
          return Redirect(url);
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
