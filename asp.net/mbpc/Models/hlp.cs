using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Threading;

namespace mbpc.Models
{
  public static class Hlp
  {
    public static Decimal toDecimal(string value) 
    {
      if(String.IsNullOrEmpty(value))
          return 0;

      string s = value.Replace(".", Thread.CurrentThread.CurrentCulture.NumberFormat.NumberDecimalSeparator)
                      .Replace(",", Thread.CurrentThread.CurrentCulture.NumberFormat.NumberDecimalSeparator);

      return Convert.ToDecimal(s);
    }

    public static string toString(decimal value, string format="{0:0.00}")
    {
      return String.Format(format, value).Replace(",", ".");
    }


    public static string Pager(int currentPage, int currentPageSize, int totalRecords)
    {
      StringBuilder sb1 = new StringBuilder();

      int totalpages = (int)(Math.Ceiling((double)(totalRecords / currentPageSize)));
      sb1.AppendLine("<ul class=\"pagination\">");


      if (currentPage > 1)
        sb1.AppendLine(String.Format("<li class=\"text\"><a href=\"{0}/{1}\">Previous</a></li>", "/admin/pager", currentPage - 1));

      if (currentPage > 5)
      {
        sb1.AppendLine(String.Format("..."));

        for (int i = currentPage - 4; i < currentPage + 4 || i > totalpages; i++)
        {
          if (i == currentPage)
          {
            sb1.AppendLine(String.Format("<li class=\"page\"><a>{1}</a></li>", i));
          }
          else
          {
            sb1.AppendLine(String.Format("<li><a href=\"{0}/{1}\">{1}</a></li>", "/admin/pager", i + 1));
          }
        }
      }
      else
      {
        for (int i = 1; i < currentPage + 9 || i > totalpages; i++)
        {
          if (i == currentPage)
          {
            sb1.AppendLine(String.Format("<li class=\"page\"><a>{0}</a></li>", i));
          }
          else
          {
            sb1.AppendLine(String.Format("<li><a href=\"{0}/{1}\">{1}</a></li>", "/admin/pager", i + 1));
          }
        }
      }

      if (totalpages - currentPage > 9)
        sb1.AppendLine(String.Format("..."));

      if (currentPage < totalpages)
        sb1.AppendLine(String.Format("<li class=\"text\"><a href=\"{0}/{1}\">Next</a></li>", "/admin/pager", currentPage + 1));

      sb1.AppendLine("</ul>");

      return sb1.ToString();
    }


    public static string formp(List<formfield> fields, string[] excludes)
    {

      StringBuilder sb1 = new StringBuilder();

      foreach (var field in fields)
      {
        if (excludes.Contains(field.columna))
        {
          fields.Remove(field);
        }
      }

      foreach (var field in fields)
      {
        if (field.msg != "")
        {
          sb1.AppendLine("<p>");
          sb1.AppendFormat("<label for=\"errorbox\"><span class=\"red\"><strong>{0}</strong></span></label>", field.columna);
          sb1.AppendFormat("<input type=\"text\" id=\"errorbox\" class=\"inputbox errorbox\" name=\"{0}\" value=\"{1}\")<img src=\"/img/icons/icon_missing.png\" alt=\"Error\" /> <br />", field.columna, field.value);
          sb1.AppendFormat("<span class=\"smltxt red\">{0}</span>", field.msg);
          sb1.AppendLine("</p>");
        }
        else
        {
          sb1.AppendLine("<p>");
          sb1.AppendFormat("<label for=\"textfield\"><strong>{0}</strong></label>", field.columna);
          sb1.AppendFormat("<input type=\"text\" id=\"textfield\" class=\"inputbox\" name=\"{0}\" value=\"{1}\"/><br />", field.columna, field.value) ;
          sb1.AppendLine("</p>");
        }
      }

      return sb1.ToString();

    }


  }
}