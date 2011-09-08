<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<table style="width: 100%">
        <tr>
          <th>ID</th>
          <th>PUERTO</th>
          <th>INST. PORTUARIA</th>
          <th>MUELLE</th>
        </tr>
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
        <tr class="condata" onclick="pegar_y_cerrar('<%= result["NOMBRE_M"] %>' , <%= result["ID"] %>)" >
    <%    
    foreach (string key in result.Keys)
        { 
  %>
          <td> <%= result[key]%></td>
  <%    }
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
        </tr>
        <%
      }
    }

    if (results.Count == 0 && first_time == false)
    {
      %><p style="display:none;" id="noresults">No hay resultados</p><%
    }
  
%>
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
        } else {
            $(selected).nextAll('.condata:eq(0)').addClass('selected');
        }

        return false;
    }


</script>
