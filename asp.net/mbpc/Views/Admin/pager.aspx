<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Register TagPrefix="controls" TagName="ship" Src="../Shared/ShipItem.ascx" %>



<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Admin
</asp:Content>

<asp:Content ID="Content0" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<% List<object> resultados = ViewData["results"] as List<object>; %>


        <!-- Alternative Content Box Start -->
  <div class="contentcontainer">
    <div class="headings altheading">
        <h2>Alternative coloured heading</h2>
    </div>
    <div class="contentbox">
      <table width="100%">
          <thead>
              <tr>
                    <% foreach (string key in (resultados[0] as Dictionary<string, string>).Keys)
                       {
                         Response.Write("<th>" + key + "</th>");
                       }
                    %>
                    <th><input name="" type="checkbox" value="" id="checkboxall" /></th>
                </tr>
            </thead>
            <tbody>

              <% var i = 0; 
                foreach (Dictionary<string, string> row in resultados)
                 { %>
                  <tr <%= i % 2 == 0 ? "" : "class=\"alt\"" %>>

                  <%foreach (string key in row.Keys)
                  {
                  %>      
                     <td> <%= row[key] %></td>
                  <%    
                  }
                 %>

                  <td>
                        <a href="#" title=""><img src="/img/icons/icon_edit.png" alt="Edit" /></a>
                        <a href="#" title=""><img src="/img/icons/icon_approve.png" alt="Approve" /></a>
                        <a href="#" title=""><img src="/img/icons/icon_unapprove.png" alt="Unapprove" /></a>
                        <a href="#" title=""><img src="/img/icons/icon_delete.png" alt="Delete" /></a>
                    </td>
                    <td><input type="checkbox" value="" name="checkall" /></td>
                </tr>

                <% i++;
                 } %>


            </tbody>
        </table>
        <div class="extrabottom">
          <ul>
              <li><img src="/img/icons/icon_edit.png" alt="Edit" /> Edit</li>
                <li><img src="/img/icons/icon_approve.png" alt="Approve" /> Approve</li>
                <li><img src="/img/icons/icon_unapprove.png" alt="Unapprove" /> Unapprove</li>
                <li><img src="/img/icons/icon_delete.png" alt="Delete" /> Remove</li>
            </ul>
            <div class="bulkactions">
              <select>
                  <option>Select bulk action...</option>
                </select>
                <input type="submit" value="Apply" class="btn" />
            </div>
        </div>

        <%= ViewData["pagelinks"] %>


        <div style="clear: both;"></div>
    </div>
            
</div>
<!-- Alternative Content Box End -->





</asp:Content>

