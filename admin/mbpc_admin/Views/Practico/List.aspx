<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ import Namespace="JQGridHelper" %>


<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Practicos
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% if (ViewData.ContainsKey("flash"))
       {   %>
         <div class="status <%=ViewData["flash_type"]%>">
        	<p class="closestatus"><a href="#" onclick="$(this).parent().parent().remove()" title="Cerrar">x</a></p>
        	<p><img src="/img/icons/icon_<%=ViewData["flash_type"]%>.png" alt="Success" /><%= ViewData["flash"] %></p>
          </div>
    <%} %>

    <h2>Practicos</h2><br />    <table id="list"><tr><td/></tr></table> 
    <div id="pager"></div> 
    <div id="filter" style="display:none">Search Invoices</div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">

<script type="text/javascript">


  $(document).ready(function () {


    $(function () {
      var mygrid = $("#list").jqGrid({
        url: '/Practico/ListJson',
        datatype: 'json',
        mtype: 'GET',
        colNames: ["ID","Nombre"],  
        colModel: [
      { name: 'ID', index: 'ID', width: 90, hidden: true },
      { name: 'NOMBRE', index: 'NOMBRE', width: 90 }, //, formatter: tipodecargas, stype: 'select', editoptions: { value: tipodecargas_edit}},

    ],
        pager: '#pager',

        rowList: [10, 20, 30],
        viewrecords: true,
        gridview: true,
        sortname: 'ID',
        sortorder: 'asc',
        autowidth: true,
        height: 400,
        caption: 'Puntos de control'

        <%// Html.RestoreJQState("carga") %>
        
      });

      mygrid.filterToolbar();
      mygrid.navGrid('#pager', { edit: false,
        add: false,
        del: false,
        search: false
      }).navButtonAdd('#pager', {
        caption: "Nuevo",
        buttonicon: "ui-icon-add",
        onClickButton: function () {
            window.location = '/Practico/New';
        },
        position: "last"
      }).navButtonAdd('#pager', {
        caption: "Editar",
        buttonicon: "ui-icon-add",
        onClickButton: function () {
            var gsr = mygrid.getGridParam('selrow');
            if (!gsr){
            alert("Debe elegir un practico");
            return;
            }
            var id = mygrid.getRowData(gsr)['ID'];
            window.location = '/Practico/Edit?ID='+id;
        },
        position: "last"
      }).navButtonAdd('#pager', {
        caption: "Borrar",
        buttonicon: "ui-icon-add",
        onClickButton: function () {
            var gsr = mygrid.getGridParam('selrow');
            if (!gsr){
            alert("Debe elegir un practico");
            return;
            }
            if (!confirm("Esta seguro que desea eliminar este practico?"))
                return;
            var id = mygrid.getRowData(gsr)['ID'];
            window.location = '/Practico/Remove?ID='+id;
        },
        position: "last"
      });
    });

    <%//Html.RestoreJQStateScript("carga", true)%>

  });
</script>
</asp:Content>
