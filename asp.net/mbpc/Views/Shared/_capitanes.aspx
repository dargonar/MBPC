<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<table>
<% 
  
  List<object> results = ViewData["results"] as List<object>;
  if (results != null)
  {
    var capitanes = (ViewData["results"] as List<object>);
    if (capitanes.Count == 0)
    {
      %>
      <tr><td colspan="3"><strong>No hay resultados</strong></td></tr>
      <%
    }
    else
    {
      foreach (Dictionary<string, string> result in capitanes)
      { 
      %>
            <tr onclick="pegarCapitan('<%= result["NOMBRE"] %>', '<%= result["ID"] %>')" class="navoff" onmouseover="className='navon'" onmouseout="className='navoff'" >
      <%    foreach (string key in result.Keys)
            {
              if (key != "NOMBRE")
                continue;
      %>      
              <td> <%= result[key]%></td>
      <%    } 
      %>
            </tr>     
      <% 
      }
    }
  }
%>
</table>


<script type="text/javascript">

  function pegarCapitan(nombre, id) {

    $('#capitanh').val(id);
    $('#capitantext').val(nombre);
    $('.latabla').html('');

  }



</script>
