<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Admin
</asp:Content>

<asp:Content ID="Content0" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


<div class="contentcontainer">
  <div class="headings alt">
    <h2>Agregar Practico</h2>
  </div>
  <div class="contentbox">
    <form id="nuevoUsuario" action="<%= Url.Content("~/Item/crearPractico") %>" method="post">
      <p>
        <label>Nombre</label>
        <input autocomplete="off" class="inputbox" type="text" style="width:200px" name="userid" id="Text2"/><br />
      </p>
    
      <input type="submit" value="nuevo" class="btn" style="margin-left: 149px"/>
    </form>
    
  </div>
</div>






</asp:Content>

