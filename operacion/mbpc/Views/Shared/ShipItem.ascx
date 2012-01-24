<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%  Dictionary<string, string> ship = Model as Dictionary<string,string>; %>
<div class="box" id="B<%=ship["ID"]%>" style="height:30px">
  <div class="searchmeta" style="display:none">
  <%= ship["NOMBRE"] %> &nbsp; <%= ship["NRO_ISMM"] %> &nbsp; <%= ship["MATRICULA"] %> &nbsp; <%= ship["SDIST"] %> &nbsp; <%= ship["NRO_OMI"] %> 
  <div><%= ship["NOMBRE"] %></div>
  </div>

  <!-- status icons -->
  <div class="status-icons" style="background:#aaaaaa;margin-right:10px" >
    <%= ship["ESTADO_BUQUE"].ToString() != "" ? ship["ESTADO_BUQUE"] : "N/A"%>
  </div>
  
    <% if (ViewData["showlinks"].ToString() != "0")
     { %>
            <div class="shipmenu">
                <div class="dropdown">
                    <button class="rerun">Acciones</button>
                    <button class="select" onclick="toggle_menu(this, '<%=ship["ID"]%>'); " id="select_<%=ship["ID"]%>" >Elija una accion</button>
                </div><!-- dropdown -->
                <div class="items" id="Item<%=ship["ID"]%>" style="z-index:5; top:0px">
                    <ul>
                      <li><a href="<%= Url.Content("~/Home/zonasAdyacentes/") + Session["zona"] + "/" + ship["ID"] + "/false"%>" onclick="return dialogozonas(this,'Proximo Destino');">   Proximo Destino </a></li>
                      <li><a href="<%= Url.Content("~/Home/zonasAdyacentes/") + Session["zona"] + "/" + ship["ID"] %>"        
                             onclick="fx(this);return dialogozonas(this,'Pasar Barco',true);" nextdest="<%= ship["DESTINO_ID"] %>"   class="pasarbarcolink" >                              Pasar Barco</a></li>
                      <li><a href="<%= Url.Content("~/Viaje/preguntarFecha/") + ship["ID"] + "/terminarviaje" %>"                                 onclick="return preguntarfecha(this,2);">                            Terminar Viaje</a></li>
                      <li><a href="<%= Url.Content("~/Viaje/editarEtapa/") +  ship["ID"] + "/" + ship["ETAPA_ID"] %>"    onclick="return editaretapa(this);" class="editaretapalink">Editar Etapa/Viaje</a></li>
                      <li><a href="<%= Url.Content("~/Viaje/Acompanantes/") + ship["ETAPA_ID"] %>" onclick="return elegiracompanante(this);return false;">Acompañantes</a></li>
                      <% if (ship["ACOMPANANTE"] != "" || ship["ACOMPANANTE2"] != "" || ship["ACOMPANANTE3"] != "" || ship["ACOMPANANTE4"] != "")
                         {  %>
                             <li><a href="<%= Url.Content("~/Viaje/preguntarFecha/") + ship["ID"] + "/separarconvoy" %>"     onclick="return preguntarfecha(this,1);return false;">Separar Convoy</a></li>
                      <% } %>
                      <li><a href="<%= Url.Content("~/Carga/ver/") +  ship["ETAPA_ID"] %>"              onclick="return editarcargas(this);">                              Editar Cargas </a></li>
                      <li><a href="<%= Url.Content("~/Carga/barcoenzona/") + ship["ETAPA_ID"] + "?viaje_id=" + ship["ID"] %>"          onclick="return transferirbarcazas(this);">                  Transferir Barcazas </a></li>
                      <li><a href="<%= Url.Content("~/Carga/barcoenzona/") + ship["ETAPA_ID"] + "?viaje_id=" + ship["ID"] %>&carga=1"          onclick="return transferirbarcazas(this);">                  Transferir Carga </a></li>
                      <li><a href="<%= Url.Content("~/Viaje/editarNotas/") + ship["ID"] %>"                                   onclick="return editarnotas(this);return false;">            Editar Notas</a></li>
                      <li><a href="<%= Url.Content("~/Viaje/editarPbip/") + ship["ID"] %>"                                    onclick="return pbip(this);">PBIP (beta)</a></li>
                      <li><a href="<%= Url.Content("~/Home/detallesTecnicos/") + ship["BUQUE_ID"] %>"                        onclick="return detallestecnicos(this);">                    Detalles Técnicos</a></li>
                      <li><a href="<%= Url.Content("~/Viaje/histRVP/") + ship["ID"] %>?etapa_id=<%=ship["ETAPA_ID"]%>" onclick="return histrvp(this);">                                                                   Historial R/V/P</a></li>
                      <li><a href="<%= Url.Content("~/Viaje/cambiarEstado/") + ship["ETAPA_ID"] %>" onclick="return agregarevento(this);" class="agregareventolink">Cambiar Estado</a></li>
                     </ul>
                </div><!-- items -->
            </div><!-- menu -->
    <% } %>

<div class="prox-dest">Prox. Dest.: <%= ship["DESTINO_ID"] == "" ? "N/D" : ship["CUATRIGRAMA"] + " - Km" + ship["KM"]%></div>

  <div class="title" style="height:13px;">
  <table style="position: relative;top: -5px;">
  <tr>
    <td>
      <label class="nombrebarco"><%= ship["NOMBRE"] %></label>
    </td>
    <td>
      <span class="info" title="<table>
        <!--<tr>
          <td>Practico</td>
          <td><% //ship["PRACTICO"] %></td>
        </tr>-->
        <tr>
          <td>Latitud</td>
          <td><%= ship["LATITUD"] %></td>
        </tr>
        <tr>
          <td>Longitud</td>
          <td><%= ship["LONGITUD"] %></td>
        </tr>
        <tr>
          <td>Km</td>
          <td><%= ship["KM"] %></td>
        </tr>
        <tr>
          <td>Calado Maximo del Buque</td>
          <td><%= ship["CALADO_MAXIMO"] %></td>
        </tr>
        <tr>
          <td>Calado informado por el capitan</td>
          <td><%= ship["CALADO_INFORMADO"] %></td>
        </tr>
        <tr>
          <td>Matricula</td>
          <td><%= ship["MATRICULA"]%></td>
        </tr>
        <tr>
          <td>OMI:</td>
          <td><%= ship["NRO_OMI"]%></td>
        </tr>
        <tr>
          <td>Bandera:</td>
          <td><%= ship["BANDERA"]%></td>
        </tr>
        <tr>
          <td>Señal:</td>
          <td><%= ship["SDIST"]%></td>
        </tr>
        <tr>
          <td>MMSI:</td>
          <td><%= ship["NRO_ISMM"]%></td>
        </tr>
        <tr>
          <td>Inscripcion:</td>
          <td>N/A</td>
        </tr>
        <tr>
          <td>Estado:</td>
          <td><%= ship["ESTADO_BUQUE"].ToString() != "" ? ship["ESTADO_BUQUE"] : "N/A"%></td>
        </tr>
        <tr>
          <td>ETA:</td>
          <td><%= ship["ETA"]%></td>
        </tr>

      <label><span></span></label>

      </table>">     

      <img src="<%= Url.Content("~/img/i_icon.png") %>" style="width: 20px;height: 20px;"/></span>
    </td>
  <td>
    <%if( ship["ACOMPANANTE"] != "") {%> <label class="nombreacomp"><%=ship["ACOMPANANTE"]%></label> <% } %>
    <%if( ship["ACOMPANANTE2"] != "") {%><label class="nombreacomp">&nbsp-&nbsp<%=ship["ACOMPANANTE2"]%></label> <% } %>
    <%if( ship["ACOMPANANTE3"] != "") {%><label class="nombreacomp">&nbsp-&nbsp<%=ship["ACOMPANANTE3"]%></label> <% } %>
    <%if( ship["ACOMPANANTE4"] != "") {%><label class="nombreacomp">&nbsp-&nbsp<%=ship["ACOMPANANTE4"]%></label> <% } %>
  </td>

  </tr>
  </table>

  <div class="split"></div>
  </div><!-- title -->

  <div class="split"></div>
</div>