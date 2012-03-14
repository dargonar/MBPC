<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<% string selected_attr = Convert.ToString(ViewData["selected_attribute_as"]); %>

<div class="item <%= ViewData["odd_or_even"] %>">
  <input type="hidden" value="resultcolumn_<%= ViewData["resultcolumn_index"] %>" name="resultcolumn_<%= ViewData["resultcolumn_index"] %>"/>
  <div class="field">
    <select class="full_width result_column_item_select" name="resultcolumn-field_<%= ViewData["resultcolumn_index"] %>">
      <% SortedDictionary<string, SortedDictionary<string, string>> attributes_by_entity = ViewData["attributes_by_entity"] as SortedDictionary<string, SortedDictionary<string, string>>; %>
      <% if(attributes_by_entity!= null)
          foreach (string entity_key in attributes_by_entity.Keys)  
          {
            SortedDictionary<string, string> entity_attribute = attributes_by_entity[entity_key];
      %>  
          <optgroup label="<%=entity_key%>">   
      <%
            foreach (string attribute in entity_attribute.Keys){
              if (String.IsNullOrEmpty(selected_attr))
                selected_attr = attribute;
      %>
          <option value="<%= entity_key %>.<%= entity_attribute[attribute] %>" <%= entity_attribute[attribute]==Convert.ToString(ViewData["selected_attribute_id"])?"SELECTED":"" %> ><%= attribute%></option>
      <% } %>
          </optgroup>
        <% } %>      
    </select>
  </div>
  <div class="as">
    se&nbsp;ve&nbsp;como&nbsp;<input type="text" placeholder="Nombre" value="<%=selected_attr %>" name="resultcolumn-value_<%= ViewData["resultcolumn_index"] %>"/>
  </div>
  <div class="actions">
    <a href="#" class="result_column_item_remove" style="font-size:10px;">Quitar campo</a>     
  </div>
  <div style="clear:both;"></div>
</div>