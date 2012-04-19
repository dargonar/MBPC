<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<link rel="stylesheet" href="<%= Url.Content("~/Content/planillaprint.css") %>"  type="text/css" />



<div id="planilla">
	<div class="header">
    	<div class="title">
            PREFECTURA NAVAL ARGENTINA<br />
        </div>

		<div class="date">
            FECHA: <label><%= ViewData["fecha"] %></label>
        </div>

        <table>
        <tr>
          <td>Dragas operando:</td>
        </tr>
        <tr>
          <td>balizadores</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
        </table>
        <div class="split"></div>
    </div>

    <!-- h1/table -->
    <% ViewData["sentido"] = "1"; %>
    <% Html.RenderPartial("_tablareporte"); %>
    
    <% (ViewData["zonas"] as List<object>).Reverse(); %>
    
    <!-- h1/table -->
    <% ViewData["sentido"] = "0"; %>
    <% Html.RenderPartial("_tablareporte"); %>

</div>

<script type="text/javascript">

  window.print();
</script>
