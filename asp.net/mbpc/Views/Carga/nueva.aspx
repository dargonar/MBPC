<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<% List<object> unidades = ViewData["unidades"] as List<object>; %>
<form id="agrgar_carga" action="<%= Url.Content("~/Carga/agregar/") %>">

  <input type="hidden" value="<%= ViewData["etapa_id"] %>"  name="etapa_id"/>
  <input type="hidden" id="carga_id" name="carga_id" />
  <input type="hidden" id="buque_id" name="buque_id" />

  <label>Carga</label><br />
  <input type="text" id="carga" name="carga" style="width: 250px;" autocomplete="off"  /><br />

  <div class="latabla" style="position:absolute;z-index:5;width: 250px;"></div>
    <label>Código</label><br />
    <input type="text" id="codigo" name="codigo" autocomplete="off" style="width: 40px" /><br />

    <label style="float: left;width: 93px;">Cantidad</label><label style="float: left; width: 80px">Unidad</label><br />
    <input style="float: left;width: 80px;height: 20px;" autocomplete="off" type="text" id="cantidad" name="cantidad" />
  
    <select style="float: left; width: 87px" id="unidad_id" name="unidad_id">
    <%  
    foreach (Dictionary<string, string> unidad in unidades)
    {
      %><option value="<%= unidad["ID"] %>" ><%= unidad["NOMBRE"] %></option><%
    }
    %>
    </select><br/><br/>

    <p>
    <input type="checkbox" name="en_transito" value="" id="en_transito" />Está en tránsito
    </p>
    <p>
    <input type="checkbox" name="enbarcaza" value="" id="enbarcaza" />Está en barcaza
    </p>
    <input type="text" id="barcaza_text" style="width: 250px;" autocomplete="off" disabled="disabled"/><br />
    <br /><br /><br />
    
    <input type="submit" class="botonsubmit" style="margin-left: 180px"value="agregar" />
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
              cod:   item.CODIGO
            }
          }));
        }
      });
    },
    minLength: 2,
    select: function (event, ui) {
      $("#carga_id").val(ui.item.id);
      $('#codigo').val(ui.item.cod);
    },
    open: function () {
      $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
    },
    close: function () {
      $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
    }
  });

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
              id:    item.ID_BUQUE,
              label: item.NOMBRE,
              value: item.NOMBRE,
            }
          }));
        }
      });
    },
    minLength: 2,
    select: function (event, ui) {
      $("#buque_id").val(ui.item.id);
    }
  });


  $("#enbarcaza").change(function () {

    if ($(this).is(":checked")) {
      $('#barcaza_text').removeAttr('disabled');
    }
    else {
      $('#barcaza_text').attr('disabled', 'disabled');
      $("#buque_id").val('');
    }
    return false;
  });

  $("#agrgar_carga").submit(function () {

    $('.botonsubmit').attr('disabled','disabled');

    if ($("#carga_id").val() == "") {
      alert("Debe seleccionar tipo de carga");
      $('.botonsubmit').removeAttr('disabled');
      return false;
    }

    if ($("#unidad").val() == "") {
      alert("Debe ingresar la unidad");
      $('.botonsubmit').removeAttr('disabled');
      return false;
    }

    if ($("#codigo").val() == "") {
      alert("Debe ingresar el codigo");
      $('.botonsubmit').removeAttr('disabled');
      return false;
    }

    if ($("#cantidad").val() == "") {
      alert("Debe ingresar la cantidad");
      $('.botonsubmit').removeAttr('disabled');
      return false;
    }

    $.ajax({
      type: "POST",
      cache: false,
      url: $(this).attr('action'),
      data: $(this).serialize(),
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
  });

</script>
