<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>MBPC</title>
  <link rel="stylesheet" type="text/css" href="<%= Url.Content("~/Content/login.css") %>" />
</head>
<body>
  <div id="header"></div>
  <div id="login">
      <h1>Login</h1>
      <div class="content">
          <form action="<%= Url.Action("login","Auth") %>" method="post" >
            <label>Usuario: <input type="text" name="username" id="usuario" autocomplete="off" /></label>
            <label>Password: <input type="password" name="password" id="password" /></label>
            <div></div>
            <label><span><%= ViewData["Error"] %></span></label>
          <br />
          <input type="submit" name="btn_login" id="btn_login" value="Login" />
          </form>
      </div><!-- content -->
  </div><!-- login -->
</body>
</html>
