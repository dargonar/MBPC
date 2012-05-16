<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<% Dictionary<string, string> carga = ViewData["carga"] as Dictionary<string, string>; %>
<form id="editar_tipo_carga" action="<%= Url.Content("~/Carga/modificarTipo/") %>">

  <input type="hidden" id="etapa_id" name="etapa_id" value="<%= carga["ETAPA_ID"] %>"/>
  <input type="hidden" id="carga_id" name="carga_id" value="<%= carga["CARGA_ID"] %>"/>
  <input type="hidden" id="unidad_id" name="unidad_id" value="<%= carga["UNIDAD_ID"] %>"/>
  <input type="hidden" id="tipocarga_id" name="tipocarga_id" value="<%= carga["TIPOCARGA_ID"] %>"/>
  
  <label>Carga</label><br />
  <input type="text" id="carga" style="width: 250px;" autocomplete="off" value="<%= carga["NOMBRE"] %>"  /><br />
  
  <div class="latabla" style="position:absolute;z-index:5;width: 250px;"></div>
    <label>Código</label><br />
    <input type="text" id="codigo" autocomplete="off" style="width: 40px" readonly="readonly" value="<%= carga["CODIGO"] %>"/><br />

    <br />
    <input type="submit" class="the_submit" value="Modificar" />
</form>

<script type="text/javascript">

  url = '<%= Url.Content("~/Autocomplete/cargas") %>';
  $("#carga").autocomplete({
    source: function (request, response) {

      $.ajax({
        type: "POST",
        url: url,
        dataType: "json",
        data: {
          query: request.term
        },
        success: function (data) {
          response($.map(data, function (item) {
            return {
              label: item.NOMBRE,
              value: item.NOMBRE,
              id:    item.ID,
              cod:   item.CODIGO,
              unom:  item.UNOMBRE,
              uid:   item.UNIDAD_ID
            }
          }));
        }
      });
    },
    minLength: 2,
    select: function (event, ui) {
      $("#tipocarga_id").val(ui.item.id);
      $('#codigo').val(ui.item.cod);
      //$('#unidad_txt').val(ui.item.unom);
      $('#unidad_id').val(ui.item.uid);
      
      
    },
    open: function () {
      $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
    },
    close: function () {
      $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
    }
  });

  $("#editar_tipo_carga").submit(function () {

    $("#fullscreen").css("display", "block");
    $('.the_submit').attr('disabled', 'disabled');

    $.ajax({
      type: "POST",
      cache: false,
      url: $(this).attr("action"),
      data: $(this).serialize(),
      success: (function (data) {
        $('.the_submit').removeAttr('disabled');
        $('#dialogdiv').html(data);
        $("#fullscreen").css("display", "none");
         $('#dialogdiv3').dialog('close');
        
      }),
      error: (function (data) {
        $("#fullscreen").css("display", "none");
        var titletag = /<title\b[^>]*>.*?<\/title>/
        alert(titletag.exec(data.responseText));
        $('.the_submit').removeAttr('disabled');
      })
    });
    return false;

  });
</script>
