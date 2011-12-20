<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ import Namespace="JQGridHelper" %>


<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Buques
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% if (ViewData.ContainsKey("flash"))
       {   %>
         <div class="status <%=ViewData["flash_type"]%>">
        	<p class="closestatus"><a href="#" onclick="$(this).parent().parent().remove()" title="Cerrar">x</a></p>
        	<p><img src="/img/icons/icon_<%=ViewData["flash_type"]%>.png" alt="Success" /><%= ViewData["flash"] %></p>
          </div>
    <%} %>

    <h2>Buques Nacionales </h2><br />    <table id="list"><tr><td/></tr></table> 
    <div id="pager"></div> 
    <div id="filter" style="display:none">Search Invoices</div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">

<script type="text/javascript">

  //var referenceId = <%// ViewData["ID"] == null ? "null" : "'" + ViewData["ID"] + "'"%>;
  <%//Html.ComboFilter("tipodecargas") %>
  <%//Html.ComboFilter("unidades") %>

  $(document).ready(function () {


    $(function () {
      var mygrid = $("#list").jqGrid({
        url: '/Buque/ListJson',
        datatype: 'json',
        mtype: 'GET',
        colNames: ["ID","Tipo de Servicio","Tipo de buque","Eliminacion","Registro","Actualizacion Fecha","Actualizacion Usuario","Valor","Inscripcion Provisoria","Fecha de inscripcion","ISMM","Año de construccion","Bandera","Nombre","Nro OMI","Matricula","Señal Distintiva"],  
        colModel: [
      { name: 'BUQUE_ID', index: 'BUQUE_ID', width: 90 },
      { name: 'TIPO_SERVICIO', index: 'TIPO_SERVICIO', width: 90 }, //, formatter: tipodecargas, stype: 'select', editoptions: { value: tipodecargas_edit}},
      { name: 'TIPO_BUQUE', index: 'TIPO_BUQUE', width: 80 },
      { name: 'ELIMINACION', index: 'ELIMINACION', width: 80 },
      { name: 'REGISTRO', index: 'REGISTRO', width: 90 },
      { name: 'ACTUALIZACION_FECHA', index: 'ACTUALIZACION_FECHA', width: 90 },
      { name: 'ACTUALIZACION_USUARIO', index: 'ACTUALIZACION_USUARIO', width: 90 },
      { name: 'VALOR', index: 'VALOR', width: 90 },
      { name: 'INSCRIP_PROVISORIA', index: 'INSCRIP_PROVISORIA', width: 90 },
      { name: 'FECHA_INSCRIP', index: 'FECHA_INSCRIP', width: 90 },
      { name: 'NRO_ISMM', index: 'NRO_ISMM', width: 90 },
      { name: 'ANIO_CONSTRUCCION', index: 'ANIO_CONSTRUCCION', width: 90 },
      { name: 'BANDERA_ID', index: 'BANDERA_ID', width: 90 },
      { name: 'NOMBRE', index: 'NOMBRE', width: 90 },
      { name: 'NRO_OMI', index: 'NRO_OMI', width: 90 },
      { name: 'MATRICULA', index: 'MATRICULA', width: 90 },
      { name: 'SDIST', index: 'SDIST', width: 90 },

    ],
        pager: '#pager',

        rowList: [10, 20, 30],
        viewrecords: true,
        gridview: true,
        sortname: 'NOMBRE',
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
      })
    });

    <%//Html.RestoreJQStateScript("carga", true)%>

  });
</script>
</asp:Content>
