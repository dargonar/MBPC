<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<% List<object> unidades = ViewData["unidades"] as List<object>; %>
<form id="agrgar_carga" action="<%= Url.Content("~/Carga/agregar/") %>">

  <input type="hidden" value="<%= ViewData["etapa_id"] %>"  name="etapa_id"/>
  <input type="hidden" id="carga_id" name="carga_id" />
  <input type="hidden" id="buque_id" name="buque_id" />
  <input type="hidden" id="unidad_id" name="unidad_id"/>

  <label>Carga</label><br />
  <input type="text" id="carga" name="carga" style="width: 250px;" autocomplete="off"  /><br />

  <div class="latabla" style="position:absolute;z-index:5;width: 250px;"></div>
    <label>Código</label><br />
    <input type="text" id="codigo" name="codigo" autocomplete="off" style="width: 40px" readonly="readonly"/><br />

    <label style="float: left;width: 93px;">Cantidad</label><br />
   
    <input style="width: 80px;height: 20px;" autocomplete="off" type="text" id="cantidad" name="cantidad" />&nbsp;<span id="un1">--</span>&nbsp;&nbsp;&nbsp;
    
    <input style="width: 80px;height: 20px;display:none" autocomplete="off" type="text" id="cantidad2" name="cantidad2" />&nbsp;<span id="un2" style="display:none">KG</span>

    <input type="hidden" style="float: left;margin-left:10px;width: 80px;height: 20px;" autocomplete="off" type="text" id="unidad_txt" name="unidad_txt"/>
    <br/>

    <p>
    <input type="checkbox" name="en_transito" value="" id="en_transito" />Está en tránsito
    </p>
    <p>
    <input type="checkbox" name="enbarcaza" value="" id="enbarcaza" />Está en barcaza
    </p>
    <input type="text" id="barcaza_text" style="width: 250px;" autocomplete="off" disabled="disabled"/>
    <input href="<%=Url.Content("~/Item/nuevaBarcaza")%>" id="newbarcaza" type="button" value="..." onclick="return nuevaBarcaza(this);" title="NUEVA BARCAZA" disabled="disabled"/> <br />
    <br />
    <input type="submit" value="agregar" />
</form>

<script type="text/javascript">

    function nuevaBarcaza(obj)
    {
      $.ajax({
        type: "GET",
        cache: false,
        url: $(obj).attr('href'),
        success: (function (data) {
          $('#dialogdiv4').html(data);
          $('#dialogdiv4').dialog({
            height: 375,
            width: 240,
            modal: true,
            title: 'Nueva Barcaza',
          });
        }),
        error: (function (data) {
          var titletag = /<title\b[^>]*>.*?<\/title>/
          alert(titletag.exec(data.responseText));
        })
      });

      return false;
    }

  //TN to KG
  $("#cantidad").change( function() {
    var v = $(this).val();
    var vv = '';
    if( v != '')
    {
      var vv = (parseFloat(v)*1000.0).toFixed(2);
    }
    
    $('#cantidad2').val(vv);
  });

  //KG to TN
  $("#cantidad2").change( function() {
    var v = $(this).val();
    var vv = '';
    if( v != '' )
    {
      var vv = (parseFloat(v)/1000.0).toFixed(4);
    }

    $("#cantidad").val(vv);
  });


  url = '<%= Url.Content("~/Autocomplete/cargas") %>';
  $("#carga").autocomplete({
    source: function (request, response) {
      $.ajax({
        type: "POST",
        url: url,
        dataType: "json",
        data: {
          query: request.term
        },
        success: function (data) {
          response($.map(data, function (item) {
            return {
              label: item.NOMBRE,
              value: item.NOMBRE,
              id:    item.ID,
              cod:   item.CODIGO,
              unom:  item.UNOMBRE,
              uid:   item.UNIDAD_ID
            }
          }));
        }
      });
    },
    minLength: 2,
    select: function (event, ui) {
      $("#carga_id").val(ui.item.id);
      $('#codigo').val(ui.item.cod);
      $('#unidad_txt').val(ui.item.unom);
      $('#unidad_id').val(ui.item.uid);
      
      //hack
      $('#un1').html(ui.item.unom);
      if( ui.item.unom == 'TN' )
      {
        $("#cantidad2").show();
        $("#un2").show();
      }
      else
      {
        $("#cantidad2").hide();
        $("#un2").hide();
      }

    },
    open: function () {
      $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
    },
    close: function () {
      $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
    }
  });

  $("#barcaza_text").autocomplete({
    source: function (request, response) {
      $.ajax({
        type: "POST",
        url: '<%= Url.Content("~/Autocomplete/barcazas") %>',
        dataType: "json",
        data: {
          query: request.term,
          etapa_id: '<%= ViewData["etapa_id"] %>'
        },
        success: function (data) {
          response($.map(data, function (item) {
            return {
              id     : item.ID_BUQUE,
              nombre : item.NOMBRE,
              bandera: item.BANDERA,
              info   : item.INFO,
              vf     : item.VIAJE_FONDEADA,
              etapa  : item.ETAPA
            }
          }));
        }
      });
    },
    minLength: 2,
    select: function (event, ui) {

        if( ui.item.info != '0' && ui.item.etapa != '0')
        {
            $("#buque_id").val('');
            $("#barcaza_text").val('');
            event.preventDefault();
            return false;
        }

      $("#buque_id").val(ui.item.id);
      $("#barcaza_text").val(ui.item.nombre);
      return false;
    }
  }).data( "autocomplete" )._renderItem = function( ul, item ) {
			      
    var bg = '';
    var mr = '';

    if( item.info != '0' && item.etapa != '0')
    {
        if(item.vf == 'v')
        {
            mr = 'Viajando en ';
            bg = 'style="background:#B99"';
        }
        else
        {
            mr = 'Fondeada en ';
            bg = 'style="background:#099"';
        }

        
        mr += item.info;
    }

    return $( "<li "+ bg + "></li>" )
			    .data( "item.autocomplete", item )
			    .append( "<a>" + item.nombre + " (" + item.bandera + ") " 
                        + mr
                        + "</a>" )
			    .appendTo( ul );
  }; 


  $("#enbarcaza").change(function () {

    if ($(this).is(":checked")) {
      $('#barcaza_text').removeAttr('disabled');
      $('#newbarcaza').removeAttr('disabled');
      $("#buque_id").val('');
      //$("#barcaza_text").val('');
    }
    else {
      $('#barcaza_text').attr('disabled', 'disabled');
      $('#newbarcaza').attr('disabled', 'disabled');
      $("#buque_id").val('');
      //$("#barcaza_text").val('');
    }
    return false;
  });

  $("#agrgar_carga").submit(function () {

    $('.botonsubmit').attr('disabled','disabled');

    if ($("#carga_id").val() == "") {
      alert("Debe seleccionar tipo de carga");
      $('.botonsubmit').removeAttr('disabled');
      return false;
    }

    if ($("#unidad").val() == "") {
      alert("Debe ingresar la unidad");
      $('.botonsubmit').removeAttr('disabled');
      return false;
    }

    if ($("#codigo").val() == "") {
      alert("Debe ingresar el codigo");
      $('.botonsubmit').removeAttr('disabled');
      return false;
    }

    if ($("#cantidad").val() == "") {
      alert("Debe ingresar la cantidad");
      $('.botonsubmit').removeAttr('disabled');
      return false;
    }

    if ( $("#enbarcaza").is(":checked") && $("#buque_id").val()=='' ) {
      alert("Debe ingresar la barcaza");
      $('.botonsubmit').removeAttr('disabled');
      return false;
    }
    ///

    $.ajax({
      type: "POST",
      cache: false,
      url: $(this).attr('action'),
      data: $(this).serialize(),
      success: function (data) {
        $("#dialogdiv3").dialog('close');
        $('#dialogdiv').html(data);
      },
      error: function (data) {
        var titletag = /<title\b[^>]*>.*?<\/title>/
        alert(titletag.exec(data.responseText));
        $('.botonsubmit').removeAttr('disabled');
      }
    });
    return false;
  });

</script>
