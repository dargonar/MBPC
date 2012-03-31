<%@ Page Title="" Language="C#"  Inherits="System.Web.Mvc.ViewPage" %>

<div id="linkos" style="display:none">
<a id="l0" href="#" xhref="<%= Url.Content("~/Viaje/agregarReporte/") + "?id=%SHIPID%&nombre=%NOMBRE%"%>" onclick="return agregarreporte(this);">Agregar Reporte</a>
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
<a id="l12" href="#" xhref="<%= Url.Content("~/Home/detallesTecnicos/") + "%IDBUQUE%" %>" onclick="return detallestecnicos(this);">Detalles Técnicos</a>
<a id="l13" href="#" xhref="<%= Url.Content("~/Viaje/histRVP/") %>%SHIPID%?etapa_id=%ETAPAID%" onclick="return histrvp(this);">Historial R/V/P</a>
<a id="l14" href="#" xhref="<%= Url.Content("~/Viaje/cambiarEstado/") + "%ETAPAID%" %>" onclick="return agregarevento(this);" class="agregareventolink">Actualizar/Cambiar Estado</a>
<a id="l15" href="#" xhref="<%= Url.Content("~/Viaje/practicos/") + "%ETAPAID%" %>" onclick="return practico(this);" class="agregareventolink">Practico/Baqueano</a>
</div>

<div class="contextMenu" id="myMenu1" style="display:none">
  <ul style="width: 200px">
    <li id="m0"><span style="font-size:80%; font-family:Verdana">Agregar Reporte</span></li>
    <li id="m1"><span style="font-size:80%; font-family:Verdana">Proximo Destino</span></li>
    <li id="m2"><span style="font-size:80%; font-family:Verdana">Pasar Barco</span></li>                
    <li id="m3"><span style="font-size:80%; font-family:Verdana">Terminar Viaje</span></li>                
    <li id="m4"><span style="font-size:80%; font-family:Verdana">Editar Etapa/Viaje</span></li>
    <li id="m5"><span style="font-size:80%; font-family:Verdana">Acompañantes</span></li>
    <li id="m6"><span style="font-size:80%; font-family:Verdana">Separar Convoy</span></li>
    <li id="m7"><span style="font-size:80%; font-family:Verdana">Editar Cargas</span></li>                
    <li id="m8"><span style="font-size:80%; font-family:Verdana">Transferir Barcazas</span></li>                
    <li id="m9"><span style="font-size:80%; font-family:Verdana">Transferir Carga</span></li>
    <li id="m10"><span style="font-size:80%; font-family:Verdana">Editar Notas</span></li>
    <li id="m11"><span style="font-size:80%; font-family:Verdana">PBIP (beta)</span></li>
    <li id="m12"><span style="font-size:80%; font-family:Verdana">Detalles Técnicos</span></li>                
    <li id="m13"><span style="font-size:80%; font-family:Verdana">Historial R/V/P</span></li>                
    <li id="m14"><span style="font-size:80%; font-family:Verdana">Actualizar/Cambiar Estado</span></li>
    <li id="m15"><span style="font-size:80%; font-family:Verdana">Practico/Baqueano</span></li>
  </ul>
</div>

<%Html.RenderPartial("_tabs_main");%>

<table id="list"></table> 
<div id="pager"></div>
<div id="filter" style="display:none">Buscar</div>

<!--<select size="6" id="searchlist"></select>-->


<script type="text/javascript">
  function myformatter ( totaldelay, options, rowObject )
  {
    newval = 'n/a';
    if( totaldelay < 0)
    {
        alert(totaldelay);
        return newval;
    }

    var d;
    if(d=Math.floor(totaldelay/86400))
    {
        totaldelay = totaldelay % 86400;
        return d + ' dias';
    }
    if(d=Math.floor(totaldelay/3600))
    {
        totaldelay = totaldelay % 3600;
        return d + ' horas';
    }
    if(d=Math.floor(totaldelay/60))
    {
        totaldelay = totaldelay % 60;
        return d + ' minutos';
    }

    d=Math.floor(totaldelay/1);
    totaldelay = totaldelay % 1;
    return d + ' segundos';

  }
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
      url: '/Viaje/ListJson?VESTADO=0&PID=<%=Session["zona"].ToString()%>',
      datatype: 'json',
      mtype: 'GET',
      colNames: ["PID", "ID", "COSTERA", "ETAPA", "PROXDEST", "ID_BUQUE", "Buque", "OMI", "Matricula", "Señal Dist.", "Bandera", "Lat", "Lon", "Origen", "Destino", "Estado", "Ultimo Reporte"],
      colModel: [
    { name: 'PID', index: 'PID', width: 90, hidden: true },
    { name: 'ID', index: 'ID', width: 90 },
    { name: 'COSTERA', index: 'COSTERA', width: 90 },
    { name: 'ETAPA', index: 'ETAPA', width: 90, hidden: true },
    { name: 'PROXDEST', index: 'PROXDEST', width: 90, hidden: true },
    { name: 'ID_BUQUE', index: 'ID_BUQUE', width: 90, hidden: true },
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
    { name: 'ULTIMO', index: 'ULTIMO', width: 80, formatter: myformatter },
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
  var idbuque = mygrid.getRowData(gsr)['ID_BUQUE'];
  var nombre  = mygrid.getRowData(gsr)['NOMBRE'];

  

  var href = $('#'+linkname).attr('xhref');
  href = href.replace('%SHIPID%', shipid);
  href = href.replace('%ETAPAID%', etapaid);
  href = href.replace('%IDBUQUE%', idbuque);
  href = href.replace('%NOMBRE%', nombre);
  

  $('#'+linkname).attr('href', href).click();
  $('#'+linkname).attr('nextdest',proxdest);

}

function initGrid() {
  jQuery(".jqgrow", "#list").contextMenu('myMenu1', {
    bindings: {
      'm0': function (t) { runlink('l0'); },
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
      $('#'+rowId).click();
      //grid.setSelection(rowId, true);

      return true;

    }
  });
}



</script>