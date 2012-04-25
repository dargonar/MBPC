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

      public ActionResult ListEtapasJSON(string sidx, string sord, int page, int rows)
      {
        var columns = new Dictionary<string, string> { 
          {"ID","i"},
          { "VIAJE_ID","i"},
          { "NRO_ETAPA","i"},
          { "ORIGEN_DESC","s"},
          { "DESTINO_DESC","s"},
          { "HRP","d"},
          { "ETA","d"},
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
          {"ACTUAL","i"},
          {"ID","i" },
          {"NOMBRE","s" },
          {"NRO_OMI","s" },
          {"MATRICULA","s" },
          {"SDIST","d" },
          {"BANDERA","s" },
          {"ORIGEN","s" },
          {"DESTINO","S" },
          {"FECHA_SALIDA","d" },
          {"ETA","d" },
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
