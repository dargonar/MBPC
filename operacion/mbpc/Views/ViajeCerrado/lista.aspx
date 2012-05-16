<%@ Page Title="" Language="C#"  Inherits="System.Web.Mvc.ViewPage" %>

<div id="linkos" style="display:none">
  <a id="l1" href="#" xhref="<%= Url.Content("~/ViajeCerrado/editarEtapa/") + "?id=%ETAPA_ID%"%>" onclick="return editarEtapa(this);">Editar puntos</a>
  <a id="l2" href="#" xhref="<%= Url.Content("~/ViajeCerrado/editarEtapaFecha/") + "?id=%ETAPA_ID%"%>" onclick="return editarFechaEtapa(this);">Editar fecha</a>
  <a id="l3" href="#" xhref="<%= Url.Content("~/ViajeCerrado/editarViajeFecha/") + "?viaje_id=%VIAJE_ID%"%>" onclick="return editarFechaViaje(this);">Editar fecha</a>
</div>

<div class="contextMenu" id="myMenu1" style="display:none">
  <ul style="width: 200px">
    <li id="m1"><span style="font-size:80%; font-family:Verdana">Editar Etapa</span></li>
    <li id="m2"><span style="font-size:80%; font-family:Verdana">Editar HRP</span></li>
  </ul>
</div>

<div class="contextMenu" id="myMenu2" style="display:none">
  <ul style="width: 200px">
    <li id="m3"><span style="font-size:80%; font-family:Verdana">Editar Fecha Partida</span></li>
  </ul>
</div>


<div id="area" style="padding-bottom:0px;">
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

  var mygrid;
  $(function () {
      mygrid = $("#list").jqGrid({
          url: '/ViajeCerrado/ListJson',
          datatype: 'json',
          mtype: 'GET',
          colNames: ["VIAJE", "NOMBRE", "NRO_OMI", "MATRICULA", "SDIST", "BANDERA", "ORIGEN", "DESTINO", "FECHA_SALIDA", "Pto. CONTROL ACTUAL", "NOTAS", "ESTADO"],
          colModel: [
          { name: 'ID', index: 'ID', width: 90},
          { name: 'NOMBRE', index: 'NOMBRE', width: 90 },
          { name: 'NRO_OMI', index: 'NRO_OMI', width: 90 },
          { name: 'MATRICULA', index: 'MATRICULA', width: 90 },
          { name: 'SDIST', index: 'SDIST', width: 90 },
          { name: 'BANDERA', index: 'BANDERA', width: 90 },
          { name: 'ORIGEN', index: 'ORIGEN', width: 90 },
          { name: 'DESTINO', index: 'DESTINO', width: 90 },
          { name: 'FECHA_SALIDA', index: 'FECHA_SALIDA', width: 90 },
          /*{ name: 'FECHA_LLEGADA', index: 'ETA', width: 90 },*/
          { name: 'Pto. CONTROL ACTUAL', index: 'ACTUAL', width: 90 },
          { name: 'NOTAS', index: 'NOTAS', width: 90 },
          { name: 'ESTADO', index: 'ESTADO', width: 90}],
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
          hoverrows: false,
          gridComplete: function(){
            jQuery(".jqgrow", "#list").contextMenu('myMenu2', {
                bindings: {
                  'm3': function (t) { runlink("#list", 'l3'); }
                },
                onContextMenu: function (event, menu) {
                  var rowId = $(event.target).parent("tr").attr("id")
                  var grid = $("#list");
                  $("#list"+ ' ' + '#'+rowId).click();
                  return true;
                }
              });
          },
          <% Html.RenderPartial("_etapas_subgrid"); %>
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

var grillon;
function runlink(id, linkname)
{
  grillon = id;
  var gsr = $(id).getGridParam('selrow');
  if (!gsr){
    alert("Debe elegir un viaje");
    return;
  }

  var _ID = $(id).getRowData(gsr)['ID'];
  //var _VIAJE_ID = $(id).getRowData(gsr)[''];
  
  var href = $('#'+linkname).attr('xhref');
  href = href.replace('%ETAPA_ID%', _ID);
  href = href.replace('%VIAJE_ID%', _ID);

  $('#'+linkname).attr('href', href).click();
  
}

function editarEtapa(sender){
    var href = $(sender).attr('href');
    modificarEtapaPopUp(href, 'Editar Etapa', 330, 395);
    return true;
}

function editarFechaEtapa(sender){
    var href = $(sender).attr('href');
    modificarEtapaPopUp(href, 'Editar Fecha Etapa', 250, 395);
    return true;
}

function editarFechaViaje(sender){
    var href = $(sender).attr('href');
    modificarEtapaPopUp(href, 'Editar Fecha Viaje', 250, 395);
    return true;
}

function modificarEtapaPopUp(href, title, _height, _width) {
      
    $("#fullscreen").css("display", "block");

    $.ajax({
    type: "GET",
    cache: false,
    url: href,
    success: (function (data) {
        $('#dialogdiv').attr('grilla', grillon);
        $('#dialogdiv').html(data);
        $('#dialogdiv').dialog({
        height: _height,
        width: _width,
        modal: true,
        title: title,
        });
        $("#fullscreen").css("display", "none");
    }),
    error: (function (data) {
        $("#fullscreen").css("display", "none");
        var titletag = /<title\b[^>]*>.*?<\/title>/
        alert(titletag.exec(data.responseText));
    })
    });
    return false;
    
}

  
</script>