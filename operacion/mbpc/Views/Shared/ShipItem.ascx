<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%  Dictionary<string, string> ship = Model as Dictionary<string,string>; %>
<% var rnd = new Random(DateTime.Now.Millisecond); %>
<div class="box" id="B<%=ship["ID"]%>" style="height:30px">
  <div class="searchmeta" style="display:none">
  <%= ship["NOMBRE"] %> &nbsp; <%= ship["NRO_ISMM"] %> &nbsp; <%= ship["MATRICULA"] %> &nbsp; <%= ship["SDIST"] %> &nbsp; <%= ship["NRO_OMI"] %> 
  <div><%= ship["NOMBRE"] %></div>
  </div>

  <!-- status icons -->
  <div class="status-icons" style="background:#aaaaaa;margin-right:10px" >
    <a style="position:relative; z-index:100;" title="<%=ship["ESTADO_TEXT"]%>"><%= ship["ESTADO_BUQUE"].ToString() != "" ? ship["ESTADO_BUQUE"] : "N/A"%></a>
  </div>
  
    <% if (ViewData["showlinks"].ToString() != "0")
     { %>
            <div class="shipmenu shipmenu_<%=ship["ID"]%>">
                <div class="dropdown">
                    <button class="rerun">Acciones</button>
                    <button class="select" onclick="toggle_menu(this, '<%=ship["ID"]%>'); " id="select_<%=ship["ID"]%>" >Elija una accion</button>
                </div><!-- dropdown -->
                <div class="items" id="Item<%=ship["ID"]%>" style="z-index:5; top:0px">
                    <ul>
                      <li><a href="<%= Url.Content("~/Home/zonasAdyacentes/") + Session["punto"] + "/" + ship["ID"] + "/false"%>" onclick="hideMaskAndMenu();return dialogozonas(this,'Proximo Destino');">   Proximo Destino </a></li>
                      <li><a href="<%= Url.Content("~/Home/zonasAdyacentes/") + Session["punto"] + "/" + ship["ID"] %>" onclick="hideMaskAndMenu();fx(this);return dialogozonas(this,'Pasar Barco',true);" nextdest="<%= ship["DESTINO_ID"] %>"   class="pasarbarcolink" >                              Pasar Barco</a></li>
                      <li><a href="<%= Url.Content("~/Viaje/preguntarFecha/") + ship["ID"] + "/terminarviaje" %>" onclick="hideMaskAndMenu();return preguntarfecha(this,2);">                            Terminar Viaje</a></li>
                      <li><a href="<%= Url.Content("~/Viaje/editarEtapa/") +  ship["ID"] + "/" + ship["ETAPA_ID"] %>"    onclick="hideMaskAndMenu();return editaretapa(this);" class="editaretapalink">Editar Etapa/Viaje</a></li>
                      <li><a href="<%= Url.Content("~/Viaje/Acompanantes/") + ship["ETAPA_ID"] %>" onclick="hideMaskAndMenu();return elegiracompanante(this);return false;">Acompañantes</a></li>
                      <li><a href="<%= Url.Content("~/Viaje/preguntarFecha/") + ship["ID"] + "/separarconvoy" %>"     onclick="hideMaskAndMenu();return preguntarfecha(this,1);return false;">Separar Convoy</a></li>
                      <li><a href="<%= Url.Content("~/Carga/ver/") +  ship["ETAPA_ID"] %>"              onclick="hideMaskAndMenu();return editarcargas(this);">                              Editar Cargas </a></li>
                      <li><a href="<%= Url.Content("~/Carga/barcoenzona/") + ship["ETAPA_ID"] + "?viaje_id=" + ship["ID"] %>"          onclick="hideMaskAndMenu();return transferirbarcazas(this);">                  Transferir Barcazas </a></li>
                      <li><a href="<%= Url.Content("~/Carga/barcoenzona/") + ship["ETAPA_ID"] + "?viaje_id=" + ship["ID"] %>&carga=1"          onclick="hideMaskAndMenu();return transferirbarcazas(this);">                  Transferir Carga </a></li>
                      <li><a href="<%= Url.Content("~/Viaje/editarNotas/") + ship["ID"] %>"                                   onclick="hideMaskAndMenu();return editarnotas(this);return false;">            Editar Notas</a></li>
                      <!--li><a href="<%= Url.Content("~/Viaje/editarPbip/") + ship["ID"] %>"                                    onclick="return pbip(this);">PBIP (beta)</a></li -->
                      <li><a href="<%= Url.Content("~/Home/detallesTecnicos/") + ship["BUQUE_ID"] %>"                        onclick="hideMaskAndMenu();return detallestecnicos(this);">                    Detalles Técnicos</a></li>
                      <li><a href="<%= Url.Content("~/Viaje/histRVP/") + ship["ID"] %>?etapa_id=<%=ship["ETAPA_ID"]%>" onclick="hideMaskAndMenu();return histrvp(this);">                                                                   Historial R/V/P</a></li>
                      <li><a href="<%= Url.Content("~/Viaje/cambiarEstado/") + ship["ETAPA_ID"] %>" onclick="hideMaskAndMenu();return agregarevento(this);" class="agregareventolink">Actualizar/Cambiar Estado</a></li>
                      <li><a href="<%= Url.Content("~/Viaje/practicos/") + ship["ETAPA_ID"] %>" onclick="hideMaskAndMenu();return practico(this);" class="agregareventolink">Practico/Baqueano</a></li>
                     </ul>
                </div><!-- items -->
            </div><!-- menu -->
    <% } %>
    <% else{  %>
      <% if (ViewData["recientemente_liberado"]=="1")
         {  %>
         <div class="shipmenu shipmenu_<%=ship["ID"]%>">
                <div class="dropdown">
                    <button class="rerun">Acciones</button>
                    <button class="select" onclick="toggle_menu(this, '<%=ship["ID"]%>'); " id="Button1" >Elija una accion</button>
                </div><!-- dropdown -->
                <div class="items <%= ViewData["menu_class"] %>" id="Item<%=ship["ID"]%>" style="z-index:5; top:0px">
                    <ul>
                      <li><a href="<%= Url.Content("~/Viaje/traerBarcoRecienLiberado/") + ship["ID"] %>" onclick="hideMaskAndMenu();return traer_barco_recien_liberado(this);">   Traer Barco</a></li>
                     </ul>
                </div><!-- items -->
            </div><!-- menu -->
      <% } %>
    <% } %>

 <!--<div class="prox-dest">String.IsNullOrWhiteSpace(ship["PROXIMO"]) ? "" : "Proximo: " + ship["PROXIMO"]</div>-->

  <div class="title" style="height:13px;">
  <table style="position: relative;top: -5px;">
  <tr>
    <td>
      <label class="nombrebarco"><%= ship["NOMBRE"] %></label>
    </td>
    <td>
      <a class="info" rel="<%=Url.Content("~/Viaje/Tooltip")%>?viaje_id=<%=ship["ID"]%>&fakernd=<%=rnd.Next()%>">
        <img src="<%= Url.Content("~/img/i_icon.png") %>" style="width: 20px;height: 20px;"/>
      </a>

      <% if (!String.IsNullOrEmpty(ship["BARCAZAS_LISTADO"])) { %> 
      <span class="info" title="<table>
        <tr>
          <td>Barcazas</td>
          <td><%= ship["BARCAZAS_LISTADO"] %></td>
        </tr>
        <label><span></span></label>
        </table>">     
      <img src="<%= Url.Content("~/img/icons/ship_icon.png") %>" style="width: 20px;height: 20px;"/></span>
      <% } %> 

      <% if(false && !String.IsNullOrWhiteSpace(ship["TIENE_NOTAS"])) { %>
      <a class="info" rel="<%=Url.Content("~/Viaje/Notas")%>?viaje_id=<%=ship["ID"]%>&fakernd=<%=rnd.Next()%>">
        <img src="<%= Url.Content("~/img/n_icon.png") %>" style="width: 20px;height: 20px;"/>
      </a>
      <%}%>

    </td>

  </tr>
  </table>

  <div class="split"></div>
  </div><!-- title -->

  <div class="split"></div>
</div>