<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

  <form id="elegirAcompanante" action="<%= Url.Content("~/Viaje/editarAcompanante") %>">
    <input type="hidden" id="etapa_id" name="etapa_id" value="<%= ViewData["etapa_id"] %>"/>
    
    <input style="float:left; width: 300px" autocomplete="off" class="autocompletetext" name="acompanante" id="acompanante" type="text" />
    <input type="hidden" id="buque_id" name="buque_id"/>

    <div style="clear:both"></div>

    <input type="submit" class="botonsubmit" value="Elegir" />
  </form>





<script type="text/javascript">

  url1 = '<%= Url.Content("~/Autocomplete/view_buquesnac/") %>';

  $("#acompanante").autocomplete({
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
              label: item.NOMBRE,
              value: item.NOMBRE,
              MATRICULA: item.ID_BUQUE
            }
          }));
        }
      });
    },
    minLength: 2,
    select: function (event, ui) {
      $(this).nextAll('input[type=hidden]').first().val(ui.item.MATRICULA);
    },
    open: function () {
      $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
    },
    close: function () {
      $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
    }
  });



    $('.autocompletetext').bind('keydown', 'return', function () {
        $("#elegirAcompanante").submit();
        return false;
    });

    

    $("#elegirAcompanante").submit(function () {

        $('.botonsubmit').attr('disabled', 'disabled');

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


