<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
  <div class="item <%= ViewData["odd_or_even"] %>">
    <input type="hidden" value="conditionitem_<%= ViewData["condition_item_index"] %>" name="conditionitem_<%= ViewData["condition_item_index"] %>" />
    <div class="field">
      <select class="full_width condition_item_selector" name="conditionitem-attribute_<%= ViewData["entity_id"] %>_<%= ViewData["condition_item_index"] %>">
        <% SortedDictionary<string, Dictionary<string, string>> attributes = ViewData["attributes"] as SortedDictionary<string, Dictionary<string, string>>; %>
        <% foreach (string key in attributes.Keys)  
              {
                string attr_key = key;
                Dictionary<string, string>  attr_data = attributes[key];   
              
              %>
              <option value="<%= attr_data["id"] %>" data_type="<%= attr_data["type"] %>"><%= attr_key %></option>
           <% } %>      
      </select>
    </div>
    <div class="operator">
      <select class="full_width operators" name="conditionitem-operator_<%= ViewData["entity_id"] %>_<%= ViewData["condition_item_index"] %>">
        <% Html.RenderPartial("operatorByType"); %>
      </select>
    </div>
    <div class="value">
      <input type="text" value="" class="full_width input_value" placeholder="value" name="conditionitem-value_<%= ViewData["entity_id"] %>_<%= ViewData["condition_item_index"] %>" />
    </div>
    <div class="is_param">
      <input type="checkbox" class="condition_item_is_param" name="conditionitem-isparam_<%= ViewData["entity_id"] %>_<%= ViewData["condition_item_index"] %>"/>Es parámetro
    </div>
    <div class="actions">
      <a href="#" class="delete_condition" style="font-size:10px;">Quitar condición</a>     
    </div>
    <div style="clear:both;"></div>
  </div>