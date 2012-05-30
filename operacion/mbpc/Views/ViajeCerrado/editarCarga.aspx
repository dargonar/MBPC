<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="mbpc.Controllers" %>
<% 
    Dictionary<string, string> carga = new Dictionary<string,string>();
    
    bool isNew = ViewData["isNew"] != null;
    if(!isNew)
        carga = ViewData["carga"] as Dictionary<string, string>;
%>

<div>
<form id="carga_form" action="<%= Url.Content("~/ViajeCerrado/modificarCarga") %>" method="post">
  
  <%=Html.Hidden("carga_id", isNew ? "-1" : carga["CARGA_ID"])%>

  <label>Tipo de carga</label><br />
  <%=Html.TextBox("carga", isNew ? "" : carga["NOMBRE"], new { @style = "width:350px;float:left;" }) %><br /><br />
  <%=Html.Hidden("tipocarga_id", isNew ? "" : carga["TIPOCARGA_ID"])%>

  <label>Cantidad Inicial</label><br />
  <%=Html.TextBox("cantidad_inicial", isNew ? "" : carga["CANTIDAD_INICIAL"], new { @autocomplete = "off" })%><br /><br />

  <label>Cantidad Cargada</label><br />
  <%=Html.TextBox("cantidad_entrada", isNew ? "" : carga["CANTIDAD_ENTRADA"], new { @autocomplete = "off" })%><br /><br />

  <label>Cantidad Descargada</label><br />
  <%=Html.TextBox("cantidad_salida", isNew ? "" : carga["CANTIDAD_SALIDA"], new { @autocomplete = "off" })%><br /><br />

  <label>Unidad</label><br />
  <%=Html.DropDownList("unidad_id") %><br /><br />

  <%=Html.CheckBox("en_barcaza", isNew ? false : carga["BARCAZA"] != "")%>En Barcaza<br />
  
  <% if( isNew || String.IsNullOrWhiteSpace(carga["BARCAZA"])  ) { %>
    <%=Html.TextBox("barcaza", isNew ? "" : carga["BARCAZA"], new { @disabled = "disabled" })%><br /><br />
  <% } else { %>
    <%=Html.TextBox("barcaza", isNew ? "" : carga["BARCAZA"])%><br /><br />
  <% } %>

  <%=Html.Hidden("barcaza_id", isNew ? "" : carga["ID_BUQUE"])%>

  <%=Html.CheckBox("en_transito", isNew ? false : carga["EN_TRANSITO"] != "0")%>En Transito<br /><br />

  <!-- is new? -->
  <%=Html.Hidden("etapa_id", ViewData["etapa_id"])%>
  <%=Html.Hidden("isnew"   , isNew)%>

  <br />
  <input type="submit" value="<%= isNew ? "Crear Carga" : "Modificar Carga"%>" />

</form>
</div>

<script type="text/javascript">

    $("#en_barcaza").change(function () {

        if ($("#en_barcaza").is(":checked")) {
            $("#barcaza").attr("disabled", false);
            $("#barcaza_id").val('');
            $("#barcaza").val('');
        }
        else {
            $("#barcaza").attr("disabled", "disabled");
            $("#barcaza_id").val('');
            $("#barcaza").val('');
        }
    });


    $("#barcaza").autocomplete({
        source: function (request, response) {
            $.ajax({
                type: "POST",
                url: '<%= Url.Content("~/Autocomplete/barcazas") %>',
                dataType: "json",
                data: {
                    query: request.term,
                    etapa_id: 0
                },
                success: function (data) {
                    response($.map(data, function (item) {
                        return {
                            id      : item.ID_BUQUE,
                            nombre  : item.NOMBRE,
                            bandera : item.BANDERA,
                            info    : item.INFO,
                            vf      : item.VIAJE_FONDEADA,
                            etapa   : item.ETAPA
                        }
                    }));
                }
            });
        },
        minLength: 2,
        select: function (event, ui) {

            /*
            if (ui.item.info != '0' && ui.item.etapa != '0') {
                $("#barcaza_id").val('');
                $("#barcaza").val('');
                event.preventDefault();
                return false;
            }*/

            $("#barcaza_id").val(ui.item.id);
            $("#barcaza").val(ui.item.nombre);
            return false;
        }
    }).data("autocomplete")._renderItem = function (ul, item) {

        var bg = '';
        var mr = '';

        return $("<li " + bg + "></li>")
			    .data("item.autocomplete", item)
			    .append("<a>" + item.nombre + " (" + item.bandera + ") "
                        + mr
                        + "</a>")
			    .appendTo(ul);
    };

    $("#carga_form").submit(function () {
        if ($("#tipocarga_id").val() == "") {
            alert("Debe seleccionar una carga");
            return false;
        }

        //        if ($("#tipocarga_id").val() == "") {
        //            return false;
        //        }

        $.ajax({
            type: "POST",
            cache: false,
            url: $("#carga_form").attr('action'),
            data: $("#carga_form").serialize(),
            success: (function (data) {
                var grilla = $('#dialogdiv').attr('grilla');
                alert(grilla);
                $(grilla).trigger('reloadGrid');
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

    url = '<%= Url.Content("~/Autocomplete/cargas") %>';
    $("#carga").autocomplete({
        source: function (request, response) {
            $.ajax({
                type: "POST",
                url: url,
                dataType: "json",
                data: {
                    query: request.term
                },
                success: function (data) {
                    response($.map(data, function (item) {
                        return {
                            label: item.NOMBRE,
                            value: item.NOMBRE,
                            id   : item.ID,
                            cod  : item.CODIGO,
                            unom : item.UNOMBRE,
                            uid  : item.UNIDAD_ID
                        }
                    }));
                }
            });
        },
        minLength: 2,
        select: function (event, ui) {
            $("#tipocarga_id").val(ui.item.id);
        }
    });

</script>