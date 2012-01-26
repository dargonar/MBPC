<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%  Dictionary<string, string> ship = Model as Dictionary<string,string>; %>

<div class="box" id="B<%=ship["ID"]%>" style="height:30px">
  <div class="title" style="height:13px;">
    <table style="position: relative;top: -5px;">
      <tr>
        <td>
          <label class="nombrebarco">BARCAZA FONDEADA => <%= ship["NOMBRE"] %></label>
          &nbsp;&nbsp;&nbsp;
          <a href="<%= Url.Content("~/Viaje/editarNotas/") + ship["ID"] %>" onclick="return editarnotas(this);return false;">(Notas)</a>
        </td>
      </tr>
    </table>
  </div>
</div>