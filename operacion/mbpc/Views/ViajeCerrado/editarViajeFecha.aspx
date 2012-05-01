<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="mbpc.Controllers" %>
<% List<object> viajelist = ViewData["viajedata"] as List<object>; %>
<% Dictionary<string, string> viaje = viajelist[0] as Dictionary<string, string>; %>

<div>
<form id="modificar_etapa" action="<%= Url.Content("~/ViajeCerrado/modificarFechaViaje") %>" method="post">

  <input id="viaje_id" name="viaje_id" type="hidden" value="<%=ViewData["VIAJE_ID"] %>" />
  
  <label>Fecha de partida</label><br />
  <input autocomplete="off" type="text" id="fecha_salida" name="fecha_salida" class="editaretapatext" value="<%= viaje["FECHA_SALIDA_fmt"] %>" /><br />
  <label class="desc">Formato: dd-mm-aa hh:mm</label><br /><br />
  <input id="fecha_salida_original" name="fecha_salida_original" type="hidden" value="<%= viaje["FECHA_SALIDA_fmt"] %>"/>

  <br />
  
  <input type="submit" class="botonsubmit" style="margin-left: 250px" value="Modificar Viaje" />

</form>
</div>

<script type="text/javascript">

    
//  $("#en_adelante").change(function () {
//    $("#fecha_salida").attr('disabled', !$("#fecha_salida").attr('disabled'));
//    return false;
//  });
    
    $("#fecha_salida").mask("99-99-99 99:99");

    
      $("#modificar_etapa").submit(function () {

          $('.botonsubmit').attr('disabled', 'disabled');

          
            if ($("#fecha_salida").val() == "") {
              alert("Debe indicar fecha de partida");
              $("#fecha_salida").focus();
              $('.botonsubmit').removeAttr('disabled');
              return false;
            }

          $.ajax({
              type: "POST",
              cache: false,
              url: $(this).attr('action'),
              data: $(this).serialize(),
              success: (function (data) {
                  var grilla = $('#dialogdiv').attr('grilla');
                  alert(grilla);
                  $(grilla).trigger('reloadGrid');
                  $('#dialogdiv').dialog('close');

                  //$('div.msg_info.msg_success').show();
                  //setTimeout(function () {
                  //  $('div.msg_info.msg_success').fadeOut('slow', function () {
                  //    $('div.msg_info.msg_success').hide();
                  //  });
                  //  
                  //}, 5000);

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