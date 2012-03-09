<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<select id="barcoszona" style="width: 270px">
<%string etapapa = ViewData["etapa_id"].ToString(); %>
<% foreach (Dictionary<string, string> barco in (ViewData["barcos_en_zona"] as List<object>))
    {
      if (barco["ETAPA_ID"] == etapapa) continue;
     %>
       <option value="<%= barco["ETAPA_ID"] %>"><%= barco["NOMBRE"] %></option>
 <% } 
%>
</select>
<% if (ViewData["carga"] == null) { %>
<button type="button" style="margin-left: 161px;margin-top: 20px" onclick="return editarBarcazas('<% Response.Write(Url.Content("~/Carga/editarBarcazas/" + ViewData["etapa_id"] )); %>/' + $('#barcoszona').val() );">Siguiente</button>
<% } else { %>
<button type="button" style="margin-left: 161px;margin-top: 20px" onclick="return pasarCargas('<% Response.Write(Url.Content("~/Carga/pasarCargas/" + ViewData["etapa_id"] )); %>/' + $('#barcoszona').val() );">Siguiente</button>
<% } %>


<script type="text/javascript">
//element como parametro, llena diaglogdiv
  function pasarCargas(url) {
		$.ajax({
		  type: "GET",
		  cache: false,
		  url: url,
		  success: (function (data) {
		    $('#selector').html(data);
        $('#selector').dialog({
          title: "Trasvase de carga",
          width: 600,
          height: 370,
          modal: true
        });
		  }),
		  error: (function (data) {
        var titletag = /<title\b[^>]*>.*?<\/title>/
        alert(titletag.exec(data.responseText));
		  })
		});
		      
    return false;
  }
</script>