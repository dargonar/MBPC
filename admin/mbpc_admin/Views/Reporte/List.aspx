﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Reportes
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% if (ViewData.ContainsKey("flash"))
       {   %>
         <div class="status <%=ViewData["flash_type"]%>">
        	<p class="closestatus"><a href="#" onclick="$(this).parent().parent().remove()" title="Cerrar">x</a></p>
        	<p><img src="/img/icons/icon_<%=ViewData["flash_type"]%>.png" alt="Success" /><%= ViewData["flash"] %></p>
          </div>
    <%} %>

    <h2>Listado de reportes</h2><br />

<table id="list"><tr><td/></tr></table> 
<div id="pager"></div>
<!--div id="filter" style="display:none">Search Invoices</div-->

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">

<script type="text/javascript">
     
  $(document).ready(function () {

    $(function () {
      var mygrid = $("#list").jqGrid({
        url: '/Reporte/ListJson',
        datatype: 'json',
        mtype: 'GET',
        colNames: ["Nombre", "Descripción", "Fecha", "ID"],  
        colModel: [
      { name: 'NOMBRE', index: 'NOMBRE', width: 90},
      { name: 'DESCRIPCION', index: 'DSCRIPCION', width: 90 },
      { name: 'FECHA', index: 'FECHA_CREACION', width: 80 },
      { name: 'ID', index: 'ID', width: 80 }
    ],
        pager: '#pager',
        rowNum: 20,
        rowList: [10, 20, 30],
        sortname: 'nombre',
        sortorder: 'desc',
        viewrecords: true,
        gridview: true,
        autowidth: true,
        height: 400,
        caption: 'Reportes',
        search: true,
      });

      mygrid.filterToolbar({
      height: 20
      });
      mygrid.navGrid('#pager', { edit: false,
        add: false,
        del: false,
        search: false
      }).navButtonAdd('#pager', {
        caption: "Nuevo",
        buttonicon: "ui-icon-add",
        onClickButton: function () {
            window.location = '/Reporte/New';
        },
        position: "last"
      }).navButtonAdd('#pager', {
        caption: "Editar",
        buttonicon: "ui-icon-edit",
        onClickButton: function () {
            var gsr = mygrid.getGridParam('selrow');
            if (!gsr){
              alert("Debe elegir un reporte");
              return;
            }
            var id = mygrid.getRowData(gsr)['ID'];
            window.location = '/Reporte/Edit?id='+id;
        },
        position: "last"
      }).navButtonAdd('#pager', {
        caption: "Borrar",
        buttonicon: "ui-icon-del",
        onClickButton: function () {
            var gsr = mygrid.getGridParam('selrow');
            if (!gsr){
            alert("Debe elegir un reporte");
            return;
            }
            if (!confirm("¿Esta seguro de eliminar este reporte?"))
                return;
            var id = mygrid.getRowData(gsr)['ID'];
            window.location = '/Reporte/Remove?ID='+id;
        },
        position: "last"
      });
    });

  });
</script>
</asp:Content>
