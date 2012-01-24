<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
  <% 
     string url;
     string titulo;
     string boton;

     if (ViewData["action"].ToString() != "bajar_practico_fecha")
     {
       url = Url.Content("~/Viaje/activar_practico/");
       titulo = "Ingrese fecha de activación";
       boton = "Activar";
     }
     else
     {
       url = Url.Content("~/Viaje/bajar_practico");
       titulo = "Ingrese fecha de bajada";
       boton = "Bajar Practico";
     }
  %>

  <form onsubmit="return practico_fecha(this)" id="practicoFecha" action="<%= url %>">
    <input type="hidden" id="etapa_id" name="etapa_id" value="<%= ViewData["etapa_id"] %>"/>
    <input type="hidden" id="practico_id" name="practico_id" value="<%= ViewData["practico_id"] %>"/>
    
    <label><%=titulo%></label>
    <input style="float:left; width: 300px" autocomplete="off"  name="fecha" id="fecha" type="text" value="<%=System.DateTime.Now.ToString("dd-MM-yy HH:mm")%>"/>
    <div style="clear:both"></div>

    <input type="submit" class="botonsubmit" style="margin-left: 226px;" value="<%= boton %>" />
  </form>

<script type="text/javascript">
  $("#fecha").mask("99-99-99 99:99");

  function practico_fecha(frm) 
  {
    $('.botonsubmit').attr('disabled', 'disabled');

    $.ajax({
      type: "POST",
      cache: false,
      url: $(frm).attr('action'),
      data: $(frm).serialize(),
      success: (function (data) {
        $('#dialogdiv3').dialog('close');
        $('#dialogdiv').html(data);
      }),
      error: (function (data) {
        var titletag = /<title\b[^>]*>.*?<\/title>/
        alert(titletag.exec(data.responseText));
        $('.botonsubmit').removeAttr('disabled');
      })
    });

    return false;
  }

</script>


