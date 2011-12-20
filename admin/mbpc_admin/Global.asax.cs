using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace mbpc_admin
{
  // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
  // visit http://go.microsoft.com/?LinkId=9394801

  public class MvcApplication : System.Web.HttpApplication
  {
    public static void RegisterRoutes(RouteCollection routes)
    {
      routes.IgnoreRoute("{resource}.axd/{*pathInfo}");


      routes.MapRoute(
        "Home",                    // Route name
        "",                        // URL with parameters
        new { controller = "Viaje", action = "List" }
      );

      routes.MapRoute(
          "listar", // Route name
          "usuarios", // URL with parameters
          new { controller = "admin", action = "listar", pagina = 1, cantidad = 10, columna="usuario_id" } // Parameter defaults
      );

      routes.MapRoute(
          "GridData", // Route name
          "{controller}/{action}/{sidx}/{sord}/{page}/{rows}", // URL with parameters
          new { controller = "viaje", action = "griddata", sidx = "id", page = 1, rows = 10 } // Parameter defaults
      );


      routes.MapRoute(
        "AuthShowForm",            // Route name
        "auth",                    // URL with parameters
        new { controller = "Auth", action = "ShowForm" }
      );

      routes.MapRoute(
        "Carga", // Route name
        "Carga/{action}", // URL with parameters
        new { controller = "Carga", action = "Agregar" } // Parameter defaults
      );


      routes.MapRoute(
          "Default", // Route name
          "{controller}/{action}/{id}", // URL with parameters
          new { controller = "Home", action = "Index", id = UrlParameter.Optional } // Parameter defaults
      );

    }

    protected void Application_Start()
    {
      AreaRegistration.RegisterAllAreas();

      RegisterRoutes(RouteTable.Routes);
    }
  }
}