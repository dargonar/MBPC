<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

    <% 
      Dictionary<string, Dictionary<string,string>> reporte = null;
      List<object> zonas = ViewData["zonas"] as List<object>;

      string tabletitle;

      if (ViewData["sentido"] == "1")
      {
        tabletitle = "BUQUES DE SUBIDA";
        reporte = ViewData["reporte_arriba"] as Dictionary<string, Dictionary<string,string>>;
      }
      else
      {
        tabletitle = "BUQUES DE BAJADA";
        reporte = ViewData["reporte_abajo"] as Dictionary<string, Dictionary<string, string>>;
      }
      
    %>

    <h1><%= tabletitle %> </h1>
    <table>
      <tr>
        <th rowspan="2" scope="col">NOMBRE DEL BUQUE</th>
        <th rowspan="2" scope="col">S/DIST</th>
        <th rowspan="2" scope="col">BAND.</th>
        <th rowspan="2" scope="col">F.M</th>
        <th rowspan="2" scope="col">T.O</th>
        <th rowspan="2" scope="col">CAL.</th>
        <th rowspan="2" scope="col">VEL.</th>
        <th rowspan="2" scope="col">INICIO<BR/>de ZOE</th>
        <% foreach (Dictionary<string, string> zona in zonas)
           {
               string nombre = string.Empty;
               if (zona["KM"] == "0")
                   nombre = zona["CANAL"] + " - " + zona["UNIDAD"];
               else
                   nombre = zona["CANAL"] + " - " + zona["UNIDAD"] + " " + zona["KM"];               
            %>
            <th colspan="2" ><%= nombre %></th>
        <% } %>
        <th rowspan="2" scope="col">OBSEV.</th>
      </tr>
      <tr>
        <% 
           foreach (Dictionary<string, string> ZONA in zonas)
           { %>
            <th>ETA</th>
            <th>HRP</th>
        <% } %>
      </tr>

      <%
        
        //Por todos los resultados de SQL
        foreach(KeyValuePair<string,Dictionary<string,string>> kp in reporte)
        {
          //Una fila
          ViewData["row"] = kp.Value;
          Html.RenderPartial("_filareporte");
        }
        
      %>
      
      


</table>
