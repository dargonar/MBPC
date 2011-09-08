<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<div>
<table style="width: 100%">

  <tr>
    <th>Carga</th>
    <th>Cantidad</th>
    <th>Unidad</th>
    <th>Codigo</th>
    <th>Barcaza</th>
    <th>Acciones</th>
  </tr>

<% 
  
  List<object> results = ViewData["results"] as List<object>;
  if (results != null)
  {
    var cargas = (ViewData["results"] as List<object>);
    if (cargas.Count == 0)
    {
      %>
      <tr><td colspan="3"><strong>No hay resultados</strong></td></tr>
      <%
    }
    else
    {
      foreach (Dictionary<string, string> result in cargas)
      { 
      %>
          <tr class="navoff"  >
      <%  foreach (string key in result.Keys)
            {
              if (key == "CARGA_ID") continue;
              if (key == "CANTIDAD") 
              {
                Response.Write("<td id=\"C" + result["CARGA_ID"] + "\" >" +  result[key]+ "</td>");
              }
              else
              {
                Response.Write("<td>" + result[key] + "</td>");
              }
            } 
      %>
            <td>
              <input type="button" value="&nbsp;&nbsp;Editar&nbsp;&nbsp;" onclick="editarestacarga(<%= result["CARGA_ID"]%>)" />
              <form id="eliminarcargaform" action="">
                <input type="button" value="Eliminar" onclick="if( confirmdelete() ) eliminarcarga($(this).parent(), '<%= Url.Content("~/Carga/eliminar/") %>'); return false;"/>
                <input type="hidden" id="carga_idx" name="carga_id" value="<%= result["CARGA_ID"]%>" />
                <input type="hidden" id="viaje_idx" name="viaje_id" value="<%= ViewData["viaje_id"] %>" />
                <input type="hidden" name="etapa_id" value="<%= ViewData["etapa_id"] %>" />
                <input type="hidden" name="id2" value="<%= ViewData["etapa_id"] %>" />
              </form>
            </td>
            </tr>
      <% 
      }
    }
  }
%>
</table>

<div id="controleseditarcantidad" style="display: none;width: 40px">
  <form id="editarcantidadform" action="">
    <input type="text" name="cantidad" autocomplete="off" style="width: 50px;float:left;" /> 
    <input type="hidden" name="carga_id" />
    <input type="hidden" name="viaje_id" value="<%= ViewData["viaje_id"] %>" />
    <input type="hidden" name="etapa_id" value="<%= ViewData["etapa_id"] %>" />
    <input type="button" value="OK" onclick="modificarcarga($(this).parent(), '<%= Url.Content("~/Carga/modificar/") %>'); return false;" style="width: 40px" />
  </form>



</div>

<br />

<input type="button" value="Agregar" onclick="agregarcarga('<%= Url.Content("~/Carga/agregar/" + ViewData["viaje_id"] + "/" + ViewData["etapa_id"]  ) %>');" style="right: 25px;float:right;position:relative;" />

</div>

<script type="text/javascript">

  function editarestacarga(id) {
    var cantidad = $("#C" + id).html()

    $("#C" + id).html($("#controleseditarcantidad").html());
    $("#C" + id + "> form").attr("id", "C" + id + "form");
    $("#C" + id + "form > input:first").val(cantidad);
    $("#C" + id + "form > input:eq(1)").val(id);
  }

  //$('#eliminarcargaform').submit(function () {


  function eliminarcarga(formelement, url) {

      $.ajax({
        type: "POST",
        cache: false,
        url: url,
        data: $(formelement).serialize(),
        success: (function (data) {
          $('#dialogdiv').html(data);
        }),
        error: (function (data) {
          var titletag = /<title\b[^>]*>.*?<\/title>/
          alert(titletag.exec(data.responseText));
        })
      });
      return false;

    };



    function confirmdelete() {
      return confirm("¿Esta seguro que desea eliminar esta carga?");
    }


  function modificarcarga(formelement, url) {


    $.ajax({
      type: "POST",
      cache: false,
      url: url,
      data: $(formelement).serialize(),
      success: (function (data) {
        $('#dialogdiv').html(data);
      }),
      error: (function (data) {
        var titletag = /<title\b[^>]*>.*?<\/title>/
        alert(titletag.exec(data.responseText));
      })
    });
    return false;
  }


  $('#editarcantidadform').submit(function () {

    alert($("#editarcantidadtext").val())

    if ($("#editarcantidadtext").val() == null) {
      alert("Debe ingresar un numero");
      return false;
    }

    $.ajax({
      type: "POST",
      cache: false,
      url: $(this).attr("action"),
      data: $(this).serialize(),
      success: (function (data) {
        $('#dialogdiv').html(data);
      }),
      error: (function (data) {
        var titletag = /<title\b[^>]*>.*?<\/title>/
        alert(titletag.exec(data.responseText));
      })
    });
    return false;
  });

</script>