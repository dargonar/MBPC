<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<table style="width: 100%">
  <% if (ViewData["barcaza"] != null) { %>
  <h1>Verifique que la barcaza no este dada de alta previamente.</h1>
  <% }else{ %>
  <h1>Verifique que el barco no este dado de alta previamente.</h1>
  <%} %>
  <tr>
    <th>Nombre</th>
    <th>SDIST</th>
    <th>OMI/Matricula</th>
    <th>Bandera</th>
  </tr>
  <% var barcos = ViewData["similares"] as List<object>; %>

  <tr id="noload" <%= (barcos != null && barcos.Count != 0) ? "style=\"display:none\"" : "" %>>
    <% if (ViewData["barcaza"] != null) { %>
    <td colspan="4" style="text-align: center; padding: 30px;background:#dddddd"><strong>No se encuentran barcazas similares</strong></td>
    <% } else { %>
    <td colspan="4" style="text-align: center; padding: 30px;background:#dddddd"><strong>No se encuentran buques similares</strong></td>
    <% } %>
  </tr>

  <% foreach( Dictionary<string,string> barco in barcos ) { %>
  <tr>
    <td><%=barco["NOMBRE"]%></td>
    <td><%=barco["SDIST"]%></td>
    <td><%=barco["NRO_OMI"]+"/"+barco["MATRICULA"]%></td>
    <td><%=barco["BANDERA"]%></td>
  </tr>
  <% } %>
<table>
<br /><br />
<%if (barcos.Count != 0) { %>
<button onclick="return continuar_alta('cancel')" style="width:300px">Cancelar alta</button>
&nbsp;&nbsp;&nbsp;&nbsp;
<% } %>
<button onclick="return continuar_alta('ok')" >Continuar</button>

<script type="text/javascript">
    function continuar_alta(res) {
        $("#dialogdiv").attr('resultd', res);
        $("#dialogdiv5").dialog('close');
    }
</script>