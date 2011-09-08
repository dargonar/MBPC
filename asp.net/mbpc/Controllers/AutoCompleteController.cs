using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace mbpc.Controllers
{
    public class AutoCompleteController : Controller
    {
        //
        // GET: /AutoComplete/
        public JsonResult view_buques_disponibles(string query)
        {
          //TODO: Borrar
          //System.Threading.Thread.Sleep(1000);
          var buques = new List<object>();
          if (query != "")
            {
                buques = DaoLib.autocompleterb('%' + query + '%');
            }
          return Json(buques, JsonRequestBehavior.AllowGet);
        }

        public JsonResult view_buquesjson(string query)
        {
          var buques = new List<object>();
          if (query != "")
          {
            buques = DaoLib.autocompletebactivos('%' + query + '%');
          }
          return Json(buques, JsonRequestBehavior.AllowGet);
        }


        public JsonResult view_buquesnac(string query)
        {
          var buques = new List<object>();
          if (query != "")
          {
            buques = DaoLib.autocompletebnacionales('%' + query + '%');
          }
          return Json(buques, JsonRequestBehavior.AllowGet);
        }


        public JsonResult rioscanales(string query)
        {
          var buques = new List<object>();
          if (query != "")
          {
            buques = DaoLib.autocompleterioscanales('%' + query + '%');
          }
          return Json(buques, JsonRequestBehavior.AllowGet);
        }


        public JsonResult estados(string query)
        {
          var estados = new List<object>();
          if (query != "")
          {
            estados = DaoLib.autocompleterestados('%' + query + '%');
          }

          return Json(estados, JsonRequestBehavior.AllowGet);
        }


        public JsonResult view_muelles(string query)
        {
          var muelles = new List<object>();
            if (query != "")
            {
                muelles = DaoLib.autocompletem('%' + query + '%');
            }
            return Json(muelles, JsonRequestBehavior.AllowGet);
        }

        public JsonResult cargas(string query)
        {
          //TODO: Borrar
          //System.Threading.Thread.Sleep(1000);
          var cargas = new List<object>();
          if (query != "")
          {
            cargas = DaoLib.autocomplete("tbl_tipo_carga", '%' + query + '%');
          }
          return Json(cargas, JsonRequestBehavior.AllowGet);
        }

        public JsonResult practicos(string query)
        {
          var practicos = new List<object>();
          if (query != "")
          {
            practicos = DaoLib.autocomplete("tbl_practico", '%' + query + '%');
          }
          return Json(practicos, JsonRequestBehavior.AllowGet);
        }

        public JsonResult capitanes(string query)
        {
          var capitanes = new List<object>();

          if (query != "")
          {
            capitanes = DaoLib.autocomplete("tbl_capitan", '%' + query + '%');
          }
          return Json(capitanes, JsonRequestBehavior.AllowGet);
        }

        public JsonResult traertipoxcodigo(string id)
        {
          return Json(DaoLib.traer_por_codigo(id));
        }


    }
}
