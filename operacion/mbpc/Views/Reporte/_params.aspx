<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<% var _params = (List<Object>)ViewData["params"];%>
<input type="hidden" value="<%=_params.Count%>" name="count" />
<% 
  foreach (var tmp in _params)
  {
    var param = (Dictionary<string, string>)tmp;
%>
  <div class="reporte_params_container" style="background:#EEE">
    <label><strong><%=param["NOMBRE"] %></strong></label><br />
    <input class="rparam" mask="<%= param["TIPO_DATO"] == "0" ? "99-99-99" : "" %>" autocomplete="off" type="text" id="param<%=param["INDICE"]%>" name="param<%=param["INDICE"]%>" style="width:270px"/><br />
    
    <% if(param["TIPO_DATO"] == "0") { %>
    <label class="desc">Formato: dd-mm-aa</label><br />
    <% } %>
  </div>
<%
  }
%>