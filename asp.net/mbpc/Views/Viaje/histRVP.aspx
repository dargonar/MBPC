﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<% List<object> historial = ViewData["historial"] as List<object>; %>
<% List<object> eventos = ViewData["eventos"] as List<object>; %>


<% foreach (Dictionary<string, string> etp in historial) { %>
<table class="hist etapa">
<tr>
    <th>
    Etapa Nro: <%= etp["NRO_ETAPA"] %>
    </th>
</tr>
<tr>
    <td>
    <table class="hist datos">
      <tr><th colspan="3">Datos del buque</th></tr>
      <tr>
        <td>P. de control</td>
      </tr>
      <tr>
        <td><small><%= etp["CANAL"] +" - KM " + etp["KM"] %></small></td>

      </tr>
    </table>

    <table class="hist datos">
      <tr><th colspan="5">Reportes</th></tr>
      <tr>
        <td>Latitud</td>
        <td>Longitud</td>
        <td>Rumbo</td>
        <td>Velocidad</td>
        <td>Codigo</td>
        
      </tr>
    <% foreach (Dictionary<string, string> evt in eventos) {
         if (evt["ETAPA_ID"] == etp["ID"] && evt["TIPO_ID"] == "19")
         {
           %>
            <tr>
                <td><%= decimal.Parse(evt["LATITUD"]).ToString("0.00")%>&nbsp;</td>
                <td><%= decimal.Parse(evt["LONGITUD"]).ToString("0.00")%>&nbsp;</td>
                <td><%= evt["RUMBO"]%></td>
                <td><%= evt["VELOCIDAD"]%></td>
                <td><%= evt["ESTADO"]%></td>
            </tr>
            <% } 
        } %>


     </table>


    <table class="hist datos">
      <tr><th colspan="6">Eventos</th></tr>
      <tr>
        <td>Latitud</td>
        <td>Longitud</td>
        <td>Comentario</td>
        <td>Descripcion</td>
        <td>Estado</td>
        <td>Rio Canal</td>
      </tr>
    <% decimal temp; 
     foreach (Dictionary<string, string> evt in eventos) {
       if (evt["ETAPA_ID"] == etp["ID"] && evt["TIPO_ID"] == "20")
       {
           %>
            <tr>
                <td><% if (!decimal.TryParse(evt["LATITUD"].ToString(), out temp)) Response.Write("sin dato"); else Response.Write(temp.ToString("0.00")); %>&nbsp;</td>
                <td><% if (!decimal.TryParse(evt["LONGITUD"].ToString(), out temp)) Response.Write("sin dato"); else Response.Write(temp.ToString("0.00"));%>&nbsp;</td>
                <td><%= evt["COMENTARIO"] %></td>
                <td><%= evt["DESCRIPCION"] %></td>
                <td><%= evt["ESTADO"]%></td>
                <td><%= evt["RIOCANAL"]%></td>
            </tr>
            <% } 
        } %>


     </table>



    </td>
</tr>
  
</table>    
  <% } %>