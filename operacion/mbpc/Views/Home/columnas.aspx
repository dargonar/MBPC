<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%
  if( (string)ViewData["tipo_punto"] == "0" ) {
    Html.RenderPartial("_columnas"); 
  } else {
    Html.RenderPartial("_columnas_maritimo"); 
  }
%>