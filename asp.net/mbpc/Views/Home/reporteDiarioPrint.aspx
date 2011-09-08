<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<link rel="stylesheet" href="<%= Url.Content("~/Content/planillaprint.css") %>"  type="text/css" />



<div id="planilla">
	<div class="header">
    	<div class="title">
            PREFECTURA NAVAL ARGENTINA<br />
            PREFECTURA DE ZONA RIO DE LA PLATA<br />
            CENTRO DE CONTROL DE TRAFICO RIO DE LA PLATA
        </div>

		<div class="date">
			CANAL MARTIN GARCIA<br /><br />
            FECHA: <label><%= DateTime.Now.ToString("dd/MM/yyyy") %></label>
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
