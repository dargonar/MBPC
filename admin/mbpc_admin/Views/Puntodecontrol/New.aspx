<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<mbpc_admin.TBL_PUNTODECONTROL>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	<%= ViewData["titulo"] %> Punto de Control
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2><%= ViewData["titulo"] %> Punto de Control</h2><br />

    <% if (ViewData.ContainsKey("flash"))
       {   %>
         <div class="status <%=ViewData["flash_type"]%>">
        	<p class="closestatus"><a href="#" onclick="$(this).parent().parent().remove()" title="Cerrar">x</a></p>
        	<p><img src="/img/icons/icon_<%=ViewData["flash_type"]%>.png" alt="Success" /><%= ViewData["flash"] %></p>
          </div>
    <%} %>

       <div class="contentbox">
    <% using (Html.BeginForm("Create", "Puntodecontrol")) {%>
        <%: Html.ValidationSummary(true) %>

          
            <%= Html.Hidden("ID", Model.ID != 0 ? String.Format("{0:F}", Model.ID): "")%>
            
            <p>
                <%: Html.Label("ZONA") %>
                <%= Html.DropDownList("ZONA_ID")%>
                <br />
                <span class="smltxt red">
                <%: Html.ValidationMessageFor(model => model.ZONA_ID) %></span>
            </p>
            
            <p>
                <%: Html.Label("RIO CANAL KM/PAR")%>
                <%= Html.DropDownList("RIOS_CANALES_KM_ID")%>
                    <br />
                <span class="smltxt red">
                <%: Html.ValidationMessageFor(model => model.RIOS_CANALES_KM_ID) %></span>
            </p>
            
            <p>
                <%: Html.LabelFor(model => model.USO) %>
                <%: Html.TextBoxFor(model => model.USO, new { @class = "inputbox" })%>
                <br />
                <span class="smltxt red">
                <%: Html.ValidationMessageFor(model => model.USO) %></span>
            </p>
            
            <p>
                <input type="submit" value="<%= ViewData["titulo"] %>" class="btn"/>
            </p>

    <% } %>

    <div>
        <%: Html.ActionLink("Volver a la lista", "List") %>
    </div>

    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

