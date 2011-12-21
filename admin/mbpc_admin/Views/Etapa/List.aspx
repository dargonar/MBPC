<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ import Namespace="JQGridHelper" %>


<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Etapas
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">



    <h2>Etapas de <%= ViewData["titulo"] %></h2>

<table id="list"><tr><td/></tr></table> 
<div id="pager"></div> 
<div id="filter" style="display:none">Search Invoices</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">

<script type="text/javascript">

  var referenceId = <%= ViewData["referenceId"] == null ? "null" : "'" + ViewData["referenceId"] + "'"%>;


  <%=Html.ComboFilter("pdcs") %>

  $(document).ready(function () {


    $(function () {
      var mygrid = $("#list").jqGrid({
        url: '/etapa/ListJSON',
        datatype: 'json',
        mtype: 'GET',
        colNames: ["ID", "Etapa Nro:", "Origen", "Actual", "Destino", "HRP", "ETA", "Fecha de salida",	"Fecha de llegada", "Creado"],  
        colModel: [
      { name: 'ID', index: 'ID', width: 90, hidden: true },
      { name: 'NRO_ETAPA', index: 'NRO_ETAPA', width: 90 },
      { name: 'ORIGEN_ID', index: 'ORIGEN_ID', width: 80, formatter: pdcs, stype: 'select', editoptions: { value: pdcs_edit}},
      { name: 'ACTUAL_ID', index: 'ACTUAL_ID', width: 80, formatter: pdcs, stype: 'select', editoptions: { value: pdcs_edit} },
	    { name: 'DESTINO_ID', index: 'DESTINO_ID', width: 80, formatter: pdcs, stype: 'select', editoptions: { value: pdcs_edit} },
      { name: 'HRP', index: 'HRP', width: 80,
	      searchoptions: {
	        dataInit: function (el) {
	          $(el).daterangepicker({
	            onClose: function () {
	              mygrid[0].triggerToolbar();
	            }
	          });
	        }
	      }
	    },
      { name: 'ETA', index: 'ETA', width: 80,
	      searchoptions: {
	        dataInit: function (el) {
	          $(el).daterangepicker({
	            onClose: function () {
	              mygrid[0].triggerToolbar();
	            }
	          });
	        }
	      }
	    },
      { name: 'FECHA_SALIDA', index: 'FECHA_SALIDA', width: 80,
	      searchoptions: {
	        dataInit: function (el) {
	          $(el).daterangepicker({
	            onClose: function () {
	              mygrid[0].triggerToolbar();
	            }
	          });
	        }
	      }
	    },
      { name: 'FECHA_LLEGADA', index: 'FECHA_LLEGADA', width: 80,
	      searchoptions: {
	        dataInit: function (el) {
	          $(el).daterangepicker({
	            onClose: function () {
	              mygrid[0].triggerToolbar();
	            }
	          });
	        }
	      }
	    },
      { name: 'CREATED_AT', index: 'CREATED_AT', width: 80 }
    ],
        pager: '#pager',
        rowNum: 20,
        rowList: [10, 20, 30],
        sortname: 'id',
        sortorder: 'desc',
        viewrecords: true,
        gridview: true,
        height: 400,
        autowidth: true,
        caption: 'Etapas',
        search: referenceId != null ? true : false,
        postData: referenceId != null ? { VIAJE_ID: referenceId} : {}
      });

      mygrid.filterToolbar();
      mygrid.navGrid('#pager', { edit: false,
        add: false,
        del: false,
        search: false
      }).navButtonAdd('#pager', {
        caption: "Ver Cargas",
        buttonicon: "ui-icon-add",
        onClickButton: function () {
            var gsr = mygrid.getGridParam('selrow');
            if (!gsr){
            alert("Debe elegir una etapa");
            return;
            }
            var id = mygrid.getRowData(gsr)['ID'];
            window.location = '/carga/list?ID='+id;
          },
        position: "last"
      }).navButtonAdd('#pager', {
        caption: "Agregar Carga",
        buttonicon: "ui-icon-add",
        onClickButton: function () {
            var gsr = mygrid.getGridParam('selrow');
            if (!gsr){
            alert("Debe elegir una etapa");
            return;
            }
            var id = mygrid.getRowData(gsr)['ID'];
            window.location = '/Carga/New?etapa_id='+id;
          },
        position: "last"
      });
    });
  });
</script>
</asp:Content>
