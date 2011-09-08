<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<% List<object> pbiplist = ViewData["pbip"] as List<object>; %>
<% Dictionary<string, string> pbip = pbiplist[0] as Dictionary<string, string>; %>
<div id="formcontainer"> 
<form id="editarPbipForm" action="<%= Url.Content("~/Viaje/modificarPBIP") %>">
  <input type="hidden" name="viaje" value="<%= ViewData["viaje_id"] %>"/><br />

  <fieldset>
  <legend>1.0 Pormenores del buque y dato de contacto</legend>

  <label>1.1 Nro OMI</label><br />
  <input autocomplete="off"  type="text" style="width:270px" id="nroomi" name="nro_omi" disabled="disabled" value="<%= pbip["NRO_OMI"] %>"/><br />

  <label>1.2 Nombre del Buque</label><br />
  <input autocomplete="off" type="text" style="width:270px" id="nombredelbuque" name="nombredelbuque" disabled="disabled" value="<%= pbip["BUQUE"] %>"/><br />

  <label>1.3 Puerto de Matricula</label><br />
  <input autocomplete="off" type="text" id="puertodematricula" style="width:270px" name="puertodematricula" value="<%= pbip["PUERTODEMATRICULA"] %>" /><br />

  <label>1.4 Bandera</label><br />
  <input autocomplete="off" type="text" id="bandera" style="width:270px" value="<%= pbip["BANDERA_ID"] %>" disabled="disabled" /><br />

  <label>1.5 Tipo de Buque</label><br />
  <input autocomplete="off" type="text" id="tipodebuqe" style="width:270px" value="<%= pbip["TIPO_BUQUE"] %>" disabled="disabled" /><br />

  <label>1.6 Distintivo de llamada</label><br />
  <input autocomplete="off" type="text" id="distintivodellamada" style="width:270px" value="<%= pbip["SDIST"] %>" disabled="disabled" /><br />

  <label>1.7 Numero inmarsat</label><br />
  <input autocomplete="off" type="text" style="width:270px" id="nroinmarsat" name="numeroinmarsat" value="<%= pbip["NROINMARSAT"] %>"/><br />

  <label>1.8 Arqueo Bruto</label><br />
  <input autocomplete="off" type="text" style="width:270px" id="arqueobruto" name="arqueobruto" value="<%= pbip["ARQUEOBRUTO"] %>" /><br />

  <label>1.9 Nombre de la compania</label><br />
  <input autocomplete="off" type="text" style="width:270px" id="compania" name="compania" value="<%= pbip["COMPANIA"] %>" /><br />
  
  <label>1.10 Nombre y datos de contacto permante del ocmp</label><br />
  <input autocomplete="off" type="text" style="width:270px" id="contacto" name="contactoOCPM" value="<%= pbip["CONTACTOOCPM"] %>"  /><br />
  </fieldset>
  <br />
  <fieldset>
  <legend>2.0 Informacion del puerto y la instalación portuaria</legend>

  <label>2.1a Puerto de LLegada</label><br />
  <input autocomplete="off" type="text" id="Text1" style="width:270px" value="<%= pbip["PUERTO"] %>" disabled="disabled" /><br />

  <label>2.1b Instalación Portuaria</label><br />
  <input autocomplete="off" type="text" id="Text2" style="width:270px" value="<%= pbip["INSTPORT"] %>" disabled="disabled" /><br />

  <label>2.2 Eta</label><br />
  <input autocomplete="off" type="text" style="width:270px" id="Text3" value="<%= pbip["ETA"] %>" disabled="disabled" /><br />

  <label>2.3 Objetivo principal de la escala</label><br />
  <input autocomplete="off" type="text" style="width:270px" id="Text4" name="objetivo" value="<%= pbip["OBJETIVO"] %>"/><br />
  
  </fieldset>
  <input type="submit" class="botonsubmit" value="Modificar PBIP" />

</form>
</div>

<script type="text/javascript">


  $("#editarPbipForm").submit(function () {


      $('.botonsubmit').attr('disabled', 'disabled');
    /*if ($("#buquetext").val() == "") {
    alert("Debe seleccionar un buque");
    return false;
    }*/

    //alert($(this).serialize());
    //return false;


    $.ajax({
      type: "POST",
      cache: false,
      url: $(this).attr('action'),
      data: $(this).serialize(),
      success: (function (data) {
        //$("#columnas").html(data);
        //$('#dialogdiv').dialog('close');
        //$('#selector').dialog('close');
        $('#dialogdiv').dialog('close');
        $('#dialogdiv3').html(data);
        $('#dialogdiv3').dialog({
          height: 200,
          width: 300,
          modal: true,
          title: 'Ok'
        });
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