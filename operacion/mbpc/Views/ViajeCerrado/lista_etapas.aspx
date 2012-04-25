<%@ Page Title="" Language="C#"  Inherits="System.Web.Mvc.ViewPage" %>

<div id="linkos" style="display:none">
  <a id="l1" href="#" xhref="<%= Url.Content("~/ViajeCerrado/editarEtapa/") + "?id=%ETAPA_ID%"%>" onclick="return editarEtapa(this);">Editar Etapa</a>
</div>

<div class="contextMenu" id="myMenu1" style="display:none">
  <ul style="width: 200px">
    <li id="m1"><span style="font-size:80%; font-family:Verdana">Editar Etapa</span></li>
  </ul>
</div>

<div id="area" style="padding-bottom:5px;">
  <ul id="tabs">
    <div class="btn-new-class" style="float:left;">
      <a id="a1" href="<%= Url.Content("~/ViajeCerrado/Index")%>" > Viajes</a>
    </div>
    <!-- div class="btn-new-class" style="margin-left:10px;float:left;">
      <a id="a2" href="#" onclick="return false;"> ?</a>
    </div -->    
  </ul>
  <div class="split"></div>	
</div>

<% if (!String.IsNullOrEmpty(Convert.ToString(ViewData["result_message"])))
   { %>
    <div class="msg_info msg_<%=ViewData["result_type"]%>"><%=ViewData["result_message"]%></div>
    
<% } else{%>
    <div class="msg_info msg_success" style="display:none;">La etapa fue modificada satisfactoriamente.</div>
<% }%>

<table id="list"></table> 
<div id="pager"></div>
<div id="filter" style="display:none">Buscar</div>

<!--<select size="6" id="searchlist"></select>-->


<script type="text/javascript">
  
  var viajeId = <%= ViewData["viajeId"] == null ? "null" : "'" + ViewData["viajeId"] + "'"%>;

  function editarEtapa(sender){
    var href = $(sender).attr('href');
    modificarEtapaPopUp(href, 'Editar Etapa');
    //window.location.href = href;
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
      url: '/ViajeCerrado/ListEtapasJSON',
      datatype: 'json',
      mtype: 'GET',
      colNames: [
        "ID", "VIAJE ID", "NRO ETAPA", "ORIGEN", "DESTINO", "HRP", "ETA", "FECHA SALIDA", "FECHA LLEGADA"
      ],
      colModel: [
          { name: 'ID',      index:'ID', width: 50 /*, hidden: true*/ },
          { name: 'VIAJE_ID', index: 'VIAJE_ID', width: 0, hidden: true },
          { name: 'NRO_ETAPA',  index:'NRO_ETAPA', width: 90},
          { name: 'ORIGEN_DESC',   index:'ORIGEN_DESC', width: 90},
          { name: 'DESTINO_ID',   index:'DESTINO_DESC', width: 90},
          { name: 'HRP', index:'HRP', width: 90},
          { name: 'ETA',  index:'ETA', width: 90},
          { name: 'FECHA_SALIDA', index:'FECHA_SALIDA', width: 90 },
          { name: 'ETA', index:'ETA', width: 90}
      ],
      pager: '#pager',
      rowNum: 20,
      rowList: [10, 20, 30],
      sortname: 'NRO_ETAPA',
      sortorder: 'asc',
      viewrecords: true,
      gridview: true,
      autowidth: true,
      height: 400,
      caption: 'Etapas de Viaje',
      search: viajeId != null ? true : false,
      postData: viajeId != null ? { VIAJE_ID: viajeId} : {},
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

  var _ID = mygrid.getRowData(gsr)['ID'];
  
  var href = $('#'+linkname).attr('xhref');
  href = href.replace('%ETAPA_ID%', _ID);

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