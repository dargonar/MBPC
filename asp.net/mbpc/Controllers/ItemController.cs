﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Oracle.DataAccess.Client;

namespace mbpc.Controllers
{
    public class ItemController : Controller
    {


      public JsonResult crearBuque(string nombre, string matricula, string sdist, string bandera, string internacional, string servicio)
      {
        if (internacional != "1")
          return Json(DaoLib.crear_buque(nombre, matricula, sdist, servicio));
        else
          return Json(DaoLib.crear_buque_int(nombre, matricula, sdist, bandera));
      }

      public ActionResult nuevoBuque()
      {
        ViewData["menu"] = "buque";
        ViewData["banderas"] = DaoLib.traer_banderas();
        return View();
      }

      public ActionResult nuevoPractico()
      {
        ViewData["menu"] = "practico";
        return View();
      }

      public JsonResult crearMuelle(string puerto, string instport, string mNombre)
      {
        return Json(DaoLib.crear_muelle(puerto, instport, mNombre));
      }

      public ActionResult nuevoMuelle()
      {
        ViewData["puertos"] = DaoLib.traer_puertos();
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