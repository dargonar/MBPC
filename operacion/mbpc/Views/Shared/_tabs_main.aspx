<%@ Page Title="" Language="C#"  Inherits="System.Web.Mvc.ViewPage" %>
<div id="area">
      <ul id="tabs">
        <% foreach (Dictionary<string, string> zona in (Session["zonas"] as List<object>))
       {
         string classstr = string.Empty;
         if ( Session["zona"].ToString() == zona["ID"].ToString() ) classstr = "class=\"megaestiloselected\"";
         string nombre = string.Empty;
         
        if( zona["KM"] == "0" )
            nombre = zona["CANAL"] + " - " + zona["UNIDAD"];
         else
            nombre = zona["CANAL"] + " - " + zona["UNIDAD"] + " " + zona["KM"];
        %>
            <li <%=classstr%>><a href="<%= Url.Action("cambiarZona", "Home", new { @id = zona["ID"] }) %>" onclick="return cambiarZona(this);"><%=nombre%></a></li>

       <% } %>

       <div class="btn-new-class" style="margin-left:10px;">
        <a id="a1" href="<%= Url.Content("~/Reporte/Index/") %>" target="_blank" class="agregarreportelink"> Reportes</a>
       </div>

       <div class="btn-new-class" style="margin-left:10px;">
        <a id="a2" href="<%= Url.Content("~/PBIP/Index/") %>" target="_blank" class="agregarreportelink"> PBIP</a>
       </div>
       
       <div class="btn-new-class">
        <a href="<%= Url.Content("~/Home/reporteDiario/") %>" onclick="return reportediario(this);"> Reporte Diario</a>
       </div>

       <div class="btn-new-class">
       <a href="<%= Url.Content("~/Viaje/terminados/") %>" onclick="return viajesterminados(this);"> Viajes Terminados</a>
       </div>


       <div id="btn-new">
        <a id="nuevo_viaje" href="<%= Url.Content("~/Viaje/nuevo/") %>" onclick="return nuevoviaje(this);"> Nuevo Viaje</a>
       </div>

       <div class="btn-new-class">
        <a id="agregar_reporte" href="<%= Url.Content("~/Viaje/agregarReporte/") %>" onclick="return agregarreporte(this);" class="agregarreportelink"> Agregar Reporte</a>
       </div>
       
       <%Html.RenderPartial("_boton_edicion_cargas"); %>

      </ul>
  <div class="split"></div>	
</div><!-- tabs -->
