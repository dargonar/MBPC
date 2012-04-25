<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="mbpc.Controllers" %>
<% Dictionary<string, string> etapa = ViewData["etapa"] as Dictionary<string, string>; %>

<div>
<form id="modificar_etapa" action="<%= Url.Content("~/ViajeCerrado/modificar") %>" method="post">

  <input id="etapa_id" name="etapa_id" type="hidden" value="<%=ViewData["ETAPA_ID"] %>" />
  
  <label>Desde</label><br />
  <input autocomplete="off" type="text" style="width:350px;float:left;" id="desdetext"  value="<%= etapa["ORIGEN_DESC"] %>"/><br /><br />
  <input id="desde_id" name="desde_id" type="hidden" value="<%= etapa["PUERTO_ORIGEN"] %>"/>

  <label>Hasta</label><br />
  <input autocomplete="off" type="text" style="width:350px;float:left;" id="hastatext"  value="<%= etapa["DESTINO_DESC"] %>" /><br /><br />
  <input id="hasta_id" name="hasta_id" type="hidden" value="<%= etapa["PUERTO_DESTINO"] %>"/>

  <br />
  <input type="checkbox" name="en_adelante" >Modificar esta etapa y las siguientes<br /><br /><br />

  <input type="submit" class="botonsubmit" style="margin-left: 250px" value="Modificar Etapa" />

</form>
</div>

<script type="text/javascript">

    //$('#btnSeleccionarBarco').click();

    $('#hastatext, #desdetext').bind('keydown', 'ctrl+s', function () {
        $(this).next().click();
        return false;
    });

       url2 = '<%= Url.Content("~/Autocomplete/view_muelles/") %>' ;
    
      $("#desdetext, #hastatext").autocomplete({
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
                  label: '(' + item.COD + ') ' + item.PUERTO + ' (' + item.PAIS + ')',
                  value: '(' + item.COD + ') ' + item.PUERTO + ' (' + item.PAIS + ')',
                  id: item.COD
                }
              }));
            }
          });
        },
        minLength: 2,
        select: function (event, ui) {
          $(this).nextAll('input[type=hidden]').first().val(ui.item.id);
        },
        open: function () {
          $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
        },
        close: function () {
          $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
        }
      });

      $("#modificar_etapa").submit(function () {

          $('.botonsubmit').attr('disabled', 'disabled');

          if ($("#desdetext").val() == "" || $("#desde_id").val() == "") {
              alert("Debe seleccionar muelle de origen");
              $("#desdetext").focus();
              $('.botonsubmit').removeAttr('disabled');
              return false;
          }

          if ($("#hastatext").val() == "" || $("#hasta_id").val() == "") {
              alert("Debe seleccionar muelle de destino");
              $("#hastatext").focus();
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