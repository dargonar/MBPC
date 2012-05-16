using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace mbpc.Controllers
{
    public class CargaController : MyController
    {

      public ActionResult editarTipo(string carga_id)
      {
        var carga = DaoLib.traer_carga(carga_id) as Dictionary<string, string>;
        ViewData["carga"] = carga;
        return View();
      }

      public ActionResult modificarTipo(string ETAPA_ID, string CARGA_ID, string UNIDAD_ID, string TIPOCARGA_ID)
      {
        DaoLib.modificar_tipo_carga(CARGA_ID, UNIDAD_ID, TIPOCARGA_ID);
        return RedirectToAction("ver", "Carga", new { etapa_id = Int32.Parse(ETAPA_ID), refresh_viajes = "1" });
      }

      public ActionResult adjuntar_barcazas(int etapa_id, int[] barcazas)
      {
        int[] etapas_ids = new int[barcazas.Length];
        for(int i=0; i<etapas_ids.Length; i++) etapas_ids[i] = etapa_id;

        DaoLib.adjuntar_barcazas(etapas_ids, barcazas);
        // Para actualizar listado de barcazas de viaje. HACK
        DaoLib.actualizar_listado_de_barcazas(etapa_id.ToString());
        return RedirectToAction("ver", "Carga", new { etapa_id = etapa_id, refresh_viajes = "1" });
      }

      public ActionResult seleccionar_nueva_barcaza(int etapa_id, int barcaza_id)
      {
        ViewData["etapa_id"] = etapa_id;
        ViewData["barcaza_id"] = barcaza_id;
        return View();
      }

      public ActionResult corregir_barcaza(int buque_id, int etapa_id, int barcaza_id)
      {
        DaoLib.corregir_barcaza(etapa_id, buque_id, barcaza_id);
        return RedirectToAction("ver", "Carga", new { etapa_id = etapa_id });
      }


      public ActionResult barcazas_fondeadas(int etapa_id)
      {
        ViewData["etapa_id"] = etapa_id;
        ViewData["barcazas_en_zona"] = DaoLib.barcazas_en_zona(Session["zona"].ToString(), null);
        return View();
      }

      public ActionResult fondear_barcaza(int etapa_id, int barcaza_id, string riocanal, string pos, string fecha)
      {
        var latlon = DaoLib.parsePos(pos);

        DaoLib.fondear_barcaza(etapa_id, barcaza_id, riocanal, latlon[0], latlon[1], fecha);

        // Para actualizar listado de barcazas de viaje. HACK
        DaoLib.actualizar_listado_de_barcazas(etapa_id.ToString());
        
        return RedirectToAction("ver", "Carga", new { etapa_id = etapa_id, refresh_viajes = "1" });
      }

      /// <summary>
      /// Fondea múltiples barcazas de una sola vez.
      /// </summary>
      /// <param name="etapa_id"></param>
      /// <param name="barcaza_id"></param>
      /// <param name="riocanal"></param>
      /// <param name="pos"></param>
      /// <param name="fecha"></param>
      /// <returns></returns>
      public ActionResult fondear_barcazas_multiple(int etapa_id, string barcaza_id, string riocanal, string pos, string fecha)
      {
        var latlon = DaoLib.parsePos(pos);

        List<int> etapas = new List<int>();
        List<int> barcazas = new List<int>();
        List<string> riocanales= new List<string>(); 
        List<decimal?> lats = new List<decimal?>();
        List<decimal?> lons = new List<decimal?>();
        List<string> fechas = new List<string>();

        foreach (string barcaza in barcaza_id.Split(','))
          if (!String.IsNullOrEmpty(barcaza))
          {
            etapas.Add(Convert.ToInt32(etapa_id));
            barcazas.Add(Convert.ToInt32(barcaza));

            riocanales.Add(riocanal);
            lats.Add(latlon[0]);
            lons.Add(latlon[1]);
            fechas.Add(fecha);

          }

        DaoLib.fondear_barcazas_multiple(etapas.ToArray(), barcazas.ToArray(), riocanales.ToArray(), lats.ToArray(), lons.ToArray(), fechas.ToArray());

        // Para actualizar listado de barcazas de viaje. HACK
        DaoLib.actualizar_listado_de_barcazas(etapa_id.ToString());

        return RedirectToAction("ver", "Carga", new { etapa_id = etapa_id, refresh_viajes = "1" });
      }

      public ActionResult zona_fondeo(int etapa_id, int barcaza_id)
      {
        ViewData["etapa_id"] = etapa_id;
        ViewData["barcaza_id"] = barcaza_id;
        ViewData["post_url"] = "fondear_barcaza";
        return View();
      }

      public ActionResult zona_fondeo_multiple(int etapa_id, string barcaza_id)
      {
        ViewData["etapa_id"] = etapa_id;
        ViewData["barcaza_id"] = barcaza_id;
        ViewData["post_url"] = "fondear_barcazas_multiple";
        return View("zona_fondeo");
      }

      public ActionResult descargar_barcaza(int etapa_id, int barcaza_id)
      {
        DaoLib.descargar_barcaza(etapa_id, barcaza_id);
        return RedirectToAction("ver", "Carga", new { etapa_id = etapa_id });
      }

      /// <summary>
      /// Descarga múltiples barcazas de una sola vez.
      /// </summary>
      /// <param name="etapa_id"></param>
      /// <param name="barcaza_id"></param>
      /// <returns></returns>
      public ActionResult descargar_multiples_barcazas(string etapa_id, string barcazas_id)
      {
        List<int> etapas = new List<int>();
        List<int> barcazas = new List<int>();
        foreach (string barcaza_id in barcazas_id.Split(','))
          if(!String.IsNullOrEmpty(barcaza_id))
          {
            etapas.Add(Convert.ToInt32(etapa_id));
            barcazas.Add(Convert.ToInt32(barcaza_id));
          }

        DaoLib.descargar_multiples_barcazas(barcazas.ToArray(), etapas.ToArray());
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

      public ActionResult modificar(int carga_id, string tipo_modif, string cantidad_actual, string cantidad_entrada, string cantidad_salida, int etapa_id)
      {
        if (tipo_modif == null)
        {
          cantidad_entrada = cantidad_entrada.Replace(',', '.');
          cantidad_salida = cantidad_salida.Replace(',', '.');
          DaoLib.modificar_carga(carga_id, cantidad_entrada, cantidad_salida);
        }
        else
        {
          cantidad_actual = cantidad_actual.Replace(',', '.');
          DaoLib.modificar_carga_actual(carga_id, cantidad_actual);
        }
        
        return RedirectToAction("ver", "Carga", new { etapa_id = etapa_id });
      }

      public ActionResult eliminar(int carga_id, int etapa_id)
      {
        DaoLib.eliminar_carga(carga_id);
        return RedirectToAction("ver", "Carga", new { etapa_id = etapa_id });
      }

      public ActionResult agregar(int etapa_id, int carga_id, string cantidad, int unidad_id, string buque_id, string en_transito)
      {
        int m_en_transito = String.IsNullOrEmpty(en_transito) ? 0 : 1;
        ViewData["results"] = DaoLib.insertar_carga(etapa_id, carga_id, cantidad, unidad_id, buque_id, m_en_transito);

        // Para actualizar listado de barcazas de viaje. HACK
        DaoLib.actualizar_listado_de_barcazas(etapa_id.ToString());

        return RedirectToAction("ver", "Carga", new { etapa_id = etapa_id, refresh_viajes="1" });
      }

      public ActionResult barcoenzona(int etapa_id, int viaje_id, string carga)
      {
        ViewData["viaje_id"] = viaje_id;
        ViewData["etapa_id"] = etapa_id;
        ViewData["carga"]    = carga;

        ViewData["barcos_en_zona"] = DaoLib.barcos_en_zona(Session["zona"].ToString(), null);
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

      public ActionResult pasarCargas(string shipfrom, string shipto)
      {
        ViewData["buque_origen"] = DaoLib.traer_buque_de_etapa(shipfrom);
        ViewData["buque_destino"] = DaoLib.traer_buque_de_etapa(shipto);

        ViewData["etapa_origen"] = shipfrom;
        ViewData["etapa_destino"] = shipto;

        var tmp = DaoLib.traer_cargas_nobarcazas(int.Parse(shipfrom));
        tmp.AddRange(DaoLib.traer_cargas_nobarcazas(int.Parse(shipto)));

        if (tmp.Count == 0)
          return View("noHayCargas");

        var cargas = new Dictionary<string, Dictionary<string, Dictionary<string,string>> >();

        foreach (Dictionary<string,string> carga in tmp)
        {
          if( !cargas.Keys.Contains(carga["TIPOCARGA_ID"]) )
          {
            cargas[carga["TIPOCARGA_ID"]] = new Dictionary<string, Dictionary<string, string>>();
            cargas[carga["TIPOCARGA_ID"]]["from"] = null;
            cargas[carga["TIPOCARGA_ID"]]["to"] = null;
          }

          if (carga["ETAPA_ID"] == shipfrom)
            cargas[carga["TIPOCARGA_ID"]]["from"] = carga;
          else
            cargas[carga["TIPOCARGA_ID"]]["to"] = carga;
        }

        ViewData["cargas"] = cargas;

        return View();
      }




      public ActionResult separarConvoy(string viaje_id, string id2, string fecha)
      {
        List<object> etapa_to_list = DaoLib.separar_convoy(viaje_id, fecha);

        if (etapa_to_list.Count == 0)
          throw new Exception("No tiene acompanantes");
        
        Dictionary<string, string> etapa_to = etapa_to_list[0] as Dictionary<string, string>;
        return RedirectToAction("editarBarcazas", new { shipfrom = id2, shipto = etapa_to["ID"] });
      }

       
      public ActionResult transferirCargas()
      {

        var etapa_id = new List<string>();
        var carga_id = new List<string>();
        var cantidad = new List<string>();
        var unidad_id = new List<string>();
        var tipo_id = new List<string>();
        var modo = new List<string>();
        var original = new List<string>();
        var recibeemite = new List<string>();

        var total = int.Parse(Request.Params["cargas"]);
        for (int i = 0; i < total; i++)
        {

          var eid = Request[string.Format("carga{0}[eid]",i+1)];
          var cid = Request[string.Format("carga{0}[cid]",i+1)];
          var uid = Request[string.Format("carga{0}[uid]",i+1)];
          var val = Request[string.Format("carga{0}[val]",i+1)];
          var tci = Request[string.Format("carga{0}[tci]",i+1)];
          var oci = Request[string.Format("carga{0}[oci]",i+1)];
          var org = Request[string.Format("carga{0}[org]",i+1)];
            
          
          string ree = string.Empty;          

          etapa_id.Add(eid);
          carga_id.Add(cid);
          unidad_id.Add(uid);
          cantidad.Add(val);
          tipo_id.Add(tci);
          original.Add(oci);

          //No tenia esta carga?
          if (cid == "-1")
          {
            modo.Add("add");
            ree = "rec";
          }
          //Tenia la carga
          else
          {
            //Y ahora se la sacaron toda
            if (val == "0")
            {
              modo.Add("del");
              ree = "emi";
            }
            else
            {
              modo.Add("upd");
              if (int.Parse(val) > int.Parse(org))
                ree = "rec";
              else
                ree = "emi";
            }
          }

          recibeemite.Add(ree);

        }

        DaoLib.transferir_cargas(etapa_id.ToArray(), carga_id.ToArray(), cantidad.ToArray(),
          unidad_id.ToArray(), tipo_id.ToArray(), modo.ToArray(), original.ToArray(), recibeemite.ToArray());


        return null;
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

        // Para actualizar listado de barcazas de viaje. HACK
        DaoLib.actualizar_listado_de_barcazas(etapa_origen);
        DaoLib.actualizar_listado_de_barcazas(etapa_destino);

        barcazas_origen.Concat(barcazas_destino);

        return View();
      }
    }
}
