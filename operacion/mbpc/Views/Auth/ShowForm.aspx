<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>MBPC</title>
  <link rel="stylesheet" type="text/css" href="<%= Url.Content("~/Content/layout.css") %>" />
</head>
<body>
  <div id="header"></div>
  <!--<p><strong>"Se informa que a partir del 05/03/12 el Sistema MBPC se ha integrado al Sistema de usuarios de la Intranet. Para poder acceder al mismo deberá usarse el usuario asignado en la Intranet. En caso de no poseer usuario, solicitarlo via MOI a DICOPNA.
Para consultas comunicarse al interno 2979 de 7 a 19 hs., a la cuenta de correo: dico-mbpc@prefecturanaval.gov.ar o por skype al usuario DICO-MBPC"</strong></p>-->
  
  <div style="height:auto;float:left" id="login">
      <h1>Login</h1>
      <div class="content">
          <form action="<%= Url.Action("login2","Auth") %>" method="post" >
            <%if(ViewData["msg"] != null) { %>
            <label style="float:left;margin-left:15px;"><span style="color:#000;"><strong><%=ViewData["msg"]%></strong></span></label><br /><br />
            <%}%>
            <label>DNI: <input type="text" name="username" id="usuario" autocomplete="off" /></label><br />
            <label>Password: <input type="password" name="password" id="password" /></label><br />
            <div></div>
            <label><span><%= ViewData["Error"] %></span></label>
          <br />
          <input type="submit" name="btn_login" id="btn_login" value="Login" />
          </form>
      </div><!-- content -->
  </div><!-- login -->

</body>
</html>
