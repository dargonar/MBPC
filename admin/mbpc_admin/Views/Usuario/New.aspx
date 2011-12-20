<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<mbpc_admin.VW_INT_USUARIOS>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	<%= ViewData["titulo"]%> Usuario
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <% if (ViewData.ContainsKey("flash"))
       {   %>
         <div class="status <%=ViewData["flash_type"]%>">
        	<p class="closestatus"><a href="#" onclick="$(this).parent().parent().remove()" title="Cerrar">x</a></p>
        	<p><img src="/img/icons/icon_<%=ViewData["flash_type"]%>.png" alt="Success" /><%= ViewData["flash"] %></p>
          </div>
    <%} %>


    <h2><%= ViewData["titulo"]%> Usuario</h2> <br/>

   <div class="contentbox">

    <% using (Html.BeginForm("Create", "Usuario"))
       {%>
        <%: Html.ValidationSummary(true) %>

            <p>
                <%: Html.Label("USUARIO_ID") %>
                <%: Html.TextBox("USUARIO_ID", String.Format("{0:0.}", Model.NDOC), new { @class = "inputbox" })%>
                <br />
                <span class="smltxt red"><%: Html.ValidationMessage("USUARIO_ID") %></span>
            </p>
            
            <p>
                <%: Html.Label("NDOC") %>
                <%: Html.TextBox("NDOC", String.Format("{0:0.}", Model.NDOC), new { @class = "inputbox" })%>
                <br />
                <span class="smltxt red"><%: Html.ValidationMessage("NDOC") %></span>
            </p>
            
            <p>
                <%: Html.Label("PASSWORD") %>
                <%: Html.TextBox("PASSWORD", String.Format("{0:F}", Model.PASSWORD), new { @class = "inputbox" })%>
                <br />
                <span class="smltxt red">
                <%: Html.ValidationMessage("PASSWORD") %></span>
            </p>
            
            <p>
                <%: Html.Label("APELLIDO") %>
                <%: Html.TextBox("APELLIDO", String.Format("{0:F}", Model.APELLIDO), new { @class = "inputbox" })%>
                <br />
                <span class="smltxt red">
                <%: Html.ValidationMessage("APELLIDO") %></span>
            </p>
            
            <p>
                <%: Html.Label("NOMBRES") %>
                <%: Html.TextBox("NOMBRES", String.Format("{0:F}", Model.NOMBRES), new { @class = "inputbox" })%>
                <br />
                <span class="smltxt red">
                <%: Html.ValidationMessage("NOMBRES") %></span>
            </p>
            
            <p>
                <%: Html.Label("DESTINO") %>
                <%: Html.TextBox("DESTINO", String.Format("{0:F}", Model.DESTINO), new { @class = "inputbox" })%>
                <br />
                <span class="smltxt red">
                <%: Html.ValidationMessage("DESTINO") %></span>
            </p>
            
            <p>
                <%: Html.Label("FECHAVENC") %>
                <%: Html.TextBox("FECHAVENC", String.Format("{0:F}", Model.FECHAVENC), new { @class = "inputbox" })%>
                <br />
                <span class="smltxt red">
                <%: Html.ValidationMessage("FECHAVENC") %></span>
            </p>
            
            <p>
                <%: Html.Label("TEDIRECTO") %>
                <%: Html.TextBox("TEDIRECTO", String.Format("{0:0.}", Model.TEDIRECTO), new { @class = "inputbox" })%>
                <br />
                <span class="smltxt red">
                <%: Html.ValidationMessage("TEDIRECTO") %></span>
            </p>
            
            <p>
                <%: Html.Label("TEINTERNO") %>
                <%: Html.TextBox("TEINTERNO", String.Format("{0:0.}", Model.TEINTERNO), new { @class = "inputbox" })%>
                <br />
                <span class="smltxt red"><%: Html.ValidationMessage("TEINTERNO") %></span>
            </p>
            
            <p>
                <%: Html.Label("EMAIL") %>
                <%: Html.TextBox("EMAIL", String.Format("{0:F}", Model.EMAIL), new { @class = "inputbox" })%>
                <br />
                <span class="smltxt red"><%: Html.ValidationMessage("EMAIL") %></span>
            </p>
            
            <p>
                <%: Html.Label("ESTADO") %>
                <%: Html.TextBox("ESTADO", String.Format("{0:F}", Model.ESTADO), new { @class = "inputbox" })%>
                <br />
                <span class="smltxt red"><%: Html.ValidationMessage("ESTADO") %></span>
            </p>
          
            <p>
                <%: Html.Label("NOMBREDEUSUARIO") %>
                <%: Html.TextBox("NOMBREDEUSUARIO", Model.NOMBREDEUSUARIO, new { @class = "inputbox" })%>
                <br />
                <span class="smltxt red"><%: Html.ValidationMessage("NOMBREDEUSUARIO") %></span>
            </p>
            
            
            <p>
                <input type="submit" value="<%= ViewData["titulo"]%>" class="btn" />
            </p>

    <% } %>

    <div>
        <%: Html.ActionLink("Volver a la lista", "List")%>
    </div>


</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

