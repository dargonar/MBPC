<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<table style="width:100%">
  <thead>
  <tr>
    <th>MATRICULA</th>
    <th>NRO OMI</th>
    <th>NOMBRE</th>
    <th>BANDERA</th>
    <th>NRO ISMM</th>
    <th>TIPO</th>
  </tr>
  </thead>
  <tbody>
<% 
  List<object> results = ViewData["results"] as List<object>;
  bool first_time = false;
  if (results == null)
  {
    results = new List<object>();
    first_time = true;
  }

  foreach (Dictionary<string, string> result in results)
  { 
    %>

          <% if (result["EN_VIAJE"] != "0")
             { %>
              <tr class="greyed condata" >
          <% }
             else
             {
               if (ViewData["Action"] as string != "seleccionBuques")
               { %>
                    <tr class="condata" onclick="pegar(this, '<%= result["NOMBRE"] %>' , '<%=result["MATRICULA"] as String %>')" >
            <% }
               else
               { %>
                    <tr class="condata" onclick="pegar_y_cerrar('<%= result["NOMBRE"] %>' , '<%=result["MATRICULA"] as String %>', <%=  result["TIPO"] == "nacional" ? 0 : 1 %>)" >
            <% }
             } 
             
          foreach (string key in result.Keys)
          {
            if (key == "MATRICULA" || key == "NRO_OMI" || key == "NOMBRE" || key == "BANDERA" || key == "NRO_ISMM" || key == "TIPO")
            { 
    %>      
            <td> <%= result[key] %></td>
    <%    
}
          }
    %>
         </tr>     
    <%
    }

    if (results.Count < 6)
    {
      for (int i = 0; i < 6 - results.Count; i++)
      { %>
        <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        </tr>
        <%
      }
    }

    if (results.Count == 0 && first_time == false)
    {
      %><p style="display:none;" id="noresults">No hay resultados</p><%
    }
%>
</tbody>
</table>


<script type="text/javascript">

    var selected 
    function movercursor(direccion) {

        if ($('.selected').length == 0) {
            $('.condata').first().addClass('selected');
            return false;
        }
        selected = $('.selected');
        $('.condata').removeClass('selected');

        if (direccion == 'arriba') {
            $(selected).prevAll('.condata:eq(0)').addClass('selected');
        } else  {
            $(selected).nextAll('.condata:eq(0)').addClass('selected');
        }

        return false;
    }


</script>