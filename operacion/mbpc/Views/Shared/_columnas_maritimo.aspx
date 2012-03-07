﻿<%@ Page Title="" Language="C#"  Inherits="System.Web.Mvc.ViewPage" %>

<div id="linkos" style="display:none">
<a id="l1" href="#" xhref="<%= Url.Content("~/Home/zonasAdyacentes/") + Session["zona"] + "/%SHIPID%/false"%>" onclick="return dialogozonas(this,'Proximo Destino');">Proximo Destino</a>
<a id="l2" href="#" xhref="<%= Url.Content("~/Home/zonasAdyacentes/") + Session["zona"] + "/%SHIPID%" %>" onclick="fx(this);return dialogozonas(this,'Pasar Barco',true);" nextdest="#" class="pasarbarcolink" >Pasar Barco</a>
<a id="l3" href="#" xhref="<%= Url.Content("~/Viaje/preguntarFecha/") + "%SHIPID%/terminarviaje" %>" onclick="return preguntarfecha(this,2);">Terminar Viaje</a>
<a id="l4" href="#" xhref="<%= Url.Content("~/Viaje/editarEtapa/") +  "%SHIPID%/%ETAPAID%" %>" onclick="return editaretapa(this);" class="editaretapalink">Editar Etapa/Viaje</a>
<a id="l5" href="#" xhref="<%= Url.Content("~/Viaje/Acompanantes/") + "%ETAPAID%" %>" onclick="return elegiracompanante(this);return false;">Acompañantes</a>
<a id="l6" href="#" xhref="<%= Url.Content("~/Viaje/preguntarFecha/") + "%SHIPID%/separarconvoy" %>" onclick="return preguntarfecha(this,1);return false;">Separar Convoy</a>
<a id="l7" href="#" xhref="<%= Url.Content("~/Carga/ver/") + "%ETAPAID%" %>" onclick="return editarcargas(this);">Editar Cargas</a>
<a id="l8" href="#" xhref="<%= Url.Content("~/Carga/barcoenzona/") + "%ETAPAID%?viaje_id=%SHIPID%" %>" onclick="return transferirbarcazas(this);">Transferir Barcazas </a>
<a id="l9" href="#" xhref="<%= Url.Content("~/Carga/barcoenzona/") + "%ETAPAID%?viaje_id=%SHIPID%" %>&carga=1" onclick="return transferirbarcazas(this);">Transferir Carga </a>
<a id="l10" href="#" xhref="<%= Url.Content("~/Viaje/editarNotas/") + "%SHIPID%" %>" onclick="return editarnotas(this);return false;">Editar Notas</a>
<a id="l11" href="#" xhref="<%= Url.Content("~/Viaje/editarPbip/") + "%SHIPID%" %>" onclick="return pbip(this);">PBIP (beta)</a>
<a id="l12" href="#" xhref="<%= Url.Content("~/Home/detallesTecnicos/") + "%SHIPID%" %>" onclick="return detallestecnicos(this);">Detalles Técnicos</a>
<a id="l13" href="#" xhref="<%= Url.Content("~/Viaje/histRVP/") %>%SHIPID%?etapa_id=%ETAPAID%" onclick="return histrvp(this);">Historial R/V/P</a>
<a id="l14" href="#" xhref="<%= Url.Content("~/Viaje/cambiarEstado/") + "%ETAPAID%" %>" onclick="return agregarevento(this);" class="agregareventolink">Actualizar/Cambiar Estado</a>
<a id="l15" href="#" xhref="<%= Url.Content("~/Viaje/practicos/") + "%ETAPAID%" %>" onclick="return practico(this);" class="agregareventolink">Practico/Baqueano</a>
</div>

<div class="contextMenu" id="myMenu1" style="display:none">
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

<table id="list"></table> 
<div id="pager"></div>
<div id="filter" style="display:none">Buscar</div>

<!--<select size="6" id="searchlist"></select>-->


<script type="text/javascript">
  //{"PID","i"},
  //{"ID","i"}, 
  //{"NOMBRE","s"},
  //{"NRO_OMI","s"},
  //{"MATRICULA","s"},
  //{"SDIST","s"},
  //{"BANDERA","s"},
  //{"LATITUD","f"},
  //{"LONGITUD","f"},
  //{"ORIGEN_ID","s"},
  //{"DESTINO_ID","s"},
  //{"ESTADO","s"},
  //{"ULTIMO","i"}
  var mygrid;
  $(function () {
    mygrid = $("#list").jqGrid({
      url: '/Viaje/ListJson?PID=<%=Session["zona"].ToString()%>',
      datatype: 'json',
      mtype: 'GET',
      colNames: ["PID", "ID", "ETAPA", "PROXDEST", "Buque", "OMI", "Matricula", "Señal Dist.", "Bandera", "Lat", "Lon", "Origen", "Destino", "Estado", "Ultimo Reporte"],
      colModel: [
    { name: 'PID', index: 'PID', width: 90, hidden: true },
    { name: 'ID', index: 'ID', width: 90 },
    { name: 'ETAPA', index: 'ETAPA', width: 90, hidden: true },
    { name: 'PROXDEST', index: 'PROXDEST', width: 90, hidden: true },
    { name: 'NOMBRE', index: 'NOMBRE', width: 90 },
    { name: 'NRO_OMI', index: 'NRO_OMI', width: 80 },
    { name: 'MATRICULA', index: 'MATRICULA', width: 80 },
    { name: 'SDIST', index: 'SDIST', width: 80 },
    { name: 'BANDERA', index: 'BANDERA', width: 80 },
    { name: 'LATITUD', index: 'LATITUD', width: 80 },
    { name: 'LONGITUD', index: 'LONGITUD', width: 80 },
    { name: 'ORIGEN', index: 'ORIGEN', width: 80 },
    { name: 'DESTINO', index: 'DESTINO', width: 80 },
    { name: 'ESTADO', index: 'ESTADO', width: 80 },
    { name: 'ULTIMO', index: 'ULTIMO', width: 80 },
    ],
      pager: '#pager',
      rowNum: 20,
      rowList: [10, 20, 30],
      sortname: 'ULTIMO',
      sortorder: 'desc',
      viewrecords: true,
      gridview: true,
      autowidth: true,
      height: 400,
      caption: 'Viajes',
      search: true,
      gridComplete: initGrid,
      hoverrows: false
    });

    mygrid.filterToolbar({
      height: 25
    });

    mygrid.navGrid('#pager', {
      edit: false,
      add: false,
      del: false,
      search: false,
      refreshstate: 'current'
    });

  });

function runlink(linkname)
{
  var gsr = mygrid.getGridParam('selrow');
  if (!gsr){
    alert("Debe elegir un viaje");
    return;
  }
  
  var shipid  = mygrid.getRowData(gsr)['ID'];
  var etapaid = mygrid.getRowData(gsr)['ETAPA'];
  var proxdest = mygrid.getRowData(gsr)['PROXDEST'];
  
  var href = $('#'+linkname).attr('xhref');
  href = href.replace('%SHIPID%', shipid);
  href = href.replace('%ETAPAID%', etapaid);
  $('#'+linkname).attr('href', href).click();
  $('#'+linkname).attr('nextdest',proxdest);

}

function initGrid() {
  jQuery(".jqgrow", "#list").contextMenu('myMenu1', {
    bindings: {
      'm1': function (t) { runlink('l1'); },
      'm2': function (t) { runlink('l2'); },
      'm3': function (t) { runlink('l3'); },
      'm4': function (t) { runlink('l4'); },
      'm5': function (t) { runlink('l5'); },
      'm6': function (t) { runlink('l6'); },
      'm7': function (t) { runlink('l7'); },
      'm8': function (t) { runlink('l8'); },
      'm9': function (t) { runlink('l9'); },
      'm10': function (t) { runlink('l10'); },
      'm11': function (t) { runlink('l11'); },
      'm12': function (t) { runlink('l12'); },
      'm13': function (t) { runlink('l13'); },
      'm14': function (t) { runlink('l14'); },
      'm15': function (t) { runlink('l15'); },
    },
    onContextMenu: function (event, menu) {
      var rowId = $(event.target).parent("tr").attr("id")
      var grid = $("#list");
      grid.setSelection(rowId);

      return true;

    }
  });
}



</script>