<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ import Namespace="JQGridHelper" %>


<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Cargas
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% if (ViewData.ContainsKey("flash"))
       {   %>
         <div class="status <%=ViewData["flash_type"]%>">
        	<p class="closestatus"><a href="#" onclick="$(this).parent().parent().remove()" title="Cerrar">x</a></p>
        	<p><img src="/img/icons/icon_<%=ViewData["flash_type"]%>.png" alt="Success" /><%= ViewData["flash"] %></p>
          </div>
    <%} %>

    <h2>Cargas de la etapa <%=ViewData["titulo"]%></h2><br />
    <table id="list"><tr><td/></tr></table> 
    <div id="pager"></div> 
    <div id="filter" style="display:none">Search Invoices</div>
    <a href="/etapa/list?ID=<%=ViewData["viaje_id"]%>&alone=<%=ViewData["alone"]%>">Volver a la lista de etapas</a>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">

<script type="text/javascript">

  var referenceId = <%= ViewData["referenceId"] == null ? "null" : "'" + ViewData["referenceId"] + "'"%>;
     
  <%=Html.ComboFilter("tipodecargas") %>
  <%=Html.ComboFilter("unidades") %>

  $(document).ready(function () {


    $(function () {
      var mygrid = $("#list").jqGrid({
        url: '/carga/ListJson?<%if(ViewData["alone"]!=null){%>alone=<%=ViewData["alone"]%>&<%}%>',
        datatype: 'json',
        mtype: 'GET',
        colNames: ["ID",	"TIPOCARGA_ID" , "CANTIDAD_INICIAL" , "CANTIDAD_ENTRADA", "CANTIDAD_SALIDA", "EN_TRANSITO", "UNIDAD_ID", "ETAPA_ID", "BUQUE_ID"],  
        colModel: [
      { name: 'ID', index: 'ID', width: 90, hidden: true },
      { name: 'TIPOCARGA_ID', index: 'TIPOCARGA_ID', width: 90, formatter: tipodecargas, stype: 'select', editoptions: { value: tipodecargas_edit}},
      { name: 'CANTIDAD', index: 'CANTIDAD', width: 80 },
      { name: 'CANTIDAD_ENTRADA', index: 'CANTIDAD_ENTRADA', width: 80 },
      { name: 'CANTIDAD_SALIDA', index: 'CANTIDAD_SALIDA', width: 80 },
      { name: 'EN_TRANSITO', index: 'EN_TRANSITO', width: 80 },
      { name: 'UNIDAD_ID', index: 'UNIDAD_ID', width: 80, formatter: unidades, stype: 'select', editoptions: { value: unidades_edit} },
      { name: 'ETAPA_ID', index: 'ETAPA_ID', width: 80 },
	  { name: 'BUQUE_ID', index: 'BUQUE_ID', width: 80 }
    ],
        pager: '#pager',

        rowList: [10, 20, 30],
        viewrecords: true,
        gridview: true,
        autowidth: true,
        width: 800,
        height: 400,
        caption: 'Cargas',
        <%= Html.RestoreJQState("cargas") %>
        search: referenceId != null ? true : false,
        postData: referenceId != null ? { ETAPA_ID: referenceId} : {}
      });

      mygrid.filterToolbar({
      height: 20
      });
      <%if(ViewData["alone"]!="1"){%>
      mygrid.navGrid('#pager', { edit: false,
        add: false,
        del: false,
        search: false
      }).navButtonAdd('#pager', {
        caption: "Nueva Carga",
        buttonicon: "ui-icon-add",
        onClickButton: function () {
            window.location = '/Carga/New?<%if(ViewData["alone"]!=null){%>alone=<%=ViewData["alone"]%>&<%}%>etapa_id='+referenceId;
        },
        position: "last"
      }).navButtonAdd('#pager', {
        caption: "Editar Carga",
        buttonicon: "ui-icon-add",
        onClickButton: function () {
            var gsr = mygrid.getGridParam('selrow');
            if (!gsr){
            alert("Debe elegir una carga");
            return;
            }
            var id = mygrid.getRowData(gsr)['ID'];
            window.location = '/Carga/Edit?<%if(ViewData["alone"]!=null){%>alone=<%=ViewData["alone"]%>&<%}%>ID='+id;
        },
        position: "last"
      }).navButtonAdd('#pager', {
        caption: "Borrar Carga",
        buttonicon: "ui-icon-add",
        onClickButton: function () {
            var gsr = mygrid.getGridParam('selrow');
            if (!gsr){
            alert("Debe elegir una carga");
            return;
            }
            if (!confirm("¿Esta seguro de eliminar esta carga?"))
                return;
            var id = mygrid.getRowData(gsr)['ID'];
            window.location = '/Carga/Remove?<%if(ViewData["alone"]!=null){%>alone=<%=ViewData["alone"]%>&<%}%>ID='+id;
        },
        position: "last"
      });
      <%}%>
    });

    <%=Html.RestoreJQStateScript("carga", true)%>

  });
</script>
</asp:Content>
