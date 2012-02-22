<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<mbpc_admin.TBL_REPORTECATEGORIA>" %>
<%@ Import Namespace="mbpc_admin.Controllers" %>
<%@ Import Namespace="mbpc_admin" %>

<asp:Content ID="HeadContent1" ContentPlaceHolderID="HeadContent" runat="server">
  <script	type="text/javascript">
      function isNonEmptyString(obj_id) {
        var val = jQuery('#'+obj_id).val();
        return (typeof val == 'string' && val!='');

      }

      function checkCategoria() {
        if (!isNonEmptyString('NOMBRE')) {
          alert("Por favor indique nombre.");
          return false;
        }
        return true;
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

    <% using (Html.BeginForm("CreateCategory", "Reporte", FormMethod.Post, new { @onsubmit = "return checkCategoria();" }))
       {%>
        <%: Html.ValidationSummary(true)%>

            <%= Html.Hidden("ID", Model.ID != 0 ? String.Format("{0:0.}", Model.ID) : "0")%>
            <p>
                <%: Html.Label("NOMBRE")%>
                <%: Html.TextBox("NOMBRE", String.Format("{0:0.}", Model.NOMBRE), new { @class = "inputbox" })%>
                <br />
                <span class="smltxt red"><%: Html.ValidationMessage("NOMBRE")%></span>
            </p>

            <br />
            <p>
                <input type="submit" value="Guardar Categoria" title="Guardar Categoria" class="btn" />&nbsp;&nbsp;&nbsp;<%: Html.ActionLink("Volver a la lista", "List")%>
            </p>

    <% } %>

    <div>
        
    </div>


</div>

</asp:Content>


