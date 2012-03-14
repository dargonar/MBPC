<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="mbpc.Controllers" %>
  
  <div class="item <%= ViewData["odd_or_even"] %>">
    <input type="hidden" value="conditionitem_<%= ViewData["condition_item_index"] %>" name="conditionitem_<%= ViewData["condition_item_index"] %>" />
    <div class="field">
        
      <% Dictionary<string, string> my_dict = ViewData["dict"] as Dictionary<string, string>; %>  
      <% bool editing = my_dict != null; %>  
      <% var selected_attribute_id = editing ? Convert.ToString(my_dict["XML_ID"]) : ""; %>  
      <%= Html.DropDownList("conditionitem-attribute_" + ViewData["entity_id"] + "_" + ViewData["condition_item_index"]
                      , ReporteController.CreateConditionAttributeCombo(Convert.ToString(ViewData["entity_id"]), selected_attribute_id)
                      ,  new Dictionary<string, object>{ { "class", "full_width condition_item_selector" } }) %>
      
    </div>
    <% bool condition_is_param = editing ? Convert.ToInt32(my_dict["IS_PARAM"])==1 : false; %>
    <% string condition_value = editing ? Convert.ToString(my_dict["VALOR"]) : ""; %>
    <% bool is_hardcoded = ReporteController.attributeTypeIsHardcoded(selected_attribute_id); %>
    <% Dictionary<string, object> attr = new Dictionary<string, object> { { "class", "full_width operators" } };
       if (is_hardcoded)
         attr.Add("disabled", "disabled");
        %>
    <div class="operator">
        <% string selected_operator_id = editing ? Convert.ToString(my_dict["OPERADOR"]):""; %>
        <%= Html.DropDownList("conditionitem-operator_" + ViewData["entity_id"] + "_" + ViewData["condition_item_index"]
                      , ReporteController.CreateConditionAttributeOperatorCombo(Convert.ToString(ViewData["entity_id"]), selected_attribute_id, selected_operator_id)
                      , attr) %>
                         
        
        
    </div>
    <div class="value">
      <input type="text" <%= (condition_is_param || is_hardcoded)?"disabled=\"disabled\"":"" %> value="<%= condition_value %>" class="full_width input_value" placeholder="value" name="conditionitem-value_<%= ViewData["entity_id"] %>_<%= ViewData["condition_item_index"] %>" />
    </div>
    <div class="is_param">
      
      <input type="checkbox" <%= condition_is_param?"checked":"" %> class="condition_item_is_param" name="conditionitem-isparam_<%= ViewData["entity_id"] %>_<%= ViewData["condition_item_index"] %>"/>Es parámetro
    </div>
    <div class="actions">
      <a href="#" class="delete_condition" style="font-size:10px;">Quitar condición</a>     
    </div>
    <div style="clear:both;"></div>
  </div>