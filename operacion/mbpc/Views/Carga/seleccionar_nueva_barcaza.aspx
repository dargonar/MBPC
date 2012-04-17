<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<form action="<%= Url.Content("~/Carga/corregir_barcaza/") %>" method="post" onsubmit="return corregir_barcaza(this);">

      <label>Barcaza</label><br />
      <input type="text" id="barcaza_text" style="width: 200px;" autocomplete="off" />
      <input href="<%=Url.Content("~/Item/nuevaBarcaza")%>" id="newbarcaza" type="button" value="..." onclick="return nuevaBarcaza(this);" title="NUEVA BARCAZA"/> <br />
      <input type="submit" value="Corregir Barcaza" />

      <input type="hidden" id="buque_id" name="buque_id" />
      <input type="hidden" id="etapa_id" name="etapa_id" value="<%= ViewData["etapa_id"] %>"/>
      <input type="hidden" id="barcaza_id" name="barcaza_id" value="<%= ViewData["barcaza_id"]%>" />

      
</form>

<script type="text/javascript">

    function nuevaBarcaza(obj)
    {
      $.ajax({
        type: "GET",
        cache: false,
        url: $(obj).attr('href'),
        success: (function (data) {
          $('#dialogdiv4').html(data);
          $('#dialogdiv4').dialog({
            height: 375,
            width: 240,
            modal: true,
            title: 'Nueva Barcaza',
          });
        }),
        error: (function (data) {
          var titletag = /<title\b[^>]*>.*?<\/title>/
          alert(titletag.exec(data.responseText));
        })
      });

      return false;
    }

  function corregir_barcaza(obj)
  {
    $('.botonsubmit').attr('disabled','disabled');

    if ($("#buque_id").val() == "") {
      alert("Debe seleccionar una barcaza");
      $('.botonsubmit').removeAttr('disabled');
      return false;
    }

    $.ajax({
      type: "POST",
      cache: false,
      url: $(obj).attr('action'),
      data: $(obj).serialize(),
      success: function (data) {
        $("#dialogdiv3").dialog('close');
        $('#dialogdiv').html(data);
      },
      error: function (data) {
        var titletag = /<title\b[^>]*>.*?<\/title>/
        alert(titletag.exec(data.responseText));
        $('.botonsubmit').removeAttr('disabled');
      }
    });

    return false;
  }

$("#barcaza_text").autocomplete({
    source: function (request, response) {
      $.ajax({
        type: "POST",
        url: '<%= Url.Content("~/Autocomplete/barcazas") %>',
        dataType: "json",
        data: {
          query: request.term,
          etapa_id: '<%= ViewData["etapa_id"] %>'
        },
        success: function (data) {
          response($.map(data, function (item) {
            return {
              id     : item.ID_BUQUE,
              nombre : item.NOMBRE,
              bandera: item.BANDERA,
              info   : item.INFO,
              vf     : item.VIAJE_FONDEADA,
              etapa  : item.ETAPA
            }
          }));
        }
      });
    },
    minLength: 2,
    select: function (event, ui) {

        if( ui.item.info != '0' && ui.item.etapa != '0')
        {
            $("#buque_id").val('');
            $("#barcaza_text").val('');
            event.preventDefault();
            return false;
        }

      $("#buque_id").val(ui.item.id);
      $("#barcaza_text").val(ui.item.nombre);
      return false;
    }
  }).data( "autocomplete" )._renderItem = function( ul, item ) {
			      
    var bg = '';
    var mr = '';

    if( item.info != '0' && item.etapa != '0')
    {
        if(item.vf == 'v')
        {
            mr = 'Viajando en ';
            bg = 'style="background:#B99"';
        }
        else
        {
            mr = 'Fondeada en ';
            bg = 'style="background:#099"';
        }

        
        mr += item.info;
    }

    return $( "<li "+ bg + "></li>" )
			    .data( "item.autocomplete", item )
			    .append( "<a>" + item.nombre + " (" + item.bandera + ") " 
                        + mr
                        + "</a>" )
			    .appendTo( ul );
  };


  
  </script>