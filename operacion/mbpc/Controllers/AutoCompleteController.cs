using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace mbpc.Controllers
{
  public class AutoCompleteController : MyController
  {
    public JsonResult autocomplete_viajes_grp(string query)
    {
      var grupo = Session["grupo"].ToString();

      //var barcazas = DaoLib.autocomplete_viajes_grp(query, grupo);
      var barcazas = DaoLib.autocomplete_viajes_usr(query);
      return Json(barcazas, JsonRequestBehavior.AllowGet);
    }
    
    public JsonResult barcazas(string etapa_id, string query)
    {
      var barcazas = DaoLib.autocomplete_barcazas(etapa_id, query.ToUpper());
      return Json(barcazas, JsonRequestBehavior.AllowGet);
    }

    public JsonResult buques_disponibles(string query)
    {
      //TODO: Borrar
      //System.Threading.Thread.Sleep(1000);
      var buques = new List<object>();
      if (query != "")
      {
        buques = DaoLib.autocomplete_buques_disponibles(query);
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

    public JsonResult view_buques_deptocontrol_json(string punto_id, string query)
    {
      var buques = new List<object>();
      if (query != "")
      {
        buques = DaoLib.autocompletebactivos_enpunto(punto_id, query);
      }
      return Json(buques, JsonRequestBehavior.AllowGet);
    }

    public JsonResult remolcadores(string query)
    {
      var buques = new List<object>();
      if (query != "")
      {
        buques = DaoLib.autocomplete_remolcadores(query);
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

    public JsonResult muelles(string query)
    {
      var muelles = new List<object>();
        if (query != "")
        {
          muelles = DaoLib.autocomplete_muelles(query);
        }
        return Json(muelles, JsonRequestBehavior.AllowGet);
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
      var cargas = new List<object>();
      if (query != "")
      {
        cargas = DaoLib.autocomplete_cargas(query);
      }
      return Json(cargas, JsonRequestBehavior.AllowGet);
    }

    public JsonResult practicos(string query, string etapa_id)
    {
      var practicos = new List<object>();
      if (query != "")
      {
        practicos = DaoLib.autocomplete_practicos(query, etapa_id);
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
