<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<mbpc_admin.TBL_PRACTICO>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Agregar Practico
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <% if (ViewData.ContainsKey("flash"))
       {   %>
         <div class="status <%=ViewData["flash_type"]%>">
        	<p class="closestatus"><a href="#" onclick="$(this).parent().parent().remove()" title="Cerrar">x</a></p>
        	<p><img src="/img/icons/icon_<%=ViewData["flash_type"]%>.png" alt="Success" /><%= ViewData["flash"] %></p>
          </div>
    <%} %>


    <h2><%= ViewData["titulo"] %> Practico</h2><br />

    <div class="contentbox">

    <% using (Html.BeginForm("Create", "Practico")) {%>
        <%: Html.ValidationSummary(true) %>

            
              <%= Html.Hidden("ID", Model.ID != 0 ? String.Format("{0:0.}", Model.ID) : "")%>

            
            <p>
                <%: Html.Label("NOMBRE") %>
                <%: Html.TextBoxFor(model => model.NOMBRE, new { @class = "inputbox" }) %>
                                <br />
                <span class="smltxt red">
                <%: Html.ValidationMessageFor(model => model.NOMBRE) %></span>
            </p>
            
            <p>
                <input type="submit" value="<%= ViewData["titulo"] %>" class="btn" />
            </p>

    <% } %>

    <div>
        <%: Html.ActionLink("Volver a la lista", "List") %>
    </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

