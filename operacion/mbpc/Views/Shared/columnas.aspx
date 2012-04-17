<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%
  if( (string)Session["tipo_punto"] != "0" ) {
    Html.RenderPartial("_columnas_maritimo"); 
  } else {
    Html.RenderPartial("_columnas"); 
  }
%>