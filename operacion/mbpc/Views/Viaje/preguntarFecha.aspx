<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="mbpc.Controllers" %>
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
    
    <% if (ViewData["tiene_carga"] != null) { %>
    
        <div style="width:100%;height:40px; vertical-align:middle; text-align:center;background:#ff0000;color:#ffffff">Este viaje contiene cargas aún.<br />Descargue antes de terminar el viaje.</div>
        <div style="clear:both"></div>
        <br />
    <% } %>
    
    <label><%= titulo %></label><br />
    <input style="float:left; width: 300px" autocomplete="off"  name="fecha" id="fecha" type="text" value="<%= ViewData["fecha"] %>"/><br />
    <div style="clear:both"></div>
    <% if (ViewData["action"].ToString() == "terminarviaje") { %>
    <label>Escalas</label><br />
    <input style="float:left; width: 300px" autocomplete="off"  name="escalas" id="escalas" type="text" value=""/><br />
    <div style="clear:both"></div>
    <label>¿Va a o viene de  Malvinas?</label><br />
    <%= Html.DropDownList("codigo_malvinas"
                      , ViajeController.MalvinasOptions(true)
                          , new Dictionary<string, object> { { "style", "width:300px;" } })%>
    <div style="clear:both"></div>
    <% } %>

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

          if (data == "nop")
            $('#list').trigger('reloadGrid');
          else
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


