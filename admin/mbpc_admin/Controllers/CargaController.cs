using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Objects;
using mbpc_admin.Models;

namespace mbpc_admin.Controllers
{
    public class CargaController : MyController
    {
      public ActionResult List(string id)
      {
        ViewData["tipodecargas"] = (from c in context.TBL_TIPO_CARGA select new { id = c.ID, value = c.NOMBRE.Replace("\"", " ") }).ToArray();
        ViewData["unidades"] = (from d in context.TBL_UNIDAD select new { id = d.ID, value = d.NOMBRE }).ToArray();

        var decid = decimal.Parse(id);
        var etapa_temp = (from d in context.TBL_ETAPA where d.ID == decid select d).ToArray();
        ViewData["titulo"] = "nro " + etapa_temp[0].NRO_ETAPA + " del viaje " + etapa_temp[0].VIAJE_ID;

        if (id != null)
          ViewData["referenceId"] = id;
        
        return View();
      }


      public ActionResult Remove(int id)
      {
        FlashOK("La carga fue eliminada correctamente");

        try
        {
          var contract = context.TBL_CARGAETAPA.Where(c => c.ID == id).SingleOrDefault();
          context.TBL_CARGAETAPA.DeleteObject(contract);
          context.SaveChanges();
          ViewData["tipodecargas"] = (from c in context.TBL_TIPO_CARGA select new { id = c.ID, value = c.NOMBRE.Replace("\"", " ") }).ToArray();
          ViewData["unidades"] = (from d in context.TBL_UNIDAD select new { id = d.ID, value = d.NOMBRE }).ToArray();

          return View("List");
        }
        catch (Exception ex)
        {
          FlashError("No se pudo eliminar la carga, intente nuevamente");
        }

        ViewData["tipodecargas"] = (from c in context.TBL_TIPO_CARGA select new { id = c.ID, value = c.NOMBRE.Replace("\"", " ") }).ToArray();
        ViewData["unidades"] = (from d in context.TBL_UNIDAD select new { id = d.ID, value = d.NOMBRE }).ToArray();


        return View("List");
      }

      public ActionResult Edit(decimal id)
      {
        ViewData["titulo"] = "Editar";
        
        var cargaetapa = context.TBL_CARGAETAPA.Where(c => c.ID == id).First();
        CreateCombo(cargaetapa);
        
        ViewData["etapa_id"] = cargaetapa.ETAPA_ID;
        
        return View("New", cargaetapa);
      }

      public ActionResult New(int etapa_id)
      {
        ViewData["titulo"] = "Nueva";
        
        var cargaetapa = new TBL_CARGAETAPA();
        CreateCombo(cargaetapa);

        ViewData["etapa_id"] = etapa_id;

        return View(cargaetapa);
      }

      private void CreateCombo(TBL_CARGAETAPA cargaetapa)
      {
        
        //var barcazas = from b in context.TBL_BQ_BUQUES where b.TIPO_SERVICIO == 99 select b;
        ViewData["TIPOCARGA_ID"] = new SelectList(context.TBL_TIPO_CARGA.OrderBy(tc => tc.NOMBRE) , "ID", "NOMBRE", cargaetapa.TIPOCARGA_ID);
        ViewData["UNIDAD_ID"] = new SelectList(context.TBL_UNIDAD, "ID", "NOMBRE", cargaetapa.UNIDAD_ID.ToString());
      }

      public ActionResult Create(TBL_CARGAETAPA cargaetapa)
      {
        try
        {
          if (cargaetapa.ID == 0)
          {
            context.TBL_CARGAETAPA.AddObject(cargaetapa);
            FlashOK("La carga fue agregada con exito");
          }
          else
          {
            var updatedCargaEtapa = context.TBL_CARGAETAPA.Where(c => c.ID == cargaetapa.ID).SingleOrDefault();
            updatedCargaEtapa.SimpleCopyFrom(cargaetapa, new string[] {"TIPOCARGA_ID", "CANTIDAD", "UNIDAD_ID"});
            FlashOK("La carga se modifico con exito");
          }
          context.SaveChanges();
          
          //HACK- Cambiar cuando el connector de Oracle funcione bien
          var nuevacargaetapa = context.TBL_CARGAETAPA.OrderByDescending(c => c.ID).First();
          //HACK------------------------------------------------------

          return Edit(nuevacargaetapa.ID);
        }
        catch (Exception ex)
        {
          FlashError("Error: " + ex.Message +"\nInner: " + ex.InnerException.Message);
        }

        ViewData["title"] = "Nueva carga";
        ViewData["etapa_id"] = cargaetapa.ETAPA_ID;

        CreateCombo(cargaetapa);
        return View("New", cargaetapa);
      }


      public ActionResult ListJSON(string sidx, string sord, int page, int rows)
      {
        var columns = new string[] { "ID", "TIPOCARGA_ID", "CANTIDAD", "UNIDAD_ID", "ETAPA_ID", "BUQUE_ID" };

        var tmp = JQGrid.Helper.PaginageS1<TBL_CARGAETAPA>(Request.Params, columns, page, rows, sidx, sord);

        var items = context.ExecuteStoreQuery<TBL_CARGAETAPA>((string)tmp[0], (ObjectParameter[])tmp[1]);

        return Json(JQGrid.Helper.PaginateS2<TBL_CARGAETAPA>(
          items.ToArray(),
          columns, context.TBL_CARGAETAPA.Count(), page, rows
          ), JsonRequestBehavior.AllowGet);
      }

    }
}
