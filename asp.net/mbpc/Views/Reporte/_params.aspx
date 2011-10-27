<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<% 
  foreach (var tmp in (List<Object>)ViewData["params"])
  {
    var param = (Dictionary<string, string>)tmp;
%>
  <div class="reporte_params_container">
    <label>#<%=param["INDICE"]%> <%=param["NOMBRE"] %></label><br />
    <input class="rparam" dval="<% %>" autocomplete="off" type="text" id="param<%=param["INDICE"]%>" name="param<%=param["INDICE"]%>" style="width:270px"/><br />
    
    <% if(param["TIPO_DATO"] == "0") {%>
    <label class="desc">Formato: dd-mm-aa</label><br />
    {% } %}
  </div>
<%
  }    
%>