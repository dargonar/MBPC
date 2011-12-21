using System;
using System.Linq;
using System.Data;
using System.Collections.Generic;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Configuration;
using System.Globalization;

using System.Data.Common;
using System.Data.EntityClient;
using System.Data.EntityModel;
using System.Data.Objects.DataClasses;
using System.Data.Objects;


using mbpc_admin;

public static class DaoLib2
{
  public static IQueryable traeruser(string id)
  {
    
    using (MBPCEntities5 bla = new MBPCEntities5())

    {
        //bla.TBL_CAPITAN
        var oralinq1 = from e in bla.INT_USUARIOS
                       where e.USUARIO_ID == int.Parse(id)
                       select e;

        return oralinq1;
    }


  }

}

public class EntityQuery<T> where T : EntityObject
{

    public string EntitySetName { get; set; }



    public EntityQuery(string entitySetName)
    {

        this.EntitySetName = entitySetName;

    }



    private ObjectQuery<T> CreateQuery(ObjectContext context)
    {

        return context.CreateQuery<T>(EntitySetName);

    }

}