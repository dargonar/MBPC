<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%  var ship = Model as Dictionary<string,string>; %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
  <title>Titulin</title>
  <style type="text/css" media="screen">
    .float-left {
      float: left;
      margin-right: .5em;
      display: inline;
    }
    h2 {
      font-size: 1.1em;
    }
  </style>
</head>
<body>

<table border="1">
        <tr>
          <td>Viaje</td>
          <td><%= ship["ID"] %></td>
        </tr>
        <tr>
          <td>Tiene Acomp.</td>
          <td><%= ship["TIENE_ACOMPANANTE"].ToString() == "1" ? "SI" : "NO" %></td>
        </tr>
        
        <tr>
          <td>Origen</td>
          <td><%= ship["ORIGEN"] %></td>
        </tr>
        <tr>
          <td>Destino</td>
          <td><%= ship["DESTINO"] %></td>
        </tr>
        <tr>
          <td>ETA Prox.</td>
          <td><%= ship["ETA"] %></td>
        </tr>
        <tr>
          <td>Pto. Prox</td>
          <td><%= ship["PROXIMO"]%></td>
        </tr>
        <tr>
          <td>Pto. Anterior</td>
          <td><%= ship["ANTERIOR"]%></td>
        </tr>
        <tr>
          <td>Costera</td>
          <td><%= ship["COSTERA"] %></td>
        </tr>
        <tr>
          <td>Estado</td>
          <td><%=ship["ESTADO_TEXT"] %></td>
        </tr>
        <tr>
          <td>Matricula</td>
          <td><%= ship["MATRICULA"]%></td>
        </tr>
        <tr>
          <td>OMI</td>
          <td><%= ship["NRO_OMI"]%></td>
        </tr>
        <tr>
          <td>Bandera</td>
          <td><%= ship["BANDERA"]%></td>
        </tr>
        <tr>
          <td>Señal Dist.</td>
          <td><%= ship["SDIST"]%></td>
        </tr>
        <tr>
          <td>Calado Informado</td>
          <td><%= ship["CALADO_INFORMADO"]%></td>
        </tr>
        <tr>
          <td>Calado Máximo</td>
          <td><%= ship["CALADO_MAX"]%></td>
        </tr>
</table>
</body>
</html>