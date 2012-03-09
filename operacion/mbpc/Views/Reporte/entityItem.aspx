<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<div class="selected_entity closed" entity="<%=ViewData["entity"]%>" entity_id="<%=ViewData["entity_id"]%>">
  <input type="hidden" value="entity_<%= ViewData["entity_index"] %>" name="entity_<%= ViewData["entity_index"] %>"/>
  <a class="header" href="#" onclick="$('.selected_entity[entity=<%=ViewData["entity"]%>]').toggleClass('closed');return false;">
    <span class="tag"></span>
    <h3 class="name"><%=ViewData["entity"]%></h3>
  </a>
  <a href="#" class="quitar_entidad" onclick="removeEntityItem('<%=ViewData["entity"]%>', true);return false;">Quitar entidad</a>
  <div class="condition_list">
    <div class="items">
    </div>
    <hr/>
    <div class="toolbar">
      <a href="#" onclick="addConditionItem('<%=ViewData["entity"]%>');return false;">Agregar condición</a>
      <a href="#" onclick="clearConditionItems('<%=ViewData["entity"]%>');return false;">Limpiar condiciones</a>
    </div>
  </div>
  <div style="clear:both"></div>
  <hr />
  <br />
</div>
