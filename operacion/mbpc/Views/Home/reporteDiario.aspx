<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<div id="header"></div>
<div id="planilla">
	<div class="header">
    	<div class="title">
            PREFECTURA NAVAL ARGENTINA<br />
        </div>
        <a id="printver" target="_blank" href="<%= Url.Content("~/Home/reporteDiarioPrint/") %>?fecha=<%= ViewData["fecha"] %>" style="float:right;margin-right: 17px;position:relative" > Version para imprimir</a>
		<div class="date">
            FECHA: <label><%= ViewData["fecha"] %> </label>
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
