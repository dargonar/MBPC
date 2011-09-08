using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace mbpc.Controllers
{
    public class CargaController : Controller
    {
        //
        // GET: /Carga/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult agregar(string viaje_id, string id2)
        {

          ViewData["unidades"] = DaoLib.traer_unidades();
          ViewData["barcazas"] = DaoLib.traer_barcazas();
          ViewData["usadas"] = DaoLib.barcazas_utilizadas();

          ViewData["etapa_id"] = id2;
          ViewData["viaje_id"] = viaje_id;
          return View();
        }


        public ActionResult editar(string viaje_id, string id2)
        {
          ViewData["results"] = DaoLib.traer_cargas(id2);
          ViewData["viaje_id"] = viaje_id;
          ViewData["etapa_id"] = id2;
          return View();
        }

        public ActionResult modificar(string viaje_id, string etapa_id, string carga_id, string cantidad)
        {
          DaoLib.modificar_carga(carga_id, cantidad);
          return RedirectToAction("editar", "Carga", new { viaje_id = viaje_id, id2 = etapa_id });
        }

        public ActionResult eliminar(string viaje_id, string etapa_id, string carga_id)
        {
          DaoLib.eliminar_carga(carga_id);
          ViewData["viaje_id"] = viaje_id;
          return RedirectToAction("editar", "Carga", new { viaje_id = viaje_id, id2 = etapa_id });
        }

        public ActionResult insertar(string viaje_id, string etapa_id, string carga_id, string cantidad, string unidad_id, string buque_id)
        {
          ViewData["results"] = DaoLib.insertar_carga(etapa_id, carga_id, cantidad, unidad_id, buque_id);
          return RedirectToAction("editar", "Carga", new { viaje_id = viaje_id, id2 = etapa_id });
        }


        public ActionResult barcoenzona(string viaje_id, string id2)
        {
          ViewData["viaje_id"] = viaje_id;
          ViewData["etapa_id"] = id2;

          ViewData["barcos_en_zona"] = DaoLib.barcos_en_zona(Session["zona"].ToString());
          var i = 0;
          foreach (Dictionary<string, string> barco in (ViewData["barcos_en_zona"] as List<object>))
          {
            if (barco["ETAPA_ID"] == id2) continue;
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



        public ActionResult separarConvoy(string viaje_id, string id2, DateTime fecha)
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
          string[] cargas = barcazas_origen.Concat(barcazas_destino).ToArray();

          DaoLib.transferir_barcazas(cargas, etapas);

          barcazas_origen.Concat(barcazas_destino);

          return View();
        }
    }
}
