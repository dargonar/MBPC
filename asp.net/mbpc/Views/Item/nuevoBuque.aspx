﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<% List<Object> banderas = ViewData["banderas"] as List<object>; %>

  <form id="nuevoBuque" action="<%= Url.Content("~/Item/crearBuque") %>">
    <table>
      <tr>
        <td><label>Nacional</label></td>
        <td><input type="radio" name="internacional" id="nac" checked="checked" value="0" onclick="nacion()"/></td>
        <td><label>Internacional</label></td>
        <td><input type="radio" name="internacional" id="inter" value="1" onclick="internacion()"/></td>
      </tr>
    </table>
    <label id="matlabel">Matricula</label><br />
    <input autocomplete="off" type="text" style="width:200px" name="matricula" id="matriculaN"/><br />
    <label>Nombre</label><br />
    <input autocomplete="off" type="text" style="width:200px" name="nombre" id="nombreN"/><br />
    <label>Señal Distintiva</label><br />
    <input autocomplete="off" type="text" style="width:200px" name="sdist" id="sdist"/><br />
    <label>Bandera</label><br />
      <select name="bandera" id="bandera" style="width:200px">
      <% foreach (Dictionary<string,string> bandera in banderas) 
         {
           Response.Write("<option value=\"" + bandera["DESCRIPCION"] + "\">" + bandera["DESCRIPCION"] + "</option>");   
         }
      %>
      </select><br /><br />

    <label>Tipo de Servicio</label><br />
    <input autocomplete="off" type="text" style="width:200px" name="servicio" id="servicio" <% if( ViewData["noint"] != null ) { %> value="BARCAZA" readonly="readonly" <% } %> /><br />
    <input type="submit" class="botonsubmitb" value="nuevo" style="margin-left: 149px"/>
  </form>

  <script type="text/javascript">

    $('#nac').click();

    function nacion() {
      $('#bandera').val('ARGENTINA');
      $('#bandera').attr('disabled', 'disabled');
      $('#matlabel').html('Matricula');
      $('#servicio').removeAttr('disabled');
      return false;
    }


    function internacion() {
      <% if( ViewData["noint"] == null ) { %>
      $('#servicio').attr('disabled', 'disabled');
      <% } %>
      $('#bandera').removeAttr('disabled');
      $('#bandera').val('');
      $('#matlabel').html('NRO OMI');

      return false;
    }

    $("#nuevoBuque").submit(function () {

      $('.botonsubmitb').attr('disabled', 'disabled');

      if ($("#matriculaN").val() == "") {
        alert("Debe ingresar la matricula");
        $('.botonsubmitb').removeAttr('disabled');
        return false;
      }
      if ($("#nombreN").val() == "") {
        alert("Debe ingresar un nombre");
        $('.botonsubmitb').removeAttr('disabled');
        return false;
      }
      if ($("#sdist").val() == "") {
        alert("Debe ingresar la señal distintiva");
        $('.botonsubmitb').removeAttr('disabled');
        return false;
      }


      if ($("input[name=internacional]:checked").val() == 1 && isNaN($("#matriculaN").val())) {
        alert("El MMSI debe ser numerico");
        $('.botonsubmitb').removeAttr('disabled');
        return false;
      }

      $.ajax({
        type: "POST",
        cache: false,
        url: $(this).attr('action'),
        data: $(this).serialize(),
        success: (function (data) {
          <% if( ViewData["noint"] == null ) { %>
          $('#dialogdiv3').dialog('close');
          pegar_y_cerrar($('#nombreN').val(), data[0].ID_BUQUE, $("input[name=internacional]:checked").val());
          <% } else { %>
          $('#buque_id').val(data[0].ID_BUQUE);
          $('#barcaza_text').val(data[0].NOMBRE);
          $('#dialogdiv4').dialog('close');
          <% } %>
        }),
        error: (function (data) {
          var titletag = /<title\b[^>]*>.*?<\/title>/

          if(titletag != "")
            alert(unescape(titletag.exec(data.responseText)));
          else
            alert(data);

          $('.botonsubmitb').removeAttr('disabled');
        })
      });
      return false;
    });
  
  
  
  </script>