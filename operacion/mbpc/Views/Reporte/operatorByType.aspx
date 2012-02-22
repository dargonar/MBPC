<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
 
<% SortedDictionary<string, string> operators = ViewData["operators"] as SortedDictionary<string, string>; %>
<% foreach (string key in operators.Keys)  
      {
        string attr_key = key;
        string attr_description = operators[key];   
              
      %>
      <option value="<%= attr_key %>" ><%= attr_description %></option>
    <% } %>