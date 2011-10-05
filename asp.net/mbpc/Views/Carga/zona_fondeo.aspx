<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<form id="fondear_form" action="<%= Url.Content("~/Carga/fondear_barcaza/") %>" method="post">

      <label>Rio/Canal Km/Par</label><br />
      <input autocomplete="off" type="text" id="riocanal" style="width:270px" /><br />
      <input type="hidden" id="riocanalh" name="riocanal" />

      <label>Posicion</label><br />
      <input autocomplete="off" type="text" id="pos" name="pos" style="width:200px" /><br />
      <label class="desc">Formato: 9000S18000W </label><br />

      <label>Fecha/Hora</label><br />
      <input autocomplete="off" type="text" id="fecha" name="fecha" style="width:200px" /><br />
      <label class="desc">Formato: dd-mm-aa hh:mm</label><br /><br />

      <input type="hidden" id="etapa_id" name="etapa_id" value="<%= ViewData["etapa_id"] %>"/>
      <input type="hidden" id="barcaza_id" name="barcaza_id" value="<%= ViewData["barcaza_id"] %>"/>

      <input type="submit" class="botonsubmit" style="margin-left: 160px" value="Fondear Barcaza" />
</form>

<script type="text/javascript">
  $("#fecha").mask("99-99-99 99:99");
  $("#pos").mask("9999S99999W");

  $("#fecha").val('<%= DateTime.Now.ToString("dd-MM-yy HH:mm")%>');

  var url2 = '<%= Url.Content("~/Autocomplete/rioscanales") %>';
  $("#riocanal").autocomplete({
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
  });
  
  $('#fondear_form').submit(function () {

    $('.botonsubmit').attr('disabled', 'disabled');

    if ($("#fecha").val() == "") {
      alert("Debe indicar fecha");
      $("#fecha").focus();
      $('.botonsubmit').removeAttr('disabled');
      return false;
    }

    if ($("#estado").val() == "") {
        alert("Debe indicar estado");
        $("#fecha").focus();
        $('.botonsubmit').removeAttr('disabled');
        return false;
      }

    if (isDate($("#fecha").val())) {
      alert("La fecha es invalida");
      $("#fecha").focus();
      $('.botonsubmit').removeAttr('disabled');
      return false;
    }

    if ($('#pos').val() == "" || $('#pos').val().match(/\d{4}[NS]\d{5}[EW]/) == null || !validpos($('#pos').val()) ) {
        alert('Valores de posicion incorrectos');
        $('.botonsubmit').removeAttr('disabled');
        return false;
    }

    $.ajax({
        type: "POST",
        cache: false,
        url: $(this).attr('action'),
        data: $(this).serialize(),
        success: (function (data) {
            //$("#columnas").html(data.barcos);
            $("#dialogdiv").html(data);
            $('#dialogdiv3').dialog('close');
        }),
        error: (function (data) {
            var titletag = /<title\b[^>]*>.*?<\/title>/;
            alert(titletag.exec(data.responseText));
            $('.botonsubmit').removeAttr('disabled');
        })
    });

    return false;
  });

</script>