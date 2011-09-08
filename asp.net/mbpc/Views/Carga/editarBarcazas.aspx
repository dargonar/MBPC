<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<% Dictionary<string, string> buque_origen = (ViewData["buque_origen"] as List<object>)[0] as Dictionary<string, string>; %>
<% Dictionary<string, string> buque_destino = (ViewData["buque_destino"] as List<object>)[0] as Dictionary<string, string>; %>

<form id="editarBarcazasForm" action="<%= Url.Content("~/Carga/transferirBarcazas") %>" >
  <table>
    <tr>
      <th><%= buque_origen["NOMBRE"]  %></th>
      <th></th>
      <th><%= buque_destino["NOMBRE"] %></th>
    </tr>
    <tr>
      <td>
        <select multiple id="barcazas_origen" name="barcazas_origen" size="15" style="width: 220px;float:left;">
        <% foreach (Dictionary<string, string> barcaza in (ViewData["barcazas1"] as List<object>))
            { %>
               <option value="<%= barcaza["CARGA_ID"] %>"><%= barcaza["BARCAZA"]%></option>
         <% } 
        %>
        </select>
      </td>
      <td align="center" valign="middle">
        <input type="hidden" id="etapa_origen" name="etapa_origen"  value="<%= ViewData["etapa_origen"] %>" />
        <input type="hidden" id="etapa_destino" name="etapa_destino" value="<%= ViewData["etapa_destino"] %>" />
        <input type="button" onclick="move(this.form.barcazas_origen,this.form.barcazas_destino)" value="->" /><br />
        <input type="button" onclick="move(this.form.barcazas_destino,this.form.barcazas_origen)" value="<-" />
      </td>
      <td>
        <select multiple id="barcazas_destino" name="barcazas_destino" size="15" style="width: 220px;float:left;">
        <% foreach (Dictionary<string, string> barcaza in (ViewData["barcazas2"] as List<object>))
            { %>
               <option value="<%= barcaza["CARGA_ID"] %>"><%= barcaza["BARCAZA"] %></option>
         <% } %>
        </select>
      </td>
    </tr>
    <tr>
      <td colspan="3" align="right">
        <input type="submit" class="botonsubmit" value="Transferir" />
      </td>
    </tr>
  </table>
</form>


<script type="text/javascript">
        
      function move(tbFrom, tbTo)   
      {   
        var arrFrom = new Array(); 
        var arrTo = new Array();    
        var arrLU = new Array();   
        var i;   
        
        for (i = 0; i < tbTo.options.length; i++)    
        {    
          arrLU[tbTo.options[i].text] = tbTo.options[i].value;    
          arrTo[i] = tbTo.options[i].text;
        }   
        
        var fLength = 0;   
        var tLength = arrTo.length;
        
        for(i = 0; i < tbFrom.options.length; i++)    
        {    
          arrLU[tbFrom.options[i].text] = tbFrom.options[i].value;    
          if (tbFrom.options[i].selected && tbFrom.options[i].value != "")     
          {     
            arrTo[tLength] = tbFrom.options[i].text;     
            tLength++;
          }    
          else     
          {     
            arrFrom[fLength] = tbFrom.options[i].text;     
            fLength++;    
          }  
        }    
        
        tbFrom.length = 0;  
        tbTo.length = 0;
        var ii;
        
        for(ii = 0; ii < arrFrom.length; ii++)   
        {    
          var no = new Option();
          no.value = arrLU[arrFrom[ii]];
          no.text = arrFrom[ii];
          tbFrom[ii] = no;
        }    
        for(ii = 0; ii < arrTo.length; ii++)   
        {   
          var no = new Option();
          no.value = arrLU[arrTo[ii]];
          no.text = arrTo[ii];
          tbTo[ii] = no;
        }  
      }


      $("#editarBarcazasForm").submit(function () {

          $('option').attr('selected', 'selected');
          $('.botonsubmit').attr('disabled', 'disabled');

        $.ajax({
          type: "POST",
          cache: false,
          url: $(this).attr("action"),
          data: $(this).serialize(),
          success: (function (data) {
            $('#dialogdiv3').html(data);
            $('#dialogdiv3').dialog({
              height: 200,
              width: 300,
              modal: true,
              title: 'Ok'
            });
            $('#selector').dialog('close');
            $('#dialogdiv').dialog('close');
          }),
          error: (function (data) {
            var titletag = /<title\b[^>]*>.*?<\/title>/
            alert(titletag.exec(data.responseText));
            $('.botonsubmit').removeAttr('disabled');
          })
        });
        return false;

      });




</script>