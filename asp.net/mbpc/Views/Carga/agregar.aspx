<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<% List<object> unidades = ViewData["unidades"] as List<object>; %>
<% List<object> barcazas = ViewData["barcazas"] as List<object>; %>
<% List<object> usadas = ViewData["usadas"] as List<object>; %>
<form id="agCarga" action="<%= Url.Content("~/Carga/insertar/") %>">

  <input type="hidden" value="<%= ViewData["etapa_id"] %>"  name="etapa_id"/>
  <input type="hidden" value="<%= ViewData["viaje_id"] %>"  name="viaje_id"/>

  <label>Carga</label><br />
    
    <input type="text" id="carga" name="carga" style="width: 250px;" autocomplete="off"  /><br />
    <input type="hidden" id="cargaid" name="carga_id" />
  <div class="latabla" style="position:absolute;z-index:5;width: 250px;"></div>

  <label>Codigo</label><br />
  <input type="text" id="codigo" name="codigo" autocomplete="off" onchange="traerporcodigo('<%= Url.Content("~/Autocomplete/traertipoxcodigo/") %>', this.value )" style="width: 40px" /><br />


  <label style="float: left;width: 93px;">Cantidad</label><label style="float: left; width: 80px">Unidad</label><br />
  <input style="float: left;width: 80px;height: 20px;" autocomplete="off" type="text" id="cantidad" name="cantidad" />
  <select style="float: left; width: 87px" id="unidad_id" name="unidad_id">
  <%  foreach (Dictionary<string, string> unidad in unidades)
      {
 %> 
        <option value="<%= unidad["ID"] %>" ><%= unidad["NOMBRE"] %></option>
 <%
      }
     %>
  </select><br /><br />
  <p><input type="checkbox" name="enbarcaza" value="enbarcaza" id="enbarcaza" onchange="mostrarselect()"/>Esta en barcaza</p>
    <select style="float: left; width: 250px;" id="barcazas" disabled="disabled" name="buque_id">
      <option value=""></option>
  <%  foreach (Dictionary<string, string> barcaza in barcazas)
      {
 %>    
        <option value="<%= barcaza["MATRICULA"] %>"> <%= barcaza["NOMBRE"] %></option>        
 <%
      }
     %>
  </select><br /><br /><br />
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
              id: item.ID,
              cod: item.CODIGO
            }
          }));
        }
      });
    },
    minLength: 2,
    select: function (event, ui) {
      $(this).nextAll('input[type=hidden]').first().val(ui.item.id);
      $('#codigo').val(ui.item.cod);
    },
    open: function () {
      $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
    },
    close: function () {
      $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
    }
  });


  function mostrarselect() {
    if ($('#enbarcaza').is(':checked')) {
      $('#barcazas').removeAttr('disabled');
    } else {
      $('#barcazas').attr('disabled', 'disabled');
      $('#barcazas').val("");
    }
    return false;
  }

  function traerporcodigo(url, codigo) {
    $.ajax({
      type: "POST",
      cache: false,
      url: url,
      data: 'id=' + codigo,
      success: (function (data) {
        $("#carga").val(data[0].NOMBRE);
        $("#cargaid").val(data[0].ID);
      }),
      error: (function (data) {
        var titletag = /<title\b[^>]*>.*?<\/title>/
        alert(titletag.exec(data.responseText));
      })
    });
  }

  $("#agCarga").submit(function () {

      $('.botonsubmit').attr('disabled','disabled');

    if ($("#carga").val() == "") {
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
      success: (function (data) {
        $("#dialogdiv3").dialog('close');
        $('#dialogdiv').html(data);
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
