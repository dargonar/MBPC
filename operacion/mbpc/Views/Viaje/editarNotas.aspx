<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<% List<object> viajelist = ViewData["NOTAS"] as List<object>; %>
<% Dictionary<string, string> viaje = viajelist[0] as Dictionary<string, string>; %>
<div id="formcontainer"> 
<form id="editarNotasForm" action="<%= Url.Content("~/Viaje/guardarNotas") %>">
  <input type="hidden" name="id" value="<%= ViewData["VIAJE"] %>"/>
  <textarea name="notas" cols="80" rows="20"><%= viaje["NOTAS"] %></textarea>
  <input type="submit" class="botonsubmit" style="margin-left: 380px" value="Guardar" />

</form>
</div>

<script type="text/javascript">


  $("#editarNotasForm").submit(function () {

    $('.botonsubmit').attr('disabled', 'disabled');

    var mydata = $(this).serialize();
    $.ajax({
      type: "POST",
      cache: false,
      url: $(this).attr('action'),
      data: mydata,
      success: (function (data) {
        if (data == "nop")
          $('#list').trigger('reloadGrid');
        else
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