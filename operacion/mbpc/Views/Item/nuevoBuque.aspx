<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<% List<Object> banderas = ViewData["banderas"] as List<object>; %>

  <form id="nuevoBuque" action="<%= Url.Content("~/Item/crearBuque") %>">
    <table>
      <tr>
        <td><label>Nacional</label></td>
        <td><input type="radio" name="internacional" id="bnac" checked="checked" value="0" onclick="nacionb()"/></td>
        
        <td><label>Internacional</label></td>
        <td><input type="radio" name="internacional" id="binter" value="1" onclick="internacionb()"/></td>
      </tr>
    </table>
    
    <label id="bmatlabel">Matricula</label><br />
    <input autocomplete="off" type="text" style="width:200px" name="matricula" id="bmatriculaN"/><br />
    
    <label>Nombre</label><br />
    <input autocomplete="off" type="text" style="width:200px" name="nombre" id="bnombreN"/><br />

    <label>Señal Distintiva</label><br />
    <input autocomplete="off" type="text" style="width:200px" name="sdist" id="bsdist"/><br />
    
    <label>Bandera</label><br />
    <select name="bandera" id="bbandera" style="width:200px" disabled="disabled">
    <% foreach (Dictionary<string,string> bandera in banderas) { %>
      <option value="<%=bandera["DESCRIPCION"]%>" <%=( bandera["DESCRIPCION"] == "ARGENTINA" ? "selected=\"selected\"" : "") %>><%=bandera["DESCRIPCION"]%></option>
    <% } %>
    </select><br /><br />

    <label>Tipo de Servicio</label><br />
    <input autocomplete="off" type="text" style="width:200px" name="servicio" id="bservicio"/><br />

    <label>MMSI</label><br />
    <input autocomplete="off" type="text" style="width:200px" name="mmsi" id="bmmsi"/><br />
    
    <input type="submit" class="botonsubmitb" value="nuevo" style="margin-left: 149px"/>
  </form>

  <script type="text/javascript">

    function nacionb() {
      $('#bbandera').val('ARGENTINA');
      $('#bbandera').attr('disabled', 'disabled');
      $('#bmatlabel').html('Matricula');
      return false;
    }

    function internacionb() {
      $('#bbandera').val('');
      $('#bbandera').attr('disabled', false);
      $('#bmatlabel').html('Numero OMI');
      return false;
    }

    $("#nuevoBuque").submit(function () {

        $('.botonsubmitb').attr('disabled', 'disabled');
        
        /*
        if ($("#bbandera").val() != 'PARAGUAY' && $("#bmatriculaN").val() == "") {
            alert("Debe ingresar " + $('#bmatlabel').html());
            $('.botonsubmitb').removeAttr('disabled');
            return false;
        }
        */

        if ($("#bnombreN").val() == "") {
            alert("Debe ingresar un nombre");
            $('.botonsubmitb').removeAttr('disabled');
            return false;
        }

        if ($("#bbandera").val() != 'PARAGUAY' && $("#bsdist").val() == "") {
            alert("Debe ingresar la señal distintiva");
            $('.botonsubmitb').removeAttr('disabled');
            return false;
        }

        if ($("#binter").val() != 0 && $("#bbandera").val() == null) {
            alert("Seleccione la bandera");
            $('.botonsubmitb').removeAttr('disabled');
            return false;
        }

        if ($("#bservicio").val() == "") {
            alert("Debe seleccionar el tipo de servicio");
            $('.botonsubmitb').removeAttr('disabled');
            return false;
        }

        $.ajax({
            type: "POST",
            cache: false,
            url: $(this).attr('action'),
            data: $(this).serialize(),
            success: (function (data) {
                $('#dialogdiv3').dialog('close');

                $('#buque_id').val(data[0].ID_BUQUE);
                $('#buquetext').val($('#bnombreN').val()).nextAll('.nexttab:eq(0)').focus();
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