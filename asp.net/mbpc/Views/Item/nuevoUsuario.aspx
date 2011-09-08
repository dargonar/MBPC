<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	nuevoUsuario
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<% List<object> pdcs = ViewData["todos_los_pdc"] as List<object>;  %> 

<div id="sueltos" style="display: none;">
  <!-- elements que necesitan estar en el html porque el js necesita la url -->
  <img id="loaderimg" alt="loader" style="position:absolute;top:50%;left:50%;" src="<%= Url.Content("~/img/ajax-loader2.gif") %>" />
</div>
<div class="contentcontainer">
  <div class="headings alt">
    <h2>Agregar Usuario</h2>
  </div>
  <div class="contentbox">
    <form id="nuevoUsuario" action="<%= Url.Content("~/Item/crearUsuario") %>" method="post">
      <% if (ViewData.ContainsKey("generic")) { Response.Write("<div class=\"status error\"><p class=\"closestatus\"><a href=\"\" onclick=\"$(this).parent().parent().remove();return false;\" title=\"Close\">x</a></p><p><img src=\"" + Url.Content("~/img/icons/icon_error.png") +"alt=\"Error\" /><span>Error!</span> " + ViewData["generic"] + "</p></div>"); } %>
      <p>
      <label>Puntos de Control</label>
      <% if (ViewData.ContainsKey("pdcerror")) { Response.Write("<div class=\"status error\"><p class=\"closestatus\"><a href=\"\" onclick=\"$(this).parent().parent().remove();return false;\" title=\"Close\">x</a></p><p><img src=\"" + Url.Content("~/img/icons/icon_error.png") + "alt=\"Error\" /><span>Error!</span>  " + ViewData["pdcerror"] + "</p></div>"); } %>


      <%= ViewData["form"] %>



      <select id="userpdcs" name="userpdcs" size="10" multiple="multiple" style="width: 300px;">

      </select>
      <div></div>
      <select id="pdcs" style="width: 300px;" >
      <% foreach (Dictionary<string, string> pdc in pdcs)
         { %>
        
           <option value="<%= pdc["ID"] %>"><%= pdc["CANAL"] +" - Km "+ pdc["KM"] %> </option>
  <%   } %>
    
      </select>
      <button id="agregar" class="btn">Agregar Punto de Control</button>
      </p>
      <div></div>
      <p>
        <br />
        <input type="submit" value="Crear Usuario" onclick="$('option').attr('selected', 'selected');" class="btn" id="btn" />
      </p>
    </form>
    
  </div>
</div>



  

  




<script type="text/javascript">

  $('#agregar').click(function () {
    val = $('#pdcs').val();
    $("#pdcs").children("option[value=" + val + "]").clone().appendTo($('#userpdcs'));
    return false;
  });



</script>




</asp:Content>
