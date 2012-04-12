using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Oracle.DataAccess.Client;

namespace mbpc.Controllers
{
    public class ItemController : MyController
    {
      public JsonResult crearBarcaza(string nombre, string matricula, string sdist, string bandera, string internacional, string servicio)
      {
        if (internacional != "1")
        {
          bandera = "ARGENTINA";
        }

        if (DaoLib.row_count(string.Format("buques where matricula='{0}' and bandera='{1}' and (Upper(TIPO_BUQUE) LIKE 'BARCAZA%' OR Upper(TIPO_BUQUE) LIKE 'BALSA%')", matricula, bandera)) != 0)
        {
          throw new Exception("Ya existe una barcaza con esa matricula");
        }        
        
        if (internacional != "1")
        {
          return Json(DaoLib.crear_buque(nombre, matricula, sdist, servicio,""));
        }
        else
        {
          return Json(DaoLib.crear_buque_int(nombre, matricula, sdist, bandera, servicio, ""));
        }
      }

      public ActionResult nuevaBarcaza(string barcaza)
      {
        ViewData["menu"] = "barcaza";
        ViewData["banderas"] = DaoLib.traer_banderas();
        return View();
      }

      public JsonResult crearBuque(string nombre, string matricula, string sdist, string bandera, string internacional, string servicio, string mmsi)
      {
        if (DaoLib.row_count(string.Format("buques where sdist='{0}'",sdist)) != 0)
        {
          throw new Exception("Ya existe un buque con esa senal distintiva");
        }

        if (internacional != "1")
        {
          bandera = "ARGENTINA";
          if (DaoLib.row_count(string.Format("buques where matricula='{0}' and bandera='{1}'", matricula, bandera)) != 0)
          {
            throw new Exception("Ya existe un buque nacional con esa matricula");
          }

          return Json(DaoLib.crear_buque(nombre, matricula, sdist, servicio, mmsi));
        }
        else
        {
          
          if (DaoLib.row_count(string.Format("buques where nro_omi='{0}'", matricula)) != 0)
          {
            throw new Exception("Ya existe un buque internacional con ese numero OMI");
          }

          return Json(DaoLib.crear_buque_int(nombre, matricula, sdist, bandera, servicio, mmsi));
        }
      }

      public ActionResult nuevoBuque(string barcaza)
      {
        ViewData["menu"] = "buque";
        ViewData["banderas"] = DaoLib.traer_banderas();
        ViewData["barcaza"] = barcaza;
        return View();
      }

      public ActionResult nuevoPractico()
      {
        ViewData["menu"] = "practico";
        return View();
      }

      public JsonResult crearMuelle(string cod, string puerto, string pais)
      {
        return Json(DaoLib.crear_muelle(cod, puerto, pais));
      }

      public ActionResult nuevoMuelle()
      {
        ViewData["banderas"] = DaoLib.traer_banderas();
        //ViewData["puertos"] = DaoLib.traer_puertos();
        return View();
      }

      public ActionResult seleccionBuques(string vista)
      {
        return View();
      }

      public ActionResult seleccionMuelles(string campo)
      {
        ViewData["campo"] = campo;
        return View();
      }

      public ActionResult instport(string puerto)
      {
        ViewData["instports"] = DaoLib.traer_instport(puerto);
        return View();
      }

    }

}
