using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using mbpc_admin.Models;
using Oracle.DataAccess.Client;
using System.Data.Objects;

namespace mbpc_admin.Controllers
{

    public class UsuarioController : MyController
    {

      public ActionResult List()
      {
        ViewData["titulo"] = "Lista de usuarios";
        return View();
      }

      public ActionResult Remove(int id)
      {
        FlashOK("El usuario fue eliminado");

        try
        {
          var item = context.INT_USUARIOS.Where(c => c.USUARIO_ID == id).SingleOrDefault();
          context.INT_USUARIOS.DeleteObject(item);
          context.SaveChanges();
          return View("List");
        }
        catch (Exception ex)
        {
          FlashError("el usario no pudo eliminado, intente nuevamente");
        }

        return View("List");
      }

      public ActionResult Edit(decimal id)
      {
        ViewData["titulo"] = "Editar";
        var item = context.INT_USUARIOS.Where(c => c.USUARIO_ID == id).First();
        return View("New", item);
      }

      public ActionResult New()
      {
        ViewData["titulo"] = "Nuevo";
        var item = new INT_USUARIOS();
        return View(item);
      }

      public ActionResult Create(INT_USUARIOS item)
      {
        try
        {
          if (!ModelState.IsValid)
          {
            FlashError("Revise los campos con error");
            return View("New", item);
          }

          if (item.USUARIO_ID == 0)
          {
            //context.INT_USUARIOS.AddObject(item);

            FlashError("El ID de usuario es incorrecto");
            return View("New", item);
          }
          else
          {
            var updatedItem = context.INT_USUARIOS.Where(c => c.USUARIO_ID == item.USUARIO_ID).SingleOrDefault();
            if (updatedItem != null)
                updatedItem.SimpleCopyFrom(item, new string[] {"NDOC", "PASSWORD", "APELLIDO", "NOMBRES", "DESTINO", "FECHAVENC", "TEDIRECTO", "EMAIL", "ESTADO", "SECCION", "NDOC_ADMIN", "FECHA_AUDIT", "NOMBREDEUSUARIO", "USUARIO_ID"});
            else
                context.INT_USUARIOS.AddObject(item);
            FlashOK("La accion se ejecuto correctamente");
          }
          
          context.SaveChanges();

          //HACK- Cambiar cuando el connector de Oracle funcione bien
          var nuevoitem = context.INT_USUARIOS.OrderByDescending(c => c.USUARIO_ID).First();
          //HACK----------------------------------------------------------------------------


          return Edit(nuevoitem.USUARIO_ID);

        }
        catch (Exception ex)
        {
          FlashError("Error: " + ex.Message + "\nInner: " + ex.InnerException.Message);
        }

        return View("New", item);
      }


      public ActionResult ListJSON(string sidx, string sord, int page, int rows)
      {
        var columns = new string[] { "NDOC", "PASSWORD", "APELLIDO", "NOMBRES", "DESTINO", "FECHAVENC", "TEDIRECTO", "TEINTERNO", "EMAIL", "ESTADO", "SECCION", "NDOC_ADMIN", "FECHA_AUDIT", "NOMBREDEUSUARIO", "USUARIO_ID" };

        var tmp = JQGrid.Helper.PaginageS1<INT_USUARIOS>(Request.Params, columns, page, rows, sidx, sord);

        var items = context.ExecuteStoreQuery<INT_USUARIOS>((string)tmp[0],(ObjectParameter[])tmp[1]);

        return Json(JQGrid.Helper.PaginateS2<INT_USUARIOS>(
          items.ToArray(),
          columns, context.INT_USUARIOS.Count(), page, rows
          ), JsonRequestBehavior.AllowGet);
      }

      public ActionResult Grupos(int usuario)
      {
        var item = context.INT_USUARIOS.Where(c => c.USUARIO_ID == usuario).First();
        ViewData["titulo"] = "Editando grupos del usuario " + item.NOMBRES + " " + item.APELLIDO;
        CreateCombo(usuario);
        return View(item);
      }

      public ActionResult ActualizarGrupos(int usuario, int[] grupos)
      {
        if (grupos == null)
          grupos = new int[] { };

        var todos = context.TBL_USUARIOGRUPO.Where(ug => ug.USUARIO == usuario).Select(s => (int)s.GRUPO).ToList();

        foreach (var tmp in context.TBL_USUARIOGRUPO.Where(ug => !grupos.Contains((int)ug.GRUPO) && ug.USUARIO == usuario))
          context.DeleteObject(tmp);

        foreach (var i in grupos)
        {
          if (todos.Contains(i))
            continue;

          var tmp = new TBL_USUARIOGRUPO();
          tmp.ID = 1000 + i;
          tmp.USUARIO = usuario;
          tmp.GRUPO = i;
          context.TBL_USUARIOGRUPO.AddObject(tmp);
        }

        context.SaveChanges();
        
        return RedirectToAction("List");
      }

      private void CreateCombo(int usuario)
      {
        var xxx = (from c in 
                   context.TBL_USUARIOGRUPO.Where(ug => ug.USUARIO == usuario).ToList()

                   select new
                   {
                     ID     = c.GRUPO,
                     NOMBRE = c.TBL_GRUPO.NOMBRE
                   }).ToList();

        var pp = new SelectList(xxx, "ID", "NOMBRE");
        ViewData["grupos"] = pp;
      }


    }

    


}
