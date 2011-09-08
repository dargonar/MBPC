﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<% var row = ViewData["row"] as Dictionary<string, string>; %>    

    <tr> 
    <td><%= row["NOMBRE"]%></td>
    <td><%= row["SDIST"]%></td>
    <td><%= row["BAND"]%></td>
    <td><%= row["FM"]%></td>
    <td><%= row["TOX"]%></td>
    <td><%= row["CAL"]%></td>
    <td><%= row["VEL"]%></td>
    <td><%= row["ZOE"]%></td>

    <% foreach (Dictionary<string, string> zona in (ViewData["zonas"] as List<object>)) { %>
    <td><%= row.Keys.Contains("ETAKM. " + zona["KM"]) ? row["ETAKM. " + zona["KM"]] : "--"%></td>
    <td><%= row.Keys.Contains("HRPKM. " + zona["KM"]) ? row["HRPKM. " + zona["KM"]] : "--"%></td>
    <% } %>
    <td></td>
    </tr>
