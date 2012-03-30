<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	PBIP
</asp:Content>

<asp:Content ID="Content0" ContentPlaceHolderID="HeadContent" runat="server">
<script language="javascript">
  
</script>

<style>
    .pbip_container
    {width:300px;}
    .pbip_container.full
    {width:650px;}
    .pbip_container.left
    {float:left;}
    .pbip_container.right
    {float:right;}
    
    .pbip_container input, .pbip_container select
    {width:270px;}
    
    .tabla_content-body-wrapper { 
    display:table; 
    border-collapse:collapse; 
    } 
 
    .tabla_content-body { 
        display:table-row; 
    } 
 
    .tabla_td{ 
        display:table-cell; border:1px solid #e9e9e9;
        padding:1px;height:20px;
    } 
 
    .tabla_td_th {background-color:#cecece;   }
    .tabla_td_index { width:10px; } 
 
    .tabla_td_desde, .tabla_td_hasta { width:65px; }
    .tabla_td_desde input, .tabla_td_hasta input{ width:60px; }
    
    .tabla_td_descripcion {width:180px;}
    .tabla_td_descripcion input {width:175;}
    
    .tabla_td_nivel_proteccion {width:50px;} 
    .tabla_td_nivel_proteccion input {width:45px;} 
    
    .tabla_td_medida_proteccion {width:125px;} 
    .tabla_td_medida_proteccion input {width:65px; } 
    .tabla_td_medida_proteccion select {padding:1px 0px; width:45px; } 
    .tabla_td_medida_proteccion.wider input {width:120px; } 
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
