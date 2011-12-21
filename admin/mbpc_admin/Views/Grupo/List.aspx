<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Grupos
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% if (ViewData.ContainsKey("flash"))
       {   %>
         <div class="status <%=ViewData["flash_type"]%>">
         <p class="closestatus"><a href="#" onclick="$(this).parent().parent().remove()" title="Cerrar">x</a></p>
         <p><img src="/img/icons/icon_<%=ViewData["flash_type"]%>.png" alt="Success" /><%= ViewData["flash"] %></p>
         </div>
    <%} %>
    <h2>Listado de grupos</h2><br />

<table id="list"><tr><td/></tr></table> 
<div id="pager"></div>
<div id="filter" style="display:none">Search Invoices</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">

<script type="text/javascript">
     
  $(document).ready(function () {

    $(function () {
      var mygrid = $("#list").jqGrid({
        url: '/Grupo/ListJson',
        datatype: 'json',
        mtype: 'GET',
        colNames: ["id", "Nombre"],  
        colModel: [
      { name: 'ID', index: 'ID', width: 90, hidden: true },
      { name: 'NOMBRE', index: 'NOMBRE', width: 90 },
    ],
        pager: '#pager',
        rowNum: 20,
        rowList: [10, 20, 30],
        sortname: 'Nombre',
        sortorder: 'desc',
        viewrecords: true,
        gridview: true,
        autowidth: true,
        height: 400,
        caption: 'Grupos',
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
            window.location = '/Grupo/New';
        },
        position: "last"
      }).navButtonAdd('#pager', {
        caption: "Editar",
        buttonicon: "ui-icon-edit",
        onClickButton: function () {
            var gsr = mygrid.getGridParam('selrow');
            if (!gsr){
              alert("Debe elegir un grupo");
              return;
            }
            var id = mygrid.getRowData(gsr)['ID'];
            window.location = '/Grupo/Edit?id='+id;
        },
        position: "last"
      }).navButtonAdd('#pager', {
        caption: "Borrar",
        buttonicon: "ui-icon-del",
        onClickButton: function () {
            var gsr = mygrid.getGridParam('selrow');
            if (!gsr){
            alert("Debe elegir un grupo");
            return;
            }
            if (!confirm("¿Esta seguro de eliminar este grupo?"))
                return;
            var id = mygrid.getRowData(gsr)['ID'];
            window.location = '/Grupo/Remove?ID='+id;
        },
        position: "last"
      });/*.navButtonAdd('#pager', {
        caption: "Ver Puntos de Control",
        buttonicon: "ui-icon-view",
        onClickButton: function () {
            var gsr = mygrid.getGridParam('selrow');
            if (!gsr){
            alert("Debe elegir un grupo");
            return;
            }
            var id     = mygrid.getRowData(gsr)['ID'];
            var nombre = mygrid.getRowData(gsr)['NOMBRE'];
            window.location = '/Grupo/PuntosDe?grupo='+id+'&nombre='+nombre;
        },
        position: "last"
      });*/
    });

  });
</script>
</asp:Content>
