<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

    <% 
      List<object> reporte = ViewData["reporte"] as List<object>;
      List<object> zonas = ViewData["zonas"] as List<object>;
      Dictionary<string, string> current, last;
      string tabletitle;
      if (int.Parse(ViewData["entrada"].ToString()) == int.Parse("0"))
      {
        if (ViewData["sentido"] == "1")
          tabletitle = "BUQUES DE SUBIDA";
        else
          tabletitle = "BUQUES DE BAJADA";
      }
      else
      {
        if (ViewData["sentido"] == "0")
          tabletitle = "BUQUES DE ENTRADA";
        else
          tabletitle = "BUQUES DE SALIDA";
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
        <th rowspan="2" scope="col">INICIO<BR />de ZOE</th>
        <% foreach (Dictionary<string, string> zona in zonas)
           { %>
            <th colspan="2" ><%= zona["CUATRIGRAMA"] + " - "+  zona["CANAL"]  + " - "+ zona["UNIDAD"]+" " + zona["KM"] %></th>
        <% } %>
        <th rowspan="2" scope="col">OBSEV.</th>
      </tr>
      <tr>
        <% foreach (Dictionary<string, string> ZONA in zonas)
           { %>
            <th>ETA</th>
            <th>HRP</th>
        <% } %>
      </tr>

      <%
        
        //Por todos los resultados de SQL
        int i = 0;
        while( i < reporte.Count )
        {

          //Una fila
          var row = reporte[i] as Dictionary<string,string>;

          if (row["SENTIDO"].ToString() != ViewData["sentido"].ToString())
          {
            i++;
            continue;
          }
          
          row["ETA"+row["ZONA"]] = row["ETA"];
          row["HRP"+row["ZONA"]] = row["HRP"];
          
          i++;
          
          //Joineo los rows de reportes
          while( i < reporte.Count )
          {
            if ((reporte[i] as Dictionary<string, string>)["NOMBRE"] != row["NOMBRE"])
              break;
            
            var nextrow = reporte[i] as Dictionary<string, string>;
            row["ETA" + nextrow["ZONA"]] = nextrow["ETA"];
            row["HRP" + nextrow["ZONA"]] = nextrow["HRP"];
            i++;
          }

          ViewData["row"] = row;
          Html.RenderPartial("_filareporte");
        }
        
      %>
      
      


</table>
