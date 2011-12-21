<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Usuarios
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%/* if (ViewData["flash_type"] == "success")
       {   %>
         <div class="status success">
        	<p class="closestatus"><a href="#" onclick="$(this).parent().remove()" title="Close">x</a></p>
        	<p><img src="/img/icons/icon_success.png" alt="Success" /><span>Ok</span> <%= ViewData["flash"] %></p>
          </div>
    <%} */%>
    <% if (ViewData.ContainsKey("flash"))
       {   %>
         <div class="status <%=ViewData["flash_type"]%>">
        	<p class="closestatus"><a href="#" onclick="$(this).parent().parent().remove()" title="Cerrar">x</a></p>
        	<p><img src="/img/icons/icon_<%=ViewData["flash_type"]%>.png" alt="Success" /><%= ViewData["flash"] %></p>
          </div>
    <%} %>
    <h2>Listado de usuarios</h2><br />

<table id="list"><tr><td/></tr></table> 
<div id="pager"></div>
<div id="filter" style="display:none">Search Invoices</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">

<script type="text/javascript">
     
  $(document).ready(function () {
    //"NDOC", "DESTINO", "PASSWORD", "APELLIDO", "NOMBRES", "DESTINO", "FECHAVENC", "TEDIRECTO", "EMAIL", "NOMBREDEUSUARIO"
    $(function () {
      var mygrid = $("#list").jqGrid({
        url: '/Usuario/ListJson',
        datatype: 'json',
        mtype: 'GET',
        colNames: ["Documento", "Destino", "Password", "Apellido", "Nombres", "Destino", "Fechavenc", "Tel Directo", "email", "nombredeusuario"],  
        colModel: [
      { name: 'NDOC', index: 'NDOC', width: 90},
      { name: 'DESTINO', index: 'DESTINO', width: 90},
      { name: 'PASSWORD', index: 'PASSWORD', width: 90 },
      { name: 'APELLIDO', index: 'APELLIDO', width: 80 },
      { name: 'NOMBRES', index: 'NOMBRES', width: 80 },
      { name: 'DESTINO', index: 'DESTINO', width: 80 },
	    { name: 'FECHAVENC', index: 'FECHAVENC', width: 80 },
      { name: 'TEDIRECTO', index: 'TEDIRECTO', width: 80 },
      { name: 'EMAIL', index: 'EMAIL', width: 80 },
      { name: 'NOMBREDEUSUARIO', index: 'NOMBREDEUSUARIO', width: 80 },
    ],
        pager: '#pager',
        rowNum: 20,
        rowList: [10, 20, 30],
        sortname: 'NDOC',
        sortorder: 'desc',
        viewrecords: true,
        gridview: true,
        autowidth: true,
        height: 400,
        caption: 'Usuarios',
        search: true,
      });

      mygrid.filterToolbar({
      height: 20
      });
      mygrid.navGrid('#pager', { edit: false,
        add: false,
        del: false,
        search: false
      })/*.navButtonAdd('#pager', {
        caption: "Nuevo",
        buttonicon: "ui-icon-add",
        onClickButton: function () {
            window.location = '/Usuario/New';
        },
        position: "last"
      }).navButtonAdd('#pager', {
        caption: "Editar",
        buttonicon: "ui-icon-edit",
        onClickButton: function () {
            var gsr = mygrid.getGridParam('selrow');
            if (!gsr){
            alert("Debe elegir un usuario");
            return;
            }
            var id = mygrid.getRowData(gsr)['USUARIO_ID'];
            window.location = '/Usuario/Edit?id='+id;
        },
        position: "last"
      }).navButtonAdd('#pager', {
        caption: "Borrar",
        buttonicon: "ui-icon-del",
        onClickButton: function () {
            var gsr = mygrid.getGridParam('selrow');
            if (!gsr){
            alert("Debe elegir un usuario");
            return;
            }
            if (!confirm("¿Esta seguro de eliminar este usuario?"))
                return;
            var id = mygrid.getRowData(gsr)['USUARIO_ID'];
            window.location = '/Usuario/Remove?ID='+id;
        },
        position: "last"
      })*/.navButtonAdd('#pager', {
        caption: "Ver Grupos",
        buttonicon: "ui-icon-view",
        onClickButton: function () {
            var gsr = mygrid.getGridParam('selrow');
            if (!gsr){
              alert("Debe elegir un usuario");
              return;
            }
            var id = mygrid.getRowData(gsr)['USUARIO_ID'];
            window.location = '/Usuario/Grupos?usuario='+id;
        },
        position: "last"
      });
    });

  });
</script>
</asp:Content>
