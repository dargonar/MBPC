<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<div>
  <table style="width: 100%">
    <tr>
      <th>Nombre</th>
      <th>Fecha Subida</th>
      <th>Fecha Bajada</th>
      <th>Accion</th>
    </tr>

    <% 
    var res = ViewData["results"] as List<object>;
    %>
    <tr id="xnoload" <%= (res != null && res.Count != 0) ? "style=\"display:none\"" : "" %>>
      <td colspan="6" style="text-align: center; padding: 30px;background:#dddddd"><strong>SIN PRACTICOS/BAQUEANOS</strong></td>
    </tr>


    <% foreach (Dictionary<string, string> p in res) { %>
    <tr>
      <td><%=p["NOMBRE"]%></td>
      <td><%=p["FECHA_SUBIDA"]%></td>
      <td><%=p["FECHA_BAJADA"]%></td>
      <td><%if (p["FECHA_BAJADA"] == "" ) { %> <a href="#">Bajar</a> <% } %></td>
    </tr>
    <%} %>
  </table>
  <br/>

  <div class="btn-new-class" style="float:left">
    <a id="nvopract" onclick="return nuevo_practico(this);" href="<%=Url.Content("~/Viaje/nuevo_practico")%>?etapa_id=<%=ViewData["etapa_id"]%>">Agregar Practico</a>
  </div>

</div>

<script type="text/javascript">

  function showTitlexx(data) {
    var titletag = /<title\b[^>]*>.*?<\/title>/
    alert(titletag.exec(data.responseText));
  }

  function nuevo_practico(obj) {
    
    $.ajax({
      type: "GET",
      cache: false,
      url: $(obj).attr('href'),
      success: (function (data) {
        $('#dialogdiv3').html(data);
        $('#dialogdiv3').dialog({
          height: 380,
          width: 260,
          modal: true,
          title: 'Agregar nuevo practico/baqueano'
        });
      }),
      error: (function() {
        showTitlexx();
      })
    });

    return false;
  }
</script>