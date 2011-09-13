<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<% List<Object> banderas = ViewData["banderas"] as List<object>; %>

<form id="nuevomuelle" action="<%= Url.Content("~/Item/crearMuelle") %>" >
<table>
<tr>
<td><label>Codigo</label></td>
<td><input type="text" name="cod" id="cod" /></td>
</tr>

<tr>
<td><label>Nombre</label></td>
<td><input type="text" name="puerto" id="puerto" /></td>
</tr>

<tr>
<td><label>Pais</label></td>
<td><select name="pais" id="paus" style="width:200px">
<% foreach (Dictionary<string,string> bandera in banderas) 
    {
      Response.Write("<option value=\"" + bandera["DESCRIPCION"] + "\">" + bandera["DESCRIPCION"] + "</option>");   
    }
%>
</td>
</tr>
<tr>
<td colspan="2"><input type="submit" class="botonsubmit" value="crear" /></td>
</tr>
</table>
</form>

<script type="text/javascript">

  $('#nuevomuelle').submit(function () {

      $('.botonsubmit').attr('disabled', 'disabled');

      if ($("#cod").val() == "") {
          alert("Debe escribir un codigo");
          $('.botonsubmit').removeAttr('disabled');
        return false;
      }
      if ($("#puerto").val() == "") {
          alert("Debe escribir un nombre");
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
          pegar_y_cerrar(data[0].COD, data[0].muelle_id);
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