<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<table >
<% 
  
  List<object> results = ViewData["results"] as List<object>;
  if (results != null)
  {
    var cargas = (ViewData["results"] as List<object>);
    if (cargas.Count == 0)
    {
      %>
      <tr><td style="border: 3px solid;background-color:Gray" colspan="3"><strong>No hay resultados</strong></td></tr>
      <%
    }
    else
    {
      foreach (Dictionary<string, string> result in cargas)
      { 
      %>
            <tr onclick="pegarCodigo('<%= result["CODIGO"] %>','<%= result["NOMBRE"] %>','<%= result["ID"] %>',<%= result["UNIDAD_ID"] %>)" class="navoff" onmouseover="className='navon'" onmouseout="className='navoff'" >
      <%    foreach (string key in result.Keys)
            {
              if (key != "NOMBRE")
                continue;
      %>      
              <td style="border: 3px solid"> <%= result[key]%></td>
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

  function pegarCodigo(codigo, nombre, id, unidad) {

    $('#unidad_id').val(unidad);
    $('#codigo').val(codigo);
    $('#carga').val(nombre);
    $('#cargaid').val(id);
    $('.latabla').html('');

  }



</script>