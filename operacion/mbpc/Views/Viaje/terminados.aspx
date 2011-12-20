<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<%  List<object> viajes = ViewData["viajes"] as List<object>;
  if (viajes != null)
  {
    if (viajes.Count == 0)
    {
      %>
      <strong>No hay viajes Terminados</strong></td></tr>
      <%
    }
    else
    {
      %>
      <table class="detalles" style="width: 100%">

        <tr>
          <th>ID</th>
          <th>BUQUE</th>
          <th>ORIGEN</th>
          <th>DESTINO</th>
          <th>ETAPAS</th>
          <th>&nbsp;</th>
        </tr>

      <% 
      
  foreach (Dictionary<string, string> viaje in viajes)
  { 
      %>
          <tr class="navoff">
      <%  foreach (string key in viaje.Keys)
          {
            if (key == "ACTUAL_ID")
              continue;
            Response.Write("<td>" + viaje[key] + "</td>");
          } 
      %>
            <td>
              <a href="<%= Url.Content("~/Viaje/reactivar/" + viaje["ID"]) %>" onclick="reactivar($(this).attr('href'));return false;"> Reactivar</a>              
            </td>
      </tr>
<%
      }
    }
  }
%>
</table>