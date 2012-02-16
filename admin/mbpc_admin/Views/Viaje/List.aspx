<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Lista de Viajes
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Lista de viajes</h2>

<table id="list"><tr><td/></tr></table> 
<div id="pager"></div> 
<div id="filter" style="display:none">Search Invoices</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">

<script type="text/javascript">
  $(document).ready(function () {

    $(function () {
      var mygrid = $("#list").jqGrid({
        url: '/viaje/ListJSON',
        datatype: 'json',
        mtype: 'GET',
        colNames: ['ID', 'Origen', 'Destino', 'Buque', 'Fecha de salida', 'Fecha de llegada', 'ETA', 'ZOE', 'Etapa Actual', 'Estado', 'Notas', 'Viaje Padre', 'Latitud', 'Longitud', 'creado'],  
        colModel: [
      { name: 'ID', index: 'ID', width: 90, hidden: true },
      { name: 'ORIGEN_ID', index: 'ORIGEN_ID', width: 80},
      { name: 'DESTINO_ID', index: 'DESTINO_ID', width: 80},
      { name: 'BUQUE_ID', index: 'BUQUE_ID', width: 80 },
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

        //{ name: 'fecha_salida', index: 'fecha_salida', width: 80 },
      {name: 'FECHA_LLEGADA', index: 'FECHA_LLEGADA', width: 80,
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
      { name: 'ZOE', index: 'ZOE', width: 80,
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
      { name: 'ETAPA_ACTUAL', index: 'ETAPA_ACTUAL', width: 80 },
      { name: 'ESTADO', index: 'ESTADO', width: 80 },
      { name: 'NOTAS', index: 'NOTAS', width: 80 },
      { name: 'VIAJE_PADRE', index: 'VIAJE_PADRE', width: 80 },
      { name: 'LATITUD', index: 'LATITUD', width: 80 },
      { name: 'LONGITUD', index: 'LONGITUD', width: 80 },
      { name: 'CREATED_AT', index: 'CREATED_AT', width: 80 }
    ],
        pager: '#pager',
        rowNum: 20,
        rowList: [10, 20, 30],
        sortname: 'ID',
        sortorder: 'desc',
        viewrecords: true,
        gridview: true,
        height: 400,
        autowidth: true,
        search: true,
        caption: 'Viajes'
      });

      mygrid.filterToolbar();
      mygrid.navGrid('#pager', { edit: false,
        add: false,
        del: false,
        search: false
      }).navButtonAdd('#pager', {
        caption: "Ver Etapas",
        buttonicon: "ui-icon-add",
        onClickButton: function () {
            var gsr = mygrid.getGridParam('selrow');
            if (!gsr) {
            alert("Debe elegir un viaje");
            return;
            }
            var id = mygrid.getRowData(gsr)['ID'];
            window.location = '/etapa/list?<%if(ViewData["alone"]!=null){%>alone=1&<%}%>ID=' + id;
        },
        position: "last"
      });
    });
  });
</script>
</asp:Content>
