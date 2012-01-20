<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

  <form id="elegirAcompanante" action="<%= Url.Content("~/Viaje/editarAcompanantes") %>">
    <input type="hidden" id="etapa_id" name="etapa_id" value="<%= ViewData["etapa_id"] %>"/>
    
    <label>Acompañante 1</label>
    <input style="float:left; width: 300px" autocomplete="off" class="autocompletetext" name="acompanante" id="acompanante" type="text" value="<%=ViewData["NOMBRE"] %>"/>
    <input type="hidden" id="buque_id" name="buque_id" value="<%=ViewData["ACOMPANANTE_ID"] %>"/>
    <a href="#">Quitar</a>
    </br>

    <label>Acompañante 2</label>
    <input style="float:left; width: 300px" autocomplete="off" class="autocompletetext" name="acompanante" id="acompanante2" type="text" value="<%=ViewData["NOMBRE2"] %>"/>
    <input type="hidden" id="buque2_id" name="buque_id" value="<%=ViewData["ACOMPANANTE2_ID"] %>"/>
    <a href="#">Quitar</a>
    </br>

    <label>Acompañante 3</label>
    <input style="float:left; width: 300px" autocomplete="off" class="autocompletetext" name="acompanante" id="acompanante3" type="text" value="<%=ViewData["NOMBRE3"] %>"/>
    <input type="hidden" id="buque3_id" name="buque_id" value="<%=ViewData["ACOMPANANTE3_ID"] %>"/>
    <a href="#">Quitar</a>
    </br>

    <label>Acompañante 4</label>
    <input style="float:left; width: 300px" autocomplete="off" class="autocompletetext" name="acompanante" id="acompanante4" type="text" value="<%=ViewData["NOMBRE4"] %>"/>
    <input type="hidden" id="buque4_id" name="buque_id" value="<%=ViewData["ACOMPANANTE4_ID"] %>"/>
    <a href="#">Quitar</a>
    </br>

    <div style="clear:both"></div>

    <input type="submit" class="botonsubmit" value="Elegir" />
  </form>





<script type="text/javascript">

  url1 = '<%= Url.Content("~/Autocomplete/view_buquesnac/") %>';

  $("#acompanante, #acompanante2, #acompanante3, #acompanante4").autocomplete({
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


