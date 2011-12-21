using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Objects;
using mbpc_admin.Models;
using Oracle.DataAccess.Client;

namespace mbpc_admin.Controllers
{
    public class PracticoController : MyController
    {
        public ActionResult List()
        {
            return View();
        }

        public ActionResult ListJSON(string sidx, string sord, int page, int rows)
        {
            var columns = new string[] { "ID", "NOMBRE" };

            var tmp = JQGrid.Helper.PaginageS1<TBL_PRACTICO>(Request.Params, columns, page, rows, sidx, sord);

            var items = context.ExecuteStoreQuery<TBL_PRACTICO>((string)tmp[0], (ObjectParameter[])tmp[1]);

            return Json(JQGrid.Helper.PaginateS2<TBL_PRACTICO>(
              items.ToArray(),
              columns, context.TBL_PRACTICO.Count(), page, rows
              ), JsonRequestBehavior.AllowGet);
        }


        public ActionResult New()
        {
          ViewData["titulo"] = "Nuevo";
            var item = new TBL_PRACTICO();
            item.ID = _HACKID_;
            return View(item);
        }

        public ActionResult Remove(int id)
        {
            FlashOK("El practico fue eliminado");

            try
            {
                var item = context.TBL_PRACTICO.Where(c => c.ID == id).FirstOrDefault();
                context.TBL_PRACTICO.DeleteObject(item);
                context.SaveChanges();
                return View("List");
            }
            catch (Exception ex)
            {
                FlashError("Error no esperado: " + ex.InnerException.Message);
            }

            return View("List");
        }



        public ActionResult Edit(decimal id)
        {
          ViewData["titulo"] = "Editar";
            var item = context.TBL_PRACTICO.Where(c => c.ID == id).First();
            return View("New", item);
        }


        public ActionResult Create(TBL_PRACTICO item)
        {
            try
            {

              if (!ModelState.IsValid)
              {
                FlashError("Revise los campos con error");
                return View("New", item);
              }


                if (item.ID == _HACKID_)
                {
                    context.TBL_PRACTICO.AddObject(item);

                    FlashOK("Se agrego practico " + item.NOMBRE);
                }
                else
                {
                    var updatedItem = context.TBL_PRACTICO.Where(c => c.ID == item.ID).SingleOrDefault();
                    updatedItem.SimpleCopyFrom(item, new string[] { "ID", "NOMBRE" });

                    FlashOK("Se edito el practico");
                }


                context.SaveChanges();

                //HACK- Cambiar cuando el connector de Oracle funcione bien
                var nuevoitem = context.TBL_PRACTICO.OrderByDescending(c => c.ID).First();
                //HACK----------------------------------------------------------------------------
                return Edit(nuevoitem.ID);

            }
            catch (Exception ex)
            {
              FlashError("Error: " + ex.Message + "\nInner: " + ex.InnerException.Message);
                return View("New", item);
            }

        }




    }
}
