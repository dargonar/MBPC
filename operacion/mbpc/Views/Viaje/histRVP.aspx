﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<% List<object> historial = ViewData["historial"] as List<object>; %>
<% List<object> eventos = ViewData["eventos"] as List<object>; %>


<% foreach (Dictionary<string, string> etp in historial) { %>

<table class="hist etapa planilla">
<tr>
    <th>
        <h1>
            Etapa Nro. <%= etp["NRO_ETAPA"] %> - <%= etp["CANAL"] +" - KM " + etp["KM"] %>
        </h1>
    </th>
</tr>
<tr>
    <td>
    <table class="hist datos">
      <tr style="text-align:left;"><th colspan="6">Reportes</th></tr>
      <tr>
        <th>Fecha</th>
        <th>Latitud</th>
        <th>Longitud</th>
        <th>Rumbo</th>
        <th>Velocidad</th>
        <th>Codigo</th>
      </tr>
    <% bool hayReportes = false; %>
    <% foreach (Dictionary<string, string> evt in eventos) {
         if (evt["ETAPA_ID"] == etp["ID"] && evt["TIPO_ID"] == "19")
         {
           %>
           <% hayReportes = true; %>
            <tr>
                <td><%= evt["FECHA"]%>&nbsp;</td>
                <td><%= decimal.Parse(evt["LATITUD"]).ToString("0.00")%>&nbsp;</td>
                <td><%= decimal.Parse(evt["LONGITUD"]).ToString("0.00")%>&nbsp;</td>
                <td><%= evt["RUMBO"]%></td>
                <td><%= evt["VELOCIDAD"]%></td>
                <td><%= evt["ESTADO"]%></td>
            </tr>
            <% } 
        } %>
        <% if (hayReportes == false)
           { %>
        <tr style="text-align:center;"><td colspan="5"><small>Esta etapa no registra reportes.</small></td></tr>
        <% } //End if %>
     </table>


    <table class="hist datos">
      <tr style="text-align:left;"><th colspan="8">Eventos</th></tr>
      <tr>
        <th>Fecha</th>
        <th>Latitud</th>
        <th>Longitud</th>
        <th>Comentario</th>
        <th>Descripcion</th>
        <th>Estado</th>
        <th>Rio Canal</th>
        <th>Acci&oacute;n</th>
      </tr>
    <% bool hayEventos = false; %>
    <% decimal temp; 
     foreach (Dictionary<string, string> evt in eventos) {
       if (evt["ETAPA_ID"] == etp["ID"] && evt["TIPO_ID"] == "20")
       {
           %>
           <% hayEventos = true; %>
            <tr id="evt<%=evt["ID"]%>" >
                <td><%= evt["FECHA"] %></td>
                <td><% if (!decimal.TryParse(evt["LATITUD"].ToString(), out temp)) Response.Write("sin dato"); else Response.Write(temp.ToString("0.00")); %>&nbsp;</td>
                <td><% if (!decimal.TryParse(evt["LONGITUD"].ToString(), out temp)) Response.Write("sin dato"); else Response.Write(temp.ToString("0.00"));%>&nbsp;</td>
                <td><%= evt["COMENTARIO"] %></td>
                <td><%= evt["DESCRIPCION"] %></td>
                <td><%= evt["ESTADO"]%></td>
                <td><%= evt["RIOCANAL"]%></td>
                <td><a href="<%=Url.Content("~/Viaje/borrar_evento/") + evt["ID"]%>?etapa_id=<%=ViewData["etapa_id"]%>" onclick="return borrar_evento(this);">Borrar</a></td>
            </tr>
            <% } 
        } %>
        <% if (hayEventos == false)
           { %>
        <tr style="text-align:center;"><td colspan="7"><small>Esta etapa no registra eventos.</small></td></tr>
        <% } //End if %>

     </table>



    </td>
</tr>
  
</table>    
  <% } %>

<script type="text/javascript" language="javascript">
  function borrar_evento(obj) {

    if (confirm("Esta seguro que desea borrar este evento?") == false)
      return false;

    $("#fullscreen").css("display", "block");

    $.ajax({
      type: "GET",
      cache: false,
      url: $(obj).attr('href'),
      success: function (data) {
        $('#dialogdiv').html(data);
        $("#fullscreen").css("display", "none");
      },
      error: function (data) {
        $("#fullscreen").css("display", "none");
        var titletag = /<title\b[^>]*>.*?<\/title>/
        alert(titletag.exec(data.responseText));
      }
    });

    return false;
  }

  <% if( ViewData["refresh_viajes"] != null && ViewData["refresh_viajes"].ToString() == "1" ) { %>
    $.ajax({
      type: "GET",
      cache: false,
      url: '<%= Url.Content("~/Home/RefrescarColumnas") %>',
      success: function (data) {
        if (data == "nop")
          $('#list').trigger('reloadGrid');
        else
          $("#columnas").html(data);
      },
    });
  <% } %>
</script>