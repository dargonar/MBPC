<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Viajes
</asp:Content>

<asp:Content ID="Content0" ContentPlaceHolderID="HeadContent" runat="server">
<script language="javascript">
  
</script>

<style>
    .msg_info{   
      border: 1px solid;
	    margin: 10px 0px;
	    padding:15px 10px 15px 50px;
	  }

    .msg_info.msg_success {
	    color: #4F8A10;
	    background-color: #DFF2BF;
    }
    .msg_info.msg_err {
	    color: #FFFFFF;
	    background-color: #AA0000;
    }

</style>
</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div id="columnas">
    <% Html.RenderPartial("lista"); %>
</div>

<div id="sueltos" style="display: none;">
  <!-- elements que necesitan estar en el html porque el js necesita la url -->
  <!--<a id="printver" target="_blank" href="" style="float:right;margin-right: 17px" > Esssta</a></li>-->
  <img id="loaderimg" alt="loader" style="position:absolute;top:50%;left:50%;" src="<%= Url.Content("~/img/ajax-loader2.gif") %>" />
</div>

</asp:Content>
