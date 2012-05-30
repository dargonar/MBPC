<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
          subGrid: true,
          subGridRowExpanded: function (subgrid_id, row_id) {
              // subgrid_id is a id of the div tag created within a table
              // the row_id is the id of the row
              // If we want to pass additional parameters to the url we can use
              // the method getRowData(row_id) - which returns associative array in type name-value
              // here we can easy construct the following
              var etapa_id = mygride.getRowData(row_id)['ID'];
              var viaje_id = mygride.getRowData(row_id)['VIAJE_ID'];
              //var buque    = mygrid.getRowData(row_id)['NOMBRE'];

              var subgrid_table_id, pager_id;
		      subgrid_table_id = subgrid_id+"_2t";
		      pager_id = "p2_"+subgrid_table_id;
		      jQuery("#"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table><div id='"+pager_id+"' class='scroll'></div>");

              var lastSel;
              jQuery("#" + subgrid_table_id).jqGrid({
                  url: "/ViajeCerrado/ListCargasJSON?ETAPA_ID=" + etapa_id,
                  datatype: "json",
                  colNames: ["ID", "NOMBRE", "CANTIDAD", "CANTIDAD_INICIAL", "CANTIDAD_ENTRADA", "CANTIDAD_SALIDA", "UNIDAD", "CODIGO", "BARCAZA","ETAPA_ID"],
                  colModel: [
                              { name: 'ID', index: 'ID', width: 50 , hidden: true },
                              { name: 'NOMBRE', index: 'NOMBRE', width: 90 },
                              { name: 'CANTIDAD', index: 'CANTIDAD', width: 0},
                              { name: 'CANTIDAD_INICIAL', index: 'CANTIDAD_INICIAL', width: 90 },
                              { name: 'CANTIDAD_ENTRADA', index: 'CANTIDAD_ENTRADA', width: 90 },
                              { name: 'CANTIDAD_SALIDA', index: 'CANTIDAD_SALIDA', width: 90 },
                              { name: 'UNIDAD', index: 'UNIDAD', width: 90 },
                              { name: 'CODIGO', index: 'CODIGO', width: 90 },
                              { name: 'BARCAZA', index: 'BARCAZA', width: 90 },
                              { name: 'ETAPA_ID', index: 'ETAPA_ID', width: 50 , hidden: true }
                  ],
                  height: '100%',
                  rowNum: 20,
                  sortname: 'BARCAZA',
                  sortorder: 'asc',
                  autowidth: true,
                  caption: 'Cargas de etapa ' + etapa_id + ' ( viaje:' + viaje_id + ')',
                  gridComplete: function() {
                      
                      jQuery(".jqgrow", "#" + subgrid_table_id).contextMenu('myMenu3', {
                        bindings: {
                          'm4': function (t) { runlink("#" + subgrid_table_id, 'l4'); },
                          'm5': function (t) { runlink("#" + subgrid_table_id, 'l5'); },
                          'm6': function (t) { runlink("#" + subgrid_table_id, 'l6'); },
                        },
                        onContextMenu: function (event, menu) {
                          var rowId = $(event.target).parent("tr").attr("id")
                          var grid = $("#" + subgrid_table_id);
                          $("#"+subgrid_table_id + ' ' + '#'+rowId).click();
                          return true;
                        }
                      });
                      

                      var grid    = $("#" + subgrid_table_id);
                      var display = grid.getGridParam('records') == 0;
                       
                       $('#nada_'+subgrid_table_id).remove();

                      if (display) {
                        grid.append('<tbody id="nada_'+subgrid_table_id+'"><tr style="height:50px"><td style="text-align: center;" colspan="9">No hay cargas para esta etapa. <a onclick="return nuevaCarga(this,\'#' + subgrid_table_id +'\')" href="/ViajeCerrado/nuevaCarga?ETAPA_ID=' + etapa_id +'">Crear Nueva</a></td></tr></tbody>');
                      }
                  },
              });


          },
          subGridRowColapsed: function(subgrid_id, row_id) {
		        //this function is called before removing the data
                var subgrid_table_id, pager_id;
		        subgrid_table_id = subgrid_id+"_2t";
		        pager_id = "p2_"+subgrid_table_id;

		        jQuery("#"+subgrid_table_id).remove();
                jQuery("#"+pager_id).remove();
	    }