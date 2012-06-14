using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using System.Configuration;
using System.Globalization;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace mbpc.Controllers
{
    public class ViajeCerradoController : MyController
    {

      public ActionResult modificarFechaViaje()
      {
        int viaje_id = Convert.ToInt32(Request.Form["viaje_id"]);

        DaoLib.modificar_fecha_viaje(viaje_id, Request.Form["fecha_salida"]);

        return Content("ok");
      }

      public ActionResult editarViajeFecha(string viaje_id)
      {
        ViewData["viajedata"] = DaoLib.traer_viaje(viaje_id);
        ViewData["viaje_id"] = viaje_id;
        return View();
      }

      public ActionResult nuevaCarga(string etapa_id)
      {
        var etapa = isValidEdition(int.Parse(etapa_id));
        if (etapa == null)
        {
          throw new Exception("No puede crear una carga en una etapa creada por otra costera.");
        }

        ViewData["isNew"] = true;
        //ViewData["unidad_id"] = new SelectList(to_array(DaoLib.traer_unidades()), "ID", "NOMBRE", 0);
        ViewData["etapa_id"] = etapa_id;
        return View("editarCarga");
      }

      public ActionResult editarCarga(string carga_id)
      {
        var tmp = (Dictionary<string,string>)DaoLib.traer_carga(carga_id);

        var etapa = isValidEdition(int.Parse(tmp["ETAPA_ID"]));
        if (etapa == null)
        {
          throw new Exception("No puede editar la carga de una etapa creada por otra costera.");
        }

        ViewData["carga"]    = tmp;
        ViewData["carga_id"] = carga_id;
        ViewData["unidad_id"] = tmp["UNIDAD_ID"];
        ViewData["unidad"] = ((Dictionary<string, string>)tmp)["UNIDAD"];
        //ViewData["unidad_id"] = new SelectList(to_array(DaoLib.traer_unidades()), "ID", "NOMBRE", ((Dictionary<string, string>)tmp)["UNIDAD_ID"] );
        
        return View();
      }

      private System.Collections.IEnumerable to_array( List<object> list )
      {
        return list.Select(f => new { @ID = ((Dictionary<string, string>)f)["ID"], @NOMBRE = ((Dictionary<string, string>)f)["NOMBRE"] }).ToList();
      }

      public ActionResult eliminarCarga(string carga_id)
      {
        DaoLib.eliminar_carga(int.Parse(carga_id), 0);
        return Content("ok");
      }

      public ActionResult modificar(string en_adelante)
      {
        int etapa_id = Convert.ToInt32(Request.Form["etapa_id"]);
        
        Dictionary<string, string> etapa = isValidEdition(etapa_id);
        if (etapa==null)
        {
          throw new Exception("No puede editar una Etapa creada por otra costera.");
        }

        string desde_id = Request.Form["desde_id"];
        string hasta_id = Request.Form["hasta_id"];
        
        if( en_adelante == null )
          DaoLib.modificar_extremos_etapa(etapa_id, desde_id, hasta_id);
        else
          DaoLib.modificar_extremos_etapa_ex(etapa_id, desde_id, hasta_id);

        return Content("ok");
      }

      public ActionResult modificarCarga(
        string carga_id,
        string tipocarga_id,
        string cantidad_inicial,
        string cantidad_entrada,
        string cantidad_salida,
        string unidad_id,
        string en_barcaza,
        string barcaza_id,
        string en_transito,
        string isnew,
        string etapa_id
        )
      {
        if (en_barcaza == "false")
          barcaza_id = null;

        //Checkear unidades
        //HACK : Unidad id = 3
        if( unidad_id == "3" )
        {
          cantidad_inicial = integerString(cantidad_inicial);
          cantidad_entrada = integerString(cantidad_entrada);
          cantidad_salida = integerString(cantidad_salida);
        }

        en_transito = en_transito != "false" ? "1" : "0";
        DaoLib.crear_editar_carga(isnew, etapa_id, carga_id, tipocarga_id, cantidad_inicial, cantidad_entrada, cantidad_salida, unidad_id, barcaza_id, en_transito);

        return Content("ok");
      }

      public ActionResult modificarFecha(string en_adelante)
      {
        int etapa_id = Convert.ToInt32(Request.Form["etapa_id"]);

        Dictionary<string, string> etapa = isValidEdition(etapa_id);
        if (etapa == null)
        {
          throw new Exception("No puede editar una Etapa creada por otra costera.");
        }

        
        DaoLib.modificar_fecha_etapa(etapa_id, Request.Form["fecha_salida"]);
        
        return Content("ok");
      }

      public ActionResult editarEtapa(string id)
      {
        int etapa_id = Convert.ToInt32(id);
        Dictionary<string, string> etapa = isValidEdition(etapa_id);
        if (etapa == null)
        {
          throw new Exception("No puede editar una Etapa creada por otra costera.");
        }

        ViewData["etapa"] = etapa;
        ViewData["etapa_id"] = id;

        return View();
      }

      public ActionResult editarEtapaFecha(string id)
      {
        int etapa_id = Convert.ToInt32(id);
        Dictionary<string, string> etapa = isValidEdition(etapa_id);
        if (etapa == null)
        {
          throw new Exception("No puede editar una Etapa creada por otra costera.");
        }

        ViewData["etapa"] = etapa;
        ViewData["etapa_id"] = id;

        return View();
      }

      public ActionResult Index(string msg)
      {
        Session["grupos"] = null;

        if (Session["logged"] == null || int.Parse(Session["logged"].ToString()) == 0)
        {
          if (Request.UrlReferrer == null)
            Session["toreports"] = "true";

          return this.RedirectToAction("ShowForm", "Auth");
        }

        ViewData["datos_del_usuario"] = DaoLib.datos_del_usuario(Session["usuario"].ToString());

        if(!String.IsNullOrEmpty(msg))
        { 
          string message="";
          msg = msg.ToUpper();
          /*if (msg == "DEL")
            message = "Etapa borrada satisfactoriamente!";
          if (msg == "ADD")
            message = "Etapa creada satisfactoriamente!";*/
          if (msg == "MOD")
            message = "La etapa fue modificada satisfactoriamente.";
          if (msg == "COST")
            message = "No se puede borrar un PBIP creado por otra costera.";

          if (message != "")
          {
            ViewData["result_message"] = message;
            ViewData["result_type"] = msg == "COST" ? "err" : "success";
          }
        }
        
        return View();
      }

      public ActionResult verEtapas(int id)
      {
        ViewData["datos_del_usuario"] = DaoLib.datos_del_usuario(Session["usuario"].ToString());
        ViewData["viajeId"] = id;
        return View("Index");
      }


      public ActionResult ListCargasJSON(string sidx, string sord, int page, int rows)
      {
        var columns = new Dictionary<string, string> { 
          {"ID","i"},
          { "NOMBRE","s"},
          { "CANTIDAD","i"},
          { "CANTIDAD_INICIAL","i"},
          { "CANTIDAD_ENTRADA","i"},
          { "CANTIDAD_SALIDA","i"},
          { "UNIDAD","s"},
          { "CODIGO","s"},
          { "BARCAZA","s"},
          { "ETAPA_ID", "i"}
        };

        var tmp = JQGrid.JQGridUtils.PaginageS1("VW_CARGA_ETAPA", Request.Params, columns, page, rows, sidx, sord);

        var cmdcount = new OracleCommand((string)tmp[2]);
        int cnt = int.Parse(((Dictionary<string, string>)DaoLib.doSQL(cmdcount)[0])["TOTAL"]);

        var cmd = new OracleCommand((string)tmp[0]);
        cmd.Parameters.AddRange((OracleParameter[])tmp[1]);
        var items = DaoLib.doSQL(cmd);

        var coso = JQGrid.JQGridUtils.PaginateS2(items, columns, cnt, page, rows);

        return Json(coso, JsonRequestBehavior.AllowGet);
      }

      public ActionResult ListEtapasJSON(string sidx, string sord, int page, int rows)
      {
        var columns = new Dictionary<string, string> { 
          {"ID","i"},
          { "DESCRIPCION","s"},
          { "VIAJE_ID","i"},
          { "NRO_ETAPA","i"},
          { "ORIGEN_DESC","s"},
          { "DESTINO_DESC","s"},
          { "HRP","d"},
          { "FECHA_SALIDA","d"},
          { "FECHA_LLEGADA","d"},
          { "CREATED_AT","d"}
        };

        var tmp = JQGrid.JQGridUtils.PaginageS1("VW_ETAPA_VIAJE", Request.Params, columns, page, rows, sidx, sord);

        var cmdcount = new OracleCommand((string)tmp[2]);
        int cnt = int.Parse(((Dictionary<string, string>)DaoLib.doSQL(cmdcount)[0])["TOTAL"]);

        var cmd = new OracleCommand((string)tmp[0]);
        cmd.Parameters.AddRange((OracleParameter[])tmp[1]);
        var items = DaoLib.doSQL(cmd);

        var coso = JQGrid.JQGridUtils.PaginateS2(items, columns, cnt, page, rows);

        return Json(coso, JsonRequestBehavior.AllowGet);
      }

      public ActionResult ListJSON(string sidx, string sord, int page, int rows)
      {
        var columns = new Dictionary<string, string> { 
          {"ID","i" },
          {"NOMBRE","s" },
          {"NRO_OMI","s" },
          {"MATRICULA","s" },
          {"SDIST","d" },
          {"BANDERA","s" },
          {"ORIGEN","s" },
          {"DESTINO","S" },
          {"FECHA_SALIDA","d" },
          {"ACTUAL","s" },
          {"NOTAS","s" },
          {"ESTADO","s" }
        };

        //Agregamos a mano el filtro
        var tmp = JQGrid.JQGridUtils.PaginageS1("VW_VIAJES_MARITIMOS", Request.Params, columns,
                      page, rows, sidx, sord);

        var cmdcount = new OracleCommand((string)tmp[2]);
        int cnt = int.Parse(((Dictionary<string, string>)DaoLib.doSQL(cmdcount)[0])["TOTAL"]);

        var cmd = new OracleCommand((string)tmp[0]);
        cmd.Parameters.AddRange((OracleParameter[])tmp[1]);
        var items = DaoLib.doSQL(cmd);

        var coso = JQGrid.JQGridUtils.PaginateS2(items, columns, cnt, page, rows);

        return Json(coso, JsonRequestBehavior.AllowGet);
      }

      private Dictionary<string, string> isValidEdition(int etapa_id)
      {
        var etapa = DaoLib.traer_etapa_viaje(etapa_id) as Dictionary<string, string>;

        //Super user?
        string[] power_users = ConfigurationManager.AppSettings["power_users"].Split(',');
        if (power_users.Contains(Session["usuario"].ToString()))
          return etapa;

        //CERATED_BY de la etapa es de un usuario con el mismo destino mio?
        var datos = DaoLib.datos_del_usuario(Session["usuario"].ToString());
        var destino = (datos[0] as Dictionary<string, string>)["DESTINO"];

        if (etapa["DESTINO"] == destino) 
          return etapa; 

        return null;
      }
    }
}
