<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<mbpc_admin.VW_INT_USUARIOS>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	<%= ViewData["titulo"]%>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <% if (ViewData.ContainsKey("flash"))
       {   %>
         <div class="status <%=ViewData["flash_type"]%>">
        	<p class="closestatus"><a href="#" onclick="$(this).parent().parent().remove()" title="Cerrar">x</a></p>
        	<p><img src="/img/icons/icon_<%=ViewData["flash_type"]%>.png" alt="Success" /><%= ViewData["flash"] %></p>
          </div>
    <%} %>


    <h2><%= ViewData["titulo"]%></h2> <br/>

   <div class="contentbox">

    <% using (Html.BeginForm("ActualizarGrupos", "Usuario", FormMethod.Post, new { @onsubmit = "return selectall();" }))
       {%>
        <%: Html.ValidationSummary(true)%>

            <%: Html.Hidden("usuario", Model.NDOC)%>

            <p>
              <%: Html.Label("GRUPOS ASOCIADOS")%>
              <%: Html.DropDownList("grupos", (SelectList)ViewData["grupos"], new { @size = "10", @class = "inputbox", @multiple = "multiple" })%>
              <br />
              Nuevo grupo: <input id="pto" type="text" style="width:216px;"/><br /><br />
              <a href="#" id="rsel">Quitar seleccionados</a>
            </p>

            <p>
                <input type="submit" value="Actualizar Grupos" class="btn" />
            </p>

    <% } %>

    <div>
        <%: Html.ActionLink("Volver a la lista", "List")%>
    </div>


</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">

<script type="text/javascript">
  function selectall()
  {
    $('#grupos>option').attr("selected", "selected");
    return true;
  }

  $(document).ready(function () {

    $("#rsel").click( function() {
      $('#grupos>option:selected').remove();
      return false;
    });

    $("#pto").autocomplete({
      source: function (request, response) {
        $.ajax({
          type: "POST",
          url: '<%= Url.Content("~/Grupo/Buscar") %>',
          dataType: "json",
          data: {
            query: request.term
          },
          success: function (data) {
            response($.map(data, function (item) {
              return {
                label: item.NOMBRE,
                value: item.NOMBRE,
                id   : item.ID,
              }
            }));
          }
        });
      },
      minLength: 2,
      select: function (event, ui) {
        if( $('#grupos>option[value='+ui.item.id+']').length == 0 )
          $("#grupos").append('<option value="' + ui.item.id + '">' + ui.item.label + '</option>');
      }
    });

  });
</script>

</asp:Content>

