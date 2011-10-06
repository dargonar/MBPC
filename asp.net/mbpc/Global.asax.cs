using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace mbpc
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        public static void RegisterRoutes(RouteCollection routes)
        {

            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");


            routes.MapRoute(
              "AutoComplete",                            // Route name
              "AutoComplete/{action}/{query}",                   // URL with parameters
              new { controller = "AutoComplete",  query = ""}
            );

            routes.MapRoute(
              "AutoCompleteRefer",                            // Route name
              "AutoComplete/{action}/{refer}/{query}",                   // URL with parameters
              new { controller = "AutoComplete", query = "" }
            );

            routes.MapRoute(
              "IndicarProximoDestino_PasarBarco_EliminarEditarAgregarCarga",                            // Route name
              "Viaje/{action}/{viaje_id}/{id2}",                   // URL with parameters
              new { controller = "Viaje" }
            );


            routes.MapRoute(
              "EditarBarcazas",                              // Route name
              "Carga/editarBarcazas/{shipfrom}/{shipto}",                   // URL with parameters
              new { controller = "Carga", action = "editarBarcazas" }
            );


            routes.MapRoute(
              "EliminarEditarAgregarCarga",                  // Route name
              "Carga/{action}/{etapa_id}",                   // URL with parameters
              new { controller = "Carga" }
            );


            routes.MapRoute(
              "TraerInstalacionPortuaria",                            // Route name
              "Item/instport/{puerto}",                   // URL with parameters
              new { controller = "Item", action = "instport" }
            );

            routes.MapRoute(
              "SeleccionMuelles",                                 // Route name
              "Item/seleccionMuelles/{campo}",                   // URL with parameters
              new { controller = "Item", action = "seleccionMuelles", campo = "1" }
            );


            routes.MapRoute(
              "ZonasAdyacentes",                              // Route name
              "Home/zonasAdyacentes/{zona}/{viaje}/{pasar}",                   // URL with parameters
              new { controller = "Home", action = "zonasAdyacentes", pasar = "true" },
              new { zona = @"\d+" }
            );
  
            routes.MapRoute(
              "Home",                    // Route name
              "",                        // URL with parameters
              new { controller = "Home", action = "Index" }
            );

            routes.MapRoute(
              "AuthShowForm",            // Route name
              "auth",                    // URL with parameters
              new { controller = "Auth", action = "ShowForm" }
            );


            routes.MapRoute(
              "POSTRequests",                            // Route name
              "{controller}/{action}",                   // URL with parameters
              new { }
            );


            routes.MapRoute(
                "Admin", // Route name
                "{admin}/", // URL with parameters
                new { controller = "admin", action = "Index" } // Parameter defaults
            );

            routes.MapRoute(
                "pager", // Route name
                "admin/pager/{tabla}/{orderby}/{pagina}/{cantidad}", // URL with parameters
                new { controller = "admin", action = "pager", order_by = 1, pagina = 1, cantidad = 10 } // Parameter defaults
            );

            routes.MapRoute(
                "Default", // Route name
                "{controller}/{action}/{id}", // URL with parameters
                new { controller = "Home", action = "Index", id = UrlParameter.Optional } // Parameter defaults
            );

            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

        }

        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            RegisterRoutes(RouteTable.Routes);
        }

    }

}