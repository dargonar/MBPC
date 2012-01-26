<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<div>
  <table style="width: 100%">
    <tr>
      <th>Nombre</th>
      <th>Fecha Subida</th>
      <th>Accion</th>
    </tr>

    <% 
    var res = ViewData["results"] as List<object>;
    %>
    <tr id="xnoload" <%= (res != null && res.Count != 0) ? "style=\"display:none\"" : "" %>>
      <td colspan="3" style="text-align: center; padding: 30px;background:#dddddd"><strong>SIN PRACTICOS/BAQUEANOS</strong></td>
    </tr>


    <% foreach (Dictionary<string, string> p in res) { %>
    <tr <% if(p["ACTIVO"]=="1") { %>style="background:#dddddd"<% } %> >
      <td style="text-align: center;"><%=p["NOMBRE"]%></td>
      <td style="text-align: center;"><%=p["FECHA_SUBIDA"]%></td>
      <td style="text-align: center;">
      <a onclick="return bajar_practico('<%=p["ID"]%>','<%=ViewData["etapa_id"]%>');" href="#" >Bajar</a>
      <% if(p["ACTIVO"] !="1") {%>|
      <a onclick="return activar_practico('<%=p["ID"]%>','<%=ViewData["etapa_id"]%>');" href="#" >Activar</a>
      <%}%>
      </td>
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

  function activar_practico(pid, etapa_id) {
    $.ajax({
      type: "GET",
      cache: false,
      url: '<%=Url.Content("~/Viaje/activar_practico_fecha")%>?practico_id=' + pid + '&etapa_id=' + etapa_id,
      success: (function (data) {
        $('#dialogdiv3').html(data);
        $('#dialogdiv3').dialog({
          height: 148,
          width: 342,
          modal: true,
          title: 'Activar practico'
        });
      }),
      error: (function () {
        showTitlexx();
      })
    });

    return false;
  }

  function bajar_practico(pid, etapa_id) {
    $.ajax({
      type: "GET",
      cache: false,
      url: '<%=Url.Content("~/Viaje/bajar_practico_fecha")%>?practico_id='+pid+'&etapa_id='+etapa_id,
      success: (function (data) {
        $('#dialogdiv3').html(data);
        $('#dialogdiv3').dialog({
          height: 148,
          width: 342,
          modal: true,
          title: 'Bajar practico'
        });
      }),
      error: (function () {
        showTitlexx();
      })
    });

    return false;
  }

  function nuevo_practico(obj) {
    
    $.ajax({
      type: "GET",
      cache: false,
      url: $(obj).attr('href'),
      success: (function (data) {
        $('#dialogdiv3').html(data);
        $('#dialogdiv3').dialog({
          height: 181,
          width: 264,
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