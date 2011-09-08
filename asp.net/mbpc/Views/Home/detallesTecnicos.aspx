<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<% Dictionary<string, string> barco = (ViewData["barco"] as List<object>)[0] as Dictionary<string, string>;%>

<table class="detalles">
  <tr>
    <td>Matricula</td>
    <td><%= barco["MATRICULA"] %></td>
  </tr>
  <tr>
    <td>Bandera</td>
    <td><%= barco["BANDERA"] %></td>
  </tr>
  <tr>
    <td>Año de construcción</td>
    <td><%= barco["ANIO_CONSTRUCCION"] %></td>
  </tr>
  <tr>
    <td>Fecha Incripto</td>
    <td><%= barco["FECHA_INSCRIP"] %></td>
  </tr>
  <tr>
    <td>Astillero</td>
    <td><%= barco["ASTILL_PARTIC"] %></td>
  </tr>
  <tr>
    <td>Expediente</td>
    <td><%= barco["EXPTE_INSCRIP"] %></td>
  </tr>
  <tr>
    <td>Arqueo Neto</td>
    <td><%= barco["ARQUEO_NETO"] %></td>
  </tr>
  <tr>
    <td>Arqueo Total</td>
    <td><%= barco["ARQUEO_TOTAL"] %></td>
  </tr>
  <tr>
    <td>Tipo de Buque</td>
    <td><%= barco["TIPO_BUQUE"] %></td>
  </tr>
</table>