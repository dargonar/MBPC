<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<mbpc_admin.TBL_CARGAETAPA>" %>
<%@ import Namespace="Helpers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	<%= ViewData["titulo"] %> Carga
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <% if (ViewData.ContainsKey("flash"))
       {   %>
         <div class="status <%=ViewData["flash_type"]%>">
        	<p class="closestatus"><a href="#" onclick="$(this).parent().parent().remove()" title="Cerrar">x</a></p>
        	<p><img src="/img/icons/icon_<%=ViewData["flash_type"]%>.png" alt="Success" /><%= ViewData["flash"] %></p>
          </div>
    <%} %>


    <h2><%= ViewData["titulo"] %> Carga</h2><br />

    <div class="contentbox">
    <% using (Html.BeginForm("Create","Carga")) {%>
        
            <!-- ID/ETAPA_ID -->
            <%= Html.Hidden("ID", Model.ID != 0 ? String.Format("{0:0.}", Model.ID) : "")%>
            <%= Html.Hidden("ETAPA_ID", ViewData["etapa_id"])%>

            <p>
            <%= Html.Label("CARGA") %>
            <%= Html.DropDownList("TIPOCARGA_ID", (SelectList)ViewData["TIPOCARGA_ID"]) %>                <br />
                <span class="smltxt red">
            <%= Html.ValidationMessageFor(model => model.TIPOCARGA_ID) %> </span>
            </p>

            <p>
            <%= Html.Label("CANTIDAD INICIAL") %>
            <%= Html.TextBox("CANTIDAD_INICIAL", String.Format("{0:0.}", Model.CANTIDAD_INICIAL), new { @class = "inputbox" })%><br />
                <span class="smltxt red">
            <%= Html.ValidationMessageFor(model => model.CANTIDAD) %></span>
            </p>
            
            <p>
            <%= Html.Label("CANTIDAD CARGADA") %>
            <%= Html.TextBox("CANTIDAD_ENTRADA", String.Format("{0:0.}", Model.CANTIDAD_ENTRADA), new { @class = "inputbox" })%><br />
                <span class="smltxt red">
            <%= Html.ValidationMessageFor(model => model.CANTIDAD_ENTRADA)%></span>
            </p>

            <p>
            <%= Html.Label("CANTIDAD DESCARGADA") %>
            <%= Html.TextBox("CANTIDAD_SALIDA", String.Format("{0:0.}", Model.CANTIDAD_SALIDA), new { @class = "inputbox" })%><br />
                <span class="smltxt red">
            <%= Html.ValidationMessageFor(model => model.CANTIDAD_SALIDA)%></span>
            </p>

            <p>
            <%= Html.Label("EN TRANSITO") %>
            <%= Html.CheckBox("EN_TRANSITO", Model.EN_TRANSITO != 0) %><br />
              <span class="smltxt red">
            <%= Html.ValidationMessageFor(model => model.EN_TRANSITO)%></span>
            </p>

            <p>
            <%= Html.Label("UNIDAD") %>
            <%= Html.DropDownList("UNIDAD_ID") %>                <br />
                <span class="smltxt red">
            <%= Html.ValidationMessageFor(model => model.UNIDAD_ID) %></span>
            </p>
            
            
            <%//<p> Html.Label("BARCAZA") %>
            <%// Html.DropDownList("BUQUE_ID") %>
            <%//</p> Html.ValidationMessageFor(model => model.BUQUE_ID) %>
            
            <input type="hidden" name="alone" value="<%=ViewData["alone"]%>"

            <p>
                <input type="submit" value="<%= ViewData["titulo"] %>" class="btn" />
            </p>
    <% } %>

    <div>
        <%: Html.ActionLink("Volver a la lista de cargas", "List", new { alone = ViewData["alone"],  id = decimal.Parse(ViewData["etapa_id"].ToString())})%>
    </div>


    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#TIPOCARGA_ID').val('<%=ViewData["TIPOCARGA_ID_SELECTED"]%>');
        });
    </script>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

