using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using mbpc_admin.Models;
using Oracle.DataAccess.Client;
using System.Data.Objects;
using System.Transactions;

namespace mbpc_admin.Controllers
{
    public class GrupoController : MyController
    {

      public ActionResult List()
      {
        ViewData["titulo"] = "Lista de grupos";
        return View();
      }

      public ActionResult ListJSON(string sidx, string sord, int page, int rows)
      {
        var columns = new string[] { "ID", "NOMBRE" };

        var tmp = JQGrid.Helper.PaginageS1<TBL_GRUPO>(Request.Params, columns, page, rows, sidx, sord);

        var items = context.ExecuteStoreQuery<TBL_GRUPO>((string)tmp[0], (ObjectParameter[])tmp[1]);

        return Json(JQGrid.Helper.PaginateS2<TBL_GRUPO>(
          items.ToArray(),
          columns, context.TBL_GRUPO.Count(), page, rows
          ), JsonRequestBehavior.AllowGet);
      }

      public ActionResult New()
      {
        ViewData["titulo"] = "Nuevo Grupo";
        ViewData["boton"] = "Crear";

        var item = new TBL_GRUPO();
        item.ID = _HACKID_;
        CreateCombo(item);

        return View(item);
      }
      
      public ActionResult Edit(decimal id)
      {
        ViewData["titulo"] = "Editar Grupo";
        ViewData["boton"] = "Modificar";

        var item = context.TBL_GRUPO.Where(c => c.ID == id).First();

        CreateCombo(item);

        return View("New", item);
      }
      
      private void CreateCombo(TBL_GRUPO item)
      {
        var xxx = (from c in context.TBL_GRUPOPUNTO
                     .Where(gp => gp.GRUPO == item.ID).OrderBy(gp => gp.ORDEN).ToList()

                   select new
                   {
                     ID = c.PUNTO,
                     NOMBRE = (c.TBL_PUNTODECONTROL.RIOS_CANALES_KM.RIOS_CANALES.NOMBRE
                               + "-"
                               + c.TBL_PUNTODECONTROL.RIOS_CANALES_KM.UNIDAD
                               + "-"
                               + c.TBL_PUNTODECONTROL.RIOS_CANALES_KM.KM).ToString()
                   }).ToList();

        var pp = new SelectList(xxx, "ID", "NOMBRE");
        ViewData["puntos_de_control"] = pp;
      }


      public ActionResult Remove(int id)
      {
        FlashOK("El grupo fue eliminado");

        try
        {
          var item = context.TBL_GRUPO.Where(c => c.ID == id).SingleOrDefault();
          context.TBL_GRUPO.DeleteObject(item);
          context.SaveChanges();
          return View("List");
        }
        catch (Exception ex)
        {
          FlashError("El grupo no pudo ser eliminado. (Verifique que el grupo no este siendo usado por ningún usuario)");
        }

        return View("List");
      }

      public JsonResult Buscar(string query)
      {
        var buques = (from c in context.TBL_GRUPO
                        .Where(g => g.NOMBRE.ToUpper().Contains(query.ToUpper())).OrderBy(g => g.NOMBRE).ToList()

                      select new
                      {
                        ID      = c.ID,
                        NOMBRE  = c.NOMBRE
                      }
                     );

        return Json(buques, JsonRequestBehavior.AllowGet);
      }
 

      public ActionResult Create(TBL_GRUPO item, int[] puntos_de_control)
      {
        decimal eid = _HACKID_;

        try
        {
          using (var ts = new TransactionScope() )
          {

            if (!ModelState.IsValid)
            {
              FlashError("Revise los campos con error");
              CreateCombo(item);
              return View("New", item);
            }


            if (item.ID == _HACKID_)
            {
              FlashOK("El grupo fue creado con exito");
              context.TBL_GRUPO.AddObject(item);
            }
            else
            {
              var updatedItem = context.TBL_GRUPO.Where(c => c.ID == item.ID).SingleOrDefault();
              updatedItem.SimpleCopyFrom(item, new string[] { "NOMBRE" });
              FlashOK("El grupo se modifico correctamente");
              eid = item.ID;
            }

            context.SaveChanges();
        
            //HACK- Cambiar cuando el connector de Oracle funcione bien
            if (eid == _HACKID_)
            {
              eid = context.TBL_GRUPO.OrderByDescending(c => c.ID).First().ID;
            }
            //HACK----------------------------------------------------------------------------

            if (puntos_de_control == null)
              puntos_de_control = new int[]{};

            var todos = context.TBL_GRUPOPUNTO.Where(gp => gp.GRUPO == eid).Select(s => (int)s.PUNTO).ToList();
            
            foreach (var tmp in context.TBL_GRUPOPUNTO.Where(gp => !puntos_de_control.Contains((int)gp.PUNTO) && gp.GRUPO == eid))
              context.DeleteObject(tmp);

            int orden = 0;
            foreach (var i in puntos_de_control)
            {
              orden++;
              if (todos.Contains(i))
              {
                context.ExecuteStoreCommand(string.Format("update tbl_grupopunto set orden={0} where punto={1} and grupo={2}", orden, i, eid));
                continue;
              }

              var tmp = new TBL_GRUPOPUNTO();
              tmp.ID = 1000 + i;
              tmp.GRUPO = eid;
              tmp.PUNTO = i;
              tmp.ORDEN = orden;
              context.TBL_GRUPOPUNTO.AddObject(tmp);
            }
            

            context.SaveChanges();

            ts.Complete();
          }

          return RedirectToAction("List");
        }
        catch (Exception ex)
        {
          FlashError("Error: " + ex.ToString());
          return Edit(eid);
        }

        //return View("New", item);
      }

    }



}
