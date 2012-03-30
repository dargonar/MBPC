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
    //"ID", "PID", "ACTUAL",
    //"NOMBRE", "NRO_OMI", "MATRICULA", "BANDERA"
    //"ORIGEN", "DESTINO", "ESTADO", "FECHA_SALIDA", "ETA"
    $(function () {
      var mygrid = $("#list").jqGrid({
        url: '/viaje/ListJSON',
        datatype: 'json',
        mtype: 'GET',
        colNames: ["ID", "PID", "ACTUAL", "NOMBRE", "NRO_OMI", "MATRICULA", "BANDERA", "ORIGEN", "DESTINO", "ESTADO", "FECHA_SALIDA", "ETA"],  
        colModel: [
      { name: 'ID', index: 'ID', width: 90, hidden: true },
      { name: 'PID', index: 'PID', width: 80 },
      { name: 'ACTUAL', index: 'ACTUAL', width: 80 },
      { name: 'NOMBRE', index: 'NOMBRE', width: 80 },
      { name: 'NRO_OMI', index: 'NRO_OMI', width: 80 },
      { name: 'MATRICULA', index: 'MATRICULA', width: 80 },
      { name: 'BANDERA', index: 'BANDERA', width: 80 },
      { name: 'ORIGEN', index: 'ORIGEN', width: 80 },
      { name: 'DESTINO', index: 'DESTINO', width: 80 },
      { name: 'ESTADO', index: 'ESTADO', width: 80 },
      { name: 'FECHA_SALIDA', index: 'FECHA_SALIDA', width: 80 },
      { name: 'ETA', index: 'ETA', width: 80 }
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
            window.location = '/etapa/list?<%if(ViewData["alone"]!=null){%>alone=<%=ViewData["alone"]%>&<%}%>ID=' + id;
        },
        position: "last"
      });
    });
  });
/*      { name: 'FECHA_SALIDA', index: 'FECHA_SALIDA', width: 80,
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
*/
</script>
</asp:Content>
