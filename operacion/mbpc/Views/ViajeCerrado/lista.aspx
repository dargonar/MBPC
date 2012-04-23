<%@ Page Title="" Language="C#"  Inherits="System.Web.Mvc.ViewPage" %>

<div id="linkos" style="display:none">
  <a id="l1" href="#" xhref="<%= Url.Content("~/ViajeCerrado/verEtapas/") + "?id=%VIAJE_ID%"%>" onclick="return verEtapas(this);">Ver Etapas</a>
</div>

<div class="contextMenu" id="myMenu1" style="display:none">
  <ul style="width: 200px">
    <li id="m1"><span style="font-size:80%; font-family:Verdana">Ver Etapas</span></li>
  </ul>
</div>

<div id="area" style="padding-bottom:0px;">
  <!--ul id="tabs">
    <div class="btn-new-class" style="float:left;">
      <a id="a1" href="#" > ?</a>
    </div>
    <div class="btn-new-class" style="margin-left:10px;float:left;">
      <a id="a2" href="#" onclick="return false;"> ?</a>
    </div>    
  </ul-->
  <div class="split"></div>	
</div>

<% if (!String.IsNullOrEmpty(Convert.ToString(ViewData["result_message"])))
   { %>
    <div class="msg_info msg_<%=ViewData["result_type"]%>"><%=ViewData["result_message"]%></div>
    
<% } %>

<table id="list"></table> 
<div id="pager"></div>
<div id="filter" style="display:none">Buscar</div>

<!--<select size="6" id="searchlist"></select>-->


<script type="text/javascript">

  function verEtapas(sender){
    var href = $(sender).attr('href');
    window.location.href = href;
    return true;
  }

  function myformatter ( totaldelay, options, rowObject )
  {
    newval = 'n/a';
    
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
      url: '/ViajeCerrado/ListJson',
      datatype: 'json',
      mtype: 'GET',
      colNames: ["ACTUAL", "ID", "NOMBRE", "NRO_OMI", "MATRICULA", "SDIST", "BANDERA", "ORIGEN", "DESTINO", "FECHA_SALIDA", "FECHA_LLEGADA", "NOTAS", "ESTADO"],
      colModel: [
          {name: 'ACTUAL',  index: 'ACTUAL', width: 0, hidden: true },
          {name: 'ID',      index:'ID', width: 0, hidden: true },
          {name: 'NOMBRE',  index:'NOMBRE', width: 90},
          {name: 'NRO_OMI', index:'NRO_OMI', width: 90 },
          {name: 'MATRICULA', index:'MATRICULA', width: 90},
          {name: 'SDIST',   index:'SDIST', width: 90},
          {name: 'BANDERA', index:'BANDERA', width: 90},
          {name: 'ORIGEN',  index:'ORIGEN', width: 90},
          {name: 'DESTINO', index:'DESTINO', width: 90 },
          {name: 'FECHA_SALIDA', index:'FECHA_SALIDA', width: 90 },
          {name: 'FECHA_LLEGADA', index:'ETA', width: 90},
          {name: 'NOTAS',   index:'NOTAS', width: 90 },
          {name: 'ESTADO',  index:'ESTADO', width: 90 }],
      pager: '#pager',
      rowNum: 20,
      rowList: [10, 20, 30],
      sortname: 'ID',
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

  var PBIP_ID = mygrid.getRowData(gsr)['ID'];
  
  var href = $('#'+linkname).attr('xhref');
  href = href.replace('%VIAJE_ID%', PBIP_ID);

  $('#'+linkname).attr('href', href).click();
  
}

function initGrid() {
  jQuery(".jqgrow", "#list").contextMenu('myMenu1', {
    bindings: {
      'm1': function (t) { runlink('l1'); }
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

  
</script>