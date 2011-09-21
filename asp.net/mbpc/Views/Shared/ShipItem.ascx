﻿<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<script runat="server">
    public bool showlinks;
</script>
<%  Dictionary<string, string> ship = Model as Dictionary<string,string>; %>
<div class="box" id="B<%=ship["ID"]%>">
  <div class="searchmeta" style="display:none">
  <%= ship["NOMBRE"] %> &nbsp; <%= ship["NRO_ISMM"] %> &nbsp; <%= ship["MATRICULA"] %> &nbsp; <%= ship["SDIST"] %> &nbsp; <%= ship["NRO_OMI"] %> 
  <div><%= ship["NOMBRE"] %></div>
  </div>

  <!-- status icons -->
  <div class="status-icons">
    <div class="st-blue"></div>
    <div class="st-yellow"></div>
    <div class="st-red"></div>
  </div>
  
    <% if (ViewData["showlinks"].ToString() != "0")
     { %>
            <div class="shipmenu">
                <div class="dropdown">
                    <button class="rerun">Acciones</button>
                    <button class="select" onclick="toggle_menu('<%=ship["ID"]%>');">Elija una accion</button>
                </div><!-- dropdown -->
                <div class="items" id="Item<%=ship["ID"]%>" style="z-index:5">
                    <ul>
                      <li><a href="<%= Url.Content("~/Home/zonasAdyacentes/") + Session["zona"] + "/" + ship["ID"] + "/false"%>" onclick="return dialogozonas(this,'Proximo Destino');">   Proximo Destino </a></li>
                      <li><a href="<%= Url.Content("~/Home/zonasAdyacentes/") + Session["zona"] + "/" + ship["ID"] %>"        
                             onclick="fx(this);return dialogozonas(this,'Pasar Barco',true);" nextdest="<%= ship["DESTINO_ID"] %>"   class="pasarbarcolink" >                              Pasar Barco</a></li>
                      <li><a href="<%= Url.Content("~/Viaje/preguntarFecha/") + ship["ID"] + "/terminarviaje" %>"                                 onclick="return preguntarfecha(this);">                            Terminar Viaje</a></li>
                      <li><a href="<%= Url.Content("~/Viaje/editarEtapa/") +  ship["ID"] + "/" + ship["ETAPA_ID"] %>"    onclick="return editaretapa(this);" class="editaretapalink">Editar Etapa/Viaje</a></li>
                      <% if ( ship["ACOMPANANTE"] == "")
                         {  %>
                             <li><a href="<%= Url.Content("~/Viaje/elegirAcompanante/") + ship["ETAPA_ID"] %>" onclick="return elegiracompanante(this);return false;">                           Elegir Acompanante</a></li>
                      <% }
                         else
                         { %>
                             <li><a href="<%= Url.Content("~/Viaje/quitarAcompanante/") + ship["ETAPA_ID"] %>"                    onclick="return quitaracompanante(this);return false;">      Quitar Acompanante</a></li>
                             <li><a href="<%= Url.Content("~/Viaje/preguntarFecha/") + ship["ID"] + "/separarconvoy" %>"     onclick="return preguntarfecha(this);return false;">          Separar Convoy</a></li>
                      <% }%>
                      <li><a href="<%= Url.Content("~/Carga/editar/") +  ship["ID"] + "/" + ship["ETAPA_ID"] %>"              onclick="return editarcargas(this);">                              Editar Cargas </a></li>
                      <li><a href="<%= Url.Content("~/Carga/barcoenzona/") + ship["ID"] + "/" + ship["ETAPA_ID"] %>"          onclick="return transferirbarcazas(this);">                  Transferir Barcazas </a></li>
                      <li><a href="<%= Url.Content("~/Viaje/editarNotas/") + ship["ID"] %>"                                   onclick="return editarnotas(this);return false;">            Editar Notas</a></li>
                      <!--<li><a href="<%= Url.Content("~/Viaje/editarPbip/") + ship["ID"] %>"                                    onclick="return pbip(this);">                                Formulario PBIP </a></li>-->
                      <li><a href="<%= Url.Content("~/Home/detallesTecnicos/") + ship["BUQUE_ID"] %>"                        onclick="return detallestecnicos(this);">                    Detalles Técnicos</a></li>
                      <li><a href="<%= Url.Content("~/Viaje/histRVP/") + ship["ID"] %>" onclick="return histrvp(this);">                                                                   Historial R/V/P</a></li>
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
      <span class="info" title="     <table>
        <tr>
          <td>Practico</td>
          <td><% //ship["PRACTICO"] %></td>
        </tr>
<%--    <tr>
          <td>Latitud</td>
          <td><%= ship["LATITUD"] %></td>
        </tr>
        <tr>
          <td>Longitud</td>
          <td><%= ship["LONGITUD"] %></td>
        </tr>
--%>        <tr>
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
          <td>Cargas</td>
        </tr>
        <tr>
          <td>Estados</td>
        </tr>
      </table>     
">

<img src="<%= Url.Content("~/img/i_icon.png") %>" style="width: 20px;height: 20px;"/></span>
    </td>
  <td>
    <label class="nombreacomp"><%=  ship["ACOMPANANTE"] != "" ? "&nbsp;-&nbsp;" + ship["ACOMPANANTE"] : ""%></label>
  </td>

  </tr>
  </table>

  <div class="split"></div>
  </div><!-- title -->

  <div class="data">
    <table width="100%" cellpadding="0" cellspacing="0" style="float: left">
      <tr>
        <td class="grisado">Matricula:</td>
        <td class="dato"><%= ship["MATRICULA"]%></td>
        <td class="grisado">OMI:</td>
        <td class="dato"><%= ship["NRO_OMI"]%></td>
        <td class="grisado">Bandera:</td>
        <td class="dato"><%= ship["BANDERA"]%></td>
      </tr>
      <tr>
        <td class="grisado">Señal:</td>
        <td class="dato"><%= ship["SDIST"]%></td>
        <td class="grisado">MMSI:</td>
        <td class="dato"><%= ship["NRO_ISMM"]%></td>
        <td class="grisado">Inscripcion:</td>
        <td class="dato">N/A</td>
      </tr>
    </table>

  </div><!-- data -->

  <div class="status">
      <span class="estado" style="cursor:default" title="<%= ship["ESTADO_TEXT"] %>">Estado: <%= ship["ESTADO_BUQUE"].ToString() != "" ? ship["ESTADO_BUQUE"] : "N/A"%></span>
      <br />
      <label><span><%= ship["ETA"]%></span></label>
  </div><!-- status -->
  <div class="split"></div>
</div>