<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<div>
  <form id="agregar_practico" onsubmit="return agregar_practico(this)" action="<%=Url.Content("~/Viaje/agregar_practico") %>" method="post">
  
    <label>Nombre</label><br />
    <input type="text" id="nombre" name="nombre" autocomplete="off" style="width: 150px" /><br />
    <input type="hidden" id="practico_id" name="practico_id"/>
    <input type="hidden" id="etapa_id" name="etapa_id" value="<%=ViewData["etapa_id"]%>"/>
    
    <label>Fecha Subida</label><br />
    <input type="text" id="fecha_subida" name="fecha_subida" autocomplete="off" style="width: 150px" value="<%=System.DateTime.Now.ToString("dd-MM-yy HH:mm")%>"/><br />

    <input type="submit" value="Agregar" />
  </form>

</div>

<script type="text/javascript">

  $("#fecha_subida").mask("99-99-99 99:99");

  $("#nombre").autocomplete({
    source: function (request, response) {
      $.ajax({
        type: "POST",
        url: '<%= Url.Content("~/Autocomplete/practicos/")+"?etapa_id="+ViewData["etapa_id"] %>',
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
      $("#practico_id").val(ui.item.id);
    }
  });


  function agregar_practico(frm) {
    
    if ($("#practico_id").val() == '') {
      alert('Debe seleccionar un practico');
      return false;
    }
    
    if ($("#fecha_subida").val() == '') {
      alert('Debe seleccionar la fecha de subida');
      return false;
    }

    $.ajax({
      type: "POST",
      cache: false,
      url: $(frm).attr('action'),
      data: $(frm).serialize(),
      success: (function (data) {
        $('#dialogdiv3').dialog('close');
        $('#dialogdiv').html(data);
      }),
      error: function (data) {
        var titletag = /<title\b[^>]*>.*?<\/title>/
        alert(titletag.exec(data.responseText));
      }
    });

    return false;
  }

</script>