<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<mbpc_admin.TBL_REPORTE>" %>
<%@ Import Namespace="mbpc_admin.Controllers" %>
<%@ Import Namespace="mbpc_admin" %>

<asp:Content ID="HeadContent1" ContentPlaceHolderID="HeadContent" runat="server">
  <script	type="text/javascript">
    
    jQuery(document).ready(
      
    );

      function addParam() {
        var count_index = jQuery('#params_table [param_index]').length;
        var next_index = count_index + 1;
        var next_param_type_selector = '<select name="TBL_REPORTE_PARAM-TIPO_DATO_' + next_index + '" id="TBL_REPORTE_PARAM-TIPO_DATO_' + next_index + '">';
        next_param_type_selector += jQuery('#TBL_REPORTE_PARAM-TIPO_DATO_1').html();
        next_param_type_selector += '</select>';

        var next_tr = '<tr param_index="' + next_index + '">';
        next_tr += '    <td><b id="TBL_REPORTE_PARAM-INDICE_' + next_index + '">#' + next_index + '</b><input name="TBL_REPORTE_PARAM-ID_' + next_index + '" type="hidden" value=""/></td>';
        next_tr += '    <td><input id="TBL_REPORTE_PARAM-NOMBRE_' + next_index + '" name="TBL_REPORTE_PARAM-NOMBRE_' + next_index + '" type="text" value="param ' + next_index + '" class="first_col"/></td>';
        next_tr += '    <td>' + next_param_type_selector+'</td>';
        next_tr += '    <td><a href="#" onclick="return removeParam(this);">Quitar</a></td>';
        next_tr += '</tr>';
        jQuery('#params_table_tbody').append(next_tr);
        return false;

      }
      // TBL_REPORTE_PARAM-ID_
      // TBL_REPORTE_PARAM-NOMBRE_
      // TBL_REPORTE_PARAM-TIPO_DATO_
      // param_index
      function removeParam(sender) {
        var param_index       = parseInt(jQuery(sender).parent().parent().attr('param_index'));
        var current_index     = param_index + 1;
        var param_to_remove   = jQuery('#params_table [param_index=' + param_index + ']');
        var param_to_reorder = param_to_remove.next();
        param_to_remove.remove();
        while (param_to_reorder && param_to_reorder.length>0) {
          var this_index = current_index-1;
          param_to_reorder.attr('param_index', this_index);
          param_to_reorder.find('#TBL_REPORTE_PARAM-INDICE_' + current_index).html('#' + this_index);
          param_to_reorder.find('#TBL_REPORTE_PARAM-INDICE_' + current_index).attr('id', 'TBL_REPORTE_PARAM-INDICE_' + this_index);
          param_to_reorder.find('#TBL_REPORTE_PARAM-ID_' + current_index).attr('id', 'TBL_REPORTE_PARAM-ID_' + this_index).attr('name', 'TBL_REPORTE_PARAM-ID_' + this_index);
          param_to_reorder.find('#TBL_REPORTE_PARAM-NOMBRE_' + current_index).attr('id', 'TBL_REPORTE_PARAM-NOMBRE_' + this_index).attr('name', 'TBL_REPORTE_PARAM-NOMBRE_' + this_index);
          param_to_reorder.find('#TBL_REPORTE_PARAM-TIPO_DATO_' + current_index).attr('id', 'TBL_REPORTE_PARAM-TIPO_DATO_' + this_index).attr('name', 'TBL_REPORTE_PARAM-TIPO_DATO_' + this_index);

          current_index = current_index + 1;
          param_to_reorder = param_to_reorder.next();
        }
        return false;
        
      }
      function isNonEmptyString(obj_id) {
        var val = jQuery('#'+obj_id).val();
        return (typeof val == 'string' && val!='');

      }
      function checkReporte() {
        var form_is_filled = isNonEmptyString('NOMBRE') && isNonEmptyString('CONSULTA_SQL');
        if (form_is_filled)
          return true;
        alert("Por favor indique nombre y sentencia SQL.");
        return false;
      }
  </script>
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	<%= ViewData["nombre"]%> 
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <% if (ViewData.ContainsKey("flash"))
       {   %>
         <div class="status <%=ViewData["flash_type"]%>">
        	<p class="closestatus"><a href="#" onclick="$(this).parent().parent().remove()" title="Cerrar">x</a></p>
        	<p><img src="/img/icons/icon_<%=ViewData["flash_type"]%>.png" alt="Success" /><%= ViewData["flash"] %></p>
        </div>
        <span class="smltxt red"><%: Html.ValidationMessage("ID")%></span>
    <%} %>


    <h2><%= ViewData["titulo"]%></h2> <br/>

   <div class="contentbox">

    <% using (Html.BeginForm("Create", "Reporte", FormMethod.Post, new { @onsubmit = "return checkReporte();" }))
       {%>
        <%: Html.ValidationSummary(true)%>

            <%= Html.Hidden("ID", Model.ID != 0 ? String.Format("{0:0.}", Model.ID) : "0")%>
            <p>
                <%: Html.Label("TITULO")%>
                <%: Html.TextBox("NOMBRE", String.Format("{0:0.}", Model.NOMBRE), new { @class = "inputbox" })%>
                <br />
                <span class="smltxt red"><%: Html.ValidationMessage("NOMBRE")%></span>
            </p>

            <p>
                <%: Html.Label("CATEGORIA")%>
                <%= Html.DropDownList("CATEGORIA_ID", (SelectList)ViewData["combocat"])%>
                <br />
                <span class="smltxt red"><%: Html.ValidationMessage("CATEGORIA_ID")%></span>
            </p>
            
            

            <p>
                <%: Html.Label("DESCRIPCION")%>
                <%: Html.TextArea("DESCRIPCION", String.Format("{0:F}", Model.DESCRIPCION), 2, 5, new { @class = "inputbox wider" })%>
                <br />
                <span class="smltxt red">
                <%: Html.ValidationMessage("DESCRIPCION")%></span>
            </p>
            
            <p>
                <%: Html.Label("CONSULTA SQL")%>
                <%: Html.TextArea("CONSULTA_SQL", String.Format("{0:F}", Model.CONSULTA_SQL), 5, 5, new { @class = "inputbox wider higher" })%>
                <br />
                <span class="smltxt red">
                <%: Html.ValidationMessage("CONSULTA_SQL")%></span>
            </p>
            <div id="params_table_container" style="border:1px solid #E0E0E0; border-radius: 3px 3px 3px 3px; padding:4px;">
              <p>
                <label>PARÁMETROS DE CONSULTA</label> 
              </p>
              <table id="params_table"> 
                <tr>
                  <th>Indice</th>
                  <th>Nombre</th>
                  <th>Tipo de dato</th>
                  <th>Acciones</th>
                </tr>
                <tbody id="params_table_tbody">
                  <% var index = "1";%> 
                  <% foreach(TBL_REPORTE_PARAM param in Model.TBL_REPORTE_PARAM) {%> 
                    <tr param_index="<%= index %>">
                      <td><b id="TBL_REPORTE_PARAM-INDICE_<%=index%>">#<%= index %></b><input name="TBL_REPORTE_PARAM-ID_<%=index%>" type="hidden" value="<%= param.ID %>"/></td>
                      <td><input name="TBL_REPORTE_PARAM-NOMBRE_<%=index%>" type="text" value="<%= param.NOMBRE %>" class="first_col"/></td>
                      <td>
                        <%= Html.DropDownList("TBL_REPORTE_PARAM-TIPO_DATO_" + index.ToString(), ReporteController.CreateDataTypeCombo(param))%>
                      </td>
                      <td><a href="#" onclick="return removeParam(this,'<%= index %>' );">Quitar</a></td>
                    </tr>
                  <% index = (Convert.ToInt32(index)+1).ToString();%> 
                  <% } %> 
                  
                </tbody>
              </table>
              <p>
                <a href="#" onclick="return addParam();">Agregar Parámetro</a>
              </p>
                
            </div>
            <br />
            <p>
                <input type="submit" value="Guardar reporte" title="Guardar reporte" class="btn" />&nbsp;&nbsp;&nbsp;<%: Html.ActionLink("Volver a la lista", "List")%>
            </p>

    <% } %>

    <div>
        
    </div>


</div>

</asp:Content>


