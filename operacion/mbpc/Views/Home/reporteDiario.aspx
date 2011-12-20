<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<div id="header"></div>
<div id="planilla">
	<div class="header">
    	<div class="title">
            PREFECTURA NAVAL ARGENTINA<br />
        </div>

		<div class="date">
            FECHA: <label><%= DateTime.Now.ToString("dd/MM/yyyy") %> </label>
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
    <% ViewData["entradab"] = ViewData["entrada"]; %>
    <% ViewData["sentido"] = "1"; %>
    <% Html.RenderPartial("_tablareporte"); %>
    
    <% (ViewData["zonas"] as List<object>).Reverse(); %>
    
    <!-- h1/table -->
    <% ViewData["sentido"] = "0"; %>
    <% Html.RenderPartial("_tablareporte"); %>

</div>
