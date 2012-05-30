<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<% if (ViewData.ContainsKey("AutoEditarEtapa")) {  
   var AutoEditarEtapa = (ViewData["AutoEditarEtapa"] as List<object>)[0] as Dictionary<string, string>;
%>
   <script type="text/javascript">
       editarcargas_ex('<%= Url.Content("~/Carga/ver/") +  AutoEditarEtapa["ID"] %>', true, '<%=AutoEditarEtapa["VIAJE_ID"]%>', '<%=AutoEditarEtapa["ID"]%>');
   </script>
<% } %>