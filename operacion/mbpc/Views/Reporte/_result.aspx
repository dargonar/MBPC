<%@ Page Title="" Language="C#"  Inherits="System.Web.Mvc.ViewPage" %>

<% var reporte = ViewData["reporte"] as Dictionary<string,string>;%>
<% var result = ViewData["result"] as List<object>;%>
<% var first = true; %>
<div id="planilla" style="width: 100%;position: relative;">
<h1 style="margin-top:3px;font-size:18px;text-align:left"><%= reporte["NOMBRE"]%></h1>
  <table>
    <% foreach(Dictionary<string, string> item in result) { %>
    <% if (first) { %>
    <tr>
      <% foreach(var kv in item) { %>
      <% if(kv.Key.EndsWith("_fmt")) continue; %>
      <th><%=kv.Key%></th>
      <% } %>
    </tr>
    <% first = false; %>
    <% } %>
    <tr> 
      <% foreach(var kv in item) { %>
      <% if(kv.Key.EndsWith("_fmt")) continue; %>
      <td><%=kv.Value%></td>
      <% } %>
    </tr>
    <% } %>
  </table>  
</div>
  <div class="btn-new-class">
  <a href="#" onclick="return print_toggle(this)">Imprimir</a>
  <a href="#" onclick="return to_excel(this)">Exportar a Excel</a>
  </div>
