<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<form id="nuevomuelle" action="<%= Url.Content("~/Item/crearMuelle") %>" >
 <table>
 <tr><th>Puerto</th><th>Instalacion Port.</th><th>Muelle</th></tr>
 <tr>
 
 <td>
 <select id="puerto" name="puerto" size="15" style="width: 220px;float:left;">

  <% foreach (Dictionary<string, string> puerto in (ViewData["puertos"] as List<object>))
      { %>
         <option onclick="traer_instport(<%= puerto["ID"] %>,'<%= Url.Content("~/Item/instport") %>')" value="<%= puerto["ID"] %>"><%= puerto["NOMBRE"] %></option>
   <% } 
  %>

  </select>
  </td>
   
  <td>
  <select id="instport" name="instport" size="15" style="width: 220px;float:left;">
  </select>
  </td>
  
  <td style="vertical-align:top;">
  <label title="Nombre"></label>
    <input id="mNombre" name="mNombre" autocomplete="off" type="text" style="width: 220px;" />
    <input type="submit" class="botonsubmit" value="Crear Muelle" />
  </td>

  </tr>
  </table>
</form>

<script type="text/javascript">

  $('#nuevomuelle').submit(function () {

      $('.botonsubmit').attr('disabled', 'disabled');

      if ($("#puerto").val() == "") {
          alert("Debe seleccionar un puerto");
          $('.botonsubmit').removeAttr('disabled');
        return false;
      }
      if ($("#instport").val() == "") {
          alert("Debe seleccionar una instalacion portuaria");
          $('.botonsubmit').removeAttr('disabled');
        return false;
      }
      if ($("#mNombre").val() == "") {
          alert("Debe ingresar un nombre");
          $('.botonsubmit').removeAttr('disabled');
        return false;
      }

      $.ajax({
        type: "POST",
        cache: false,
        url: $(this).attr('action'),
        data: $(this).serialize(),
        success: (function (data) {
          $('#dialogdiv3').dialog('close');
          pegar_y_cerrar($('#mNombre').val(), data[0].muelle_id );
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