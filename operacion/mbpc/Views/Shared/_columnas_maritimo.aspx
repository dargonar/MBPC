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

      </ul>
  <div class="split"></div>	
</div><!-- tabs -->

<table id="list"><tr><td/></tr></table> 
<div id="pager"></div>
<div id="filter" style="display:none">Buscar</div>

<!--<select size="6" id="searchlist"></select>-->


<script type="text/javascript">
    //"NDOC", "DESTINO", "PASSWORD", "APELLIDO", "NOMBRES", "DESTINO", "FECHAVENC", "TEDIRECTO", "EMAIL", "NOMBREDEUSUARIO"
    $(function () {
      var mygrid = $("#list").jqGrid({
        url: '/Viaje/ListJson?zona=<%=zona["ID"]%>',
        datatype: 'json',
        mtype: 'GET',
        colNames: ["Documento", "Destino", "Password", "Apellido", "Nombres", "Destino", "Fechavenc", "Tel Directo", "email", "nombredeusuario"],  
        colModel: [
      { name: 'NDOC', index: 'NDOC', width: 90},
      { name: 'DESTINO', index: 'DESTINO', width: 90},
      { name: 'PASSWORD', index: 'PASSWORD', width: 90 },
      { name: 'APELLIDO', index: 'APELLIDO', width: 80 },
      { name: 'NOMBRES', index: 'NOMBRES', width: 80 },
      { name: 'DESTINO', index: 'DESTINO', width: 80 },
	    { name: 'FECHAVENC', index: 'FECHAVENC', width: 80 },
      { name: 'TEDIRECTO', index: 'TEDIRECTO', width: 80 },
      { name: 'EMAIL', index: 'EMAIL', width: 80 },
      { name: 'NOMBREDEUSUARIO', index: 'NOMBREDEUSUARIO', width: 80 },
    ],
        pager: '#pager',
        rowNum: 20,
        rowList: [10, 20, 30],
        sortname: 'NDOC',
        sortorder: 'desc',
        viewrecords: true,
        gridview: true,
        autowidth: true,
        height: 400,
        caption: 'Usuarios',
        search: true,
      });

      mygrid.filterToolbar({
      height: 20
      });
      mygrid.navGrid('#pager', { edit: false,
        add: false,
        del: false,
        search: false
      }).navButtonAdd('#pager', {
        caption: "Ver Grupos",
        buttonicon: "ui-icon-view",
        onClickButton: function () {
            var gsr = mygrid.getGridParam('selrow');
            if (!gsr){
              alert("Debe elegir un usuario");
              return;
            }
            var id = mygrid.getRowData(gsr)['NDOC'];
            window.location = '/Usuario/Grupos?usuario='+id;
        },
        position: "last"
      });
    });

</script>