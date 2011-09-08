<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
  <% string url;
     string titulo;
     string boton;
     if (ViewData["action"].ToString() == "terminarviaje")
     {
       url = Url.Content("~/Viaje/terminar/");
       titulo = "Ingrese fecha del fin del viaje";
       boton = "Terminar";
     }
     else
     {
       url = Url.Content("~/Carga/separarConvoy");
       titulo = "Ingrese fecha de inicio del viaje separado";
       boton = "Separar";
     }
        
       %>

  <form id="soloFecha" action="<%= url %>">
    <input type="hidden" id="viaje" name="viaje_id" value="<%= ViewData["viaje_id"] %>"/>
    <input type="hidden" id="etapa_id" name="id2" value="<%= ViewData["etapa_id"] %>"/>
    <label><%= titulo %></label>
    <input style="float:left; width: 300px" autocomplete="off"  name="fecha" id="fecha" type="text" value="<%= ViewData["fecha"] %>"/>
    <div style="clear:both"></div>
    <input type="submit" class="botonsubmit" style="margin-left: 226px;" value="<%= boton %>" />
  </form>

<script type="text/javascript">

  var action2 = '<%= ViewData["action"] %>';

  $("#fecha").mask("99-99-99 99:99");

  $("#soloFecha").submit(function () {
    $('.botonsubmit').attr('disabled', 'disabled');

    $.ajax({
      type: "POST",
      cache: false,
      url: $(this).attr('action'),
      data: $(this).serialize(),
      success: (function (data) {
        if (action2 == "terminarviaje") {
          $("#columnas").html(data);
          $('#dialogdiv').dialog('close');
        }
        else {
          $('#dialogdiv').dialog('close');
          $('#selector').html(data);
          $('#selector').dialog({
            title: "Transferencia de Barcazas",
            width: 524,
            height: 370,
            modal: true
          });
        }
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


