<%@ Page Title="" Language="C#"  Inherits="System.Web.Mvc.ViewPage" %>

<div id="linkos" style="display:none">
  <a id="l1" href="#" xhref="<%= Url.Content("~/PBIP/modificar/") + "?id=%PBIP_ID%"%>" onclick="return pbip(this, 'Modificar formulario PBIP');">Modificar</a>
  <a id="l2" href="#" xhref="<%= Url.Content("~/PBIP/borrar/") + "?id=%PBIP_ID%" %>" onclick="return borrarPBIP(this);" >Borrar</a>
  <!--a id="l3" href="#" xhref="<% //= Url.Content("~/PBIP/nuevo_viaje_desdePBIP/") + "?id=%PBIP_ID%" %>" onclick="alert('Pronto!');return false;">Crear Viaje para este PBIP</a -->
</div>

<div class="contextMenu" id="myMenu1" style="display:none">
  <ul style="width: 200px">
    <li id="m1"><span style="font-size:80%; font-family:Verdana">Modificar</span></li>
    <li id="m2"><span style="font-size:80%; font-family:Verdana">Borrar</span></li>                
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
    <div class="msg_info msg_success"><%=ViewData["result_message"]%></div>
    
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
      colNames: ["ID", "NRO_IMO", "BUQUE_NOMBRE", "COMPANIA", "OBJETIVO", "PUERTO_LLEGADA", "ETA", "CIPB_ESTADO"],
      colModel: [
    { name: 'ID', index: 'ID', width: 90, hidden: true },
    { name: 'NRO_IMO', index: 'NRO_IMO', width: 90 },
    { name: 'BUQUE_NOMBRE', index: 'BUQUE_NOMBRE', width: 90 },
    { name: 'COMPANIA', index: 'COMPANIA', width: 90 },
    { name: 'OBJETIVO', index: 'OBJETIVO', width: 90 },
    { name: 'DESTINO', index: 'PUERTO_LLEGADA', width: 90 },
    { name: 'ETA', index: 'ETA', width: 90 },
    { name: 'CIPB ESTADO', index: 'CIPB_ESTADO', width: 80 }/*,
    { name: 'ARQUEOBRUTO', index: 'ARQUEOBRUTO', width: 80 },
    { name: 'COMPANIA', index: 'COMPANIA', width: 80 },
    { name: 'CONTACTOOCPM', index: 'CONTACTOOCPM', width: 80 },
    { name: 'ETA', index: 'ETA', width: 80 },
    { name: 'VIAJE', index: 'VIAJE', width: 80 },
    { name: 'OBJETIVO', index: 'OBJETIVO', width: 80 },
    { name: 'DESTINO', index: 'DESTINO', width: 80 },
    { name: 'ORIGEN', index: 'ORIGEN', width: 80 },*/
    /*{ name: ' ', index: 'ULTIMO', width: 80, formatter: myformatter },*/
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
      'm2': function (t) { runlink('l2'); }
      /*'m3': function (t) { runlink('l3'); }*/
    },
    onContextMenu: function (event, menu) {
      var rowId = $(event.target).parent("tr").attr("id")
      var grid = $("#list");
      grid.setSelection(rowId);

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