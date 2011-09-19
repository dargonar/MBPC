<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<form id="agregarPosicionForm" action="<%= Url.Content("~/Viaje/insertarReporte") %>" method="post">
      <label>Barco</label><br />
      <input autocomplete="off" type="text" id="barco" style="width:270px" /><br />
      <input  type="hidden" name="barco" id="barcoh" />

      <label>Posicion</label><br />
      <input autocomplete="off" type="text" id="pos" name="pos" style="width:270px" /><br />
      <label class="desc">Formato: 9000S18000W </label><br />

      <label>Estado</label><br />
      <input autocomplete="off" type="text" id="estado" style="width:270px" /><br />
      <input  type="hidden" id="estadoh" name="estado" />

      <label>Velocidad</label><br />
      <input autocomplete="off" type="text" style="width:270px" id="velocidad" name="velocidad" /><br />

      <label>Rumbo</label><br />
      <input autocomplete="off" type="text" style="width:270px" id="rumbo" name="rumbo" /><br />

      <label>Fecha/Hora</label><br />
      <input autocomplete="off" type="text" id="fecha" name="fecha" style="width:270px"  /><br />
      <label class="desc">Formato: dd-mm-aa hh:mm</label><br /><br />

      <input type="hidden" id="viaje_id" name="viaje_id" />
      <input type="submit" class="botonsubmit" style="margin-left: 163px" value="Agregar" />
</form>

    <script type="text/javascript">

      var url = '<%= Url.Content("~/Autocomplete/view_buquesjson") %>'
      var url2 = '<%= Url.Content("~/Autocomplete/estados") %>'


      //$("#fecha").val('');
        $("#fecha").mask("99-99-99 99:99");
        $("#pos").mask("9999S99999W");
        $("#velocidad").mask("99.9");
        $("#rumbo").mask("999");

        $("#pos").blur( function () { validpos($(this).val()) } );

        $("#barco").autocomplete({
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
                        label: item.NOMBRE + ' (SD:' + item.SDIST + '-IMO:' + item.NRO_OMI + ')',
                        value: item.NOMBRE + ' (SD:' + item.SDIST + '-IMO:' + item.NRO_OMI + ')',
                        viaje_id: item.VIAJE_ID
                      }
                    }));
              }
            });
          },
          minLength: 2,
          select: function (event, ui) {
            $("#viaje_id").val(ui.item.viaje_id)
          },
          open: function () {
            $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
          },
          close: function () {
            $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
          }
        });



        $("#estado").autocomplete({
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
                    label: item.COD + " - " + item.ESTADO,
                    value: item.ESTADO,
                    cod: item.COD
                  }
                }));
              }
            });
          },
          minLength: 2,
          select: function (event, ui) {
            $("#estadoh").val(ui.item.cod)
          },
          open: function () {
            $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
          },
          close: function () {
            $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
          }
        });
        


        //$("#pos").blur(function () {
        //    esplitearpos(this);
        //});

        $('#agregarPosicionForm').submit(function () {

          $('.botonsubmit').attr('disabled', 'disabled');


          if ($('#barco').val() == "") {
            alert('Debe elegir un buque');
            $('.botonsubmit').removeAttr('disabled');
            return false;
          }

          if ($('#barco').val() == "") {
            alert('Debe elegir un buque');
            $('.botonsubmit').removeAttr('disabled');
            return false;
          }



          var RegularExpression = /\d{4}[NS]\d{5}[EW]/;

          //            alert($('#pos').val().match(RegularExpression));
          //            return false

          if ($('#pos').val() == "") {
            alert('Debe insertar una posicion');
            $('.botonsubmit').removeAttr('disabled');
            return false;
          }

          if ($('#pos').val().match(RegularExpression) == null || !validpos($('#pos').val())) {
              alert('Valores erroneos en posicion');
              $('.botonsubmit').removeAttr('disabled');
              return false;
            }


            if ($("#fecha").val() == "") {
              alert("Debe indicar fecha");
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