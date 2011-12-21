<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<mbpc_admin.TBL_PUNTODECONTROLUSUARIO>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Nueva Asignacion
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% if (ViewData.ContainsKey("flash"))
       {   %>
         <div class="status <%=ViewData["flash_type"]%>">
        	<p class="closestatus"><a href="#" onclick="$(this).parent().parent().remove()" title="Cerrar">x</a></p>
        	<p><img src="/img/icons/icon_<%=ViewData["flash_type"]%>.png" alt="Success" /><%= ViewData["flash"] %></p>
          </div>
    <%} %>


    <h2>Asignar nuevo punto de control a <%= ViewData["nombres"] %></h2><br />

    <div class="contentbox">
    <% using (Html.BeginForm("CreateAsig", "Puntodecontrol")) {%>
        <%: Html.ValidationSummary(true) %>

            <!-- ID/ETAPA_ID -->
            <%= Html.Hidden("ID", Model.ID != 0 ? String.Format("{0:0.}", Model.ID) : "")%>
            <%= Html.Hidden("USUARIO", Model.ID != 0 ? String.Format("{0:0.}", Model.USUARIO) : ViewData["user"])%>
            
            <p>
                <%= Html.Label("PUNTODECONTROL")%>
                <%= Html.DropDownList("PUNTODECONTROL") %>                <br />
                <span class="smltxt red">
                <%= Html.ValidationMessage("PUNTODECONTROL") %></span>
            </p>
            
            <p>
                <input type="submit" value="Asignar" class="btn" />
            </p>

    <% } %>

    <div>
        <%: Html.ActionLink("Volver a la lista", "ListPDCUser", new { userid = int.Parse(ViewData["user"].ToString()) })%>
    </div>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

