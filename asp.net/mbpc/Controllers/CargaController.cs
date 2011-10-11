﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace mbpc.Controllers
{
    public class CargaController : Controller
    {
      public ActionResult adjuntar_barcazas(int etapa_id, int[] barcazas)
      {
        int[] etapas_ids = new int[barcazas.Length];
        for(int i=0; i<etapas_ids.Length; i++) etapas_ids[i] = etapa_id;

        DaoLib.adjuntar_barcazas(etapas_ids, barcazas);
        return RedirectToAction("ver", "Carga", new { etapa_id = etapa_id, refresh_viajes = "1" });
      }

      public ActionResult barcazas_fondeadas(int etapa_id)
      {
        ViewData["etapa_id"] = etapa_id;
        ViewData["barcazas_en_zona"] = DaoLib.barcazas_en_zona(Session["zona"].ToString());
        return View();
      }

      public ActionResult fondear_barcaza(int etapa_id, int barcaza_id, string riocanal, string pos, string fecha)
      {
        var latlon = DaoLib.parsePos(pos);

        DaoLib.fondear_barcaza(etapa_id, barcaza_id, riocanal, latlon[0], latlon[1], fecha);
        return RedirectToAction("ver", "Carga", new { etapa_id = etapa_id, refresh_viajes = "1" });
      }

      public ActionResult zona_fondeo(int etapa_id, int barcaza_id)
      {
        ViewData["etapa_id"] = etapa_id;
        ViewData["barcaza_id"] = barcaza_id;
        return View();
      }

      public ActionResult descargar_barcaza(int etapa_id, int barcaza_id)
      {
        DaoLib.descargar_barcaza(etapa_id, barcaza_id);
        return RedirectToAction("ver", "Carga", new { etapa_id = etapa_id });
      }

      public ActionResult nueva(int etapa_id)
      {
        ViewData["etapa_id"] = etapa_id;
        ViewData["unidades"] = DaoLib.traer_unidades();
        return View();
      }

      public ActionResult ver(int etapa_id, string refresh_viajes)
      {
        var res = new Dictionary<string, List<object>>();

        var cargas = DaoLib.traer_cargas(etapa_id);
        foreach( Dictionary<string,string> carga in cargas )
        {
          var key = carga["BARCAZA"];
          if( key == "" )
            key = "?no%bark?";

          if (!res.Keys.Contains(key))
          {
            res[key] = new List<object>();
          }

          res[key].Add(carga);
        }

        ViewData["results"]   = res;
        ViewData["etapa_id"]  = etapa_id;
        ViewData["refresh_viajes"] = refresh_viajes;

        return View();
      }

      public ActionResult modificar(int carga_id, int cantidad_entrada, int cantidad_salida, int etapa_id)
      {
        DaoLib.modificar_carga(carga_id, cantidad_entrada, cantidad_salida);
        //return Content("ok");
        return RedirectToAction("ver", "Carga", new { etapa_id = etapa_id });
      }

      public ActionResult eliminar(int carga_id, int etapa_id)
      {
        DaoLib.eliminar_carga(carga_id);
        return RedirectToAction("ver", "Carga", new { etapa_id = etapa_id });
      }

      public ActionResult agregar(int etapa_id, int carga_id, int cantidad, int unidad_id, string buque_id, string en_transito)
      {
        int m_en_transito = String.IsNullOrEmpty(en_transito) ? 0 : 1;
        ViewData["results"] = DaoLib.insertar_carga(etapa_id, carga_id, cantidad, unidad_id, buque_id, m_en_transito);
        return RedirectToAction("ver", "Carga", new { etapa_id = etapa_id });
      }


      public ActionResult barcoenzona(int etapa_id, int viaje_id)
      {
        ViewData["viaje_id"] = viaje_id;
        ViewData["etapa_id"] = etapa_id;

        ViewData["barcos_en_zona"] = DaoLib.barcos_en_zona(Session["zona"].ToString());
        var i = 0;
        foreach (Dictionary<string, string> barco in (ViewData["barcos_en_zona"] as List<object>))
        {
          if (barco["ETAPA_ID"] == etapa_id.ToString()) continue;
          i++;
        }
        if (i == 0) return View("noHayBarcos");

        return View();
      }





      public ActionResult editarBarcazas(string shipfrom, string shipto)
      {
        //seleccion barcazas

        ViewData["buque_origen"] = DaoLib.traer_buque_de_etapa(shipfrom);
        ViewData["buque_destino"] = DaoLib.traer_buque_de_etapa(shipto);

        ViewData["etapa_origen"] = shipfrom;
        ViewData["etapa_destino"] = shipto;

        ViewData["barcazas1"] = DaoLib.traer_barcazas(shipfrom);
        ViewData["barcazas2"] = DaoLib.traer_barcazas(shipto);

        if ((ViewData["barcazas1"] as List<object>).Count == 0 && (ViewData["barcazas2"] as List<object>).Count == 0)
          return View("noHayBarcazas");

        return View();
      }



      public ActionResult separarConvoy(string viaje_id, string id2, string fecha)
      {
        List<object> etapa_to_list = DaoLib.separar_convoy(viaje_id, fecha);
        Dictionary<string, string> etapa_to = etapa_to_list[0] as Dictionary<string, string>;
        return RedirectToAction("editarBarcazas", new { shipfrom = id2, shipto = etapa_to["ID"] });
      }




      public ActionResult transferirBarcazas(string[] barcazas_origen, string[] barcazas_destino, string etapa_origen, string etapa_destino)
      {

        List<string> xxxx = new List<string>();

        if (barcazas_origen == null)
          barcazas_origen = new string[0];

        if (barcazas_destino == null)
          barcazas_destino = new string[0];

        int i;
        for (i = 0; i < barcazas_origen.Length; i++)
        {
          xxxx.Add(etapa_origen);
        }

        int j;
        for (j = 0; j < barcazas_destino.Length; j++)
        {
          xxxx.Add(etapa_destino);
        }

        string[] etapas = xxxx.ToArray();
        string[] barcazas = barcazas_origen.Concat(barcazas_destino).ToArray();

        DaoLib.transferir_barcazas(barcazas, etapas);

        barcazas_origen.Concat(barcazas_destino);

        return View();
      }
    }
}
