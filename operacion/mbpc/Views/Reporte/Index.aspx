<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Reportes
</asp:Content>

<asp:Content ID="Content0" ContentPlaceHolderID="HeadContent" runat="server">
<script language="javascript">
  function print_toggle(obj) {
    var isprint = $(obj).html() == "Imprimir";
    if (isprint) {
      $(".fprint").hide();
      $("#header").hide();
      $(obj).html("Volver");
      window.print();
    }
    else {
      $("#header").show();
      $(".fprint").show();
      $(obj).html("Imprimir");
    }

    
  }

  var print_me = 0;
  function to_excel(obj) {
    print_me = 1;
    $("form#reporte").submit();
  }

  function submit_me(frm) {

    if (print_me != 0) {
      $(frm).attr('action', '<%= Url.Content("~/Reporte/Ver/")%>?print_me=true');
      print_me = 0;
      return true;
    }

    $("#fullscreen").show();

    $.ajax({
      cache: false,
      type: 'POST',
      url: '<%= Url.Content("~/Reporte/Ver/")%>',
      data: $(frm).serialize(),
      success: function (data) {

        $("#rresult").html(data);
        $("#rresult").show();

        $("#fullscreen").hide();
      },
      error: function (data) {
        $("#fullscreen").hide();
      }
    });

    return false;
  }


  $(document).ready(function () {

    buildButtons();

    $("#reporte_id").change(function () {

      $(".rephid").hide();
      $(".botonsubmit").hide();
      $("#rresult").hide();

      if ($(this).val() == -1)
        return;

      $("#fullscreen").show();

      $.ajax({
        cache: false,
        url: '<%= Url.Content("~/Reporte/ParamsFor/")%>' + $(this).val(),
        success: function (data) {
          $("#reporte_params").html(data);

          $("#reporte_params input.rparam").each(function (inx) {
            var mask = $(this).attr('mask');
            if (mask != '')
              $(this).mask(mask);
          });

          if (data.length != 0)
            $(".rephid").show();

          $(".repres").hide();
          $(".botonsubmit").show();
          $("#fullscreen").hide();
        },
        error: function (data) {
          $("#fullscreen").hide();
        }
      });
    });

  });
</script>
</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div id="columnas">

<!-- LEFT COL -->
<div class="col" style="width:100%;height:100%;">

	<div class="split-bar"></div>
	<h1 class="fprint" >Reportes</h1>
  <!-- top -->

  <div class="fprint" style="padding:20px;">
    <form id="reporte" onsubmit="return submit_me(this)" action="<%= Url.Content("~/Reporte/VerReporte") %>" method="post">

      <label>Seleccione un reporte: </label>
      <select name="reporte_id" id="reporte_id" style="margin:0; width:274px;" class="nexttab">
        <option value="-1"></option>

      <% 
        string lastcat = string.Empty;
        foreach (Dictionary<string, string> reporte in (ViewData["reportes"] as List<object>))
        {
          if (lastcat != reporte["CATEGORIA"])
          {
            if (lastcat != string.Empty)
            {%> 
            </optgroup> 
            <%}
                              
            %><optgroup label="<%=reporte["CATEGORIA"]%>"><%
            lastcat = reporte["CATEGORIA"];
          }
	    %>
             <option value="<%= reporte["ID"] %>"><%= reporte["NOMBRE"] %></option>
       <%} 
      %>
      </select><br /><br />
      <div style="clear:both;"></div>
      
      
      <div class="rephid" style="display:none" id="reporte_params" class="reporte_params">
      <h4 class="rephid" style="display:none">Parámetros del reporte</h4>
      </div>

      <div style="clear:both;"></div>
      <br/>
      <input type="submit" class="botonsubmit" style="margin-left: 190px;display: block;padding: 7px 15px 7px 15px;margin: 0;text-decoration: none;text-align: center;font-size: 12px;color: black;background-color: #E6E6E6;border: #B4B4B4 solid 1px;display:none" value="Ver Reporte" />
    </form>
  </div>

  <div style="clear:both;"></div>

  <div id="rresult" class="container" style="height:100%;display:none">

  </div>

</div>
 
</div>

<div id="sueltos" style="display: none;">
  <!-- elements que necesitan estar en el html porque el js necesita la url -->
  <!--<a id="printver" target="_blank" href="" style="float:right;margin-right: 17px" > Esssta</a></li>-->
  <img id="loaderimg" alt="loader" style="position:absolute;top:50%;left:50%;" src="<%= Url.Content("~/img/ajax-loader2.gif") %>" />
</div>

</asp:Content>
