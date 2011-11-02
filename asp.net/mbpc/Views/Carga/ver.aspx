<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<div>
<table style="width: 100%">
  <tr>
    <th>Barcaza</th>
    <th>Carga</th>
    <th>Cantidad</th>
    <th>Unidad</th>
    <th>Codigo</th>
  </tr>

  <% 
  var res = ViewData["results"] as Dictionary<string, List<object>>;
  %>
  <tr id="noload" <%= (res != null && res.Count != 0) ? "style=\"display:none\"" : "" %>>
    <td colspan="6" style="text-align: center; padding: 30px;background:#dddddd"><strong>SIN CARGAS</strong></td>
  </tr>
  <%
    
    foreach (var item in res)
    {
      bool IsFirst = true;
      foreach (var tmp in item.Value)
      {
        var carga = tmp as Dictionary<string, string>;
    %>
        <tr class="navoff trcarga" id="reg<%=carga["CARGA_ID"]%>" >
          <% if (item.Key == "?no%bark?") { %>
          <td><%=carga["BARCAZA"]%></td>
          <% } else if (IsFirst) { %>
          <td rowspan="<%=item.Value.Count %>"><%=carga["BARCAZA"]%><br />
          <% if (carga["TIPOCARGA_ID"] != "412") { //LASTRE?%>
          <a href="<%= Url.Content("~/Carga/descargar_barcaza/") + ViewData["ETAPA_ID"] + "?barcaza_id=" + carga["ID_BUQUE"] %>" onclick="return descargar_barcaza(this)">Descargar</a>&nbsp;-&nbsp;
          <% } %>
          <a href="<%= Url.Content("~/Carga/zona_fondeo/") + ViewData["ETAPA_ID"] + "?barcaza_id=" + carga["ID_BUQUE"] %>" onclick="return zona_fondeo(this)">Fondear</a>
          </td>
          <% }%>
          <td colspan="<%= (carga["TIPOCARGA_ID"] != "412") ? "1" : "4" %>" ><%=carga["NOMBRE"]%></br>
          <form id="f<%=carga["CARGA_ID"]%>" action="<%= Url.Content("~/Carga/eliminar/") %>">
            <input type="hidden" name="carga_id" value="<%= carga["CARGA_ID"]%>" />
            <input type="hidden" name="etapa_id" value="<%= ViewData["ETAPA_ID"]%>" />
          </form>
          <% if (carga["TIPOCARGA_ID"] != "412") { //LASTRE?%>
          <a href="#" onclick="return eliminar_carga(<%= carga["CARGA_ID"]%>);">Quitar</a>
          <% } %>
          </td>
          <% if (carga["TIPOCARGA_ID"] != "412") { //LASTRE?%>
          <td>
            <div id="q<%=carga["CARGA_ID"]%>">
              <%=carga["CANTIDAD"]%></br>
              <span id="e<%=carga["CARGA_ID"]%>" style="display:none">
                <form action="<%= Url.Content("~/Carga/modificar/") %>" onsubmit="return modificarcarga(this,<%=carga["CARGA_ID"]%>)" >
                <div style="background:#aaaaaa">
                  <!--<a style="position:relative; right:5px; float:right; top:4px; z-index:5" href="#" onclick="cancelar_edicion_carga(<%=carga["CARGA_ID"]%>)">X</a>-->
                  <input type="hidden" name="carga_id" value="<%= carga["CARGA_ID"]%>" />
                  <input type="hidden" name="etapa_id" value="<%= ViewData["etapa_id"]%>" />
                  <table>
                    <tr>
                      <td>Carga: </td>
                      <td>
                        <input type="text" name="cantidad_entrada" autocomplete="off" value="<%=carga["CANTIDAD_ENTRADA"]%>" style="width:40px;" title="Cantidad de entrada"/><br />
                      </td>
                    </tr>
                    <tr>
                      <td>Descarga: </td>
                      <td><input type="text" name="cantidad_salida" autocomplete="off" value="<%=carga["CANTIDAD_SALIDA"]%>" style="width:40px;" title="Cantidad de salida" /> <br />
                      </td>
                    </tr>
                  </table>
                  <input type="submit" value="OK" style="width: 40px" />
                </div>
                </form>
              </span>
              <a href="#" id="modify_q_button<%=carga["CARGA_ID"]%>" onclick="return editar_carga(<%= carga["CARGA_ID"]%>);" >Modificar</a>
            </div>
            
          </td>
          <td><%=carga["UNIDAD"]%></td>
          <td><%=carga["CODIGO"]%></td>
          <% } %>
        </tr>
    <% 
    IsFirst = false;
    }
  }
  %>
</table>
<br />

<div class="btn-new-class" style="float:left">
  <a onclick="return barcazas_fondeadas(this);" href="<%= Url.Content("~/Carga/barcazas_fondeadas/" + ViewData["etapa_id"]  ) %>">Adjuntar Barcaza Fondeada</a>
</div>

<div class="btn-new-class">
  <a onclick="return nueva_carga(this);" href="<%= Url.Content("~/Carga/nueva/" + ViewData["etapa_id"]  ) %>">Agregar Carga</a>
</div>


</div>

<script type="text/javascript">

  function showTitle(data) {
    var titletag = /<title\b[^>]*>.*?<\/title>/
    alert(titletag.exec(data.responseText));
  }

  function barcazas_fondeadas(obj) {
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
          title: 'Adjuntar Barcaza'
        });
      }),
      error: showTitle
    });

    return false;
  }

  function zona_fondeo(obj) {
    $.ajax({
      type: "GET",
      cache: false,
      url: $(obj).attr('href'),
      success: (function (data) {
        $('#dialogdiv3').html(data);
        $('#dialogdiv3').dialog({
          height: 340,
          width: 300,
          modal: true,
          title: 'Fondeo de Barcaza'
        });
      }),
      error: showTitle
    });

    return false;
  }

  function descargar_barcaza(obj) {
    
    if (confirm("¿Esta seguro que desea descargar la barcaza?") == false)
      return false;

    $.ajax({
      type: "GET",
      cache: false,
      url: $(obj).attr('href'),
      success: function (data) {
        $('#dialogdiv').html(data);
      },
      error: showTitle
    });

    return false;
  }


  function editar_carga(carga_id) {
    //$("#q" + carga_id).hide();
    $("#modify_q_button" + carga_id).hide();
    var e = $("#e" + carga_id);
    e.show();
    e.find("input[type=text]").focus().select();

  }

  function cancelar_edicion_carga(carga_id) {
    //$("#q" + carga_id).show();
    $("#modify_q_button" + carga_id).show();
    $("#e" + carga_id).hide();
  }
  
  function nueva_carga(obj) {
    $.ajax({
      type: "GET",
      cache: false,
      url: $(obj).attr('href'),
      success: (function (data) {
        $('#dialogdiv3').html(data);
        $('#dialogdiv3').dialog({
          height: 380,
          width: 300,
          modal: true,
          title: 'Nueva Carga'
        });
      }),
      error: showTitle
    });

    return false;
  }

   
  function eliminar_carga(carga_id) {

    if ( confirm("¿Esta seguro que desea quitar esta carga?") == false )
      return false;

    var form = $("#f" + carga_id);

    $.ajax({
      type: "POST",
      cache: false,
      url: form.attr('action'),
      data: $(form).serialize(),
      success: function (data) {
        $('#dialogdiv').html(data);
      },
      error: showTitle
    });
    
    return false;
  }

  function modificarcarga(obj, carga_id) {
    var form = $(obj);
    $.ajax({
      type: "POST",
      cache: false,
      url: form.attr('action'),
      data: form.serialize(),
      success: function (data) {
//        $('#q' + carga_id).html(form.find('input[name=cantidad]').val());
//        cancelar_edicion_carga(carga_id);
        $('#dialogdiv').html(data);
      },
      error: showTitle
    });
    return false;
    //[<%=ViewData["refresh_viajes"] %>]
  }

  <% if( ViewData["refresh_viajes"] != null && ViewData["refresh_viajes"].ToString() == "1" ) { %>
    $.ajax({
      type: "GET",
      cache: false,
      url: '<%= Url.Content("~/Home/RefrescarColumnas") %>',
      success: function (data) {
        $("#columnas").html(data);
      },
      error: showTitle
    });
  <% } %>

</script>