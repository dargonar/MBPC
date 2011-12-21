<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<form id="adjuntar_barcazas" action="<%= Url.Content("~/Carga/adjuntar_barcazas/") + ViewData["etapa_id"] %>" >
  <table>
    <tr>
      <th>Barcazas Fondeadas</th>
    </tr>
    <tr>
      <td>
        <select multiple name="barcazas" size="15" style="width: 220px;float:left;">
        <% foreach (Dictionary<string, string> barcaza in (ViewData["barcazas_en_zona"] as List<object>))
            { %>
               <option value="<%= barcaza["ID"] %>"><%= barcaza["NOMBRE"]%></option>
         <% } 
        %>
        </select>
      </td>
    </tr>
    <tr>
      <td colspan="2" align="right">
        <input type="submit" class="botonsubmit" value="Adjuntar" />
      </td>
    </tr>
  </table>
</form>


<script type="text/javascript">

  $("#adjuntar_barcazas").submit(function () {

    $('.botonsubmit').attr('disabled', 'disabled');

    $.ajax({
      type: "POST",
      cache: false,
      url: $(this).attr("action"),
      data: $(this).serialize(),
      success: function (data) {
        $("#dialogdiv").html(data);
        $("#dialogdiv3").dialog('close');
      },
      error: (function (data) {
        var titletag = /<title\b[^>]*>.*?<\/title>/
        alert(titletag.exec(data.responseText));
        $('.botonsubmit').removeAttr('disabled');
      })
    });
    return false;

  });




</script>