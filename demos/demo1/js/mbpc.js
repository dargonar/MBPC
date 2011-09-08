oLanguage = {
  "sProcessing":   "Procesando...",
  "sLengthMenu":   "Mostrar _MENU_ registros",
  "sZeroRecords":  "No se encontraron resultados",
  "sInfo":         "Mostrando desde _START_ hasta _END_ de _TOTAL_ registros",
  "sInfoEmpty":    "Mostrando desde 0 hasta 0 de 0 registros",
  "sInfoFiltered": "(filtrado de _MAX_ registros en total)",
  "sInfoPostFix":  "",
  "sSearch":       "Buscar:",
  "sUrl":          "",
  "oPaginate": {
    "sFirst":    "Primero",
    "sPrevious": "Anterior",
    "sNext":     "Siguiente",
    "sLast":     "Ultimo"
  }
}
var oTable;
var oTable3;
var oTable4;
    
$(document).ready( function(){
	
	//Tabla principal
	oTable = $("#table1").dataTable({
		oLanguage:       oLanguage,
		bJQueryUI:       true,
		sPaginationType: 'full_numbers',
		bSort:           true,
		sDom:            '<"H"lfr>t<"F"ip>',
	});
  
	$("#table1 tbody").click(function(event) {
    $(oTable.fnSettings().aoData).each(function () {
      $(this.nTr).removeClass('row_selected');
    });
    
    $(event.target.parentNode).addClass('row_selected');
  });
	
	
	//Buscar barcos
  oTable3 = $("#table3").dataTable({
    oLanguage:       oLanguage,
    bJQueryUI:       true,
    sPaginationType: 'full_numbers',
    bSort:           true,
    sDom:            '<"H"fr>t<"F"ip>',
  });
	
  $("#table3 tbody").click(function(event) {
    $(oTable3.fnSettings().aoData).each(function () {
      $(this.nTr).removeClass('row_selected');
    });
    
    $(event.target.parentNode).addClass('row_selected');
  });
	
	 //Buscar puertos
  oTable4 = $("#table4").dataTable({
    oLanguage:       oLanguage,
    bJQueryUI:       true,
    sPaginationType: 'full_numbers',
    bSort:           true,
    sDom:            '<"H"fr>t<"F"ip>',
  });
  
  $("#table4 tbody").click(function(event) {
    $(oTable4.fnSettings().aoData).each(function () {
      $(this.nTr).removeClass('row_selected');
    });
    
    $(event.target.parentNode).addClass('row_selected');
  });
	
	//Range picker
	$("#daterange").daterangepicker({
		arrows:true,
	});
	
	//Autocomplete de dependencias
	var availableTags = ["Dependencia 1", "Dependencia 2", "Dependencia 3", "Prueba1", "Prueba2"];
    $("#proximopunto").autocomplete({
      source: availableTags
    });
	
});

function cambiar()
{
	$("#cambiar").dialog({
		title:  'Filtrar viajes',
		modal:  true,
		width:  320,
		height: 400,
    buttons: {
      "Filtrar": function(){
        $(this).dialog("close");
      }
    }
	});
}

function nuevoviaje()
{
  $("#nuevoviaje").dialog({
    title:  'Nuevo viaje',
    modal:  true,
    width:  400,
    height: 500,
    buttons: {
      "Crear viaje": function(){
        $(this).dialog("close");
      }
    }
  });
	
}

function buscarbarco()
{
  $("#buscarbarco").dialog({
    title:  'Listado de barcos',
    modal:  true,
    width:  650,
    height: 500,
    buttons: {
      "Seleccionar barco": function(){
        $(this).dialog("close");
      },
			"Nuevo barco": function(){
        nuevobarco();
      },
    }
  });
}

function nuevobarco()
{
  $("#nuevobarco").dialog({
    title:  'Nuevo barco',
    modal:  true,
    width:  400,
    height: 600,
    buttons: {
      "Crear barco": function(){
        $(this).dialog("close");
      },
    }
  });
}

function buscapuerto()
{
	  $("#buscapuerto").dialog({
    title:  'Seleccionar puerto',
    modal:  true,
    width:  650,
    height: 600,
    buttons: {
      "Seleccionar puerto": function(){
        $(this).dialog("close");
      },
    }
  });
}


function informar()
{
  $("#informar").dialog({
    title:  'Informar',
    modal:  true,
    width:  400,
    height: 600,
    buttons: {
      "Confirmar": function(){
				alert('Informado corrrectamente');
        $(this).dialog("close");
      },
    }
  });
	
}
