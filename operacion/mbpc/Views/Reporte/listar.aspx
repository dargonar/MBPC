<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Reportes
</asp:Content>

<asp:Content ID="Content0" ContentPlaceHolderID="HeadContent" runat="server">
<script language="javascript">

</script>

  <style type="text/css">
    td
    {
      max-height: 50px;
      max-width: 50px;
      overflow:hidden;
    }
    
    tr
    {
      height: 30px;
      overflow:hidden;}
  </style>
</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div id="columnas">

<!-- LEFT COL -->
<div class="col" style="width:100%;height:100%;">

	<div class="split-bar"></div>
	  <h1 class="fprint" >Listado de Reportes</h1>
    <% Html.RenderPartial("actions"); %>


<% var reportes = ViewData["reportes"] as List<object>;%>
<% var first = true; %>
<div id="planilla" style="width: 100%;position: relative;">
<h2 style="padding-left:10px;font-weight:normal;">Listado de reportes (generados con este IDE)</h2>
  <% if (reportes.Count == 0)
     {
       Html.RenderPartial("_result_empty");
    } 
  %>
  <% else {%>    
  <table>
    <% foreach (Dictionary<string, string> item in reportes)
       { %>
    <% if (first) { %>
    <tr>
      <% foreach(var kv in item) { %>
      <% if(kv.Key.EndsWith("PARAMS")) continue; %>
      <% if(kv.Key.EndsWith("FORM")) continue; %>
      <% if(kv.Key.EndsWith("_fmt")) continue; %>
      <th><%=kv.Key%></th>
      <% } %>
      <th>actions</th>
    </tr>
    <% first = false; %>
    <% } %>
    <tr> 
      <% var id = "";%>
      <% foreach(var kv in item) { %>
      <% if(kv.Key.EndsWith("FORM")) continue; %>
      <% if(kv.Key.EndsWith("PARAMS")) continue; %>
      <% if(kv.Key.EndsWith("_fmt")) continue; %>
      <% if (kv.Key.EndsWith("ID")) id = kv.Value; %>
      <td><%=kv.Value%></td>
      <% } %>
      <td>
        <a href="<%= Url.Content("~/Reporte/eliminar")%>?id=<%=id %>" onclick="return confirm('Usted está a punto de eliminar un reporte. Esta acción es irreversible.¿Desea eliminar el reporte?');">Borrar</a><br/>
        <div class="btn-new-class">
          <a href="<%= Url.Content("~/Reporte/editar")%>?id=<%=id %>">Editar/modificar</a>
        </div>
      </td>
    </tr>
    <% } %>
    
  </table>  
  <% } %>
</div>
  <div id="sueltos" style="display: none;">
    <!-- elements que necesitan estar en el html porque el js necesita la url -->
    <!--<a id="printver" target="_blank" href="" style="float:right;margin-right: 17px" > Esssta</a></li>-->
    <img id="loaderimg" alt="loader" style="position:absolute;top:50%;left:50%;" src="<%= Url.Content("~/img/ajax-loader2.gif") %>" />
  </div>

</asp:Content>
