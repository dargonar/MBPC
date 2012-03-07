using System;
using System.Linq;
using System.Text;
using System.Collections.Generic;
using System.Collections.Specialized;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;


namespace JQGrid {

  public class JQGridUtils {
  
    public static object[] PaginageS1(string table, NameValueCollection req, Dictionary<string,string> columns, int page, int rows, string sidx, string sord)
    {
      int pageIndex = Convert.ToInt32(page) - 1;
      int pageSize = rows;

      int offset = (pageIndex * pageSize) + 1;

      var tmp = buildWhere2(req, columns);

      string where = (string)tmp[0];
      OracleParameter[] vals = (OracleParameter[])tmp[1];

      string sql_count_stmt = String.Format(
        @"SELECT count(*) TOTAL
                      FROM {0} b
                      WHERE {1}", table, where);

      string sql_stmt = String.Format(

      @"SELECT *
        FROM (SELECT a.*, ROWNUM rnum
              FROM (SELECT b.*
                      FROM {0} b
                      WHERE {1}
                     ORDER BY {2} {3}) a  
                   WHERE ROWNUM < {4})
        WHERE rnum >= {5}"
     , table, where, sidx, sord, offset + rows, offset);

      return new object[] { sql_stmt, vals, sql_count_stmt };
    }

    private static DateTime[] getDatesFromString(string str)
    {
      var dates = new List<DateTime>();
      foreach(var s in str.Split(';'))
      {
        DateTime d;
        if (DateTime.TryParse(s, out d) == true)
          dates.Add(d);
      }

      return dates.ToArray();
    }


    public static object[] buildWhere2(NameValueCollection req, Dictionary<string,string> columnsraw)
    {
      var values = new List<OracleParameter>();
      var predicate = new StringBuilder();

      List<string> columns = new List<string>();
      foreach (var s in columnsraw.Keys)
      {
        columns.Add(s);
      }
          
      foreach (string key in req.AllKeys)
      {
        if (!columns.Contains(key))
          continue;

        if (predicate.Length != 0) 
          predicate.Append(" and ");

        //string
        if (columnsraw[key] == "s")
        {
          //marca 1
          predicate.Append(string.Format("upper(b.{0}) like upper(\'%{1}%\')", key, req[key]));
        }
        //datetime
        else if (columnsraw[key] == "d")
        {
          DateTime[] dates = getDatesFromString(req[key]);
          if (dates.Length == 0)
          {
            //remove "and"
            predicate.Remove(predicate.Length - 5, 5);
            continue;
          }

          //TODO: hace GETDATE(datetime) para que compare solo fecha y no fecha+hora
          if (dates.Length == 1)
          {
            //marca 2
            predicate.Append(string.Format("to_date(b.{0}) = to_date(\'{1}\', \'MM/DD/YYYY\')", key,  dates[0].ToShortDateString()));
          }

          if (dates.Length == 2)
          {
            //marca 3
            var tmp = values.Count;
            predicate.Append(string.Format("to_date(b.{0}) >= to_date(\'{1} 00:00\', \'MM/DD/YYYY HH24:MI\') and to_date(b.{0}) <= to_date(\'{2} 23:59\', \'MM/DD/YYYY HH24:MI\')", key, dates[0].ToShortDateString(), dates[1].Date.ToShortDateString()));
          }
        }
        //cualquier otro
        else
        {
          //marca 4
          //(1,2,3,4)
          if (req[key].StartsWith("("))
          {
            predicate.Append(string.Format("b.{0} in {1}", key, req[key]));
          }
          else
            predicate.Append(string.Format("b.{0} = {1}", key, req[key]));
        }
      }

      //Hack-o-matic
      //if (values.Count == 0)
      if (predicate.Length == 0)
        predicate.Append("1 = 1");

      return new object[] { predicate.ToString(), values.ToArray() };
    }

    public static object PaginateS2(List<object> items, Dictionary<string,string> columns, int totalRecords, int page, int rows)
    {
      int pageSize = rows;
      int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

      var i = 0;

      var jsonData = new
      {
        total = totalPages,
        page = page,
        records = totalRecords,
        rows = (
          from item in items
          select new
          {
            id = "row" + i++.ToString(),
            cell = from col in columns.Keys
                   select ((Dictionary<string,string>)item)[col]
          }).ToArray()
      };

      return jsonData;

    }

    private static object myFormat(object o)
    {
      if (o != null && (o.GetType() == typeof(DateTime) || o.GetType() == typeof(Nullable<DateTime>)))
      {
        return string.Format("{0:yyyy-MM-dd}", o);
      }

      if (o != null && (o.GetType() == typeof(Boolean) || o.GetType() == typeof(Nullable<Boolean>)))
      {
        return (Boolean)o;
      }

      return o;
    }

          
  }
}


