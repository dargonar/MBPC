<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%
  if( (string)Session["uso_punto"] != "0" ) {
    Html.RenderPartial("_columnas_maritimo"); 
  } else {
    Html.RenderPartial("_columnas"); 
  }
  Html.RenderPartial("_auto_edit_carga");
%>
