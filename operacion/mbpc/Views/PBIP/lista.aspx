<%@ Page Title="" Language="C#"  Inherits="System.Web.Mvc.ViewPage" %>

<div id="linkos" style="display:none">
  <a id="l1" href="#" xhref="<%= Url.Content("~/PBIP/modificar/") + "?id=%PBIP_ID%"%>" onclick="return pbip(this, 'Modificar formulario PBIP');">Modificar</a>
  <a id="l2" href="#" xhref="<%= Url.Content("~/PBIP/borrar/") + "?id=%PBIP_ID%" %>" onclick="return borrarPBIP(this);" >Borrar</a>
  <a id="l3" href="#" xhref="<%= Url.Content("~/PBIP/imprimir/") + "?id=%PBIP_ID%" %>" onclick="return imprimirPBIP(this);">Imprimir</a>
</div>

<div class="contextMenu" id="myMenu1" style="display:none">
  <ul style="width: 200px">
    <li id="m1"><span style="font-size:80%; font-family:Verdana">Modificar</span></li>
    <li id="m2"><span style="font-size:80%; font-family:Verdana">Borrar</span></li>
    <li id="m3"><span style="font-size:80%; font-family:Verdana">Imprimir</span></li>
    <!-- li id="m3"><span style="font-size:80%; font-family:Verdana">Crear Viaje para este PBIP</span></li -->                
  </ul>
</div>

<div id="area" style="padding-bottom:5px;">
  <ul id="tabs">
    <div class="btn-new-class" style="float:left;">
      <a id="a1" href="<%= Url.Content("~/PBIP/Index") %>" > Listado PBIP</a>
    </div>
    <div class="btn-new-class" style="margin-left:10px;float:left;">
      <a id="a2" href="<%= Url.Content("~/PBIP/nuevo/") %>" onclick="return pbip(this, 'Nuevo formulario PBIP');"> Nuevo PBIP</a>
    </div>    
  </ul>
  <div class="split"></div>	
</div><!-- tabs -->

<% if (!String.IsNullOrEmpty(Convert.ToString(ViewData["result_message"])))
   { %>
    <div class="msg_info msg_<%=ViewData["result_type"]%>"><%=ViewData["result_message"]%></div>
    
<% } %>

<table id="list"></table> 
<div id="pager"></div>
<div id="filter" style="display:none">Buscar</div>

<!--<select size="6" id="searchlist"></select>-->


<script type="text/javascript">

  function borrarPBIP(sender){
    if(!confirm('¿Está seguro que desea borrar este formulario? Esta acción es irreversible'))
      return false;
    var href = $(sender).attr('href');
    //document.location = href;
    window.location.href = href;
    return true;
  }

  function imprimirPBIP(sender){
    var href = $(sender).attr('href');
    window.open(href,'poppoup','width=800, scrollbars=yes, location=no, menubar=no');
    return true;
  }

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

  var mygrid;
  $(function () {
    mygrid = $("#list").jqGrid({
      url: '/PBIP/ListJson',
      datatype: 'json',
      mtype: 'GET',
      colNames: ["ID", "COSTERA", "NOMBRE", "BANDERA", "IMO", "ETA", "PUERTO_LLEGADA", "PROCEDENCIA", "NIVEL_PROTECCION_ACTUAL", "CIPB_EXPIRACION"],
      colModel: [
    { name: 'ID', index: 'ID', width: 90, hidden: true },
    { name: 'COSTERA', index: 'COSTERA', width: 90 },
    { name: 'NOMBRE', index: 'NOMBRE', width: 90 },
    { name: 'BANDERA', index: 'BANDERA', width: 90 },
    { name: 'IMO', index: 'IMO', width: 90 },
    { name: 'ETA', index: 'ETA', width: 90 },
    { name: 'PUERTO_LLEGADA', index: 'PUERTO_LLEGADA', width: 90 },
    { name: 'PROCEDENCIA', index: 'PROCEDENCIA', width: 80 },
    { name: 'NIVEL_PROTECCION_ACTUAL', index: 'NIVEL_PROTECCION_ACTUAL', width: 80 },
    { name: 'CIPB_EXPIRACION', index: 'CIPB_EXPIRACION', width: 80 }
    ],
      pager: '#pager',
      rowNum: 20,
      rowList: [10, 20, 30],
      sortname: 'ID',
      sortorder: 'desc',
      viewrecords: true,
      gridview: true,
      autowidth: true,
      height: 400,
      caption: 'PBIP',
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
    alert("Debe elegir un formulario");
    return;
  }

  var PBIP_ID = mygrid.getRowData(gsr)['ID'];
  
  var href = $('#'+linkname).attr('xhref');
  href = href.replace('%PBIP_ID%', PBIP_ID);

  $('#'+linkname).attr('href', href).click();
  
}

function initGrid() {
  jQuery(".jqgrow", "#list").contextMenu('myMenu1', {
    bindings: {
      'm1': function (t) { runlink('l1'); },
      'm2': function (t) { runlink('l2'); },
      'm3': function (t) { runlink('l3'); }
    },
    onContextMenu: function (event, menu) {
      var rowId = $(event.target).parent("tr").attr("id")
      var grid = $("#list");
      $('#'+rowId).click();
      //grid.setSelection(rowId);

      return true;

    }
  });
}

  
  <% if (!String.IsNullOrEmpty(Convert.ToString(ViewData["id"]))){ %>
    $(document).ready(function () { 
      pbip2('<%= Url.Content("~/PBIP/modificar/") + "?id=" + ViewData["id"] %>', 'Modificar formulario PBIP');
    });
  <% } %>

</script>