﻿<%@ Page Title="" Language="C#"  Inherits="System.Web.Mvc.ViewPage" %>
<div id="area">
      <ul id="tabs">
        <li><a href="#" onclick="return false;">Something</a></li>


       <div class="btn-new-class">
        <a href="#" onclick="return false;"> Exportar a CSV</a>
       </div>

       <div class="btn-new-class">
        <a href="#" onclick="return false;"> Exportar a TXT</a>
       </div>


       <div id="btn-new">
        <a href="#" onclick="return false;"> Exportar a PDF</a>
       </div>

      </ul>
  <div class="split"></div>	
</div>

<!-- LEFT COL -->
<div class="col" style="width:100%;height:100%;">

	<div class="split-bar"></div>
	<h1>Reportes</h1>
  <!-- top -->

  <div style="padding:20px;">
    <form id="reporte" action="<%= Url.Content("~/Reporte/VerReporte") %>" method="post">

      <label>Reporte</label>
      <select name="reporte_id" id="reporte_id" style="margin:0; width:274px;" class="nexttab">
      <% foreach (Dictionary<string, string> reporte in (ViewData["reportes"] as List<object>))
          { 
	    %>
             <option value="<%= reporte["ID"] %>"><%= reporte["NOMBRE"] %></option>
       <% } 
      %>
      </select><br /><br />
      <div style="clear:both;"></div>
      <h4>Parámetros del reporte</h4>
      <div id="reporte_params" class="reporte_params">
        <div class="reporte_params_container">
          <label>Param #1</label><br />
          <input autocomplete="off" type="text" id="partida" name="partida" style="width:270px"/><br />
          <label class="desc">Formato: dd/mm/aa/ hh:mm</label><br />
        </div>
        
        <div class="reporte_params_container">
          <label>Param #2</label><br />
          <input autocomplete="off" type="text" id="eta" name="eta" style="width:270px"/><br />
        </div>
        
        <div class="reporte_params_container">
          <label>Param #3</label><br />
          <input autocomplete="off" type="text" id="Text1" name="partida" style="width:270px"/><br />
        </div>
        
        <div class="reporte_params_container">
          <label>Param #4</label><br />
          <input autocomplete="off" type="text" id="Text2" name="eta" style="width:270px"/><br />
          <label class="desc">Formato: dd/mm/aa/ hh:mm</label><br />
        </div>
      </div>
      <div style="clear:both;"></div>
      <br/>
      <input type="submit" class="botonsubmit" style="margin-left: 190px;display: block;padding: 7px 15px 7px 15px;margin: 0;text-decoration: none;text-align: center;font-size: 12px;color: black;background-color: #E6E6E6;border: #B4B4B4 solid 1px;" value="Ver Reporte" />
      
    </form>
  </div>
  <div style="clear:both;"></div>
  <div class="container" style="height:100%;">
    <div id="planilla" style="width: 100%;position: relative;">
      <h1>Reporte "Reporte de reportes"</h1>
      <table>
        <tr>
          <th>Col 1</th>
          <th>Col 2</th>
          <th>Col 3</th>
          <th>Col 4</th>
          <th>Col 5</th>
        </tr>
        <tr> 
          <td>Dato 1</td>
          <td>Dato 2</td>
          <td>Dato 3</td>
          <td>Dato 4</td>
          <td>Dato 5</td>
        </tr>
        <tr> 
          <td>Dato 1</td>
          <td>Dato 2</td>
          <td>Dato 3</td>
          <td>Dato 4</td>
          <td>Dato 5</td>
        </tr>
        <tr> 
          <td>Dato 1</td>
          <td>Dato 2</td>
          <td>Dato 3</td>
          <td>Dato 4</td>
          <td>Dato 5</td>
        </tr>
      </table>  
    </div>
    <div style="color:Red;height:50px;clear:both;">O si no hubo resultados...</div>
    <div class="box">
      <div class="empty">
				<p class="box-S">No hay datos que mostrar</p>
      </div>
    </div>
  </div>
</div>
	

<script type="text/javascript">
  buildButtons();
  jQuery("#reporte_id").change(function () { 
    
  });
</script>