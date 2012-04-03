<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="mbpc.Controllers" %>
<div>
<form id="nuevoViaje" action="<%= Url.Content("~/Viaje/crear") %>" method="post">

  <label>Buque</label><br />
  <input autocomplete="off" type="text" style="width:270px" id="buquetext" class="nexttab" />
  <input id="buque_id" name="buque_id" type="hidden" />
  <input id="btnSeleccionarBarco" value="..." type="button" title="NUEVO BUQUE" onclick="nuevoBuque('<%= Url.Content("~/Item/nuevoBuque") %>');" /> <br />
  <input id="internacional" name="internacional" type="hidden" />

  <label>Desde</label><br />
  <input autocomplete="off" type="text" style="width:270px" id="desdetext" class="nexttab"/>
  <input id="desde_id" name="desde_id" type="hidden" />
  <input type="button" value="..." onclick="nuevoMuelle('<%=Url.Content("~/Item/nuevoMuelle") %>',2);" title="NUEVO PUERTO"/> <br />

  <label>Hasta</label><br />
  <input autocomplete="off" type="text" style="width:270px" id="hastatext" class="nexttab"/>
  <input id="hasta_id" name="hasta_id" type="hidden" />
  <input type="button" value="..." onclick="nuevoMuelle('<%=Url.Content("~/Item/nuevoMuelle") %>',3);" title="NUEVO PUERTO"/> <br />

  <label>Pr&oacute;ximo punto de control</label><br />
  <select id="proximo_punto" name="proximo_punto" style="margin:0; width:274px;" class="nexttab">
  <% foreach (Dictionary<string, string> zona in (ViewData["zonas"] as List<object>))
      { 
         string nombre = string.Empty;
         
        if( zona["KM"] == "0" )
            nombre = zona["CANAL"] + " - " + zona["UNIDAD"];
         else
            nombre = zona["CANAL"] + " - " + zona["UNIDAD"] + " " + zona["KM"];

	%>
         <option value="<%= zona["ID"] %>"><%= nombre %></option>
   <% } 
  %>
  </select>
  <br/>
  <label>Fecha de partida</label><br />
  <input autocomplete="off" type="text" id="partida" name="partida" style="width:270px"/><br />
  <label class="desc">Formato: dd-mm-aa hh:mm</label><br />

  <label>ETA</label><br />
  <input autocomplete="off" type="text" id="eta" name="eta" style="width:270px"/><br />
  <label class="desc">Formato: dd-mm-aa/ hh:mm</label><br />

  <label>ZOE</label><br />
  <input autocomplete="off" type="text" id="zoe" name="zoe" style="width:270px"/><br />
  <label class="desc">Formato: dd-mm-aa/ hh:mm</label><br />
  <br />
    <label>Posicion</label><br />
    <input autocomplete="off" type="text" id="pos" name="pos" style="width:270px"  /><br />
    <label class="desc">Formato: 9000S18000W </label><br /><br />

  <label>Rio/Canal Km/Par</label><br />
  <input autocomplete="off" type="text" id="riocanal" style="width:270px" /><br />
  <input  type="hidden" id="riocanalh" name="riocanal" /><br />

  <label>¿Va a o viene de  Malvinas?</label><br />
  <%= Html.DropDownList("codigo_malvinas"
                      , ViajeController.MalvinasOptions(true)
                          , new Dictionary<string, object> { { "style", "width:270px;" } })%>
  <br />

  <input type="submit" class="botonsubmit" style="margin-left: 190px" value="Crear Viaje" />



</form>
</div>

<script type="text/javascript">

    //$('#btnSeleccionarBarco').click();

    $('#buquetext, #hastatext, #desdetext').bind('keydown', 'ctrl+s', function () {
        $(this).next().click();
        return false;
    });

    $("#proximo_punto").click(function () {
      $(this).focus();
      $(this).select();
    });

    $("#proximo_punto").combobox();
    $("#proximo_punto").next()
    .css('height','23px')
    .css('margin-right','5px')
    .css('padding-left','4px')
    .css('width','268px');


      $("#partida, #eta, #zoe").mask("99-99-99 99:99");
      $("#partida").val("<%=string.Format("{0:dd-MM-yy HH:mm}", DateTime.Now) %>");
      

      $("#pos").mask("9999S99999W");

       url1 = '<%= Url.Content("~/Autocomplete/buques_disponibles/") %>';
       url2 = '<%= Url.Content("~/Autocomplete/view_muelles/") %>' ;
       url3 = '<%= Url.Content("~/Autocomplete/rioscanales") %>';

       $("#buquetext").autocomplete({
         source: function (request, response) {
           $.ajax({
             type: "POST",
             url: url1,
             dataType: "json",
             data: {
               query: request.term
             },
             success: function (data) {
               response($.map(data, function (item) {
                 return {
                   value    : item.NOMBRE,
                   id_buque : item.ID_BUQUE,
                   omi      : item.NRO_OMI,
                   nombre   : item.NOMBRE,
                   sdist    : item.SDIST,
                   tipo     : item.TIPO,
                   bandera  : item.BANDERA,
                   costera  : item.COSTERA,
                   matricula: item.MATRICULA
                 }
               }));
             }
           });
         },
         minLength: 2,
         select: function (event, ui) {
           
           if( ui.item.costera != '' )
           {
            $("#buque_id").val('');
            $("#buquetext").val('');
            event.preventDefault();
            return false;
           }
           
           $("#buque_id").val(ui.item.id_buque);
           $('#internacional').val( (ui.item.tipo == "nacional") ? "0" : "1");
         },
         open: function () {
           $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
         },
         close: function () {
           $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
         }
       }).data( "autocomplete" )._renderItem = function( ul, item ) {
			      
            var bg = '';
            var mr = '';

            if( item.costera != '' )
            {
               bg = 'style="background:#B99"';
               mr = '</br>navegando en ' + item.costera;
            }

            return $( "<li "+ bg + "></li>" )
				      .data( "item.autocomplete", item )
				      .append( "<a>" + item.nombre + " (SD:" + item.sdist + ", IMO:" + item.omi + ", MR:" + item.matricula + ", " + item.bandera + ")" 
                             + mr
                             + "</a>" )
				      .appendTo( ul );
		    };  

      $("#desdetext, #hastatext").autocomplete({
        source: function (request, response) {
          $.ajax({
            type: "POST",
            url: url2,
            dataType: "json",
            data: {
              query: request.term
            },
            success: function (data) {
              response($.map(data, function (item) {
                return {
                  label: '(' + item.COD + ') ' + item.PUERTO,
                  value: '(' + item.COD + ') ' + item.PUERTO,
                  id: item.COD
                }
              }));
            }
          });
        },
        minLength: 2,
        select: function (event, ui) {
          $(this).nextAll('input[type=hidden]').first().val(ui.item.id);
        },
        open: function () {
          $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
        },
        close: function () {
          $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
        }
      });

      $("#riocanal").autocomplete({
        source: function (request, response) {
          $.ajax({
            type: "POST",
            url: url3,
            dataType: "json",
            data: {
              query: request.term
            },
            success: function (data) {
              response($.map(data, function (item) {
                return {
                  label: item.NOMBRE + " - " + item.UNIDAD + " " + item.KM,
                  value: item.NOMBRE + " - " + item.UNIDAD + " " + item.KM,
                  id: item.ID,
                  latlong: item.LATLONG_fmt
                }
              }));
            }
          });
        },
        minLength: 2,
        select: function (event, ui) {
          $("#riocanalh").val(ui.item.id);
          $("#pos").val(ui.item.latlong);
        },
        open: function () {
          $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
        },
        close: function () {
          $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
        }
      });




     $("#nuevoViaje").submit(function () {

         $('.botonsubmit').attr('disabled', 'disabled');

         if ($("#buque_id").val() == "") {
             alert("Debe seleccionar un buque");
             $("#buquetext").focus();
             $('.botonsubmit').removeAttr('disabled');
             return false;
         }
         if ($("#desdetext").val() == "") {
             alert("Debe seleccionar muelle de origen");
             $("#desdetext").focus();
             $('.botonsubmit').removeAttr('disabled');
             return false;
         }
         if ($("#hastatext").val() == "") {
             alert("Debe seleccionar muelle de destino");
             $("#hastatext").focus();
             $('.botonsubmit').removeAttr('disabled');
             return false;
         }
         if ($("#partida").val() == "") {
             alert("Debe indicar fecha de partida");
             $("#partida").focus();
             $('.botonsubmit').removeAttr('disabled');
             return false;
         }
         if (isDate($("#partida").val())) {
             alert("La fecha de partida es invalida");
             $("#partida").focus();
             $('.botonsubmit').removeAttr('disabled');
             return false;
         }

           if ($("#eta").val() != "") {

             if (isDate($("#eta").val())) {
               alert("La fecha de ETA es invalida");
               $("#eta").focus();
               $('.botonsubmit').removeAttr('disabled');
               return false;
             }

         }



         if ($("#zoe").val() != "") {
             if (isDate($("#zoe").val())) {
                 alert("La fecha de Zona de Espera es invalida");
                 $("#zoe").focus();
                 $('.botonsubmit').removeAttr('disabled');
                 return false;
             }
         }


         if ($('#pos').val() != "") {
             var RegularExpression = /\d{4}[NS]\d{5}[EW]/

             if ($('#pos').val() == "") {
                 alert('Debe insertar una posicion');
                 $('.botonsubmit').removeAttr('disabled');
                 return false;
             }

             if ($('#pos').val().match(RegularExpression) == null) {
               alert('Valores de posicion incorrectos');
                 $('.botonsubmit').removeAttr('disabled');
                 return false;
               }

               if (!validpos($('#pos').val())) {
                 alert('Valores de posicion incorrectos');
                 $('.botonsubmit').removeAttr('disabled');
                 return false;
               }
         }         

         $.ajax({
             type: "POST",
             cache: false,
             url: $(this).attr('action'),
             data: $(this).serialize(),
             success: (function (data) {
                if (data == "nop")
                  $('#list').trigger('reloadGrid');
                else
                  $("#columnas").html(data);

                 $('#dialogdiv').dialog('close');
             }),
             error: (function (data) {
                 var titletag = /<title\b[^>]*>.*?<\/title>/
                 alert(titletag.exec(data.responseText));
                 $('.botonsubmit').removeAttr('disabled');
             })
         });


         return false;
     });
</script>