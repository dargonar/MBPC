<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<% Dictionary<string, string> buque_origen = (ViewData["buque_origen"] as List<object>)[0] as Dictionary<string, string>; %>
<% Dictionary<string, string> buque_destino = (ViewData["buque_destino"] as List<object>)[0] as Dictionary<string, string>; %>

<form id="editarCargasForm" action="<%= Url.Content("~/Carga/transferirCargas") %>" >
  <table>
    <tr>
      <th>Carga</th>
      <th><%= buque_origen["NOMBRE"]  %></th>
      <th width="80px">
        <input title="pasar todo a <%=buque_origen["NOMBRE"]%>" type="button" onclick="return moveall('f');" value="<-" />&nbsp;<a title="Volver a la carga original" href="#" onclick="return resetall();">R</a>&nbsp;<input type="button" onclick="return moveall('t');" value="->" title="pasar todo a <%=buque_destino["NOMBRE"]%>"/>
      </th>
      <th><%= buque_destino["NOMBRE"] %></th>
    </tr>
      <% var cargas = ViewData["cargas"] as Dictionary<string, Dictionary<string, Dictionary<string, string>>>; %>
      <% int cnt = 1; %>
      <% foreach( var kv in cargas ) { %>
      <tr style="background:#EEE">
        <% var unidad = kv.Value[kv.Value["from"] != null ? "from" : "to"]["UNIDAD"]; %>
        <% var unidadid = kv.Value[kv.Value["from"] != null ? "from" : "to"]["UNIDAD_ID"]; %>
        <% var tipocargaid = kv.Value[kv.Value["from"] != null ? "from" : "to"]["TIPOCARGA_ID"]; %>
        
        <% int total = 0; %>
        <% total += kv.Value["from"] != null ? int.Parse(kv.Value["from"]["CANTIDAD"]) : 0;  %>
        <% total += kv.Value["to"] != null ? int.Parse(kv.Value["to"]["CANTIDAD"]) : 0;  %>

        <td><%=kv.Value[kv.Value["from"] != null ? "from" : "to"]["NOMBRE"]%></td>
        <td>
        <% if (kv.Value["from"] != null) { %>
        <input tcid="<%=tipocargaid%>" unid="<%=unidadid%>" eid="<%=buque_origen["ID"]%>" cid="<%=kv.Value["from"]["CARGA_ID"]%>" style="width:40px" total="<%=total %>" id="f<%=cnt%>" class="cgo" cty="from" type="text" org="<%=kv.Value["from"]["CANTIDAD"]%>" value="<%=kv.Value["from"]["CANTIDAD"]%>" ocid="-1" />&nbsp;<%=unidad%>
        <% } else { %>
        <input tcid="<%=tipocargaid%>" unid="<%=unidadid%>" eid="<%=buque_origen["ID"]%>" cid="-1" style="width:40px" total="<%=total %>" id="f<%=cnt%>" class="cgo" cty="from" type="text" org="0" value="0" ocid="<%=kv.Value["to"]["CARGA_ID"]%>" />&nbsp;<%=unidad%>
        <%}%>
        </td>
        <td align="center" valign="middle">
          <input type="button" onclick="return moveto('f','<%=cnt%>');" value="<-" />&nbsp;<a href="#" onclick="return reset('<%=cnt%>');">R</a>&nbsp;<input type="button" onclick="return moveto('t','<%=cnt%>');" value="->" />
        </td>
        <td>
        <% if (kv.Value["to"] != null) { %>
        <input tcid="<%=tipocargaid%>" unid="<%=unidadid%>" eid="<%=buque_destino["ID"]%>" cid="<%=kv.Value["to"]["CARGA_ID"]%>" style="width:40px" total="<%=total %>" id="t<%=cnt%>" class="cgo" cty="to" type="text" org="<%=kv.Value["to"]["CANTIDAD"]%>" value="<%=kv.Value["to"]["CANTIDAD"]%>" ocid="-1" />&nbsp;<%=unidad%>
        <% } else { %>
        <input tcid="<%=tipocargaid%>" unid="<%=unidadid%>" eid="<%=buque_destino["ID"]%>" cid="-1" style="width:40px" total="<%=total %>" id="t<%=cnt%>" class="cgo" cty="to" type="text" org="0" value="0" ocid="<%=kv.Value["from"]["CARGA_ID"]%>" />&nbsp;<%=unidad%>
        <%}%>
        </td>
      </tr>
      <% cnt = cnt + 1; %>
      <% } %>
    <tr>
      <td colspan="4" align="right">
        <input type="submit" class="botonsubmit" value="Transferir" />
      </td>
    </tr>
  </table>
</form>


<script type="text/javascript">

      function reset(nro) {
        var forg = $('#f' + nro).attr('org');
        var torg = $('#t' + nro).attr('org');

        $('#f' + nro).val(forg == -1 ? 0 : forg);
        $('#t' + nro).val(torg == -1 ? 0 : torg);

        $('#f' + nro).parent().parent().css('background', '#eee');
      }

      function moveto(who,nro) {
        var aid = '#' + who;
        var zid = '#' + (who == 'f' ? 't' : 'f');
        $(aid + nro).val($(aid + nro).attr('total'));
        $(zid + nro).val(0);

        $(aid + nro).parent().parent().css('background', '#fff');
      }
        
      function moveall(who)
      {
        for (var i = 1; i < 1+$('.cgo').length / 2; i++) {
          moveto(who, i);
        }
      }
      
      function resetall()
      {
        for (var i = 1; i < 1 + $('.cgo').length / 2; i++) {
          reset(i);
        }
      }

      $(".cgo").blur(function () {

        //
        var cval = $(this).val();
        var total = $(this).attr('total');

        //
        var other = this.id[0] == 'f' ? 't' : 'f';
        other += this.id.substr(1);

        //
        var diff = total - cval;
        if (diff < 0) {
          $('#' + other).val(0);
          $(this).val(total);
        } else {
          $('#' + other).val(diff);
        }

        if (cval == $(this).attr('org')) {
          $(this).parent().parent().css('background', '#eee');
        }
        else {
          $(this).parent().parent().css('background', '#fff');
        }

      });

      $("#editarCargasForm").submit(function () {

        $('.botonsubmit').attr('disabled', 'disabled');

        var data = {};

        //Recorrer
        //<input eid="778" cid="916" style="width:40px" total="61" id="f1" class="cgo" cty="from" type="text" org="6" value="6">&nbsp;TN

        var count = 0;
        $("input.cgo").each(function (i, e) {

          if ( $(e).attr('org') == $(e).val() ) {
            return;
          }

          data['carga' + (count+1) ] = {  'eid': $(e).attr('eid'),
                                          'cid': $(e).attr('cid'),
                                          'org': $(e).attr('org'),
                                          'uid': $(e).attr('unid'),
                                          'tci': $(e).attr('tcid'),
                                          'oci': $(e).attr('ocid'),
                                          'val': $(e).val()
                                        };
          count = count + 1;
        });

        data['cargas'] = count;

        //console.log(data);
        //$('.botonsubmit').attr('disabled','');
        //return false;


        $.ajax({
          type: "POST",
          cache: false,
          url: $(this).attr("action"),
          data: data,
          success: (function (data) {
            $('#dialogdiv3').html(data);
            $('#dialogdiv3').dialog({
              height: 50,
              width: 100,
              modal: true,
              title: 'Transferencia OK'
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