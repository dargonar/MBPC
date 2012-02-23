<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<div class="item <%= ViewData["odd_or_even"] %>">
  <div class="field">
    <select class="full_width order_column_item_select">
      <% SortedDictionary<string, SortedDictionary<string, string>> attributes_by_entity = ViewData["attributes_by_entity"] as SortedDictionary<string, SortedDictionary<string, string>>; %>
      <% if(attributes_by_entity!= null)
          foreach (string entity_key in attributes_by_entity.Keys)  
          {
            SortedDictionary<string, string> entity_attribute = attributes_by_entity[entity_key];
      %>  
          <optgroup label="<%=entity_key%>">   
      <%
            foreach (string attribute in entity_attribute.Keys){
      %>
          <option value="<%= entity_key %>.<%= entity_attribute[attribute] %>"><%= attribute%></option>
      <% } %>
          </optgroup>
        <% } %>      
    </select>
  </div>
  <div class="order">
    <select class="full_width">
      <option value="asc">Menor a mayor</option>
      <option value="desc">Mayor a menor</option>
    </select>
  </div>
  <div class="actions">
    <a href="#" onclick="removeOrderColumn(this);return false;" style="font-size:10px;">Quitar campo</a>
  </div>
  <div style="clear:both;"></div>
</div>