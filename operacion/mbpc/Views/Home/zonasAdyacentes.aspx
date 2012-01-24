<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="mbpc.Models" %>
 <%
      var pasar = bool.Parse(ViewData["pasar"].ToString());
      var url = string.Empty;
      if (pasar)
          url = Url.Content("~/Viaje/pasarBarco/");
      else
          url = Url.Content("~/Viaje/indicarProximo/"); 
 %>

  <form id="zonas" action="<%= url %>" method="post">
      <label id='listadezonas_title'>Elija Punto de control</label><br />
      <select id="listadezonas" style="width: 270px;">

      <% string eta_destino = ""; %>
      <% bool eta_destino_setted = false; %>
      <% foreach (Dictionary<string, string> zona in (ViewData["zonas"] as List<object>))
          {
            string nombre = string.Empty;

            if (zona["KM"] == "0")
                nombre = zona["CANAL"] + " - " + zona["UNIDAD"];
            else
                nombre = zona["CANAL"] + " - " + zona["UNIDAD"] + " " + zona["KM"];
            if (!eta_destino_setted && ViewData["DESTINO_ID"].ToString() == zona["ID"].ToString())
            {
                eta_destino_setted = true;
                eta_destino = nombre.Split('-')[1].Trim();
            }
             %>
             <option value="<%= zona["ID"] %>"  <%= ViewData["DESTINO_ID"].ToString() == zona["ID"].ToString() ? "selected=\"selected\"" : "" %> ><%=nombre%></option>
       <% } 
      %>
      </select>

      <% if (pasar)  { %>
          <br/>
          <label>Fecha</label><br />
          <input autocomplete="off" type="text" id="llegada" name="fecha" style="width:270px" value="<%= ViewData["fecha"] %>"/><br />
          <label class="desc">Formato: dd-mm-aa hh:mm</label><br />
          <br/>
          <label id="eta_next_port">ETA - <%= eta_destino%></label><br />
          <input autocomplete="off" type="text" id="eta" name="eta" style="width:270px" /><br />
          <label class="desc">Formato: dd-mm-aa hh:mm</label><br />

          <label>Velocidad</label><br />
          <input autocomplete="off" type="text" class="editaretapatext" id="velocidad" name="velocidad" value=""/><br />

          <label>Rumbo</label><br />
          <input autocomplete="off" type="text" class="editaretapatext" id="rumbo" name="rumbo" value=""/><br />

      <% } %> 

       <input type="hidden" id="viajeid" name="viaje_id" value="<%= ViewData["viaje"] %>"/>
       <input type="hidden" id="id2" name="id2" value=""/>
       <input type="submit" class="botonsubmit" style="margin-left: 163px" value="<%= pasar ? "Pasar Barco" : "Indicar Proximo" %>" />

</form>

  <script type="text/javascript">
    $("#listadezonas").combobox();
    $("#listadezonas").next()
      .css('height','23px')
      .css('margin-right','5px')
      .css('padding-left','4px')
      .css('width','268px');

  
  
  $("#velocidad").mask("99.9");
  $("#rumbo").mask("999");

  <% if (pasar)  {
    var svel = Hlp.toString( Hlp.toDecimal((string)ViewData["VELOCIDAD"]), "{0:00.0}" );
    var srum = Hlp.toString( Hlp.toDecimal((string)ViewData["RUMBO"]), "{0:000}" );
  %>

    $("#velocidad").val("<%= svel %>");
    $("#rumbo").val("<%= srum %>");

        function validarfechas() {

            if ($("#eta").val() != "") {
              if (isDate($("#eta").val())) {
                  alert("La fecha de ETA es invalida");
                  $('.botonsubmit').removeAttr('disabled');
                  return true;
              }
            }

            if ($("#llegada").val() == "") {
                alert("Debe indicar fecha de llegada");
                $('.botonsubmit').removeAttr('disabled');
                return true;
            }
            if (isDate($("#llegada").val())) {
                alert("La fecha de llegada es invalida");
                $('.botonsubmit').removeAttr('disabled');
                return true;
            }

            return false;
        }


        $("#llegada,#eta").mask("99-99-99 99:99");

    
  <% } %> 
        
        //alert('binding change event');
        $('#listadezonas').bind( "autocompleteselect", function(event, data) {
            if(data!=null)
            {
                var text_arr = data.split('-');
                var text = jQuery.trim(text_arr.length>1?text_arr[1]:text_arr[0]);
                $('#eta_next_port').html('ETA - '+ text);    
                return false;
            }
            $('#eta_next_port').html('ETA');
            return false;
        });
        
        $('#listadezonas').bind('keydown', 'return', function () {
            $('#zonas').submit();
            //alert('changed2');
            return false;
        });

        $('#zonas').submit(function () {
            $('.botonsubmit').attr('disabled','disabled');


            $('#id2').val($('#listadezonas').val());

            if ($('#eta').length != 0)
                if (validarfechas()) return false;
            
              $.ajax({
                  type: "POST",
                  cache: false,
                  url: $(this).attr('action'),
                  data: $(this).serialize(),
                  success: (function (data) {
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
