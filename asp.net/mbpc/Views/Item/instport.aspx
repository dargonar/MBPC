<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>



<% foreach (Dictionary<string, string> instport in (ViewData["instports"] as List<object>))
    { %>
       <option value="<%= instport["ID_PUERTO"] %>"><%= instport["NOMBRE"]%></option>
 <% } 
%>

