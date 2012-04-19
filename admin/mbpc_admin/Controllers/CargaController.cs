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
        CreateCombos();

        var decid = decimal.Parse(id);
        var etapa_temp = (from d in context.TBL_ETAPA where d.ID == decid select d).ToArray();
        ViewData["titulo"] = "nro " + etapa_temp[0].NRO_ETAPA + " del viaje " + etapa_temp[0].VIAJE_ID;

        ViewData["viaje_id"] = etapa_temp[0].VIAJE_ID;

        if (id != null)
          ViewData["referenceId"] = id;
        
        return View();
      }

      private void CreateCombos()
      {
        ViewData["tipodecargas"] = (from c in context.TBL_TIPO_CARGA select new { id = c.ID, value = c.NOMBRE.Replace("\"", " ") }).ToArray();
        ViewData["unidades"] = (from d in context.TBL_UNIDAD select new { id = d.ID, value = d.NOMBRE }).ToArray();
        
        //var xxx = context.TBL_TIPO_CARGA.OrderBy(tc => tc.CODIGO).Select( c => new { @NOMBRE = "(" + c.CODIGO + ") " + c.NOMBRE, @ID = c.ID } );

        ViewData["barcazas"] = context.BUQUES_NEW.Where(bz => bz.TIPO_BUQUE.ToUpper().StartsWith("BARCAZA") ||
                                  bz.TIPO_SERVICIO.ToUpper().StartsWith("BARCAZA") ||
                                  bz.TIPO_BUQUE.ToUpper().StartsWith("BALSA") ||
                                  bz.TIPO_SERVICIO.ToUpper().StartsWith("BALSA") ).Select( bz => new {@id=bz.ID_BUQUE, @value=bz.NOMBRE + "(" + bz.BANDERA +")"}).ToArray();

           //     where ( UPPER(b.TIPO_BUQUE) like 'BARCAZA%' 
           //or UPPER(b.TIPO_BUQUE) like 'BALSA%' 
           //or UPPER(b.TIPO_SERVICIO) like 'BARCAZA%' 
           //or UPPER(TIPO_SERVICIO) like 'BALSA%' )


        //context.BUQUES_NEW.Select( bz => bz.ID_BUQUE, 
        //ViewData["barcazas"] = (from bz in context.BUQUES_NEW select new { id=bz.ID_BUQUE, value=bz.NOMBRE 
      }


      public ActionResult Remove(int id)
      {
        FlashOK("La carga fue eliminada correctamente");
        decimal eid = 0;
        try
        {
          var contract = context.TBL_CARGAETAPA.Where(c => c.ID == id).SingleOrDefault();
          eid = contract.ETAPA_ID;
          context.TBL_CARGAETAPA.DeleteObject(contract);
          context.SaveChanges();


          CreateCombos();
          return RedirectToAction("List", new { @alone = ViewData["alone"], @id = contract.ETAPA_ID });
        }
        catch (Exception ex)
        {
          FlashError("No se pudo eliminar la carga, intente nuevamente");
        }

        CreateCombos();

        return RedirectToAction("List", new { @id = eid });
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
        
        var xxx = context.TBL_TIPO_CARGA.OrderBy(tc => tc.CODIGO).Select( c => new { @NOMBRE = "(" + c.CODIGO + ") " + c.NOMBRE, @ID = c.ID } );

        ViewData["TIPOCARGA_ID"] = new SelectList(xxx, "ID", "NOMBRE", cargaetapa.TIPOCARGA_ID.ToString());
        ViewData["TIPOCARGA_ID_SELECTED"] = cargaetapa.TIPOCARGA_ID.ToString();

        ViewData["UNIDAD_ID"] = new SelectList(context.TBL_UNIDAD, "ID", "NOMBRE", cargaetapa.UNIDAD_ID.ToString());


        //QUERIA PONER UN ITEM MAS PARA SELECCIONAR DEFAULT NO BARCAZAAA
        //QUERIA PONER UN ITEM MAS PARA SELECCIONAR DEFAULT NO BARCAZAAA
        //QUERIA PONER UN ITEM MAS PARA SELECCIONAR DEFAULT NO BARCAZAAA
        //QUERIA PONER UN ITEM MAS PARA SELECCIONAR DEFAULT NO BARCAZAAA

        var yyy = context.BUQUES_NEW.Where(bz => bz.TIPO_BUQUE.ToUpper().StartsWith("BARCAZA") ||
                          bz.TIPO_SERVICIO.ToUpper().StartsWith("BARCAZA") ||
                          bz.TIPO_BUQUE.ToUpper().StartsWith("BALSA") ||
                          bz.TIPO_SERVICIO.ToUpper().StartsWith("BALSA"))
                          .Select(bz => new { @id = bz.ID_BUQUE, @value = bz.NOMBRE + " (" + bz.BANDERA + ")" })
                          .ToArray();

        
        //var x = new[] { new { id = "", value = "---" } };
        //yyy.Concat( new[] { x } );
        //cargaetapa.b
        //yyy.Concat(x);

        var ooo = new SelectList(yyy, "id", "value", cargaetapa.BUQUE_ID == null ? "" : cargaetapa.BUQUE_ID.ToString());
        var zzz = ooo.Concat(new[] { new SelectListItem { Text = "---", Value = "", Selected=cargaetapa.BUQUE_ID==null?true:false } });
        ViewData["BUQUE_ID"] = zzz;

      }

      public ActionResult Create(TBL_CARGAETAPA cargaetapa)
      {
        try
        {
          //HACK
          cargaetapa.EN_TRANSITO = Request.Params["EN TRANSITO"] != "false" ? 1 : 0;

          if (cargaetapa.ID == 0)
          {
            context.TBL_CARGAETAPA.AddObject(cargaetapa);
            FlashOK("La carga fue agregada con exito");
          }
          else
          {
            var updatedCargaEtapa = context.TBL_CARGAETAPA.Where(c => c.ID == cargaetapa.ID).SingleOrDefault();
            updatedCargaEtapa.SimpleCopyFrom(cargaetapa, new string[] { "BUQUE_ID", "TIPOCARGA_ID", "CANTIDAD_INICIAL", "CANTIDAD_ENTRADA", "CANTIDAD_SALIDA", "EN_TRANSITO", "UNIDAD_ID" });
            FlashOK("La carga se modifico con exito");
          }
          context.SaveChanges();
          
          //HACK- Cambiar cuando el connector de Oracle funcione bien
          var nuevacargaetapa = context.TBL_CARGAETAPA.OrderByDescending(c => c.ID).First();
          //HACK------------------------------------------------------

          return RedirectToAction("List", new { alone = ViewData["alone"], @id = cargaetapa.ETAPA_ID });
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
        var columns = new string[] { "ID", "TIPOCARGA_ID", "CANTIDAD_INICIAL", "CANTIDAD_ENTRADA", "CANTIDAD_SALIDA", "EN_TRANSITO", "UNIDAD_ID", "ETAPA_ID", "BUQUE_ID" };

        var tmp = JQGrid.Helper.PaginageS1<TBL_CARGAETAPA>(Request.Params, columns, page, rows, sidx, sord);

        var items = context.ExecuteStoreQuery<TBL_CARGAETAPA>((string)tmp[0], (ObjectParameter[])tmp[1]);

        return Json(JQGrid.Helper.PaginateS2<TBL_CARGAETAPA>(
          items.ToArray(),
          columns, context.TBL_CARGAETAPA.Count(), page, rows
          ), JsonRequestBehavior.AllowGet);
      }

    }
}
