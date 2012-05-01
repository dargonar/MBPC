<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
          subGrid: true,
          subGridRowExpanded: function (subgrid_id, row_id) {
              // subgrid_id is a id of the div tag created within a table
              // the row_id is the id of the row
              // If we want to pass additional parameters to the url we can use
              // the method getRowData(row_id) - which returns associative array in type name-value
              // here we can easy construct the following
              var viaje_id = mygrid.getRowData(row_id)['ID'];
              var buque    = mygrid.getRowData(row_id)['NOMBRE'];

              var subgrid_table_id, pager_id;
		      subgrid_table_id = subgrid_id+"_t";
		      pager_id = "p_"+subgrid_table_id;
		      jQuery("#"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table><div id='"+pager_id+"' class='scroll'></div>");

              var lastSel;
              jQuery("#" + subgrid_table_id).jqGrid({
                  url: "/ViajeCerrado/ListEtapasJSON?VIAJE_ID=" + viaje_id,
                  datatype: "json",
                  colNames: ["ID", "VIAJE ID", "NRO ETAPA", "ORIGEN", "DESTINO", "HRP", "ETA", "FECHA SALIDA", "FECHA LLEGADA"],
                  colModel: [
                            { name: 'ID', index: 'ID', width: 50 /*, hidden: true*/ },
                              { name: 'VIAJE_ID', index: 'VIAJE_ID', width: 0, hidden: true },
                              { name: 'NRO_ETAPA', index: 'NRO_ETAPA', width: 90 },
                              { name: 'ORIGEN_DESC', index: 'ORIGEN_DESC', width: 90 },
                              { name: 'DESTINO_ID', index: 'DESTINO_DESC', width: 90 },
                              { name: 'HRP', index: 'HRP', width: 90 },
                              { name: 'ETA', index: 'ETA', width: 90 },
                              { name: 'FECHA_SALIDA', index: 'FECHA_SALIDA', width: 90 },
                              { name: 'ETA', index: 'ETA', width: 90 }
                  ],
                  height: '100%',
                  rowNum: 20,
                  sortname: 'NRO_ETAPA',
                  sortorder: 'asc',
                  autowidth: true,
                  caption: 'Etapas del viaje ' + viaje_id + ' (' + buque + ')',
                  gridComplete: function() {
                      jQuery(".jqgrow", "#" + subgrid_table_id).contextMenu('myMenu1', {
                        bindings: {
                          'm1': function (t) { runlink("#" + subgrid_table_id, 'l1'); },
                          'm2': function (t) { runlink("#" + subgrid_table_id, 'l2'); }
                        },
                        onContextMenu: function (event, menu) {
                          var rowId = $(event.target).parent("tr").attr("id")
                          var grid = $("#" + subgrid_table_id);
                          $("#"+subgrid_table_id + ' ' + '#'+rowId).click();
                          return true;
                        }
                      });
                  },
              });


          },
          subGridRowColapsed: function(subgrid_id, row_id) {
		        //this function is called before removing the data
                var subgrid_table_id, pager_id;
		        subgrid_table_id = subgrid_id+"_t";
		        pager_id = "p_"+subgrid_table_id;

		        jQuery("#"+subgrid_table_id).remove();
                jQuery("#"+pager_id).remove();
	    }