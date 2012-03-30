using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using System.Globalization;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace mbpc.Controllers
{
    public class PBIPController : Controller
    {

      public static string maskLatLon(string str_lat, string str_lon)
      {
        double lat = 0.0;
        double lon = 0.0;

        double.TryParse(str_lat, out lat);
        double.TryParse(str_lon, out lon);

        return string.Format("{0:00}{1:00}{2}{3:000}{4:00}{5}",
                                Math.Abs((int)lat), Math.Abs((int)((lat - Math.Truncate(lat)) * 100.0f)),
                                Math.Sign(lat) > 0 ? 'N' : 'S',
                                Math.Abs((int)lon), Math.Abs((int)((lon - Math.Truncate(lon)) * 100.0f)),
                                Math.Sign(lon) > 0 ? 'E' : 'W');
      }
        //
        // GET: /PBIP/
        // functions
      public ActionResult modificar(string id)
      {
        int pbpip_id = Convert.ToInt32(id);
        ViewData["pbip"] = DaoLib.pbip_obtener(pbpip_id) as Dictionary<string, string>;
        ViewData["pbip_params"] = DaoLib.pbip_obtener_params(pbpip_id);
        ViewData["id"] = id;

        return View("nuevo");
      }

      public ActionResult editar(string id)
      {
        int pbpip_id = Convert.ToInt32(id);
        ViewData["pbip"] = DaoLib.pbip_obtener(pbpip_id) as Dictionary<string, string>;
        ViewData["pbip_params"] = DaoLib.pbip_obtener_params(pbpip_id);
        ViewData["id"] = id;

        ViewData["datos_del_usuario"] = DaoLib.datos_del_usuario(Session["usuario"].ToString());

        return View("Index");
      }

      public ActionResult borrar(string id)
      {
        int pbpip_id = Convert.ToInt32(id);
        DaoLib.pbip_eliminar(pbpip_id);
        return this.RedirectToAction("Index", "PBIP", new {msg="del"});
      }

      public ActionResult nuevo()
      {
        ViewData["pbip"] = null;
        ViewData["pbip_params"] = null;
        return View();
      }

      public ActionResult guardar()
      {
        int editing_pbpip_id = 0;
        string id = Request.Form["id"];
        if (!String.IsNullOrEmpty(id))
        {
          editing_pbpip_id = Convert.ToInt32(id);
        }
        
        string viaje_id = Request.Form["viaje_id"];
        string puertodematricula = Request.Form["puertodematricula"];
        string bandera = Request.Form["bandera"];
        string nroinmarsat = Request.Form["nroinmarsat"];
        string arqueobruto = Request.Form["arqueobruto"];
        string compania = Request.Form["compania"];
        string contactoocpm = Request.Form["contactoocpm"];
        string objetivo = Request.Form["objetivo"];
        string nro_imo = Request.Form["nro_imo"];
        string buque_nombre = Request.Form["buque_nombre"];
        string tipo_buque = Request.Form["tipo_buque"];
        string distintivo_llamada = Request.Form["distintivo_llamada"];
        string nro_identif_compania = Request.Form["nro_identif_compania"];
        string puerto_llegada = Request.Form["puerto_llegada"];
        string eta = Request.Form["eta"];
        string instalacion_portuaria = Request.Form["instalacion_portuaria"];
        string cipb_estado = Request.Form["cipb_estado"];
        string cipb_expedido_por = Request.Form["cipb_expedido_por"];
        string cipb_expiracion = Request.Form["cipb_expiracion"];
        string cipb_motivo_incumplimiento = Request.Form["cipb_motivo_incumplimiento"];
        string proteccion_plan_aprobado = Request.Form["proteccion_plan_aprobado"];
        string proteccion_nivel_actual = Request.Form["proteccion_nivel_actual"];

        decimal?[] latlon = new decimal?[2];
        if (Request.Form["posicion_latlon"] != "")
        {
          latlon = DaoLib.parsePos(Request.Form["posicion_latlon"]);
        }
        //Request.Form["longitud_notif"] //posicion_latlon
        //Request.Form["latitud_notif"]  //posicion_latlon
        string plan_proteccion_mant_bab = Request.Form["plan_proteccion_mant_bab"];
        string plan_protec_mant_bab_desc = Request.Form["plan_protec_mant_bab_desc"];
        string carga_desc_gral = Request.Form["carga_desc_gral"];
        string carga_sust_peligrosas = Request.Form["carga_sust_peligrosas"];
        string carga_sust_peligrosas_desc = Request.Form["carga_sust_peligrosas_desc"];
        string lista_pasajeros = Request.Form["lista_pasajeros"];
        string lista_tripulantes = Request.Form["lista_tripulantes"];
        string prot_notifica_cuestion = Request.Form["prot_notifica_cuestion"];
        string prot_notifica_polizon = Request.Form["prot_notifica_polizon"];
        string prot_notifica_polizon_desc = Request.Form["prot_notifica_polizon_desc"];
        string prot_notifica_rescate = Request.Form["prot_notifica_rescate"];
        string prot_notifica_rescate_desc = Request.Form["prot_notifica_rescate_desc"];
        string prot_notifica_otra = Request.Form["prot_notifica_otra"];
        string prot_notifica_otra_desc = Request.Form["prot_notifica_otra_desc"];
        string agente_pto_llegada_nombre = Request.Form["agente_pto_llegada_nombre"];
        string agente_pto_llegada_tel = Request.Form["agente_pto_llegada_tel"];
        string agente_pto_llegada_mail = Request.Form["agente_pto_llegada_mail"];
        string facilitador_nombre = Request.Form["facilitador_nombre"];
        string facilitador_titulo_cargo = Request.Form["facilitador_titulo_cargo"];
        string facilitador_lugar = Request.Form["facilitador_lugar"];
        string facilitador_fecha = Request.Form["facilitador_fecha"];

        List<object> res = null;
        int lastPBIPId = editing_pbpip_id;
        if (editing_pbpip_id > 0)
        {
          res = DaoLib.pbip_modificar(editing_pbpip_id, null, puertodematricula, bandera, nroinmarsat, arqueobruto, compania, contactoocpm, objetivo, nro_imo
              , buque_nombre, tipo_buque, distintivo_llamada, nro_identif_compania, puerto_llegada, eta, instalacion_portuaria
              , cipb_estado, cipb_expedido_por, cipb_expiracion, cipb_motivo_incumplimiento, Convert.ToInt32(proteccion_plan_aprobado)
              , Convert.ToInt32(proteccion_nivel_actual) , latlon[0], latlon[1], Convert.ToInt32(plan_proteccion_mant_bab), plan_protec_mant_bab_desc, carga_desc_gral
              , Convert.ToInt32(carga_sust_peligrosas), carga_sust_peligrosas_desc, Convert.ToInt32(lista_pasajeros), Convert.ToInt32(lista_tripulantes)
              , Convert.ToInt32(prot_notifica_cuestion), Convert.ToInt32(prot_notifica_polizon)
              , prot_notifica_polizon_desc, Convert.ToInt32(prot_notifica_rescate), prot_notifica_rescate_desc, Convert.ToInt32(prot_notifica_otra)
              , prot_notifica_otra_desc
              , agente_pto_llegada_nombre, agente_pto_llegada_tel, agente_pto_llegada_mail, facilitador_nombre, facilitador_titulo_cargo
              , facilitador_lugar, facilitador_fecha);
        }
        else
        {
          res = DaoLib.pbip_nuevo (null, puertodematricula, bandera,  nroinmarsat, arqueobruto, compania, contactoocpm, objetivo, nro_imo
              , buque_nombre, tipo_buque, distintivo_llamada, nro_identif_compania, puerto_llegada, eta, instalacion_portuaria
              , cipb_estado, cipb_expedido_por, cipb_expiracion, cipb_motivo_incumplimiento, Convert.ToInt32(proteccion_plan_aprobado)
              , Convert.ToInt32(proteccion_nivel_actual), latlon[0], latlon[1], Convert.ToInt32(plan_proteccion_mant_bab), plan_protec_mant_bab_desc, carga_desc_gral
              , Convert.ToInt32(carga_sust_peligrosas), carga_sust_peligrosas_desc, Convert.ToInt32(lista_pasajeros), Convert.ToInt32(lista_tripulantes)
              , Convert.ToInt32(prot_notifica_cuestion), Convert.ToInt32(prot_notifica_polizon)
              , prot_notifica_polizon_desc, Convert.ToInt32(prot_notifica_rescate), prot_notifica_rescate_desc, Convert.ToInt32(prot_notifica_otra)
              , prot_notifica_otra_desc
              , agente_pto_llegada_nombre, agente_pto_llegada_tel, agente_pto_llegada_mail, facilitador_nombre, facilitador_titulo_cargo
              , facilitador_lugar, facilitador_fecha);
          Dictionary<string, string> resDict = ((res[0]) as Dictionary<string, string>);
          lastPBIPId = Convert.ToInt32(resDict[resDict.Keys.ElementAt(0)]);
        }

        List<int> v_tbl_pbip_id = new List<int>();
        List<int> v_tipo_param = new List<int>();
        List<int> v_indice = new List<int>();
        List<string> v_fecha_desde = new List<string>();
        List<string> v_fecha_hasta = new List<string>();
        List<string> v_descripcion = new List<string>();
        List<int> v_nivel_proteccion = new List<int>(); 
        List<int> v_escalas_medidas_adic = new List<int>();
        List<string> v_escalas_medidas_adic_desc = new List<string>();
        List<string> v_actividad_bab = new List<string>();

        // Escalas
        for (int index = 1; index < 11; index++)
        {
          v_tbl_pbip_id.Add(lastPBIPId);
          v_tipo_param.Add(Convert.ToInt32(PBPIPEnum.escalas));
          v_indice.Add(index);
          
          v_fecha_desde.Add(Request.Form["escalas_fecha_desde_" + index.ToString()]);
          v_fecha_hasta.Add(Request.Form["escalas_fecha_hasta_" + index.ToString()]);
          v_descripcion.Add(Request.Form["escalas_descripcion_" + index.ToString()]);
          
          string temp = Request.Form["escalas_nivel_proteccion_" + index.ToString()];
          v_nivel_proteccion.Add(String.IsNullOrEmpty(temp) ? 0 : Convert.ToInt32(temp));

          temp = Request.Form["escalas_medidas_adic_" + index.ToString()];
          v_escalas_medidas_adic.Add(String.IsNullOrEmpty(temp) ? 0 : Convert.ToInt32(temp));
          v_escalas_medidas_adic_desc.Add(Request.Form["escalas_medidas_adic_desc_" + index.ToString()]);
          v_actividad_bab.Add("");
          
        }

        
        // Actividades
        for (int index = 1; index < 11; index++)
        {
          v_tbl_pbip_id.Add(lastPBIPId);
          v_tipo_param.Add(Convert.ToInt32(PBPIPEnum.actividades ));
          v_indice.Add(index);
          
          v_fecha_desde.Add(Request.Form["actividades_fecha_desde_" + index.ToString()]);
          v_fecha_hasta.Add(Request.Form["actividades_fecha_hasta_" + index.ToString()]);
          v_descripcion.Add(Request.Form["actividades_descripcion_" + index.ToString()]);
          string temp = Request.Form["actividades_nivel_proteccion_" + index.ToString()];
          v_nivel_proteccion.Add(String.IsNullOrEmpty(temp) ? 0 : Convert.ToInt32(temp));
          v_escalas_medidas_adic.Add(0);
          v_escalas_medidas_adic_desc.Add("");
          v_actividad_bab.Add(Request.Form["actividades_actividad_bab_" + index.ToString()]);
          
        }

        if (editing_pbpip_id > 0)
        {
          DaoLib.pbip_eliminar_params(lastPBIPId);
        }
        
        List<object> res2 = DaoLib.pbip_nuevo_param(v_tbl_pbip_id.ToArray(), v_tipo_param.ToArray(), v_indice.ToArray(), v_fecha_desde.ToArray(), 
                    v_fecha_hasta.ToArray(), v_descripcion.ToArray(), v_nivel_proteccion.ToArray(), v_escalas_medidas_adic.ToArray(), v_escalas_medidas_adic_desc.ToArray(), 
                    v_actividad_bab.ToArray());

        if (editing_pbpip_id > 0)
          return this.RedirectToAction("Index", "PBIP", new { msg = "mod" });
        return this.RedirectToAction("Index", "PBIP", new { msg = "add" });
        //return this.RedirectToAction("editar", "PBIP", new { id = lastPBIPId.ToString() });
      }

      public enum PBPIPEnum {
        escalas, actividades
      }

      public ActionResult nuevo_viaje_desdePBIP()
      {
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
          if (msg == "DEL")
            message = "PBIP borrado satisfactoriamente!";
          if (msg == "ADD")
            message = "PBIP creado satisfactoriamente!";
          if (msg == "MOD")
            message = "PBIP modificado satisfactoriamente!";
          if (message != "")
            ViewData["result_message"] = message;
        }
        
        return View();
      }

      public ActionResult ListJSON(string sidx, string sord, int page, int rows)
      {
        var columns = new Dictionary<string, string> { 
          {"ID","i"},
          {"NRO_IMO","i" },
          {"BUQUE_NOMBRE","s" },
          {"COMPANIA","s" },
          {"OBJETIVO","s" },
          {"PUERTO_LLEGADA","s" },
          {"ETA","s" },
          {"CIPB_ESTADO","s" }
          /*
          {"ID","i"},
          {"NRO_OMI","i"},
          {"BUQUE","s"},
          {"PUERTODEMATRICULA","i"},
          {"BANDERA_ID","i"},
          {"TIPO_BUQUE","s"},
          {"SDIST","s"},
          {"NROINMARSAT","s"},
          {"ARQUEOBRUTO","s"},
          {"COMPANIA","s"},
          {"CONTACTOOCPM","s"},
          {"ETA","d"},
          {"VIAJE","s"},
          {"OBJETIVO","s"},
          {"DESTINO","s"},
          {"ORIGEN","s"}*/
        };

        //Agregamos a mano el filtro
        var tmp = JQGrid.JQGridUtils.PaginageS1("VIEW_PBIP_LISTAR", Request.Params, columns,
                      page, rows, sidx, sord);

        var cmdcount = new OracleCommand((string)tmp[2]);
        int cnt = int.Parse(((Dictionary<string, string>)DaoLib.doSQL(cmdcount)[0])["TOTAL"]);

        var cmd = new OracleCommand((string)tmp[0]);
        cmd.Parameters.AddRange((OracleParameter[])tmp[1]);
        var items = DaoLib.doSQL(cmd);

        var coso = JQGrid.JQGridUtils.PaginateS2(items, columns, cnt, page, rows);

        return Json(coso, JsonRequestBehavior.AllowGet);
      }

    }
}
