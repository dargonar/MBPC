using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Objects;
using mbpc_admin.Models;
using Oracle.DataAccess.Client;




namespace mbpc_admin.Controllers
{
    public class PuntodecontrolController : MyController
    {
        //
        // GET: /Viaje/

      public ActionResult List(string[] id)
      {
        if (id != null)
          ViewData["referenceId"] = id;
        ViewData["menu"] = "pdcs.list";
        return View();
      }

      public JsonResult Buscar(string query)
      {
        //context.ExecuteStoreQuery<TBL_PUNTODECONTROL>("", new OracleParameter[] { });

        int tint = 0;
        
        var tmp = query.Split(' ');
        if(tmp.Length > 0 )
        {
          if( int.TryParse(tmp[tmp.Length-1], out tint) )
          {
            query = query.Substring(0, query.LastIndexOf(' '));
          }
        }

        List<TBL_PUNTODECONTROL> ttt;

        if (tmp.Length > 1)
        {
          ttt = context.TBL_PUNTODECONTROL
                .Where(p => p.RIOS_CANALES_KM.RIOS_CANALES.NOMBRE.ToUpper().Contains(query.ToUpper()) && (int)p.RIOS_CANALES_KM.KM == tint).ToList();
        }
        else
        {
          ttt = context.TBL_PUNTODECONTROL
                .Where(p => p.RIOS_CANALES_KM.RIOS_CANALES.NOMBRE.ToUpper().Contains(query.ToUpper())).ToList();
        }

        var buques = (from c in ttt
                      select new
                      {
                        ID = c.ID,
                        NOMBRE = (c.RIOS_CANALES_KM.RIOS_CANALES.NOMBRE
                               + "-"
                               + c.RIOS_CANALES_KM.UNIDAD
                               + "-"
                               + c.RIOS_CANALES_KM.KM).ToString(),
                        KM = c.RIOS_CANALES_KM.KM
                      }
                     );

        return Json(buques, JsonRequestBehavior.AllowGet);
      }
 

      public ActionResult ListJSON(string sidx, string sord, int page, int rows)
      {
        return NewMethod(Request.Params, sidx, sord, page, rows);
      }

      private ActionResult NewMethod(NameValueCollection nv, string sidx, string sord, int page, int rows)
      {
        var columns = new string[] { "ID", "USO", "CUATRIGRAMA", "CANAL" };
        var tmp = JQGrid.Helper.PaginageS1<VPUNTO_DE_CONTROL>(nv, columns, page, rows, sidx, sord);

        var items = context.ExecuteStoreQuery<VPUNTO_DE_CONTROL>((string)tmp[0], (ObjectParameter[])tmp[1]);

        return Json(JQGrid.Helper.PaginateS2<VPUNTO_DE_CONTROL>(
          items.ToArray(),
          columns, context.VPUNTO_DE_CONTROL.Count(), page, rows
          ), JsonRequestBehavior.AllowGet);
      }


      private void CreateCombo(decimal? userid, decimal? pdc)
      {
          var user = context.VW_INT_USUARIOS.Where(c => c.NDOC == userid).First();
          ViewData["user"] = userid;
          ViewData["nombres"] = user.APELLIDO + ", " + user.NOMBRES;
          ViewData["PUNTODECONTROL"] = new SelectList(context.VPUNTO_DE_CONTROL, "ID", "CANAL", pdc);
      }

      public ActionResult ListPDCUser(int userid)
      {
        
        ViewData["userid"] = userid;
        CreateCombo(userid, 0);
        return View();
      }

      public ActionResult Remove(int id)
      {
          FlashOK("El punto de control fue eliminado");

          try
          {
              var item = context.TBL_PUNTODECONTROL.Where(c => c.ID == id).SingleOrDefault();
              context.TBL_PUNTODECONTROL.DeleteObject(item);
              context.SaveChanges();
              return View("List");
          }
          catch (Exception ex)
          {
              FlashError("No se pudo eliminar , intente nuevamente");
          }

          return View("List");
      }


      public ActionResult RemoveAsig(decimal user, decimal pdc)
      {
          FlashOK("La asignacion fue eliminada correctamente");

          try
          {
              var item = context.TBL_PUNTODECONTROLUSUARIO.Where(c => c.USUARIO == user && c.PUNTODECONTROL == pdc).First();
              context.TBL_PUNTODECONTROLUSUARIO.DeleteObject(item);
              context.SaveChanges();
              return RedirectToAction("ListPDCUser", new { userid = user });
          }
          catch (Exception ex)
          {
              FlashError("No se pudo eliminar la asignacion, intente nuevamente");
          }

          return View("List");
      }

      private void CreateCombo2(TBL_PUNTODECONTROL item)
      {
          ViewData["ZONA_ID"] = new SelectList(context.TBL_ZONAS, "ID", "DESCRIPCION", item.ZONA_ID);

          var rioscanales = context.RIOS_CANALES_KM.OrderBy(r => r.ID);
          List<object> newList = new List<object>();
          foreach (var riocanal in rioscanales)
              newList.Add(new
              {
                  id = riocanal.ID,
                  nombre = riocanal.RIOS_CANALES.NOMBRE + "  " + riocanal.UNIDAD + " " +riocanal.KM 
              });
          this.ViewData["Members"] = new SelectList(newList, "Id", "Name");


          ViewData["RIOS_CANALES_KM_ID"] = new SelectList(newList , "id", "nombre" , item.RIOS_CANALES_KM_ID);

      }


      public ActionResult New()
      {
        ViewData["titulo"] = "Nuevo";
        ViewData["menu"] = "pdcs.new";
        

        var item = new TBL_PUNTODECONTROL();
        item.ID = MyController._HACKID_;

        CreateCombo2(item);
        return View(item);
      }


      public ActionResult Edit(decimal id)
      {
        ViewData["titulo"] = "Editar";
        ViewData["menu"] = "pdcs.list";
        var item = context.TBL_PUNTODECONTROL.Where(c => c.ID == id).First();
        CreateCombo2(item);
        return View("New", item);
      }


      public ActionResult Create(TBL_PUNTODECONTROL item)
      {
          try
          {

              if (!ModelState.IsValid)
              {
                FlashError("Revise los campos con error");
                CreateCombo2(item);
                return View("New", item);
              }

              if (item.ID == MyController._HACKID_)
              {
                item.ID = 0;
                context.TBL_PUNTODECONTROL.AddObject(item);
                FlashOK("Se agrego punto de control");
              }
              else
              {
                var updatedItem = context.TBL_PUNTODECONTROL.Where(c => c.ID == item.ID).SingleOrDefault();
                updatedItem.SimpleCopyFrom(item, new string[] { "ID", "ZONA_ID", "RIOS_CANALES_KM_ID", "USO" });

                FlashOK("Se edito el punto de control");
              }

              
              context.SaveChanges();

              //HACK- Cambiar cuando el connector de Oracle funcione bien
              var nuevoitem = context.TBL_PUNTODECONTROL.OrderByDescending(c => c.ID).First();
              //HACK----------------------------------------------------------------------------

              CreateCombo2(item);
              return Edit(nuevoitem.ID);

          }
          catch (Exception ex)
          {
            FlashError("Error: " + ex.Message + "\nInner: " + ex.InnerException.Message);
              CreateCombo2(item);
              return View("New", item);              
          }
      }



      public ActionResult NewAsig(int user)
      {

          var item = new TBL_PUNTODECONTROLUSUARIO();

          ViewData["user"] = user;
          CreateCombo(user, 0);
          item.USUARIO = user;
          item.ID = _HACKID_;

          return View(item);
      }


      public ActionResult CreateAsig(TBL_PUNTODECONTROLUSUARIO item)
      {
          try
          {

            if (!ModelState.IsValid)
            {
              FlashError("Revise los campos con error");
              CreateCombo(item.USUARIO, item.PUNTODECONTROL);
              return View("NewAsig", item);
            }

              if (item.ID == _HACKID_)
              { 
                  //Intento de usar la relacion de EF many to many (sin exito)
                  //var userob = context.VW_INT_USUARIOS.FirstOrDefault(e => e.ID == item.PUNTODECONTROL);
                  //var pdcobj = context.TBL_PUNTODECONTROL.FirstOrDefault(e => e.ID == item.PUNTODECONTROL);
                  //userobj.TBL_PUNTODECONTROLUSUARIO.add(item);
                  //pdcobj.TBL_PUNTODECONTROLUSUARIO.Add(item);
                  //----------


                  context.TBL_PUNTODECONTROLUSUARIO.AddObject(item);
                  FlashOK("La asignacion fue agregada con exito");
              }
              else
              {
                  var updatedItem = context.TBL_PUNTODECONTROLUSUARIO.Where(c => c.USUARIO == item.USUARIO && c.PUNTODECONTROL == item.PUNTODECONTROL).SingleOrDefault();
                  updatedItem.SimpleCopyFrom(item, new string[] { "ID", "PUNTODECONTROL", "USUARIO" });
                  FlashOK("La asignacion se modifico con exito");
              }
              context.SaveChanges();

              //HACK- Cambiar cuando el connector de Oracle funcione bien
              //var nuevoitem = context.TBL_CARGAETAPA.OrderByDescending(c => c.ID).First();
              //HACK------------------------------------------------------
              CreateCombo(item.USUARIO, item.PUNTODECONTROL);

              return View("NewAsig", item);
          }
          catch (Exception ex)
          {
            FlashError("Error: " + ex.Message + "\nInner: " + ex.InnerException.Message);

          }

          CreateCombo(item.USUARIO, item.PUNTODECONTROL);

          return View("NewAsig", item);
      }


      public ActionResult ListPDCUserJSON(string sidx, string sord, int page, int rows, int userid)
      {

        NameValueCollection nv = new NameValueCollection();
        for (int i = 0; i < Request.Params.Count; i++)
        {
          nv[Request.Params.GetKey(i)] = Request.Params[Request.Params.GetKey(i)];
        }

        List<string> pcus = new List<string>();
        foreach (var pcu in context.TBL_PUNTODECONTROLUSUARIO.Where(pu => pu.USUARIO == userid))
        {
          pcus.Add(((int)pcu.PUNTODECONTROL).ToString());
        }

        if (pcus.Count != 0)
        {
          var ids = "(" + String.Join(",", pcus.ToArray()) + ")";
          nv["ID"] = ids;
        }
        else
        {
          nv["ID"] = "-1";
        }

        return NewMethod(nv, sidx, sord, page, rows);
      }
    }
}
