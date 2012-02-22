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
          var item = context.VW_INT_USUARIOS.Where(c => c.NDOC == id).SingleOrDefault();
          context.VW_INT_USUARIOS.DeleteObject(item);
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
        var item = context.VW_INT_USUARIOS.Where(c => c.NDOC == id).First();
        return View("New", item);
      }

      public ActionResult New()
      {
        ViewData["titulo"] = "Nuevo";
        var item = new VW_INT_USUARIOS();
        return View(item);
      }

      public ActionResult Create(VW_INT_USUARIOS item)
      {
        try
        {
          if (!ModelState.IsValid)
          {
            FlashError("Revise los campos con error");
            return View("New", item);
          }

          if (item.NDOC == 0)
          {
            //context.VW_INT_USUARIOS.AddObject(item);

            FlashError("El ID de usuario es incorrecto");
            return View("New", item);
          }
          else
          {
            var updatedItem = context.VW_INT_USUARIOS.Where(c => c.NDOC == item.NDOC).SingleOrDefault();
            if (updatedItem != null)
              updatedItem.SimpleCopyFrom(item, new string[] { "NDOC", "PASSWORD", "APELLIDO", "NOMBRES", "DESTINO", "FECHAVENC", "TEDIRECTO", "EMAIL", "ESTADO", "NOMBREDEUSUARIO" });
            else
              context.VW_INT_USUARIOS.AddObject(item);
            FlashOK("La accion se ejecuto correctamente");
          }
          
          context.SaveChanges();

          //HACK- Cambiar cuando el connector de Oracle funcione bien
          //ESTO ROMPE!!!! VERIFICAR QUE NUNCA SE USEEE!!!
          var nuevoitem = context.VW_INT_USUARIOS.OrderByDescending(c => c.NDOC).First();
          //HACK----------------------------------------------------------------------------


          return Edit((decimal)nuevoitem.NDOC);

        }
        catch (Exception ex)
        {
          FlashError("Error: " + ex.Message + "\nInner: " + ex.InnerException.Message);
        }

        return View("New", item);
      }


      public ActionResult ListJSON(string sidx, string sord, int page, int rows)
      {
        var columns = new string[] { "NDOC", "DESTINO", "PASSWORD", "APELLIDO", "NOMBRES", "FECHAVENC", "TEDIRECTO", "EMAIL", "NOMBREDEUSUARIO" };

        var tmp = JQGrid.Helper.PaginageS1<INT_USUARIOS>(Request.Params, columns, page, rows, sidx, sord);

        var items = context.ExecuteStoreQuery<INT_USUARIOS>((string)tmp[0], (ObjectParameter[])tmp[1]);

        return Json(JQGrid.Helper.PaginateS2<INT_USUARIOS>(
          items.ToArray(),
          columns, context.INT_USUARIOS.Count(), page, rows
          ), JsonRequestBehavior.AllowGet);
      }

      public ActionResult Grupos(int usuario)
      {
        var item = context.INT_USUARIOS.Where(c => c.NDOC == usuario).First();
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
