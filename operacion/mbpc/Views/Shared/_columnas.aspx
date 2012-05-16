﻿<%@ Page Title="" Language="C#"  Inherits="System.Web.Mvc.ViewPage" %>

<%Html.RenderPartial("_tabs_main");%>

<!-- LEFT COL -->
<div class="col">

	<div class="split-bar"></div>
	<h1>Viajes próximos a ingresar</h1>
    <!-- top -->
    <div class="container">
      <% var listEntrantes = (ViewData["barcos_entrantes"] as List<object>); %>
      <% if (ViewData["barcos_entrantes"]!=null){ %>
        <% if (listEntrantes.Find( c => ((Dictionary<string, string>)c)["SENTIDO"] != "1" ) == null )
           { %>

            <div class="box">
			        <div class="empty">
				        <p class="box-S">Sin barcos en zona</p>
              </div>
            </div><!-- box -->
        <% } %>

          <% foreach (Dictionary<string, string> barco in listEntrantes)
             {
               if (barco["SENTIDO"] != "1")
               {
                 ViewData["showlinks"] = 0;
                 ViewData["recientemente_liberado"] = "0";
                 //var yyy = new { @name = barco["NOMBRE"], @ominum = barco["NRO_OMI"], @mmsi = barco["NRO_ISMM"], @status = "", @eta = barco["ETA"] };
                 Html.RenderPartial("ShipItem", barco);
               }
               //else continue;
             }
          %>
          <% }else{ %>
              <div class="box">
			        <div class="empty">
				        <p class="box-S">
                  <a href="<%= Url.Content("~/Viaje/traerBarcosEnLimites/")%>" onclick="return traer_barcos_perimetrales(this);" title="Ver viajes">Ver viajes</a>
                </p>
              </div>
            </div><!-- box -->
          <% } %>
    </div>
	<div class="split-bar"></div>
	<h1>Viaje en mi zona de responsabilidad <span id="sbox" style="display:none"><input id="searchbox" type="text" /><div class="searchlabel"> Buscar Barco:&nbsp;</div></span></h1>
	  
    <!-- center -->
    <div id="leftcol" class="container" style="height: 351px;">
        
    <% var listEnZona = (ViewData["barcos_en_zona"] as List<object>); %>
    <% var barcazas = (ViewData["barcazas_en_zona"] as List<object>); %>
    <% if (listEnZona.Find(c => ((Dictionary<string, string>)c)["SENTIDO"] != "1") == null && barcazas.Count == 0)
       { %>

         <div class="box-large">
			<div class="empty">
				<p class="box-L">Sin barcos en zona</p>
            </div>
        </div><!-- box -->
    <% } %>
      <% foreach (Dictionary<string, string> barcaza in barcazas)
         {
           Html.RenderPartial("BarcazaItem", barcaza);
         }
      %>

      <% foreach (Dictionary<string, string> barco in listEnZona)
         {
           ViewData["showlinks"] = 1;
           if (barco["SENTIDO"] != "1")
           {
             //var yyy = new { @name = barco["NOMBRE"], @ominum = barco["NRO_OMI"], @mmsi = barco["NRO_ISMM"], @status = "", @eta = barco["ETA"] };
             Html.RenderPartial("ShipItem", barco);
           }
           //else continue;
         }
      %>
    </div>
	<div class="split-bar"></div>
	<h1>Viajes liberados de mi zona de responsabilidad</h1>
    <!-- bottom -->
    <div class="container">
        
    <% var listSalientes = (ViewData["barcos_salientes"] as List<object>); %>
    <% if (ViewData["barcos_salientes"]!=null){ %>
      <% if (listSalientes.Find( c => ((Dictionary<string, string>)c)["SENTIDO"] != "1" ) == null )
         { %>

          <div class="box">
			  <div class="empty">
				  <p class="box-S">Sin barcos en zona</p>
              </div>
          </div><!-- box -->
      <% } %>

        <% 
          ViewData["showlinks"] = 0;
          ViewData["recientemente_liberado"] = "1";
          ViewData["menu_class"] = "bottom_"; 
         
          foreach (Dictionary<string, string> barco in listSalientes)
           {
             if (barco["SENTIDO"] != "1")
             {
               //var yyy = new { @name = barco["NOMBRE"], @ominum = barco["NRO_OMI"], @mmsi = barco["NRO_ISMM"], @status = "", @eta = barco["ETA"] };
               Html.RenderPartial("ShipItem", barco);
             }
             //else continue;
           }
           // reseteo la clase del menu.
           ViewData["menu_class"] = "";
        %>
      <% }else{ %>
            <div class="box">
			      <div class="empty">
				      <p class="box-S">
                <a href="<%= Url.Content("~/Viaje/traerBarcosEnLimites/")%>" onclick="return traer_barcos_perimetrales(this);" title="Ver viajes">Ver viajes</a>
              </p>
            </div>
          </div><!-- box -->
      <% } %>
    </div>
</div>

<!-- RIGHT COL -->
<div class="col">
	<div class="split-bar"></div>
	<h1>Viajes liberados de mi zona de responsabilidad</h1>

    <!-- top -->
    <div class="container">
    <% if (ViewData["barcos_salientes"]!=null){ %>
      <% if (listSalientes.Find( c => ((Dictionary<string, string>)c)["SENTIDO"] != "0" ) == null )
         { %>

          <div class="box">
			  <div class="empty">
				  <p class="box-S">Sin barcos en zona</p>
              </div>
          </div><!-- box -->
      <% } %>

        <% foreach (Dictionary<string, string> barco in listSalientes)
           {
             ViewData["showlinks"] = 0;
             ViewData["recientemente_liberado"] = "1";
             ViewData["menu_class"] = ""; 
             if (barco["SENTIDO"] != "0")
             {
               //var yyy = new { @name = barco["NOMBRE"], @ominum = barco["NRO_OMI"], @mmsi = barco["NRO_ISMM"], @status = "", @eta = barco["ETA"] };
               Html.RenderPartial("ShipItem", barco);
             }
             //else continue;
           }
        %>
       <% }else{ %>
            <div class="box">
			      <div class="empty">
				      <p class="box-S">
                <a href="<%= Url.Content("~/Viaje/traerBarcosEnLimites/")%>" onclick="return traer_barcos_perimetrales(this);" title="Ver viajes">Ver viajes</a>
              </p>
            </div>
          </div><!-- box -->
      <% } %>
    </div>
	<div class="split-bar"></div>
	<h1>Viaje en mi zona de responsabilidad</h1>
  	<!-- center -->
    <div  id="rightcol" class="container" style="height: 351px;" >
        <% //if ((ViewData["barcos_en_zona"] as List<object>).Count == 0)
       if (listEnZona.Find( c => ((Dictionary<string, string>)c)["SENTIDO"] != "0" ) == null )
       { %>
       <div class="box-large">
    			<div class="empty">
				<p class="box-L">Sin barcos en zona</p>
            </div>
        </div><!-- box -->
    <% } %>

      <% foreach (Dictionary<string, string> barco in listEnZona)
         {
           ViewData["showlinks"] = 1;
            if (barco["SENTIDO"] != "0")
            {
              //var xxx = new { @name = barco["NOMBRE"], @ominum = barco["NRO_OMI"], @mmsi = barco["NRO_ISMM"], @status = "", @eta = barco["ETA"] };
              Html.RenderPartial("ShipItem", barco);
            }
         }
      %>
    </div>
	<div class="split-bar"></div>
	<h1>Viajes próximos a ingresar</h1>
  	
    <div class="container" >
      <% if (ViewData["barcos_salientes"]!=null){ %>
        <% if (listEntrantes.Find( c => ((Dictionary<string, string>)c)["SENTIDO"] != "0" ) == null )
         { %>
            <div class="box">
			        <div class="empty">
				        <p class="box-S">Sin barcos en zona</p>
              </div>
            </div><!-- box -->
        <% } %>

          <% foreach (Dictionary<string, string> barco in listEntrantes)
          {
             ViewData["showlinks"] = 0;
            if (barco["SENTIDO"] != "0")
             {
               ViewData["recientemente_liberado"] = "0";
               //var yyy = new { @name = barco["NOMBRE"], @ominum = barco["NRO_OMI"], @mmsi = barco["NRO_ISMM"], @status = "", @eta = barco["ETA"] };
               Html.RenderPartial("ShipItem", barco);
             }
             //else continue;
           }
          %>
       <% }else{ %>
            <div class="box">
			      <div class="empty">
				      <p class="box-S">
                <a href="<%= Url.Content("~/Viaje/traerBarcosEnLimites/")%>" onclick="return traer_barcos_perimetrales(this);" title="Ver viajes">Ver viajes</a>
              </p>
            </div>
          </div><!-- box -->
      <% } %>
    </div>
</div>

<select size="6" id="searchlist"></select>


<% if (ViewData.ContainsKey("AutoEditarEtapa")) { 
   Dictionary<string,string> AutoEditarEtapa = (ViewData["AutoEditarEtapa"] as List<object>)[0] as Dictionary<string, string>;
   Response.Write("<script type=\"text/javascript\">$('#B" + AutoEditarEtapa["VIAJE_ID"] + " .editaretapalink').click()</script>");
} %>

<script type="text/javascript">

  //$("#ecuatrigrama").html('Costera <%=ViewData["cuatrigrama"]%>');
  function traer_barco_recien_liberado(obj) { 
    $("#fullscreen").css("display", "block");
    $.ajax({
      type: "GET",
      cache: false,
      url: $(obj).attr('href'),
      success: (function (data) {
        if (data == "nop")
          $('#list').trigger('reloadGrid');
        else
          $("#columnas").html(data);

        $("#fullscreen").css("display", "none");
      }),
      error: (function (data) {
        $("#fullscreen").css("display", "none");
        var titletag = /<title\b[^>]*>.*?<\/title>/
        alert(titletag.exec(data.responseText));
      })
    });
    return false;
  }

  buildButtons();
  $('.info').hoverbox();
  $('.estados').hoverbox();

  $('#searchbox').bind('keydown', 'return', function () {
      return false;
  });

  $('#searchbox').bind('keydown', 'down', function () {
      $('#searchlist').focus();
  });

  $('#searchbox').bind('keydown', 'esc', function () {
      $('#sbox').hide();
      $('#searchlist').hide();
  });

  $('#searchlist').bind('keydown', 'return', function () {
      $('.box').removeClass('selectedbox');
      $('#' + $(this).val()).addClass('selectedbox')
      $('#' + $(this).val()).parent().scrollTo($('#' + $(this).val()))
      $(this).css('display', 'none');
      $('#sbox').hide();
  });

  $('#searchbox').keyup(function () {

      $('#searchlist').html('');
      var position = $(this).offset();

      if ($(this).val() == '') {
          $('#searchlist').html('');
          $('#searchlist').css('display', 'none');
          return false;
      }

      $('#leftcol, #rightcol').find('.searchmeta').each(function () {
          if ($(this).html().toUpperCase().indexOf($('#searchbox').val().toUpperCase()) != -1) {
              $('#searchlist').append('<option value="' + $(this).parents('.box').attr('id') + '">' + $(this).children().first().html() + '</option>')
          }
      });

      $('#searchlist').css('top', position.top + 18);
      $('#searchlist').css('left', position.left);
      $('#searchlist').css('display', 'block');

      return false;
  });
</script>