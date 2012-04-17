<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>MBPC</title>
  <link rel="stylesheet" type="text/css" href="<%= Url.Content("~/Content/layout.css") %>" />
  <style>
    .tabla_content-body-wrapper { 
      display:table; 
      border-collapse:collapse; 
      width:600px;
      height:auto;
      margin-left:-150px;
      padding-top:150px;
    } 
 
    .tabla_content-body { 
      display:table-row; 
    } 
 
    .tabla_td{ 
      display:table-cell; 
      border:1px solid #e9e9e9;
      padding:1px;
      min-height:100px;
      width:50%;
      overflow-y:auto;overflow-x:hidden;
    }
  </style>
</head>
<body>
  <div id="header"></div>
  <!--<p><strong>"Se informa que a partir del 05/03/12 el Sistema MBPC se ha integrado al Sistema de usuarios de la Intranet. Para poder acceder al mismo deberá usarse el usuario asignado en la Intranet. En caso de no poseer usuario, solicitarlo via MOI a DICOPNA.
Para consultas comunicarse al interno 2979 de 7 a 19 hs., a la cuenta de correo: dico-mbpc@prefecturanaval.gov.ar o por skype al usuario DICO-MBPC"</strong></p>-->
  
  <div style="height:auto;float:left" id="login">
    <div style="border:1px solid #b4b4b4;">
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
    </div>
    <br/>

    <div class="tabla_content-body-wrapper"> 
      <div class="tabla_content-body"> 
        <div id="novedades" class="tabla_td"><h1>Novedades</h1><br /><%=ViewData["novedades"]%></div> 
        <div id="recomendaciones" class="tabla_td"><h1>Recomendaciones</h1><br /><%=ViewData["recomendaciones"]%></div> 
      </div>
    </div>
  </div><!-- login -->
</body>
</html>
