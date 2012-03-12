<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<div class="selected_entity closed" entity="<%=ViewData["entity"]%>" entity_id="<%=ViewData["entity_id"]%>">
  <input type="hidden" value="entity_<%= ViewData["entity_index"] %>" name="entity_<%= ViewData["entity_index"] %>"/>
  <a class="header" href="#" >
    <span class="tag"></span>
    <h3 class="name"><%=ViewData["entity"]%></h3>
  </a>
  <a href="#" class="quitar_entidad">Quitar entidad</a>
  <div class="condition_list">
    <div class="items">
    </div>
    <hr/>
    <div class="toolbar">
      <a href="#" class="add_condition_item">Agregar condición</a>
      <a href="#" class="clear_condition_items" >Limpiar condiciones</a>
    </div>
  </div>
  <div style="clear:both"></div>
  <hr />
  <br />
</div>
