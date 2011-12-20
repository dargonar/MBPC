<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<table>
<% 
  
  List<object> results = ViewData["results"] as List<object>;
  if (results != null)
  {
    var practicos = (ViewData["results"] as List<object>);
    if (practicos.Count == 0)
    {
      %>
      <tr><td colspan="3"><strong>No hay resultados</strong></td></tr>
      <%
    }
    else
    {
      foreach (Dictionary<string, string> result in practicos)
      { 
      %>
            <tr onclick="pegarPractico('<%= result["NOMBRE"] %>', '<%= result["ID"] %>')" class="navoff" onmouseover="className='navon'" onmouseout="className='navoff'" >
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

  function pegarPractico(nombre, id) {

    //$('#practicoh').val(id);
    //$('#practicotext').val(nombre);

    var nono = false;
    $('#practicoselect').children().each(function () {
      if ($(this).html() == nombre) {
        alert("Ya agregó a este practico")
        $('.latabla').html('');
        var nono = True;
      }
    });

    if (nono) {
      return false;
    }

    if ($('#practicoselect').children().length > 2) {
      alert("solo puede agregar 3 practicos por etapa")
      $('.latabla').html('');
      return false;
    }

    $('#practicoselect').append('<option class="practicopt" onclick="seleccionarPractico(this)" value="' + id + '">' + nombre + '</option>');
    
    $('.practicosh').each(function () {
      if ($(this).val() == "") {
        $(this).val(id);
        return false;
      }
    });
    
  }


</script>