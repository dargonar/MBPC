using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Text;
using System.Linq.Dynamic;
using System.Data.Objects;
using System.Transactions;
using JQGrid;
using mbpc_admin.Models;

namespace mbpc_admin.Controllers
{
    public class ReporteController : MyController
    {
      public ActionResult List()
      {
        //ViewData["reportes"] = (from c in context.TBL_REPORTE  select new { id = c.ID, value = c.NOMBRE.Replace("\"", " ") }).ToArray();
        ViewData["menu"] = "reporte.list";
        checkFlash();
        return View();
      }

      public ActionResult New()
      {
        ViewData["menu"] = "reporte.new";
        ViewData["titulo"] = "Nuevo Reporte";
        var item = this.getNewReporte(null);
        return View(item);
      }

      private TBL_REPORTE getNewReporte(TBL_REPORTE reporte) 
      {
        TBL_REPORTE _reporte = new TBL_REPORTE();
        if (reporte != null)
        {
          _reporte = reporte;
        }

        _reporte.TBL_REPORTE_PARAM = new System.Data.Objects.DataClasses.EntityCollection<TBL_REPORTE_PARAM>();
        TBL_REPORTE_PARAM param = new TBL_REPORTE_PARAM();
        param.INDICE = 1;
        param.NOMBRE = "nombre";
        param.TIPO_DATO = Convert.ToInt32(ReporteParamDataType.ENTERO);

        _reporte.TBL_REPORTE_PARAM.Add(param);
        return _reporte;
      }

      
      public enum ReporteParamDataType {
        FECHA, ENTERO, DECIMAL, TEXTO
      }
      
      static public SelectList CreateDataTypeCombo(TBL_REPORTE_PARAM param) {
        List<object> newList = new List<object>();
        foreach (ReporteParamDataType dataType in Enum.GetValues(typeof(ReporteParamDataType)))
          newList.Add(new
          {
            id = Convert.ToInt32(dataType),
            nombre = Convert.ToString(dataType)
          });

        return new SelectList(newList, "id", "nombre", Convert.ToInt32(param.TIPO_DATO));
      }

      public ActionResult Edit(decimal id)
      {
        
        var item = context.TBL_REPORTE.Where(c => c.ID== id).First();

        ViewData["menu"] = "reporte.edit";
        ViewData["titulo"] = "Editar Reporte '<b>"+item.NOMBRE+"</b>'";

        return View("New", item);
      }


      public ActionResult Create(TBL_REPORTE reporte)
      {
        try
        {

          //TransactionOptions to = new TransactionOptions();
          decimal reporte_id = reporte.ID;
          context.Connection.Open();
          using (var tr = context.Connection.BeginTransaction())
          {

            if (!ModelState.IsValid)
            {
              FlashError("Revise los campos");
              return View("New", this.getNewReporte(reporte));
            }


            if (reporte.ID > 0)
            {
              var items = context.TBL_REPORTE_PARAM.Where(c => c.REPORTE_ID == reporte.ID);
              foreach (TBL_REPORTE_PARAM param in items)
                context.DeleteObject(param);

              var updatedItem = context.TBL_REPORTE.Where(c => c.ID == reporte.ID).SingleOrDefault();
              updatedItem.SimpleCopyFrom(reporte, new string[] { "ID", "NOMBRE", "CONSULTA_SQL", "DESCRIPCION" });
              reporte = updatedItem;
            }
            else
            {
              context.TBL_REPORTE.AddObject(reporte);
            }

            context.SaveChanges();

            if (reporte_id < 1)
            {
              tr.Commit();
              ////HACK- Cambiar cuando el connector de Oracle funcione bien
              reporte = context.TBL_REPORTE.OrderByDescending(c => c.ID).First();
              ////HACK----------------------------------------------------------------------------
              reporte_id = reporte.ID;
              this.AddParams(reporte_id);
              context.SaveChanges();
            }
            else
            {
              this.AddParams(reporte_id);
              context.SaveChanges(System.Data.Objects.SaveOptions.None);
              tr.Commit();
            }
          }
        }
        catch (Exception ex) {
          FlashErrorIntraSession("La acción no se ejecutó correctamente. Error:"+ex.Message);
          return RedirectToAction("New", "Reporte", reporte);
        }
        FlashOKIntraSession("El reporte fue guardado correctamente.");          
        return RedirectToAction("List", "Reporte");
      }

      private void AddParams(decimal reporte_id) {
        string[] param_keys = this.Request.Params.AllKeys;
        int index = 1;
        string key_nombre = String.Format("TBL_REPORTE_PARAM-NOMBRE_{0}", index.ToString());
        string key_tipo_dato = String.Format("TBL_REPORTE_PARAM-TIPO_DATO_{0}", index.ToString());
        bool hay_params = param_keys.Contains(key_nombre);
        while (hay_params)
        {
          TBL_REPORTE_PARAM param = new TBL_REPORTE_PARAM();
          param.INDICE = index;
          param.NOMBRE = this.Request.Params.Get(key_nombre);
          param.TIPO_DATO = Convert.ToInt32(this.Request.Params.Get(key_tipo_dato));
          param.REPORTE_ID = reporte_id;//reporte.ID;

          context.TBL_REPORTE_PARAM.AddObject(param);
          //reporte.TBL_REPORTE_PARAM.Add(param);

          index++;
          key_nombre = String.Format("TBL_REPORTE_PARAM-NOMBRE_{0}", index.ToString());
          key_tipo_dato = String.Format("TBL_REPORTE_PARAM-TIPO_DATO_{0}", index.ToString());
          hay_params = param_keys.Contains(key_nombre);
        }
      }
      
      public ActionResult ListJSON(string sidx, string sort, int page, int rows)
      {
        var columns = new string[] { "NOMBRE", "DESCRIPCION", "FECHA_CREACION", "ID" };

        var tmp = JQGrid.Helper.PaginageS1<TBL_REPORTE>(Request.Params, columns, page, rows, sidx, sort);

        var items = context.ExecuteStoreQuery<TBL_REPORTE>((string)tmp[0], (ObjectParameter[])tmp[1]);
        
        return Json(JQGrid.Helper.PaginateS2<TBL_REPORTE>(
          items.ToArray(),
          columns, context.TBL_REPORTE.Count(), page, rows
          ), JsonRequestBehavior.AllowGet);
      }

      public ActionResult Remove(int id)
      {
        FlashOK("El Reporte fue eliminado");

        try
        {
          context.Connection.Open();
          using (var tr = context.Connection.BeginTransaction())
          {
            var item = context.TBL_REPORTE.Where(c => c.ID == id).SingleOrDefault();
            TBL_REPORTE_PARAM[] toDelete = new TBL_REPORTE_PARAM[item.TBL_REPORTE_PARAM.Count()];
            item.TBL_REPORTE_PARAM.CopyTo(toDelete,0);
            foreach (TBL_REPORTE_PARAM param in toDelete)
              context.DeleteObject(param);
            context.DeleteObject(item);

            context.SaveChanges(System.Data.Objects.SaveOptions.None);

            tr.Commit();
          }
        }
        catch (Exception ex)
        {
          FlashError("No se pudo eliminar el reporte, intente nuevamente:"+ex.Message);
        }
        
        return View("List");
        
        
      }
    }
}
