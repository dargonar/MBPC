<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Register TagPrefix="controls" TagName="ship" Src="../Shared/ShipItem.ascx" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Home
</asp:Content>

<asp:Content ID="Content0" ContentPlaceHolderID="HeadContent" runat="server">
  <script type="text/javascript">
    
//    $(document).ready(function () {
////      $(window).bind("beforeunload", function () {
////        return inFormOrLink || confirm("Do you really want to close?");
////      })
//      
//    });
  </script>
</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div id="columnas">
  <% Html.RenderPartial("columnas"); %>
</div>

<div id="sueltos" style="display: none;">
  <!-- elements que necesitan estar en el html porque el js necesita la url -->
  <img id="loaderimg" alt="loader" style="position:absolute;top:50%;left:50%;" src="<%= Url.Content("~/img/ajax-loader2.gif") %>" />
</div>

<!--
<div class="split"></div>
<div class="row">
	<label>Argenmar Austral, yendo de <a href="#">Asuncion</a> a <a href="#">San Loreno</a></label>
    <div class="status-icons">
        <div class="st-blue"></div>
        <div class="st-yellow"></div>
        <div class="st-red"></div>
    </div>
    <div class="split"></div>
</div>
-->
</asp:Content>
