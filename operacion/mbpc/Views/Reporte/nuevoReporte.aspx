<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
 
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
          /*scope: '#selected_entities',*/
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
    });
      function addConditionItem(entity) {
        showLoading();
         $.ajax({
          type: "GET",
          cache: true,
          url: '<%= Url.Content("~/Reporte/conditionItem/")%>?entity='+entity,
          dataType: "text/html",
          success: (function (data) {
            $('.selected_entity[entity='+entity+'] .condition_list .items').append(data);
            hideLoading();
          }),
          error: (function (data) {
            var titletag = /<title\b[^>]*>.*?<\/title>/
            alert(titletag.exec(data.responseText));
            hideLoading();
          })
        });
      }

      function removeEntityItem(entity){
        showLoading();
        $('#selected_entities div.selected_entity[entity='+entity+']').remove();
        if($('#selected_entities div.selected_entity').length<=0) 
          $('#selected_entities_empty_msg').show();
        checkRelatedEntities();
        hideLoading();
      }
      
      function addEntityItem(entity) {
        if ($('.selected_entity[entity=' + entity + ']').length > 0) {
          alert('Usted ya ha agregado esta entidad a la lista de condiciones!');
          return false;
        }
        $('#selected_entities_empty_msg').hide();
        showLoading();
        $.ajax({
          type: "GET",
          cache: true,
          url: '<%= Url.Content("~/Reporte/entityItem/")%>?entity=' + entity,
          dataType: "text/html",
          success: (function (data) {
            $('#selected_entities').append(data);
            hideLoading();
            checkRelatedEntities();
          }),
          error: (function (data) {
            var titletag = /<title\b[^>]*>.*?<\/title>/
            alert(titletag.exec(data.responseText));
            hideLoading();
          })
        });
      }

      function checkRelatedEntities(){
        var allowed_entities = [];
        
        if($('#selected_entities div.selected_entity').length<=0)
        {
          $.each($('#entities div.entity'), function (index, value){
            if(!$(this).hasClass("related"))
            {
              $(this).addClass("related");
            } 
          });
          return;
        }
        $('#selected_entities div.selected_entity').each(function (){
          var cur_entity = $(this).attr("entity");
          allowed_entities.push(cur_entity); 
        });

        //console.log('selected entities:'+allowed_entities.join(','));
        
        $.each($('#entities div.entity'), function (index, value){
          var cur_entity = $(this).attr("entity");
          var cur_relations = $(this).attr("relations").split(',');
          
          //console.log('['+cur_entity+'] is related to ['+$(this).attr("relations")+']');
          
          if(jQuery.inArray(cur_entity, allowed_entities)!=-1)
          {
            $(this).removeClass("related");
            //console.log('['+cur_entity+'] no puede ser vinculada X');
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
            //console.log('['+cur_entity+'] no puede ser vinculada Y');
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

      var operators = <%=ViewData["operators_json"] %>;

      function onFieldChanged(obj)
      {
          var str = "";
          var data_type = $(obj).find("option:selected").attr('data_type');
          showLoading();
          $.ajax({
          type: "GET",
          cache: true,
          url: '<%= Url.Content("~/Reporte/operatorByType/")%>?data_type=' + data_type,
          dataType: "text/html",
          success: (function (data) {
            $(obj).parent().parent().find('select.operators').html(data);
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

      function addOrderField(){}
      function clearOrderFields(){}
      function addResultField(){}
      function clearResultFields(){}
  </script>


</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div id="columnas" style="height:100%;overflow:hidden;">

  <div style="width:100%;height:100%;">

	  <div class="split-bar"></div>
	  <h1 class="fprint" >Reportes</h1>
    <!-- top -->
    <h2 style="padding-left:10px;font-weight:normal;">Nuevo Reporte "<b>reporte-1</b>"</h2>
    
    <div id="reporte_button_bar" style="width:100%;padding: 0px 0px 10px 10px;">
      <input type="submit" class="botonsubmit megaboton"  value="Modificar nombre de reporte" />
    </div>
    
    <div class="split-bar"></div>
    
    
    <div id="contentwrapper" >
      <div id="contentcolumn">
        <div class="innertube">
          <h1 class="fprint" >Condiciones</h1>
          <div id="selected_entities">
            
            <div id="selected_entities_empty_msg" class="box">
			        <p class="box-S">No hay condiciones.<br/> Arrastre las entidades de su preferencia aquí.</p>
            </div> 
          </div>
          <div style="clear:both;"></div>
          <h1 class="fprint" >Resultado</h1>
          <div id="resultado">
            <div id="resultado_columnas">
              <h2>Campos en resultado:</h2>
              <div class="container">
                <div class="items">
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
                </div>
                <hr/> 
                <div class="toolbar">
                  <a href="#" onclick="addOrderField();return false;">Agregar orden</a>
                  <a href="#" onclick="clearOrderFields();return false;">Limpiar orden</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <div id="leftcolumn">
      <div class="innertube">
        <h1 class="fprint" >Entidades</h1>
        <div id="entities">
          <% SortedDictionary<string, string> entities = ViewData["entities"] as SortedDictionary<string, string>; %>
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
    
      

      <!--form id="reporte" onsubmit="return submit_me(this)" action="<%= Url.Content("~/Reporte/VerReporte") %>" method="post">
        <div style="clear:both;"></div>
        <div style="clear:both;"></div>
          
      </form -->
        
  </div>
  
</div>

<div id="sueltos" style="display: none;">
  <!-- elements que necesitan estar en el html porque el js necesita la url -->
  <a id="printver" target="_blank" href="" style="float:right;margin-right: 17px" > Esssta</a>
  <img id="loaderimg" alt="loader" style="position:absolute;top:50%;left:50%;" src="<%= Url.Content("~/img/ajax-loader2.gif") %>" />
</div>

</asp:Content>
