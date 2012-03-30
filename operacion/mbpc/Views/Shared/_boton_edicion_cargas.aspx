<%@ Page Title="" Language="C#"  Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="mbpc.Controllers" %>
<%
    var dnis = new string[] {"31719506","16819396","22995096","33423975","33470722",
                      "16648958","17311623","34057914","35005525","21928593"};

    if( dnis.Contains(Session["usuario"]) ) {
    %>
<div class="btn-new-class">
    <a id="a2" href="<%=MyController.URLPara("carga_link", Request)%>" target="_blank" class="agregarreportelink">Cargas</a>
</div>
<%}%>
