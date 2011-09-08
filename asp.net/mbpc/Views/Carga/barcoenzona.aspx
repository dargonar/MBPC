<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<select id="barcoszona" style="width: 270px">
<%string etapapa = ViewData["etapa_id"].ToString(); %>
<% foreach (Dictionary<string, string> barco in (ViewData["barcos_en_zona"] as List<object>))
    {
      if (barco["ETAPA_ID"] == etapapa) continue;
     %>
       <option value="<%= barco["ETAPA_ID"] %>"><%= barco["NOMBRE"] %></option>
 <% } 
%>
</select>
<button type="button" style="margin-left: 161px;margin-top: 20px" onclick="return editarBarcazas('<% Response.Write(Url.Content("~/Carga/editarBarcazas/" + ViewData["etapa_id"] )); %>/' + $('#barcoszona').val() );">
                                            <% Response.Write("Siguiente"); %> </button>
