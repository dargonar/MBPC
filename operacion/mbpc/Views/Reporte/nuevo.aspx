<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %> 
<%@ Import Namespace="mbpc.Controllers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Reportes
</asp:Content>

<asp:Content ID="Content0" ContentPlaceHolderID="HeadContent" runat="server">
  <style type="text/css">
  div
  {
    margin: 0px;
    padding: 0px;
    position: relative;
    display:block;
  }
  
  #contentwrapper{
    float: left;
    width: 100%;
    height:100%;
    display: inline-block;
  }

  #contentcolumn{
    margin-left: 200px; /*Set left margin to LeftColumnWidth*/
    height:100%;
  }
  
  #contentcolumn.hover-droppable
  {
    border: 2px solid #FF9C08 ;    
  }
  #leftcolumn{
    float: left;
    width: 200px; /*Width of left column*/
    margin-left: -100%;
    /*background: #C8FC98;*/
  }


  .innertube{
    margin: 5px; 
    margin-top: 0;
    height:100%;
  }
  .contentcolumn innertube {margin-right:0px;}
  .megaboton
  {
    display: block;
    padding: 7px 15px 7px 15px;
    margin: 0;
    text-decoration: none;
    text-align: center;
    font-size: 12px;
    color: black;
    background-color: #E6E6E6;
    border: #B4B4B4 solid 1px;
  }
  
  .megaboton.entity
  {
    padding: 15px 15px 15px 15px;
  }
    
  #entities, #selected_entities, #resultado 
  {
    display:block;
    height:100%;
    width:100%;
    border-left: #B4B4B4 solid 1px;
    border-bottom: #B4B4B4 solid 1px;
    border-right: #B4B4B4 solid 1px;
    padding-top:5px;
    overflow:hidden;
  }
  
  #entities, #selected_entities /*, #resultado_columnas .container, #orden_columnas .container*/
  {
    overflow-x: hidden;
    overflow-y: auto;
  }
  
  #resultado_columnas .toolbar, #orden_columnas .toolbar
  {
    bottom:0px;
    height:20px;
  }
  
  #resultado_columnas .items, #orden_columnas .items
  {
    overflow-x: hidden;
    overflow-y: auto;
    height:80px;
  }
  
  #resultado 
  {
      min-height:100px;
  }
  
  #resultado h2 
  {
    font-size: 12px;padding-left:5px;  
  }
  #resultado #resultado_columnas, #resultado #orden_columnas
  {
    width:50%;height:100%;
    /*background-color:#999999;*/
    min-height:100px;float:left;
  }
  
  #resultado #resultado_columnas div.container, #resultado #orden_columnas div.container
  {
    margin:0px 5px 0px 5px;
  } 
  #resultado #orden_columnas{ border-left: #B4B4B4 solid 1px;}
    
  #resultado #resultado_columnas div.container .items .field, 
  #resultado #resultado_columnas div.container .items .as,
  #resultado #resultado_columnas div.container .items .actions,
  #resultado #orden_columnas div.container .items .field, 
  #resultado #orden_columnas div.container .items .order,
  #resultado #orden_columnas div.container .items .actions
  { min-width:150px; max-width:30%; float:left; margin-left:5px;}
  
  #resultado #resultado_columnas div.container .items .as
  { min-width:150px; max-width:40%;}
  
  #resultado #resultado_columnas div.container .items .actions,
  #resultado #orden_columnas div.container .items .actions
    { margin-left:10px;line-height:30px;}
  
  
  #resultado #orden_columnas div.container .items select, #resultado #orden_columnas div.container .items input {padding:4px;}
  
  #entities {z-index:2;min-height:500px;}
  #selected_entities{/*padding:5px;*/}
  
  #entities div.entity
  {
    margin:5px;
    z-index:3;  
  }
  #entities div.entity.first
  {
    margin-top:0px;
  }
  
  #selected_entities .box{
	  margin:0px ;
	  display:block;
	  height:100%;
	  width:100%;
	  top:0px;
	  position:relative;
	  padding:1px 0;
	  background-color:#f5f5f5;
  }
 
  #selected_entities .box-S{
    font-weight:bold;
    color:#646464;
    text-align:center;
    padding-top:150px;
  }
  
  #selected_entities .selected_entity  {
    width:100%;
    padding-left:5px;  
    min-height: 50px;
    height: auto;
  }
  
  #selected_entities .selected_entity span.tag {
    width:44px;height:44px;
    float:left;
    /*border:2px solid #b4b4b4;*/
    background:url(/img/icons/reporte_close-details_minus.png) center center no-repeat;  
  }
  
  #selected_entities .selected_entity.closed span.tag{
    background:url(/img/icons/reporte_open-details_plus.png) center center no-repeat;  
  }
  
  #selected_entities .selected_entity h3 {margin:0; display:inline-block;line-height:44px;padding-left:5px;}
  
  #selected_entities .selected_entity a.header {text-decoration:none;color:#000000;}
  
  #selected_entities .selected_entity .condition_list {
    padding:5px 5px 5px 50px;
    margin-top:10px;
  }
  
  #selected_entities .selected_entity.closed .condition_list {
    display:none;
  }
    
  #selected_entities .selected_entity.opened .condition_list {
    display:;
  }
  
  
  .condition_list .item .field, .condition_list .item .operator, .condition_list .item .value, .condition_list .item .is_param,
  .condition_list .item .actions    
    { min-width:200px; max-width:20%; float:left; margin-left:5px;}
  .condition_list .item .is_param, .condition_list .item .actions     
    { margin-left:10px;line-height:30px;}
  .condition_list .item select, .condition_list .item input {padding:4px;}
  select.full_width, input.full_width {width:100%;}
  
  a.quitar_entidad
  {
    float: right;
    padding-right: 25px;
  }
</style>

  <script language="javascript">

    var attribute_types = jQuery.parseJSON('<%= ViewData["attributes_types"]%>');

    $(document).ready(function () {
      buildButtons();
      if ($('#entities').height() > $('#selected_entities').height())
        $('#selected_entities').css('height', $('#entities').height() - 125);

      $('#entities div.entity').draggable(
        {
          revert: "invalid",
          addClasses: false,
          containment: 'document',
          zIndex: 2700,
          appendTo: 'body',
          helper: 'clone'
        }
      );
      $('#selected_entities').droppable(
        {
          accept: "#entities .entity.related",
          activeClass: "ui-state-hover",
          hoverClass: "hover-droppable",
          drop: function (event, ui) {
            addEntityItem(ui.draggable.attr('entity'));
          }
        }
      );

      enableDisableSidebarUnrelatedEntities();
    });

    function addConditionItem(entity) {

        var last = '';
        if($('.selected_entity[entity='+entity+'] .condition_list .items .item').length>0)
        {
          last = $('.selected_entity[entity='+entity+'] .condition_list .items .item:last input[type=hidden]').val();
        }
        
        showLoading();
         $.ajax({
          type: "GET",
          cache: true,
          url: '<%= Url.Content("~/Reporte/conditionItem/")%>?entity='+entity+'&last='+last,
          success: (function (data) {
            $('.selected_entity[entity='+entity+'] .condition_list .items').append(data);
            hideLoading();
          }),
          error: (function (data) {
            hideLoading();
            var titletag = /<title\b[^>]*>.*?<\/title>/
            alert(titletag.exec(data.responseText));
          })
        });
      }

      
      function removeEntityItem(entity, ask){
        
        if(ask)
          if(!confirm("Usted está por eliminar la entidad '"+entity+"' y toda vinculación de ésta. Dicha acción no es reversible. ¿Desea continuar?"))
            return false;
        
        showLoading();
        
        // Me guardo las relations de la entidad a borrar.
        var relations = $('#entities .entity[entity='+entity+']').attr('relations');

        doRemoveEntityItem(entity);

        removeSelectedEntitiesIfNotRelated();

        // Habilito y/o deshabilito las entidades de la sidebar en funcion de las entidades elegidas para el query.
        enableDisableSidebarUnrelatedEntities();
        hideLoading();
      }

      function removeSelectedEntitiesIfNotRelated(){ 
        var selected_entities = getSelectedEntities();
        
        if(selected_entities.length<=0)
        {
          return;
        }
        
        var relations = getSelectedEntitiesRelations();
        
        $.each($('#selected_entities div.selected_entity'), function (index, value){
          var cur_entity = $(this).attr("entity");
          
          if(index==0)
          {
            return true;
          }
          
          if(jQuery.inArray(cur_entity, relations)==-1)
          {
            doRemoveEntityItem(cur_entity);
            //$(this).remove();
            relations = getSelectedEntitiesRelations();
            return true;
          }
        });
      }

      function getSelectedEntitiesRelations()
      {
        var relations = [];
        $.each($('#selected_entities div.selected_entity'), function (index, value){
          var cur_entity = $(this).attr("entity");
          var cur_relations = $('#entities div.entity[entity='+cur_entity+']').attr("relations").split(',');
          relations = relations.concat(cur_relations);
        });
        return relations;
      }
      function doRemoveEntityItem(entity){
         //Elimino la entidad
        $('#selected_entities div.selected_entity[entity='+entity+']').remove();
        
        // Si no hay mas entidades, muestro el cartel de entidades vacias.
        if($('#selected_entities div.selected_entity').length<=0) 
          $('#selected_entities_empty_msg').show();

        // Elimino las columnas de resultado y de orden.
        
        $.each($(".result_column_item_select"), function () {
          if($(this).val().indexOf(entity, 0)==0)
            $(this).parent().parent().remove();
        });

        $.each($(".order_column_item_select"), function () {
          if ($(this).val().indexOf(entity, 0) == 0)
            $(this).parent().parent().remove();
        });

        /*$.each($(".result_column_item_select[value^='" + entity + ".']"), function () {
          $(this).parent().parent().remove();
        });
        $.each($(".order_column_item_select[value^='"+entity+".']"), function(){
          $(this).parent().parent().remove();
        });*/
      }

      function removeResultColumn(obj)
      {
        if(!confirm("Usted está por eliminar este campo en resultado. Dicha acción no es reversible. ¿Desea continuar?"))
          return false;
        $(obj).parent().parent().remove();
      }

      function removeOrderColumn(obj)
      {
        if(!confirm("Usted está por eliminar este orden de resultado. Dicha acción no es reversible. ¿Desea continuar?"))
          return false;
        $(obj).parent().parent().remove();
      }
      
      function addEntityItem(entity) {
        if ($('.selected_entity[entity=' + entity + ']').length > 0) {
          alert('Usted ya ha agregado esta entidad a la lista de condiciones!');
          return false;
        }
        $('#selected_entities_empty_msg').hide();
        
        var last = '';
        if($('.selected_entity').length>0)
        {
          last = $('.selected_entity:last input[type=hidden]').val();
        }
        
        showLoading();
        $.ajax({
          type: "GET",
          cache: true,
          url: '<%= Url.Content("~/Reporte/entityItem/")%>?entity=' + entity+'&last='+last,
          success: (function (data) {
            
            var obj = $('#selected_entities').append(data);
            hideLoading();
            enableDisableSidebarUnrelatedEntities();

          }),
          error: (function (data) {
            hideLoading();
            var titletag = /<title\b[^>]*>.*?<\/title>/
            alert(titletag.exec(data.responseText));
          })
        });
      }

      function getSelectedEntities(){
        var allowed_entities = [];
        $('#selected_entities div.selected_entity').each(function (){
          var cur_entity = $(this).attr("entity");
          allowed_entities.push(cur_entity); 
        });
        return allowed_entities;
      }


      function enableDisableSidebarUnrelatedEntities(){ 
        var allowed_entities = getSelectedEntities();
        
        if(allowed_entities.length<=0)
        {
          $.each($('#entities div.entity'), function (index, value){
            if(!$(this).hasClass("related"))
            {
              $(this).addClass("related");
            } 
          });

          $('#resultado_columnas .container .items').html('');
          $('#orden_columnas .container .items').html('');
          return;
        }
        
        $.each($('#entities div.entity'), function (index, value){
          var cur_entity = $(this).attr("entity");
          var cur_relations = $(this).attr("relations").split(',');
          
          if(jQuery.inArray(cur_entity, allowed_entities)!=-1)
          {
            $(this).removeClass("related");
            return true;
          }
          
          var is_related = false; 
          $.each(cur_relations, function(i, val){
            if(jQuery.inArray(val, allowed_entities)!=-1)
            {
              is_related = true;
              return false;
            }
          }); 
          
          if(!is_related)
          {
            $(this).removeClass("related");
            return true;;
          }

          //console.log('['+cur_entity+'] SI puede ser vinculada');
          if(!$(this).hasClass("related"))
          {
            $(this).addClass("related");
          }
        });
      }

      function clearConditionItems(entity) {
        if(!confirm("Usted está por eliminar todas las condiciones. Dicha acción no es reversible. ¿Desea continuar?"))
          return false;

        $('.selected_entity[entity='+entity+'] .condition_list .items').html('');
      }

      function onFieldChanged(obj)
      {
          
          var str = "";
          var attribute_id  = $(obj).find("option:selected").val();

          var data_type     = attribute_types[attribute_id];

          var select_obj    = $(obj).parent().parent().find('select.operators');
          var input_obj     = $(obj).parent().parent().find('input.input_value');
          var checkbox_obj  = $(obj).parent().parent().find('div.is_param input');
                    

          if('hardcoded'==data_type)
          {
            $(select_obj).html('');
            $(checkbox_obj).attr('checked', false).attr('disabled', 'disabled');
            $(select_obj).attr('disabled', 'disabled');
            $(input_obj).attr('disabled','disabled');
            $(input_obj).val('');

            return false;
          }

          $(checkbox_obj).attr('checked', false).attr('disabled', false);
          $(select_obj).attr('disabled', false);
          $(input_obj).attr('disabled',false);
          $(input_obj).val('');

          showLoading();
          $.ajax({
          type: "GET",
          cache: true,
          url: '<%= Url.Content("~/Reporte/operatorByType/")%>?data_type=' + data_type,
          success: (function (data) {
            $(obj).parent().parent().find('select.operators').html(data).attr('disabled',false);
            hideLoading();
          }),
          error: (function (data) {
            hideLoading();
            var titletag = /<title\b[^>]*>.*?<\/title>/
            alert(titletag.exec(data.responseText));
            
          })
        });

      }

      function showLoading(){
        /*var obj = $('#loaderimg').clone().addClass("_loaderimg");
        $(document).append(obj);*/
        $("#fullscreen").show();
      }
      function hideLoading(){
        /*if($("._loaderimg").length>0)
          $("._loaderimg").remove();*/
          $("#fullscreen").hide();
      }

      function addOrderField(){
        var selected_entities = getSelectedEntities();
        if(selected_entities.length<=0)
        {
          alert('Para agregar orden de resultado debe seleccionar al menos una entidad!');
          return;
        }

        var last = '';
        if($('#orden_columnas .items .item').length>0)
        {
          last = $('#orden_columnas .items .item:last input[type=hidden]').val();
        }

        showLoading();
        $.ajax({
          type: "GET",
          cache: true,
          url: '<%= Url.Content("~/Reporte/orderColumnItem/")%>?entities='+selected_entities.join(',')+'&last='+last,
          success: (function (data) {
            $('#orden_columnas .items').append(data);
            $('#orden_columnas .items').scrollTop($('#orden_columnas .items').height());
             hideLoading();
          }),
          error: (function (data) {
            hideLoading();
            var titletag = /<title\b[^>]*>.*?<\/title>/
            alert(titletag.exec(data.responseText));
            
          })
        });
      }
      function clearOrderFields(){
        if(!confirm("Usted está por eliminar el orden de resultado. Dicha acción no es reversible. ¿Desea continuar?"))
          return false;
        $('#orden_columnas .items').html('');
      }
      
      function addResultField()
      {
        var selected_entities = getSelectedEntities();
        if(selected_entities.length<=0)
        {
          alert('Para agregar campos de resultado debe seleccionar al menos una entidad!');
          return;
        }

        var last = '';
        if($('#resultado_columnas .items .item').length>0)
        {
          last = $('#resultado_columnas .items .item:last input[type=hidden]').val();
        }

        showLoading();
        $.ajax({
          type: "GET",
          cache: true,
          url: '<%= Url.Content("~/Reporte/resultColumnItem/")%>?entities='+selected_entities.join(',')+'&last='+last,
          success: (function (data) {
            $('#resultado_columnas .items').append(data);
            hideLoading();
            $('#resultado_columnas .items').scrollTop($('#resultado_columnas .items').height());
          }),
          error: (function (data) {
            hideLoading();
            var titletag = /<title\b[^>]*>.*?<\/title>/
            alert(titletag.exec(data.responseText));
            
          })
        });
      }
      function clearResultFields(){
        if(!confirm("Usted está por eliminar los campos de resultado. Dicha acción no es reversible. ¿Desea continuar?"))
          return false;
        $('#resultado_columnas .items').html('');
      }

      function result_column_item_selectChanged(obj)
      {
        $(obj).parent().parent().find("div.as input").attr('value', $(obj).find("option:selected").html());
      }

      function getFormJSON(obj){
        var elems = $(obj), nodes = $(obj), eventName;

          options  = {
                      grouped: true,
                      dataType: "json"
                  };

          options.grouped = true;
          elems = nodes = $(obj).find(":input,button");

          var vals = {}, form;

          if (options.grouped) {
              nodes.each(function (i) {
                  /**
                   * Do not include button and input:submit as nodes to 
                   * send, EXCEPT if the button/submit was the explicit
                   * target, aka it was clicked
                   */
                  if (!$(this).is('button,:submit')) {
                      if ($(this).is(':radio') && $(this).attr('checked')==false)
                          return;
                      vals[this.name] = $(this).is(':checkbox') ? 
                          $(this).attr('checked') : 
                          $(this).val();
                  }
              });
          }
          else {
              vals[actsOn.name] = $(actsOn).is(':checkbox') ? 
                  $(actsOn).attr('checked') : 
                  $(actsOn).val();
          }

          return vals;
      }

      function onSubmit(){
         
        if(!$.trim($('#nombre_reporte').val()).length)
        {
          alert("Debe ingresar un nombre para identificar al reporte.");
          return false;
        }

        if($('#selected_entities div.selected_entity').length==0)
        {
          alert("Debe seleccionar al menos una entidad.");
          return false;
        }

        if($('#resultado_columnas .items .item').length==0)
        {
          alert("Debe seleccionar al menos un campo para mostrar en el resultado.");
          return false;
        }

        $('#resultfields_count').val($('#resultado_columnas .items .item').length);
        $('#orderfields_count').val($('#orden_columnas .items .item').length);

        var conditions_by_entity_count = [];
        var entities_list = [];
        $.each($('#selected_entities div.selected_entity'), function (index, value){
          var dati = $(this).find('input[type=hidden]').val() + '=' + $(this).find('.condition_list .item').length;
          conditions_by_entity_count.push(dati);
          var datu = $(this).attr('entity')+ '=' + $(this).attr('entity_id');
          entities_list.push(datu);
        });
        $('#conditions_by_entity_count').val(conditions_by_entity_count.join(','));
        $('#entities_list').val(entities_list.join(','));

        
        $('#serialized_form').val($('#report-form').serialize());
        
        return true;
      }

      $(document).ready(function () {
        $('select.result_column_item_select').live("click", function () {
          result_column_item_selectChanged(this);
          return false;
        });

        $('a.result_column_item_remove').live("click", function () {
          removeResultColumn(this);
          return false;
        });

        $('a.order_column_item_remove').live("click", function () {
          removeOrderColumn(this);
          return false;
        });

        $('div.selected_entity a.header').live("click", function () {
          $(this).parent().toggleClass('closed');
          return false;
        });

        $('div.selected_entity a.quitar_entidad').live("click", function () {
          removeEntityItem($(this).parent().attr('entity'), true);
          return false;
        });

        $('div.selected_entity .toolbar a.add_condition_item').live("click", function () {
          addConditionItem($(this).parent().parent().parent().attr('entity'));
          return false;
        });

        $('div.selected_entity .toolbar a.clear_condition_items').live("click", function () {
          clearConditionItems($(this).parent().parent().parent().attr('entity'));
          return false;
        });

        $('div.is_param .condition_item_is_param').live("change", function () {
          var obj = $(this).parent().parent().find('.value input.input_value'); obj.attr('disabled', !obj.attr('disabled'));
          return false;
        });

        $('div.actions a.delete_condition').live("click", function () {
          if (confirm('¿Está seguro que desea quitar la condición? Esta acción es irreversible.')) 
            $(this).parent().parent().remove();
          return false;
        });

        $('select.condition_item_selector').live("change", function () {

          onFieldChanged(this);
           
          return false;
          
        });

        
      });
  </script>

  
</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<% SortedDictionary<string, string> entities = ViewData["entities"] as SortedDictionary<string, string>; %>
<% Dictionary<string, string> entities_by_id = ViewData["entities_by_id"] as Dictionary<string, string>; %>

<div id="columnas" style="height:100%;overflow:hidden;">

  <div id="tutto" style="width:100%;height:100%;">

	  <div class="split-bar"></div>
	  <h1 class="fprint" ><%= (ViewData["editing"] != null)?"Editar":"Nuevo" %> Reporte</h1>
    <% Html.RenderPartial("actions"); %>

    <form id="report-form" action="<%= Url.Content("~/Reporte/guardar") %><%= (ViewData["editing"] != null)?"?id="+ViewData["id"]:"" %>" method="post" onsubmit="return onSubmit();" >
    
      <h2 style="padding-left:10px;font-weight:normal;">Nombre: <input type="text" value="<%= (ViewData["editing"]!=null)? (ViewData["reporte"] as Dictionary<string, string>)["NOMBRE"]:"" %>" id="nombre_reporte" name="nombre_reporte" style="width:500px;" placeholder="de reporte" /></h2>
      
      <div class="split-bar"></div>
    
      <div id="contentwrapper" >
        <div id="contentcolumn">
          <div class="innertube">
            <h1 class="fprint" >Condiciones</h1>
          
            <input type="hidden" id="entities_list" name="entities_list" value="" />
            <input type="hidden" id="resultfields_count" name="resultfields_count" value="0" />
            <input type="hidden" id="orderfields_count" name="orderfields_count" value="0" />
            <input type="hidden" id="conditions_by_entity_count" name="conditions_by_entity_count" value="" />

            <input type="hidden" id="serialized_form" name="serialized_form" value="" />
            <input type="hidden" id="html_form" name="html_form" value="" />
            <input type="hidden" id="json_form" name="json_form" value="" />

            <div id="selected_entities">
            <% List<object> metadata=  ViewData["reporte_metadata"] as List<object>;  %>
            <% List<string> global_selected_entities=  null;  %>
              <div id="selected_entities_empty_msg" class="box" style="display:<%= ViewData["editing"]!=null?"none":"" %>;" >
			          <p class="box-S">No hay condiciones.<br/> Arrastre las entidades de su preferencia aquí.</p>
              </div> 
                <% if (ViewData["editing"] != null)
                   { 
                     List<string> selected_entities = new List<string>();
                     string current_entidad = "";
                     int entity_index = 0;
                     foreach (object obj_dict in metadata)  
                     {
                       Dictionary<string, string> dict = obj_dict as Dictionary<string, string>;
                       current_entidad = dict["ENTIDAD_ENTIDAD"];
                       if (!selected_entities.Contains(current_entidad))
                       {
                        selected_entities.Add(current_entidad); 
                        entity_index++;
                        ViewData["entity"] = entities_by_id[current_entidad];
                        ViewData["entity_id"] = current_entidad;
                        ViewData["entity_index"] = entity_index.ToString();
                        ViewData["dict"] = dict;
                        %>
                        
                        <% Html.RenderPartial("entityItem"); %>
                        
                        <%
                       }
                     } 
                     global_selected_entities=selected_entities;
                    } %>
              
            </div>
            <% ViewData["attributes_by_entity"] = global_selected_entities!=null?ReporteController.getAttributesByEntityIds(global_selected_entities.ToArray()):null; %>
            <div style="clear:both;"></div>
            <h1 class="fprint" >Resultado</h1>
            <div id="resultado">
              <div id="resultado_columnas">
                <h2>Campos en resultado:</h2>
                <div class="container">
                  <div class="items">
                  <% if (ViewData["editing"] != null)
                     {
                       int result_index = 0;
                       foreach (object obj_dict in metadata)
                       {
                         Dictionary<string, string> dict = obj_dict as Dictionary<string, string>;
                         if (dict["TIPO"] == "select")
                         {
                           result_index++;
                           ViewData["resultcolumn_index"] = result_index;
                           ViewData["selected_attribute_as"] = dict["VALOR"];
                           ViewData["selected_attribute_id"] = dict["XML_ID"];
                           ViewData["dict"] = dict;
                        %>
                        
                        <% Html.RenderPartial("resultColumnItem"); %>
                    
                    <%  }
                       }
                     }
                     %>
                  </div>
                  <hr/>
                  <div class="toolbar">
                    <a href="#" onclick="addResultField();return false;">Agregar campo</a>
                    <a href="#" onclick="clearResultFields();return false;">Limpiar campos</a>
                  </div>
                </div>
              </div>
              <div id="orden_columnas">
                <h2>Orden de resultado:</h2>
                <div class="container">
                  <div class="items">
                  <% if (ViewData["editing"] != null)
                     {
                       int ordercolumn_index = 0;
                       foreach (object obj_dict in metadata)
                       {
                         Dictionary<string, string> dict = obj_dict as Dictionary<string, string>;
                         if (dict["TIPO"] == "order")
                         {
                           ordercolumn_index++;
                           ViewData["ordercolumn_index"] = ordercolumn_index;
                           ViewData["selected_order"] = dict["VALOR"];
                           ViewData["selected_attribute_id"] = dict["XML_ID"];
                           ViewData["dict"] = dict;
                        %>
                        
                        <% Html.RenderPartial("orderColumnItem"); %>
                    
                    <%  }
                       }
                     }
                     %>

                  </div>
                  <hr/> 
                  <div class="toolbar">
                    <a href="#" onclick="addOrderField();return false;">Agregar orden</a>
                    <a href="#" onclick="clearOrderFields();return false;">Limpiar orden</a>
                  </div>
                </div>
              </div>
            </div>

            <div id="reporte_button_bar" style="width:100%;padding: 10px 0px 10px 10px;">
              <input type="submit" class="botonsubmit megaboton"  value="<%= (ViewData["editing"] != null)?"Guardar cambios":"Crear reporte" %>" />
            </div>
          </div>
        </div>
      </div>
    
      <div id="leftcolumn">
        <div class="innertube">
          <h1 class="fprint" >Entidades</h1>
          <div id="entities">
            <% var index = 0;
               foreach (string key in entities.Keys )  
              {
                string entity_key = key;
                string entity_relations = entities[key];   
              %>
              <div class="entity related <%=(index<1?"first":"") %>" entity="<%= entity_key %>" relations="<%= entity_relations %>">
                <a href="#" class="megaboton entity"><%= entity_key %></a>
              </div>     
           <% index++; 
             } %>
          
          </div>
        </div>
      </div>
    
    </form> 
  </div>
  
</div>

<div id="sueltos" style="display: none;">
  <!-- elements que necesitan estar en el html porque el js necesita la url -->
  <a id="printver" target="_blank" href="" style="float:right;margin-right: 17px" > Esssta</a>
  <img id="loaderimg" alt="loader" style="position:absolute;top:50%;left:50%;" src="<%= Url.Content("~/img/ajax-loader2.gif") %>" />
</div>

</asp:Content>
