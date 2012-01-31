<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<mbpc_admin.TBL_GRUPO>" %>

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


    <h2><%= ViewData["titulo"]%> </h2> <br/>

   <div class="contentbox">

    <% using (Html.BeginForm("Create", "Grupo", FormMethod.Post, new { @onsubmit = "selectall()" }))
       {%>
        <%: Html.ValidationSummary(true)%>

            <%= Html.Hidden("ID", Model.ID != 0 ? String.Format("{0:0.}", Model.ID) : "")%>

            <p>
                <%: Html.Label("NOMBRE")%>
                <%: Html.TextBox("NOMBRE", String.Format("{0:0.}", Model.NOMBRE), new { @class = "inputbox" })%>
                <br />
                <span class="smltxt red"><%: Html.ValidationMessage("NOMBRE")%></span>
            </p>
            
            <p>
              <%: Html.Label("PUNTOS ASOCIADOS")%>
              <%: Html.DropDownList("puntos_de_control", (SelectList)ViewData["puntos_de_control"], new { @size = "10", @class = "inputbox", @multiple = "multiple" })%>
              <a href="#" onclick="return moveup()">Subir</a> / <a href="#" onclick="return movedown()">Bajar</a>
              <br />
              Nuevo punto: <input id="pto" type="text" style="width:216px;"/><br /><br />
              <a href="#" id="rsel">Quitar seleccionados</a>
            </p>
            
            <br />
            <br />


            <p>
                <input type="submit" value="<%= ViewData["boton"]%>" class="btn" />
            </p>

    <% } %>

    <div>
        <%: Html.ActionLink("Volver a la lista", "List")%>
    </div>


</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
<script type="text/javascript">
  
  $.fn.moveSelectedUp = function() {
    var selectedOptions = $(this).find('option:selected');
    var prev = $(selectedOptions).first().prev();
    $(selectedOptions).insertBefore(prev);
  }
  
  /*
  $.fn.moveSelectedTop = function() {
    var selectedOptions = $(this).find('option:selected');
    var first = $(this).children("option").not(":selected").first();
    $(selectedOptions).insertBefore(first);
  }

  $.fn.moveSelectedBottom = function() {
    var selectedOptions = $(this).find('option:selected');
    var last = $(this).children("option").not(":selected").last();
    $(selectedOptions).insertAfter(last);
  }
  */

  $.fn.moveSelectedDown = function() {
    var selectedOptions = $(this).find('option:selected');
    var next = $(selectedOptions).last().next();
    $(selectedOptions).insertAfter(next);
  }
  
  function moveup() {
    $("#puntos_de_control").moveSelectedUp();
  }

  function movedown() {
    $("#puntos_de_control").moveSelectedDown();
  }
  
  
  function selectall()
  {
    $('#puntos_de_control>option').attr("selected", "selected");
  }

  $(document).ready(function () {

    $("#rsel").click( function() {
      $('#puntos_de_control>option:selected').remove();
      return false;
    });

    $("#pto").autocomplete({
      source: function (request, response) {
        $.ajax({
          type: "POST",
          url: '<%= Url.Content("~/Puntodecontrol/Buscar") %>',
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
        if( $('#puntos_de_control>option[value='+ui.item.id+']').length == 0 )
          $("#puntos_de_control").append('<option value="' + ui.item.id + '">' + ui.item.label + '</option>');
      }
    });

  });
</script>
</asp:Content>

