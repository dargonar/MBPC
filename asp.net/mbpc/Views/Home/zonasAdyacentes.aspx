<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
 <%
      var pasar = bool.Parse(ViewData["pasar"].ToString());
      var url = string.Empty;
      if (pasar)
          url = Url.Content("~/Viaje/pasarBarco/");
      else
          url = Url.Content("~/Viaje/indicarProximo/"); 
 %>

  <form id="zonas" action="<%= url %>" method="post">
      <label>Elija Punto de control</label><br />
      <select id="listadezonas" style="width: 270px;">

      <% foreach (Dictionary<string, string> zona in (ViewData["zonas"] as List<object>))
          {
            string nombre = string.Empty;

            if (zona["KM"] == "0")
                nombre = zona["CANAL"];
            else
                nombre = zona["CANAL"] + " - " + zona["UNIDAD"] + " " + zona["KM"];
             
             %>
             <option value="<%= zona["ID"] %>"><%=nombre%></option>
       <% } 
      %>
      </select>

      <% if (pasar)  { %>
          <br/>
          <label>Fecha</label><br />
          <input autocomplete="off" type="text" id="llegada" name="fecha" style="width:270px" value="<%= ViewData["fecha"] %>"/><br />
          <label class="desc">Formato: dd-mm-aa hh:mm</label><br />
          <br/>
          <label>ETA</label><br />
          <input autocomplete="off" type="text" id="eta" name="eta" style="width:270px" /><br />
          <label class="desc">Formato: dd-mm-aa hh:mm</label><br />
      <% } %> 

       <input type="hidden" id="viajeid" name="viaje_id" value="<%= ViewData["viaje"] %>"/>
       <input type="hidden" id="id2" name="id2" value=""/>
       <input type="submit" class="botonsubmit" style="margin-left: 163px" value="<%= pasar ? "Pasar Barco" : "Indicar Proximo" %>" />

</form>

  <script type="text/javascript">

  <% if (pasar)  { %>

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


        $('#listadezonas').bind('keydown', 'return', function () {
            $('#zonas').submit();
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
