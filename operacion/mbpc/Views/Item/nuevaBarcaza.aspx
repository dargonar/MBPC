<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<% List<Object> banderas = ViewData["banderas"] as List<object>; %>

  <form id="nuevoBarcaza" action="<%= Url.Content("~/Item/crearBarcaza") %>">
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
    <select name="bandera" id="bandera" style="width:200px" disabled="disabled">
    <% foreach (Dictionary<string,string> bandera in banderas) { %>
      <option value="<%=bandera["DESCRIPCION"]%>" <%=( bandera["DESCRIPCION"] == "ARGENTINA" ? "selected=\"selected\"" : "") %>><%=bandera["DESCRIPCION"]%></option>
    <% } %>
    </select><br /><br />

    <label>Tipo de Servicio</label><br />
    <select name="servicio" style="width:200px">
      <option value="BARCAZA">BARCAZA</option>
      <option value="BALSA">BALSA (sin motor)</option>
    </select>

    <input type="submit" class="botonsubmitb" value="Crear Barcaza" style="margin-left: 106px"/>
  </form>

  <script type="text/javascript">

    function nacion() {
      $('#bandera').val('ARGENTINA');
      $('#bandera').attr('disabled', 'disabled');
      return false;
    }

    function internacion() {
      $('#bandera').val('');
      $('#bandera').attr('disabled', false);
      return false;
    }
    
    $("#nuevoBarcaza").submit(function () {

      $('.botonsubmitb').attr('disabled', 'disabled');

      if ($("#matriculaN").val() == "") {
        alert("Debe ingresar Matricula");
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

      if ($("#inter").val() != 0 && $("#bandera").val() == null) {
        alert("Seleccione la bandera");
        $('.botonsubmitb').removeAttr('disabled');
        return false;
      }

      $.ajax({
        type: "POST",
        cache: false,
        url: $(this).attr('action'),
        data: $(this).serialize(),
        success: (function (data) {
          $('#buque_id').val(data[0].ID_BUQUE);
          $('#barcaza_text').val(data[0].NOMBRE);
          $('#dialogdiv4').dialog('close');
        }),
        error: (function (data) {
          var titletag = /<title\b[^>]*>.*?<\/title>/

          if (titletag != "")
            alert(unescape(titletag.exec(data.responseText)));
          else
            alert(data);

          $('.botonsubmitb').removeAttr('disabled');
        })
      });
      return false;
    });
  
  
  </script>