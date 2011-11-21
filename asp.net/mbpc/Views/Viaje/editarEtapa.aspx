<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="mbpc.Models" %>

<% List<object> etapalist = ViewData["etapa"] as List<object>; %>
<% Dictionary<string, string> etapa = etapalist[0] as Dictionary<string, string>; %>
<% List<object> practicolist = ViewData["practicos"] as List<object>; %>
<% List<object> viajelist = ViewData["viajedata"] as List<object>; %>
<% Dictionary<string, string> viaje = viajelist[0] as Dictionary<string, string>; %>


<div id="editaretapaformcontainer">
<ul id="tabs" style="float:left">
  <li id="botonetapa" style="float:none;" class="megaestiloselectedb"><a href="#" onclick="return mostraretapaform();">Editar etapa</a></li><br />
  <li id="botonviaje" style="float:none;" ><a href="#" onclick="return mostrarviajeform();">Editar Viaje</a></li>
</ul>

<form style="display:none" id="nuevoViaje" action="<%= Url.Content("~/Viaje/modificar") %>">
  <input type="hidden" id="Hidden1" name="viaje_id" value="<%= viaje["ID"] %>"/>
  <div class="columna">

  <label>Buque</label><br />
  <input autocomplete="off" type="text" style="width:200px;float:left;" id="buquetext" readonly="readonly"  value="<%= viaje["NOMBRE"] %>" /><br />
  <input id="buque_id" name="buque_id" type="hidden" value="<%= viaje["ID_BUQUE"] %>"/>
  <input id="internacional" name="internacional" type="hidden" value="<%=  viaje["TIPO"] == "nacional" ? 0 : 1 %>"/>

  <label>Desde</label><br />
  <input autocomplete="off" type="text" style="width:200px;float:left;" id="desdetext"  value="<%= viaje["ORIGEN"] %>"/>
  <input type="button" value="..." onclick="nuevoMuelle('<%=Url.Content("~/Item/nuevoMuelle") %>',2);"/> <br />
  <input id="desde_id" name="desde_id" type="hidden" value="<%= viaje["ORIGEN_ID"] %>"/>

  <label>Hasta</label><br />
  <input autocomplete="off" type="text" style="width:200px;float:left;" id="hastatext"  value="<%= viaje["DESTINO"] %>" />
  <input id="hasta_id" name="hasta_id" type="hidden" value="<%= viaje["DESTINO_ID"] %>"/>
  <input type="button" value="..." onclick="nuevoMuelle('<%=Url.Content("~/Item/nuevoMuelle") %>',3);"/> <br />


  <label>Fecha de partida</label><br />
  <input autocomplete="off" type="text" id="partidav" name="partida" class="editaretapatext" value="<%= viaje["FECHA_SALIDA_fmt"] %>" /><br />
  <label class="desc">Formato: dd-mm-aa hh:mm</label><br /><br />

  <label>ETA</label><br />
  <input autocomplete="off" type="text" id="etav" name="eta" class="editaretapatext" value="<%= viaje["ETA_fmt"] %>" /><br />
  <label class="desc">Formato: dd-mm-aa hh:mm</label><br />



  </div>

  <div class="columna">


  <label>ZOE</label><br />
  <input autocomplete="off" type="text" id="zoev" name="zoe" class="editaretapatext" value="<%= viaje["ZOE_fmt"] %>" /><br />
  <label class="desc">Formato: dd-mm-aa hh:mm</label><br />

  <br />
    <label>Posicion</label><br />
    <input autocomplete="off" type="text" id="pos" name="pos" class="editaretapatext" value="<%= viaje["LATLONG_fmt"] %>" /><br />
    <label class="desc">Formato: 9000S18000W </label><br /><br/><br/><br/><br/><br/>

  <label>Rio/Canal Km/Par</label><br />
  <input autocomplete="off" type="text" id="riocanal" class="editaretapatext" value="<%= viaje["RIOCANAL"] %>" style="width:270px" /><br />
  <input  type="hidden" id="riocanalh" name="riocanal" />


    <input type="submit" class="botonsubmit" value="Modificar Viaje" />

   </div>


 </form>

  

<form id="editarEtapaForm" action="<%= Url.Content("~/Viaje/modificarEtapa") %>" method="post">

  <input type="hidden" id="viaje_id" name="viaje_id" value="<%= ViewData["viaje_id"] %>"/>
  <input type="hidden" id="etapa_id_editaretapa" name="etapa_id" value="<%= etapa["ETAPA_ID"] %>"/>



  
  <div class="columna">
    <label>Calado Proa</label><br />
    <input autocomplete="off" style="width:80px" type="text" class="editaretapatext" id="caladoproa" name="calado_proa"/>&nbsp;m&nbsp;&nbsp;&nbsp;&nbsp;
    <input autocomplete="off" style="width:80px" type="text" class="editaretapatext" id="caladoproa_ft" name="calado_proa_ft"/>&nbsp;ft
    <br />

    <label>Calado Informado</label><br />
    <input autocomplete="off" style="width:80px" type="text" class="editaretapatext" id="caladoinformado" name="calado_informado"/>&nbsp;m&nbsp;&nbsp;&nbsp;&nbsp;
    <input autocomplete="off" style="width:80px" type="text" class="editaretapatext" id="caladoinformado_ft" name="calado_informado_ft"/>&nbsp;ft
    <br />

    <label>HRP</label><br />
    <input autocomplete="off" type="text" id="hrpe" name="hrp" class="editaretapatext"  value="<%= etapa["HRP_fmt"] %>" /><br />
    <label class="desc">Formato: dd-mm-aa hh:mm</label><br /><br />

    
    <label>Fecha de salida</label><br />
    <input autocomplete="off" type="text" id="fecha_salidae" name="fecha_salida" class="editaretapatext" value="<%= etapa["FECHA_SALIDA_fmt"] %>" /><br />
    <label class="desc">Formato: dd-mm-aa hh:mm</label><br /><br />

    <!--
    <label>Cantidad de tripulantes</label><br />
    <input autocomplete="off" type="text" class="editaretapatext" id="tripulantestext" name="cantidad_tripulantes" value="<%= etapa["CANTIDAD_TRIPULANTES"] %>"/><br />
    -->
    
    <label>Practico/Baqueano</label><br />
    <input type="text" class="editaretapatext" id="practicotext" name="practico" value="" autocomplete="off" /><br />
  
    <div class="latabla" style="position:absolute;z-index:5;width: 250px;" ></div>
      <br />

      <%
        for (var i = 0; i < practicolist.Count ; i++) {
           Dictionary<string, string> PR = practicolist[i] as Dictionary<string,string>;
           Response.Write("<input class=\"practicosh\" type=\"hidden\" id=\"practico" + i + "\" name=\"practico" + i + "\" value=\"" + PR["ID"] + "\" />");
           if (PR["ACTIVO"] == "1")
             Response.Write("<input type=\"hidden\" id=\"practicoh\" name=\"activoh\" value=\"" + PR["ID"] + "\" />");
         }

        for (var j = practicolist.Count; j < 3; j++)
        {
          Response.Write("<input class=\"practicosh\" type=\"hidden\" id=\"practico" + j + "\" name=\"practico" + j + "\" value=\"\" />");
        }    
   
      %>

      <select id="practicoselect" name="activo" size="3" style="width:213px;float: left;">
      <% for (var i = 0; i < practicolist.Count; i++)
         {
           Dictionary<string, string> PR = practicolist[i] as Dictionary<string, string>;
           string sel = "";
           if (PR["ACTIVO"] == "1")
               sel = "selected=\"selected\"";
           var optstring = "<option class=\"practicopt\"" + sel + "\" onclick=\"seleccionarPractico(this)\" value=\"" + PR["ID"] + "\">" + PR["NOMBRE"] + "</option>";
           Response.Write(optstring);
         }     
      %>
      </select>
      <div style="clear:both"></div>
      <label class="desc">Listado de prácticos/baqueanos</label> 
      <button type="button" id="quitar" style="float:right;" title="Quitar Práctico seleccionado">Quitar</button><br /><br />
  </div>

  <div class="columna">
    <label>Calado Popa</label><br />
    <input autocomplete="off" style="width:80px" type="text" class="editaretapatext" id="caladopopa" name="calado_popa"/>&nbsp;m&nbsp;&nbsp;&nbsp;&nbsp;
    <input autocomplete="off" style="width:80px" type="text" class="editaretapatext" id="caladopopa_ft" name="calado_popa_ft"/>&nbsp;ft
    <br />

    <label>ETA</label><br />
    <input autocomplete="off" type="text" id="etae" name="eta" class="editaretapatext" value="<%= etapa["ETA_fmt"] %>" /><br />
    <label class="desc">Formato: dd-mm-aa hh:mm</label><br /><br />

    <label>&nbsp;</label><br />
    <input autocomplete="off" type="text" class="editaretapatext" value="" style="opacity:0;" /><br />
    <label class="desc">&nbsp;</label><br /><br />

    <!--
    <label>Cantidad de pasajeros</label><br />
    <input autocomplete="off" type="text" class="editaretapatext" id="pasajerostext" name="cantidad_pasajeros" value="<%= etapa["CANTIDAD_PASAJEROS"] %>"/><br />
    -->

    <label>Capitan</label><br />
    <input type="text" class="editaretapatext" id="capitantext" name="capitan" value="<%= etapa["CAPITAN"] %>" autocomplete="off"  /><br />
  
    <label>Velocidad</label><br />
    <input autocomplete="off" type="text" class="editaretapatext" id="velocidad" name="velocidad" value=""/><br />

    <label>Rumbo</label><br />
    <input autocomplete="off" type="text" class="editaretapatext" id="rumbo" name="rumbo" value=""/><br />


    <input type="hidden" id="capitanh" name="capitan_id" value="<%= etapa["CAPITAN_ID"] %>" />
    <div class="latabla" style="position:absolute;z-index:5;width: 250px;"> </div>
  
  </div>

  <input type="submit" class="botonsubmit" style="margin-left: 170px" value="Modificar Etapa" />
</form>

</div>

<script type="text/javascript">

  $("#velocidad").mask("99.9");
  $("#rumbo").mask("999");

  //Calado proa
  $("#caladoproa").mask("99").val("<%=etapa["CALADO_PROA"] != "" ? Hlp.toString( Hlp.toDecimal((string)etapa["CALADO_PROA"]), "{0:00}") : ""%>");
  $("#caladoproa_ft").mask("999.9").val("<%=etapa["CALADO_PROA"] != "" ? Hlp.toString( Hlp.toDecimal((string)etapa["CALADO_PROA"]) * 3.2808399M, "{0:000.0}" ) : ""%>");

  $("#caladoinformado").mask("99").val("<%=etapa["CALADO_INFORMADO"] != "" ? Hlp.toString( Hlp.toDecimal((string)etapa["CALADO_INFORMADO"]), "{0:00}") : ""%>");
  $("#caladoinformado_ft").mask("999.9").val("<%=etapa["CALADO_INFORMADO"] != "" ? Hlp.toString( Hlp.toDecimal((string)etapa["CALADO_INFORMADO"]) * 3.2808399M, "{0:000.0}" ) : ""%>");

  $("#caladopopa").mask("99").val("<%= etapa["CALADO_POPA"] != "" ? Hlp.toString( Hlp.toDecimal((string)etapa["CALADO_POPA"]), "{0:00}") : ""%>");
  $("#caladopopa_ft").mask("999.9").val("<%=etapa["CALADO_POPA"] != "" ? Hlp.toString( Hlp.toDecimal((string)etapa["CALADO_POPA"]) * 3.2808399M, "{0:000.0}" ) : ""%>");

  //meters to feets
  $("#caladoproa, #caladoinformado, #caladopopa").change( function() {
    //alert('ddd');
    var v = $(this).val();
    var vv = '';
    if( v != '')
    {
      var vint = parseInt(parseFloat(v)*3.2808399);
      var vflo = parseInt(parseFloat(parseFloat(v)*3.2808399 - vint)*10.0);
      vv = sprintf('%03d.%01d', vint, vflo);
    }

    $("#"+ $(this).attr('id') + '_ft').val(vv);
  });

  //feets to meters
  $("#caladoproa_ft, #caladoinformado_ft, #caladopopa_ft").change( function() {
    var v = $(this).val();
    var vv = '';
    if( v != '' )
    {
      var vint = parseInt(parseFloat(v)/3.2808399);
      vv = sprintf('%02d', vint);
    }

    var iidd=$(this).attr('id').split('_')[0];
    $("#"+ iidd).val(vv);
  });

  //Comment
  <%
    var svel = Hlp.toString( Hlp.toDecimal((string)etapa["VELOCIDAD"]), "{0:00.0}" );
    var srum = Hlp.toString( Hlp.toDecimal((string)etapa["RUMBO"]), "{0:000}" );
  %>

  $("#velocidad").val("<%= svel %>");
  $("#rumbo").val("<%= srum %>");

  $("#partidav, #etav, #zoev,#fecha_salidae, #etae, #hrpe").mask("99-99-99 99:99");

  $("#partidav, #etav, #zoev,#fecha_salidae, #etae, #hrpe").blur(function () {

    //isDate($(this).val());
  });


  $('#quitar').click(function () {
    selected = $("#practicoselect").val();
    $(".practicosh[value='" + selected + "']").val("");
    $("#practicoselect option[value='"+ selected +"']").remove();
  });


  function seleccionarPractico(opt) {
    $('#practicoh').val($(opt).val());
    $('#practicotext').val('');
    alert('Practico/Baqueano '+ $(opt).html()+' quedara como activo de la etapa');
  }

  $("#editarEtapaForm").submit(function () {


    $('.botonsubmit').attr('disabled', 'disabled');

    if ($("#etae").val() != "") {
      if (isDate($("#etae").val())) {
        alert("La fecha de ETA es invalida");
        $("#etae").focus();
        $('.botonsubmit').removeAttr('disabled');
        return false;
      }
    }


    if ($("#fecha_salidae").val() != "") {
      if (isDate($("#fecha_salidae").val())) {
        alert("La fecha de salida es invalida");
        $("#fecha_salidae").focus();
        $('.botonsubmit').removeAttr('disabled');
        return false;
      }
    }

    if ($("#hrpe").val() != "") {
      if (isDate($("#hrpe").val())) {
        alert("La fecha de HRP es invalida");
        $("#hrpe").focus();
        $('.botonsubmit').removeAttr('disabled');
        return false;
      }
    }



    if ($("#practicoselect").val() == null && $("#practicoselect").children().length != 0) {
      alert("debe indicar el practico/baqueano activo de la etapa");
      $('.botonsubmit').removeAttr('disabled');
      return false;
    }

    $.ajax({
      type: "POST",
      cache: false,
      url: $(this).attr('action'),
      data: $(this).serialize(),
      success: (function (data) {
        $("#columnas").html(data);
        //$("#nuevoViaje").submit();
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


  //editar viaje





  $('#buquetext, #hastatext, #desdetext').bind('keydown', 'ctrl+s', function () {
    $(this).next().click();
    return false;
  });

  url1 = '<%= Url.Content("~/Autocomplete/view_buques_disponibles/") %>';
  url2 = '<%= Url.Content("~/Autocomplete/view_muelles/") %>';
  url3 = '<%= Url.Content("~/Autocomplete/practicos/") %>';
  url4 = '<%= Url.Content("~/Autocomplete/capitanes/") %>';
  url5 = '<%= Url.Content("~/Autocomplete/rioscanales") %>';


  $("#riocanal").autocomplete({
    source: function (request, response) {
      $.ajax({
        type: "POST",
        url: url5,
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
              label: item.NOMBRE + ' (SD:' + item.SDIST + '-IMO:' + item.NRO_OMI + ')',
              value: item.NOMBRE + ' (SD:' + item.SDIST + '-IMO:' + item.NRO_OMI + ')',
              MATRICULA: item.ID_BUQUE
            }
          }));
        }
      });
    },
    minLength: 2,
    select: function (event, ui) {
      $(this).nextAll('input[type=hidden]').first().val(ui.item.MATRICULA);
      $('#internacional').val((ui.item.TIPO == "nacional") ? "0" : "1");
    },
    open: function () {
      $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
    },
    close: function () {
      $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
    }
  });

  $("#capitantext").autocomplete({
    source: function (request, response) {
      $.ajax({
        type: "POST",
        url: url4,
        dataType: "json",
        data: {
          query: request.term
        },
        success: function (data) {
          response($.map(data, function (item) {
            return {
              label: item.NOMBRE,
              value: item.NOMBRE,
              id: item.ID
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


  function pegarPractico(nombre, id) {

    //$('#practicoh').val(id);
    //$('#practicotext').val(nombre);

    var nono = false;
    $('#practicoselect').children().each(function () {
      if ($(this).html() == nombre) {
        alert("Ya agregó a este practico/baqueano")
        var nono = True;
      }
    });

    if (nono) {
      return false;
    }

    /*
    if ($('#practicoselect').children().length > 2) {
      alert("solo puede agregar 3 practicos por etapa")
      $('.latabla').html('');
      return false;
    }
    */
    
    var issel = '';
    if( $(".practicopt").length == 0 )
     issel = 'selected="selected"';

    $('#practicoselect').append('<option class="practicopt" onclick="seleccionarPractico(this)" value="' + id + '" ' +issel+' >' + nombre + '</option>');

    $('.practicosh').each(function () {
      if ($(this).val() == "") {
        $(this).val(id);
        return false;
      }
    });

  }


  $("#practicotext").autocomplete({
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
              label: item.NOMBRE,
              value: item.NOMBRE,
              id: item.ID
            }
          }));
        }
      });
    },
    minLength: 2,
    select: function (event, ui) {
      pegarPractico(ui.item.value, ui.item.id);
    },
    open: function () {
      $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
    },
    close: function () {
      $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
    }
  });


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



  $("#pos").mask("9999S99999W");


  $("#nuevoViaje").submit(function () {

    $('.botonsubmit').attr('disabled', 'disabled');



    if ($("#buquetext").val() == "") {
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
    if ($("#partidav").val() == "") {
      alert("Debe indicar fecha de partida");
      $("#partidav").focus();
      $('.botonsubmit').removeAttr('disabled');
      return false;
    }
    if (isDate($("#partidav").val())) {
      alert("La fecha de partida es invalida");
      $("#partida").focus();
      $('.botonsubmit').removeAttr('disabled');
      return false;
    }

    if ($("#etav").val() == "") {
      alert("Debe indicar eta");
      $("#etav").focus();
      $('.botonsubmit').removeAttr('disabled');
      return false;
    }

    if (isDate($("#etav").val())) {
      alert("La fecha de ETA es invalida");
      $("#etav").focus();
      $('.botonsubmit').removeAttr('disabled');
      return false;
    }


    if ($("#zoev").val() != "") {
      if (isDate($("#zoev").val())) {
        alert("La fecha de Zona de Espera es invalida");
        $("#zoev").focus();
        $('.botonsubmit').removeAttr('disabled');
        return false;
      }
    }

    if ($('#pos').val() != "") {
      var RegularExpression = /\d{4}[NS]\d{5}[EW]/;

      //            alert($('#pos').val().match(RegularExpression));
      //            return false


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


<style type="text/css">
#editaretapaformcontainer .columna
{
    float: left;
    margin: 5px;
}

#nuevoViaje
{
    float: left;
}


 </style>