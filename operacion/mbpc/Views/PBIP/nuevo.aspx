<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="mbpc.Controllers" %>

<%  Dictionary<string, string> pbip = null;
    if(ViewData["pbip"]!=null)
      pbip = ViewData["pbip"] as Dictionary<string, string>; %>

<% 
    List<object> pbip_params = null;
    if(ViewData["pbip_params"]!=null)
       pbip_params = ViewData["pbip_params"] as List<object>; 
%>

<div id="formcontainer"> 
<form id="Pbip_Form" action="<%= Url.Content("~/PBIP/guardar") %>" method="POST">
  <input type="hidden" name="id" value="<%= ViewData["id"] %>"/><br />

  <fieldset>
    <legend>1. Pormenores del buque y dato de contacto</legend>
    
    <div class="pbip_container left">
      <label>1.1 Nro OMI</label><br />
      <input autocomplete="off"  type="text" id="nro_imo" name="nro_imo"  value="<%= (pbip!=null)?pbip["NRO_IMO"]:"" %>"/><br />
    </div>
    
    <div class="pbip_container right">
      <label>1.2 Nombre del Buque</label><br />
      <input autocomplete="off" type="text" id="buque_nombre" name="buque_nombre"  value="<%= (pbip!=null)? pbip["BUQUE_NOMBRE"] : ""%>"/><br />
    </div>
    <div style="clear:both"></div>

    <div class="pbip_container left">
      <label>1.3 Puerto de Matricula</label><br />
      <input autocomplete="off" type="text" id="puertodematricula" name="puertodematricula" value="<%= (pbip!=null)?pbip["PUERTODEMATRICULA"]:"" %>" /><br />
    </div>
    
    <div class="pbip_container right">
      <label>1.4 Bandera</label><br />
      <input autocomplete="off" type="text" id="bandera" name="bandera" value="<%= (pbip!=null)?pbip["BANDERA"]:"" %>"  /><br />
    </div>
    <div style="clear:both"></div>

    <div class="pbip_container left">
      <label>1.5 Tipo de Buque</label><br />
      <input autocomplete="off" type="text" id="tipo_buque" name="tipo_buque" value="<%= (pbip!=null)?pbip["TIPO_BUQUE"]:"" %>"  /><br />
    </div>
    
    <div class="pbip_container right">
      <label>1.6 Distintivo de llamada</label><br />
      <input autocomplete="off" type="text" id="distintivo_llamada" name="distintivo_llamada" value="<%= (pbip!=null)?pbip["DISTINTIVO_LLAMADA"]:"" %>"  /><br />
    </div>
    <div style="clear:both"></div>

    <div class="pbip_container left">
      <label>1.7 Numero inmarsat</label><br />
      <input autocomplete="off" type="text" id="nroinmarsat" name="nroinmarsat" value="<%= (pbip!=null)?pbip["NROINMARSAT"]:"" %>"/><br />
    </div>
    
    <div class="pbip_container right">
      <label>1.8 Arqueo Bruto</label><br />
      <input autocomplete="off" type="text" id="arqueobruto" name="arqueobruto" value="<%=(pbip!=null)? pbip["ARQUEOBRUTO"]:"" %>" /><br />
    </div>
    <div style="clear:both"></div>

    <div class="pbip_container left">
      <label>1.9 Nombre de la compañía</label><br />
      <input autocomplete="off" type="text" id="compania" name="compania" value="<%= (pbip!=null)?pbip["COMPANIA"]:"" %>" /><br />
    </div>
    
    <div class="pbip_container right">
      <label>1.9.1 Número ident. de la compañía (si posee)</label><br />
      <input autocomplete="off" type="text" id="nro_identif_compania" name="nro_identif_compania" value="<%= (pbip!=null)?pbip["NRO_IDENTIF_COMPANIA"]:"" %>" /><br />
    </div>
    <div style="clear:both"></div>

    <div class="pbip_container left">
      <label>1.10 Nombre y datos de contacto del OCMP</label><br />
      <input autocomplete="off" type="text" id="contacto" name="contactoOCPM" value="<%= (pbip!=null)?pbip["CONTACTOOCPM"]:"" %>" placeholder="nombre y apellido, tel/fax, email." /><br />
    </div>
    
  </fieldset>
  <br />
  <fieldset>
    <legend>2. Información del puerto y la instalación portuaria</legend>

    <div class="pbip_container left">
      <label>2.1a Puerto de LLegada</label><br />
      <input autocomplete="off" type="text" id="puerto_llegada" name="puerto_llegada" value="<%= (pbip!=null)?pbip["PUERTO_LLEGADA"]:"" %>"  /><br />
    </div>
    
    <div class="pbip_container right">
      <label>2.1b Instalación portuaria</label><br />
      <input autocomplete="off" type="text" id="instalacion_portuaria" name="instalacion_portuaria" value="<%= (pbip!=null)?pbip["INSTALACION_PORTUARIA"]:"" %>"  /><br />
    </div>
    <div style="clear:both"></div>
    
    <div class="pbip_container left">
      <label>2.2 Eta</label><br />
      <input autocomplete="off" class="format_date" type="text" id="eta" name="eta" value="<%= (pbip!=null)?pbip["ETA"]:"" %>"  /><br />
    </div>
    
    <div class="pbip_container right">
      <label>2.3 Objetivo principal de la escala</label><br />
      <input autocomplete="off" type="text" id="objetivo" name="objetivo" value="<%= (pbip!=null)?pbip["OBJETIVO"]:"" %>"/><br />
    </div>
    <div style="clear:both"></div>

  </fieldset>
  <br />
  
  <fieldset>
    <legend>3. Información exigida por la regla XI-2/9.2.1 del convenio SOLAS</legend>

    <div class="pbip_container left">
      <label>3.1 Posee CIPB</label><br />
      <select name="cipb_estado" id="cipb_estado" autocomplete="off">
        <% int cipb_estado = (pbip != null) ? (Convert.ToInt32(pbip["CIPB_ESTADO"])) : 0;  %>>
        <option value="0" <%= cipb_estado==0?"SELECTED":"" %>">No posee</option>
        <option value="1" <%= cipb_estado==1?"SELECTED":"" %>">Válido</option>
        <option value="2" <%= cipb_estado==2?"SELECTED":"" %>">Aprobado</option>
      </select>
    </div>
    
    <div class="pbip_container right">
      <label>3.1.1 CIPB expedido por</label><br />
      <input autocomplete="off" type="text" id="cipb_expedido_por" name="cipb_expedido_por" value="<%= (pbip!=null)?pbip["CIPB_EXPEDIDO_POR"]:"" %>" /><br />
      Expira el:<input autocomplete="off" type="text" id="cipb_expiracion" name="cipb_expiracion" value="<%= (pbip!=null)?pbip["CIPB_EXPIRACION"]:"" %>" /><br />
    </div>
    <div style="clear:both"></div>
    
    <div class="pbip_container left">
      <label>3.1.2 Si no pose CIPB (3.1) explicar motivos</label><br />
      <input autocomplete="off" type="text" id="cipb_motivo_incumplimiento" name="cipb_motivo_incumplimiento" value="<%= (pbip!=null)?pbip["CIPB_MOTIVO_INCUMPLIMIENTO"]:"" %>"/><br />
    </div>
    
    <div class="pbip_container right">
      <label>3.1.2.1 ¿Hay a bordo un plan de protección aprobado?</label><br />
      <select name="proteccion_plan_aprobado" autocomplete="off">
        <% int plan_aprobado = (pbip != null) ? (Convert.ToInt32(pbip["PROTECCION_PLAN_APROBADO"])) : (0);  %>>
        <option value="0" <%= plan_aprobado==0?"SELECTED":"" %>">NO</option>
        <option value="1" <%= plan_aprobado==1?"SELECTED":"" %>">SI</option>
      </select>
      <br />
    </div>
    <div style="clear:both"></div>

    <div class="pbip_container left">
      <label>3.2 Nivel de protección actual</label><br />
      <select name="proteccion_nivel_actual" autocomplete="off">
        <% int proteccion_nivel_actual = (pbip != null) ? (Convert.ToInt32(pbip["PROTECCION_NIVEL_ACTUAL"])) : (0);  %>>
        <option value="0" <%= proteccion_nivel_actual==0?"SELECTED":"" %>">NO</option>
        <option value="1" <%= proteccion_nivel_actual==1?"SELECTED":"" %>">Nivel 1</option>
        <option value="2" <%= proteccion_nivel_actual==2?"SELECTED":"" %>">Nivel 2</option>
        <option value="3" <%= proteccion_nivel_actual==3?"SELECTED":"" %>">Nivel 3</option>
      </select>
    </div>

    <div class="pbip_container right">
      <label>3.2.1 Ubicación del buque al efectuar la notificación</label><br />
      <input autocomplete="off" type="text" id="posicion_latlon" name="posicion_latlon" value="<%= (pbip != null) ?PBIPController.maskLatLon(pbip["LATITUD_NOTIF"], pbip["LONGITUD_NOTIF"]):"" %>" /><br />
      <label class="desc">Formato: 9000S18000W </label>
      <br />
    </div>
    <div style="clear:both"></div>

  </fieldset>

  <br />
  <fieldset>
    <legend>3.3 Ultimas 10 escalas en orden cronológico empezando de la más reciente</legend>

    <div class="pbip_container full left">
      <div class="tabla_content-body-wrapper"> 
        <div class="tabla_content-body"> 
          <div class="tabla_td tabla_td_index tabla_td_th">#</div> 
          <div class="tabla_td tabla_td_desde tabla_td_th"> 
            Desde
          </div> 
          <div class="tabla_td tabla_td_hasta tabla_td_th"> 
            Hasta
          </div> 
          <div class="tabla_td tabla_td_descripcion tabla_td_th"> 
            Puerto, País, instalación portuaria y LOCODE
          </div> 
          <div class="tabla_td tabla_td_nivel_proteccion tabla_td_th"> 
            Nivel de Protección
          </div> 
          <div class="tabla_td tabla_td_medida_proteccion tabla_td_th"> 
            ¿Aceptó otras medidas de protecció especiales o adicionales no contempladas en el plan de protección?
          </div> 
        </div>
        <% for (int index = 1; index <= 10; index++)
           { 
             Dictionary<string, string> dict = null;
             if(pbip_params!=null)
                dict = pbip_params[index-1] as Dictionary<string, string>;
             %>
           
        <div class="tabla_content-body"> 
          <div class="tabla_td tabla_td_index">
            <%=index %> 
            <input type="hidden" name="indice_<%=index %>" value="<%=index %>"/>
          </div> 
          <div class="tabla_td tabla_td_desde"> 
            <input autocomplete="off" type="text" class="format_date" name="escalas_fecha_desde_<%=index %>" value="<%= (pbip_params != null) ? dict["FECHA_DESDE"]:"" %>" />
          </div> 
          <div class="tabla_td tabla_td_hasta"> 
            <input autocomplete="off" type="text" class="format_date" name="escalas_fecha_hasta_<%=index %>" value="<%= (pbip_params != null) ? dict["FECHA_HASTA"]:"" %>" />
          </div> 
          <div class="tabla_td tabla_td_descripcion"> 
            <input autocomplete="off" type="text" name="escalas_descripcion_<%=index %>" value="<%= (pbip_params != null) ? dict["DESCRIPCION"]:"" %>" />
          </div> 
          <div class="tabla_td tabla_td_nivel_proteccion"> 
            <input autocomplete="off" type="text" class="integer_only" name="escalas_nivel_proteccion_<%=index %>" value="<%= (pbip_params != null) ? dict["NIVEL_PROTECCION"]:"" %>" />
          </div> 
          <div class="tabla_td tabla_td_medida_proteccion"> 
            <% int medidas_adic = (pbip_params != null) ? (Convert.ToInt32(dict["ESCALAS_MEDIDAS_ADIC"])) : (0);  %>
            <select name="escalas_medidas_adic_<%=index %>">
              <option value="0" <%= medidas_adic==0?"SELECTED":"" %>">NO</option>
              <option value="1" <%= medidas_adic==1?"SELECTED":"" %>">SI</option>
            </select>&nbsp;&nbsp;
            <input autocomplete="off" type="text" name="escalas_medidas_adic_desc_<%=index %>" value="<%= (pbip_params != null) ? dict["ESCALAS_MEDIDAS_ADIC_DESC"]:"" %>" />
          </div> 
        </div>
        <% } %>
      </div> 
    </div>
    
    <div style="clear:both"></div>
    <br/>
    <br/>
    <legend>3.4 Actividades buque a buque en orden cronológico empezando por la más reciente en el período indicado en 3.3</legend>

    <div class="pbip_container full left">
      <div class="tabla_content-body-wrapper"> 
        <div class="tabla_content-body"> 
          <div class="tabla_td tabla_td_index tabla_td_th">#</div> 
          <div class="tabla_td tabla_td_desde tabla_td_th"> 
            Desde
          </div> 
          <div class="tabla_td tabla_td_hasta tabla_td_th"> 
            Hasta
          </div> 
          <div class="tabla_td tabla_td_descripcion tabla_td_th"> 
            Ubicación o Latitud y Longitud
          </div> 
          <div class="tabla_td tabla_td_nivel_proteccion tabla_td_th"> 
            Nivel de Protección
          </div> 
          <div class="tabla_td tabla_td_medida_proteccion tabla_td_th"> 
            Actividad buque a buque.
          </div> 
        </div>
        <% for (int index = 1; index <= 10; index++)
           {
             Dictionary<string, string> dict = null;
             if (pbip_params != null)
               dict = pbip_params[index - 1 + 10] as Dictionary<string, string>;
             %>
        <div class="tabla_content-body"> 
          <div class="tabla_td tabla_td_index">
            <%=index %>
            <input type="hidden" name="indice_<%=index %>" value="<%=index %>"/>
          </div> 
          <div class="tabla_td tabla_td_desde"> 
            <input autocomplete="off" type="text" class="format_date" name="actividades_fecha_desde_<%=index %>" value="<%= (pbip_params != null) ? dict["FECHA_DESDE"]:"" %>" />
          </div> 
          <div class="tabla_td tabla_td_hasta"> 
            <input autocomplete="off" type="text" class="format_date" name="actividades_fecha_hasta_<%=index %>" value="<%= (pbip_params != null) ? dict["FECHA_HASTA"]:"" %>" />
          </div> 
          <div class="tabla_td tabla_td_descripcion"> 
            <input autocomplete="off" type="text" name="actividades_descripcion_<%=index %>" value="<%= (pbip_params != null) ? dict["DESCRIPCION"]:"" %>" />
          </div> 
          <div class="tabla_td tabla_td_nivel_proteccion"> 
            <input autocomplete="off" type="text" class="integer_only" name="actividades_nivel_proteccion_<%=index %>" value="<%= (pbip_params != null) ? dict["NIVEL_PROTECCION"]:"" %>" />
          </div> 
          <div class="tabla_td tabla_td_medida_proteccion wider"> 
            <input autocomplete="off" type="text" name="actividades_actividad_bab_<%=index %>" value="<%= (pbip_params != null) ? dict["ACTIVIDAD_BAB"]:"" %>" />
          </div> 
        </div>
        <% } %>
      </div> 
    </div>

    <div style="clear:both"></div>
    <br/>
    <br/>

    <div class="pbip_container left">
      <label>3.4.1 ¿Se mantuvieron los procedimientos de protección del plan en la interfaz buque a buque?</label><br />
      <% int plan_proteccion_mant_bab = pbip!= null ? (Convert.ToInt32(pbip["PLAN_PROTECCION_MANT_BAB"])) : (0);  %>
      <select name="plan_proteccion_mant_bab">
        <option value="0" <%= plan_proteccion_mant_bab==0?"SELECTED":"" %>">NO</option>
        <option value="1" <%= plan_proteccion_mant_bab==1?"SELECTED":"" %>">SI</option>
      </select>
    </div>
    <div class="pbip_container right">
      <label>DetallAR</label><br /><br />
      <input autocomplete="off" type="text" id="plan_proteccion_mant_bab_desc" name="plan_proteccion_mant_bab_desc" value="<%= (pbip!= null) ?pbip["PLAN_PROTECCION_MANT_BAB_DESC"] : ""%>" /><br />
    </div>
    <div style="clear:both"></div>

    <div class="pbip_container left">
      <label>3.5 Descripción general de la carga a bordo</label><br />
      <input autocomplete="off" type="text" id="carga_desc_gral" name="carga_desc_gral" value="<%= (pbip!= null) ?pbip["CARGA_DESC_GRAL"]:"" %>" /><br />
    </div>
    

    <div class="pbip_container right">
      <label>3.5.1 ¿Transporta sustancias peligrosas?</label><br />
      <% int carga_sust_peligrosas = (pbip != null) ? (Convert.ToInt32(pbip["CARGA_SUST_PELIGROSAS"])) : (0);  %>
      <select name="carga_sust_peligrosas">
        <option value="0" <%= carga_sust_peligrosas==0?"SELECTED":"" %>">NO</option>
        <option value="1" <%= carga_sust_peligrosas==1?"SELECTED":"" %>">SI</option>
      </select>
    </div>
    <div style="clear:both"></div>
    
    <div class="pbip_container left">
    <label></label><br />
    </div>
    <div class="pbip_container right">
      <label>Detallar sust. peligrosas si transporta</label><br />
      <input autocomplete="off" type="text" id="carga_sust_peligrosas_desc" name="carga_sust_peligrosas_desc" value="<%= (pbip!= null) ? pbip["CARGA_SUST_PELIGROSAS_DESC"]:"" %>" /><br />
    </div>
    <div style="clear:both"></div>

    <div class="pbip_container left">
      <label>3.6 ¿Adjunta lista de tripulantes?</label><br />
      <% int lista_tripulantes = (pbip != null) ? (Convert.ToInt32(pbip["LISTA_TRIPULANTES"])) : (0);  %>
      <select name="lista_tripulantes">
        <option value="0" <%= lista_tripulantes==0?"SELECTED":"" %>">NO</option>
        <option value="1" <%= lista_tripulantes==1?"SELECTED":"" %>">SI</option>
      </select>
    </div>
    
    
    <div class="pbip_container right">
      <label>3.6 ¿Adjunta lista de pasajeros?</label><br />
      <% int lista_pasajeros = (pbip != null) ? (Convert.ToInt32(pbip["LISTA_PASAJEROS"])) : (0);  %>
      <select name="lista_pasajeros">
        <option value="0" <%= lista_pasajeros==0?"SELECTED":"" %>">NO</option>
        <option value="1" <%= lista_pasajeros==1?"SELECTED":"" %>">SI</option>
      </select>
    </div>
    <div style="clear:both"></div>

  </fieldset>
  <br />

  <fieldset>
    <legend>4. Información Adicional sobre protección</legend>

    <div class="pbip_container left">
      <label>4.1 ¿Hay alguna cuestión relacionada con la protección que desee notificar?</label><br />
      <% int prot_notifica_cuestion = (pbip != null) ? (Convert.ToInt32(pbip["PROT_NOTIFICA_CUESTION"])) : (0);  %>
      <select name="prot_notifica_cuestion">
        <option value="0" <%= lista_pasajeros==0?"SELECTED":"" %>">NO</option>
        <option value="1" <%= lista_pasajeros==1?"SELECTED":"" %>">SI</option>
      </select>
    </div>
    
    <div class="pbip_container right">
      <label></label><br />
    </div>
    <div style="clear:both"></div>

    <div class="pbip_container left">
      <label>4.1a Polizones</label><br />
      <% int prot_notifica_polizon = (pbip != null) ? (Convert.ToInt32(pbip["PROT_NOTIFICA_POLIZON"])) : (0);  %>
      <select name="prot_notifica_polizon">
        <option value="0" <%= prot_notifica_polizon==0?"SELECTED":"" %>">NO</option>
        <option value="1" <%= prot_notifica_polizon==1?"SELECTED":"" %>">SI</option>
      </select>
    </div>
    
    <div class="pbip_container right">
      <label>4.1b Detallar polizones</label><br />
      <input autocomplete="off" type="text" id="prot_notifica_polizon_desc" name="prot_notifica_polizon_desc" value="<%=(pbip!= null) ? pbip["PROT_NOTIFICA_POLIZON_DESC"] :"" %>"  /><br />
    </div>
    <div style="clear:both"></div>

    <div class="pbip_container left">
      <label>4.1c Personas rescatadas</label><br />
      <% int prot_notifica_rescate = (pbip != null) ? (Convert.ToInt32(pbip["PROT_NOTIFICA_RESCATE"])) : (0);  %>
      <select name="prot_notifica_rescate">
        <option value="0" <%= prot_notifica_rescate==0?"SELECTED":"" %>">NO</option>
        <option value="1" <%= prot_notifica_rescate==1?"SELECTED":"" %>">SI</option>
      </select>
    </div>
    
    <div class="pbip_container right">
      <label>4.1d Detallar personas rescatadas</label><br />
      <input autocomplete="off" type="text" id="prot_notifica_rescate_desc" name="prot_notifica_rescate_desc" value="<%= (pbip!= null) ?pbip["PROT_NOTIFICA_RESCATE_DESC"]:"" %>"  /><br />
    </div>
    <div style="clear:both"></div>

    <div class="pbip_container left">
      <label>4.1e Otra cuestión de protección</label><br />
      <% int prot_notifica_otra = (pbip != null) ? (Convert.ToInt32(pbip["PROT_NOTIFICA_OTRA"])) : (0);  %>
      <select name="prot_notifica_otra">
        <option value="0" <%= prot_notifica_otra==0?"SELECTED":"" %>">NO</option>
        <option value="1" <%= prot_notifica_otra==1?"SELECTED":"" %>">SI</option>
      </select>
    </div>
    
    <div class="pbip_container right">
      <label>4.1f Detallar otra cuestión de protección</label><br />
      <input autocomplete="off" type="text" id="prot_notifica_otra_desc" name="prot_notifica_otra_desc" value="<%= (pbip!= null) ?pbip["PROT_NOTIFICA_OTRA_DESC"] :"" %>"  /><br />
    </div>
    <div style="clear:both"></div>
  </fieldset>
  <br />

  <fieldset>
    <legend>5. Agente del buque en el puerto previsto de llegada</legend>

    <div class="pbip_container left">
      <label>Nombre</label><br />
      <input autocomplete="off" type="text" id="agente_pto_llegada_nombre" name="agente_pto_llegada_nombre" value="<%= (pbip!= null) ?pbip["AGENTE_PTO_LLEGADA_NOMBRE"]:"" %>" /><br />      
    </div>
    
    <div class="pbip_container right">
      <label>Teléfono / Fax</label><br />
      <input autocomplete="off" type="text" id="agente_pto_llegada_tel" name="agente_pto_llegada_tel" value="<%= (pbip!= null) ?pbip["AGENTE_PTO_LLEGADA_TEL"] :"" %>" /><br />      
    </div>
    <div style="clear:both"></div>

    <div class="pbip_container left">
      <label>Email</label><br />
      <input autocomplete="off" type="text" id="agente_pto_llegada_mail" name="agente_pto_llegada_mail" value="<%= (pbip!= null) ?pbip["AGENTE_PTO_LLEGADA_MAIL"]:"" %>" /><br />      
    </div>

    <div class="pbip_container right">
      <label></label><br />
    </div>
    <div style="clear:both"></div>
  </fieldset>
  
  <br />

  <fieldset>
    <legend>6. Identificación de la persona que facilita la información</legend>

    <div class="pbip_container left">
      <label>Nombre</label><br />
      <input autocomplete="off" type="text" id="facilitador_nombre" name="facilitador_nombre" value="<%= (pbip!= null) ?pbip["FACILITADOR_NOMBRE"] :""%>" /><br />      
    </div>
    
    <div class="pbip_container right">
      <label>Título o cargo</label><br />
      <input autocomplete="off" type="text" id="facilitador_titulo_cargo" name="facilitador_titulo_cargo" value="<%= (pbip!= null) ?pbip["FACILITADOR_TITULO_CARGO"] :""%>" /><br />      
    </div>
    <div style="clear:both"></div>

    <div class="pbip_container left">
      <label>Lugar</label><br />
      <input autocomplete="off" type="text" id="facilitador_lugar" name="facilitador_lugar" value="<%= (pbip!= null) ?pbip["FACILITADOR_LUGAR"]:"" %>" /><br />      
    </div>

    <div class="pbip_container right">
      <label>Fecha</label><br />
      <input autocomplete="off" type="text" class="format_date" id="facilitador_fecha" name="facilitador_fecha" value="<%= (pbip!= null) ?pbip["FACILITADOR_FECHA"]:"" %>" /><br />      
    </div>
    <div style="clear:both"></div>
  </fieldset>

  <br />
  
  <% if (String.IsNullOrEmpty(Convert.ToString(ViewData["id"])))
     { %>
    <input type="submit" class="botonsubmit" value="Crear nuevo PBIP" />
  <% }else{ %>
    <input type="submit" class="botonsubmit" value="Modificar PBIP" />
  <% } %>
</form>
</div>

<script type="text/javascript">

  $(document).ready(
    function () {
      $("#posicion_latlon").mask("9999S99999W");
      $('#cipb_expiracion').mask("99-99-99");
      $('.format_date').mask("99-99-99");
      $(".integer_only").numeric({ decimal: false, negative: false });
    }
  );
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