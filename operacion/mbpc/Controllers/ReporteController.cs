using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Globalization;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.IO;

using System.Xml;
using System.Xml.XPath;
using Newtonsoft.Json;

using System.Text;

namespace mbpc.Controllers
{
    public class ReporteController : MyController
    {
        // GET: /Reporte/
      private static string fileName = "C:\\dago\\wdir\\mbpc\\operacion\\mbpc\\Res\\mbpc_sqlbuilder_metadata.xml";
        
        public ActionResult Index()
        {
          Session["grupos"] = null;

          if (Session["logged"] == null || int.Parse(Session["logged"].ToString()) == 0)
          {
            if(Request.UrlReferrer == null)
              Session["toreports"] = "true";

            return this.RedirectToAction("ShowForm", "Auth");
          }
          
          ViewData["datos_del_usuario"] = DaoLib.datos_del_usuario(Session["usuario"].ToString());
          ViewData["reportes"] = DaoLib.reporte_lista();

          return View();
        }

        public ActionResult ParamsFor(int id)
        {
          ViewData["params"] = DaoLib.reporte_obtener_parametros(id);
          return View("_params");
        }

      /* ***********************************************************************/
      /* Visual Query Builder **************************************************/
        
      // XML reader
        private static XmlReader xmlReader = null;
                
        private XmlDocument openSQLConfig()
        {
          ReporteController.xmlReader = XmlReader.Create(System.IO.File.Open(fileName, FileMode.Open));
          
          XmlDocument xml = new XmlDocument();
          xml.Load(ReporteController.xmlReader);
          ReporteController.xmlReader.Close();
          return xml;
        }

        private void closeXml(){
        if (ReporteController.xmlReader == null)
          return;  
        
        ReporteController.xmlReader.Close();
        ReporteController.xmlReader = null;
      }
        
      // Operadores según tipo de dato/field.
        private SortedDictionary<string, SortedDictionary<string, string>> getOperators(XmlDocument xmlDoc)
        {
          string mpath = "/sqlbuilder/operators/operator";

          SortedDictionary<string, SortedDictionary<string, string>> operators = new SortedDictionary<string, SortedDictionary<string, string>>();

          foreach (XmlNode entity in xmlDoc.SelectNodes(mpath))
          {
            string type = entity.Attributes.GetNamedItem("type").Value;
            SortedDictionary<string, string> curOperators = new SortedDictionary<string, string>();
            foreach (XmlNode oper in entity.SelectNodes(string.Format("{0}[@type='{1}']/oper",mpath, type)))
            {
              string oper_id = oper.Attributes.GetNamedItem("id").Value;
              string oper_description = oper.Attributes.GetNamedItem("description").Value;
              curOperators.Add(oper_id, oper_description);
            }

            operators.Add(type, curOperators);
          }


          return operators;
        }

        private string getOperatorsJson(XmlDocument xmlDoc)
        {
          return JsonConvert.SerializeXmlNode(xmlDoc.SelectSingleNode("/sqlbuilder/operators"), Newtonsoft.Json.Formatting.Indented, true);
          
        }

        public ActionResult operatorByType(string data_type)
        {
          XmlDocument xmlDoc = openSQLConfig(); 
          
          ViewData["operators"] = getOperatorByType(data_type, xmlDoc);

          closeXml();
          xmlDoc = null;
          System.GC.Collect();

          return View();
        }

        private SortedDictionary<string, string> getOperatorByType(string data_type, XmlDocument xmlDoc)
        {
          string mpath = string.Format("/sqlbuilder/operators/operator[@type='{0}']/oper", data_type);
          SortedDictionary<string, string> operators = new SortedDictionary<string, string>();
          foreach (XmlNode oper in xmlDoc.SelectNodes(mpath))
          {
            string oper_id = oper.Attributes.GetNamedItem("id").Value;
            string oper_description = oper.Attributes.GetNamedItem("description").Value;
            operators.Add(oper_id, oper_description);
          }
          return operators;
        }
      // 
        public ActionResult conditionItem(string entity, string last) {
          
          ViewData["entity"] = entity;
          string mpath = string.Format("/sqlbuilder/entities/entity[@name='{0}']/attributes/attribute[@is_filter=1]", entity);

          SortedDictionary<string, Dictionary<string, string>> attributes = new SortedDictionary<string, Dictionary<string, string>>();
          
          XmlDocument xmlDoc = openSQLConfig();

          foreach (XmlNode attr in xmlDoc.SelectNodes(mpath))
          {
            string attr_id = attr.Attributes.GetNamedItem("id").Value;
            string attr_description = attr.Attributes.GetNamedItem("description").Value;
            string attr_type = attr.Attributes.GetNamedItem("type").Value;
            Dictionary<string, string> attr_data = new Dictionary<string, string>();
            attr_data.Add("id", attr_id);
            attr_data.Add("type", attr_type);
            attributes.Add(attr_description, attr_data);
          }
          
          string key = attributes.Keys.First();
          ViewData["attributes"]  = attributes;
          ViewData["operators"] = getOperatorByType(attributes[key]["type"], xmlDoc);

          string mentitypath = string.Format("/sqlbuilder/entities/entity[@name='{0}']", entity);
          ViewData["entity_id"] = xmlDoc.SelectSingleNode(mentitypath).Attributes.GetNamedItem("id").Value;
          ViewData["condition_item_index"] = 1;
          if (!String.IsNullOrEmpty(last)) 
          {
            ViewData["condition_item_index"] = Convert.ToInt32(last.Split('_')[1])+1;
          }

          closeXml();
          xmlDoc = null;
          System.GC.Collect();

          return View();
        }

        public ActionResult entityItem(string entity, string last)
        {
          ViewData["entity"]        = entity;
          XmlDocument xmlDoc = openSQLConfig(); 
          string mentitypath = string.Format("/sqlbuilder/entities/entity[@name='{0}']", entity);
          ViewData["entity_id"] = xmlDoc.SelectSingleNode(mentitypath).Attributes.GetNamedItem("id").Value;

          ViewData["entity_index"] = 1;
          if (!String.IsNullOrEmpty(last)) 
          {
            ViewData["entity_index"] = Convert.ToInt32(last.Split('_')[1])+1;
          }

          closeXml();
          xmlDoc = null;
          System.GC.Collect();

          return View();
        }

        public ActionResult resultColumnItem(string entities, string last) {

          ViewData["resultcolumn_index"] = 1;
          if (!String.IsNullOrEmpty(last))
          {
            ViewData["resultcolumn_index"] = Convert.ToInt32(last.Split('_')[1]) + 1;
          }

          string[] entities_array = entities.Split(',');
          if (entities_array.Length == 0)
          {
            ViewData["entities"] = new SortedDictionary<string, List<string>>();
            return View();
          }

          ViewData["attributes_by_entity"] = getAttributesByEntities(entities_array);

          return View();
        }

        public ActionResult orderColumnItem(string entities, string last)
        {
          ViewData["ordercolumn_index"] = 1;
          if (!String.IsNullOrEmpty(last))
          {
            ViewData["ordercolumn_index"] = Convert.ToInt32(last.Split('_')[1]) + 1;
          }

          string[] entities_array = entities.Split(',');
          if (entities_array.Length == 0)
          {
            ViewData["entities"] = new SortedDictionary<string, List<string>>();
            return View();
          }

          ViewData["attributes_by_entity"] = getAttributesByEntities(entities_array);
          
          return View();
        }

        private SortedDictionary<string, SortedDictionary<string, string>> getAttributesByEntities(string[] entities_array)
        {
          SortedDictionary<string, SortedDictionary<string, string>> attributes_by_entity = new SortedDictionary<string, SortedDictionary<string, string>>();

          XmlDocument xmlDoc = openSQLConfig();

          foreach (string entity in entities_array)
          {
            string mpath = string.Format("/sqlbuilder/entities/entity[@name='{0}']/attributes/attribute", entity);
            SortedDictionary<string, string> cur_attributes = new SortedDictionary<string, string>();
            
            foreach (XmlNode attr in xmlDoc.SelectNodes(mpath))
            {
              string attr_id = attr.Attributes.GetNamedItem("id").Value;
              string attr_description = attr.Attributes.GetNamedItem("description").Value;
              cur_attributes.Add(attr_description, attr_id);
            }
            attributes_by_entity.Add(entity, cur_attributes);
          }
          
          closeXml();
          xmlDoc = null;
          System.GC.Collect();

          return attributes_by_entity;
        }

        public ActionResult eliminar(string id)
        {
          ViewData["datos_del_usuario"] = DaoLib.datos_del_usuario(Session["usuario"].ToString());
          DaoLib.reporte_eliminar(Convert.ToInt32(id));
          ViewData["deleted"]="El reporte fue aliminado satisfactoriamente.";
          return this.RedirectToAction("listar", "Reporte");
        }
        public ActionResult editar(string id) 
        {
          ViewData["datos_del_usuario"] = DaoLib.datos_del_usuario(Session["usuario"].ToString());
          int ireporte_id = Convert.ToInt32(id);
          var reporte = DaoLib.reporte_obtener(ireporte_id) as Dictionary<string, string>;
          ViewData["form"] = reporte["FORM"];
          ViewData["json_params"] = reporte["JSON_PARAMS"]; 
          ViewData["editing"] = true;
          ViewData["id"] = id;
          return View("nuevo");
        }

        public ActionResult dummy()
        {
          return View();
        }

        public ActionResult listar() 
        {
          ViewData["datos_del_usuario"] = DaoLib.datos_del_usuario(Session["usuario"].ToString());
          List<object> res = DaoLib.reporte_obtener_html_builded();
          ViewData["reportes"] = res;
          return View();
        }
        
        public ActionResult nuevo()
        {
          ViewData["datos_del_usuario"] = DaoLib.datos_del_usuario(Session["usuario"].ToString());

          string mpath = "/sqlbuilder/entities/entity";
          
          SortedDictionary<string, string> entities = new SortedDictionary<string, string>();

          XmlDocument xmlDoc = openSQLConfig();

          foreach (XmlNode entity in xmlDoc.SelectNodes(mpath))
          {
            string name = entity.Attributes.GetNamedItem("name").Value;
            System.Text.StringBuilder relationsSB = new System.Text.StringBuilder();
            foreach (XmlNode relation in entity.SelectNodes(string.Format("/sqlbuilder/entities/entity[@name='{0}']/relations/relation", name)))
            {
              string relation_name = relation.Attributes.GetNamedItem("target").Value.Trim();
              relationsSB.AppendFormat((relationsSB.Length > 0 ? ",{0}" : "{0}"), relation_name);
            }

            entities.Add(name, relationsSB.ToString());
          }

          ViewData["entities"] = entities;
          ViewData["operators"] = getOperators(xmlDoc);
          //ViewData["operators_json"] = getOperatorsJson(xmlDoc);
          
          closeXml();
          xmlDoc = null;
          System.GC.Collect(); 
          return View();

        }
        
        [ValidateInput(false)]
        public ActionResult guardar(string id) {

          int editing_reporte_id = 0;
          if (!String.IsNullOrEmpty(id))
          {
            editing_reporte_id = Convert.ToInt32(id);
            // A ACTUALIZAR!!
          }

          // Me guardo los nombres de las entidades y los id.
          Dictionary<string, string> entities = new Dictionary<string, string>();
          // Lista de ids de entidades, temporal.
          List<string> entities_id_list_tmp = new List<string>();
          
          foreach (string item in Request.Form["entities_list"].Split(','))
          {
            string[] splitted_item = item.Split('=');
            entities.Add(splitted_item[1], splitted_item[0]);
            entities_id_list_tmp.Add(splitted_item[1]);
          }
          // Lista de entidades, para indexarlas por orden de llegada en los params del post.
          string[] entities_id = entities_id_list_tmp.ToArray();
          entities_id_list_tmp = null;

          // Lista de cantidad de condiciones (where clauses) por entidad.
          Dictionary<string, int> conditions_by_entity_count = new Dictionary<string, int>();
          foreach (string item in Request.Form["conditions_by_entity_count"].Split(',')) {
            string[] splitted_item = item.Split('=');
            conditions_by_entity_count.Add(splitted_item[0], Convert.ToInt32(splitted_item[1]));
          }

          // WHERE clause.
          StringBuilder strConditions = new StringBuilder();
          XmlDocument xmlDoc = openSQLConfig();

          Dictionary<string, Dictionary<string, string>> reporteParams = new Dictionary<string, Dictionary<string, string>>();
          int index = 0;
          int paramCount = 1;
          int total_condition_count = 0;
          foreach (KeyValuePair<string, int> pair in conditions_by_entity_count)
          {
            int current_snorbol = 1;
            int condition_count = 0;
            
            while (condition_count < pair.Value)
            {
              if (Request.Form["conditionitem-attribute_" + entities_id[index] + "_" + current_snorbol.ToString()] != null)
              {
                string attr = Request.Form["conditionitem-attribute_" + entities_id[index] + "_" + current_snorbol.ToString()];
                string oper = Request.Form["conditionitem-operator_" + entities_id[index] + "_" + current_snorbol.ToString()];
                string value = Request.Form["conditionitem-value_" + entities_id[index] + "_" + current_snorbol.ToString()];
                string is_param = Request.Form["conditionitem-isparam_" + entities_id[index] + "_" + current_snorbol.ToString()];

                string the_entity = entities[entities_id[index]];
                string type = xmlDoc.SelectSingleNode(string.Format("/sqlbuilder/entities/entity/attributes/attribute[@id='{0}']", attr)).Attributes.GetNamedItem("type").Value.Trim();
                
                string sql = "";

                string sql_column = xmlDoc.SelectSingleNode(string.Format("/sqlbuilder/entities/entity/attributes/attribute[@id='{0}']", attr)).Attributes.GetNamedItem("sql_column").Value.Trim();

                if (type != "hardcoded")
                {
                  string value_format = xmlDoc.SelectSingleNode(string.Format("/sqlbuilder/operators/operator[@type='{0}']", type)).Attributes.GetNamedItem("format").Value.Trim();
                  if (!String.IsNullOrEmpty(value_format))
                    value = String.Format(value_format, value);

                  if (is_param != null && is_param.Equals("on"))
                  {
                    value = string.Format(":p{0}", paramCount.ToString());
                    string name = xmlDoc.SelectSingleNode(string.Format("/sqlbuilder/entities/entity/attributes/attribute[@id='{0}']", attr)).Attributes.GetNamedItem("name").Value.Trim();

                    Dictionary<string, string> paramData = new Dictionary<string, string>();
                    paramData.Add("data_type", Convert.ToInt32(Enum.Parse(typeof(ReporteParamDataType), type.ToUpper())).ToString());
                    paramData.Add("name", Models.Hlp.GenerateSlug(name)); 
                    
                    reporteParams.Add(value, paramData);
                    
                    paramCount++;
                    sql = string.Format(" {0} = {1} ", sql_column, value);
                  }
                  else
                  {
                    string oper_format = xmlDoc.SelectSingleNode(string.Format("/sqlbuilder/operators/operator/oper[@id='{0}']", oper)).Attributes.GetNamedItem("format").Value.Trim();
                    sql = oper_format.Replace("$c", sql_column);
                    sql = sql.Replace("$v", value);
                  }
                  
                }
                else
                {
                  value = xmlDoc.SelectSingleNode(string.Format("/sqlbuilder/entities/entity/attributes/attribute[@id='{0}']", attr)).Attributes.GetNamedItem("value").Value.Trim();
                  sql = string.Format(" {0} = {1} ", sql_column, value);
                }

                if (!String.IsNullOrEmpty(sql))
                {
                  if (String.IsNullOrEmpty(strConditions.ToString()))
                      strConditions.AppendFormat(" WHERE ");
                  strConditions.AppendFormat(" {0} {1} ", (total_condition_count > 0 ? "AND" : ""), sql);
                  total_condition_count++; // -> *Cuando pones condiciones de dos entidades distintas, falta un AND entre medio
                }
                condition_count++;
                               
              }
              current_snorbol++;
            }
            index++;
          }

          // SELECT clause.
          int resultfields_count = Convert.ToInt32(Request.Form["resultfields_count"]);
          StringBuilder strSelect = new StringBuilder();
          strSelect.AppendFormat(" SELECT ");
          index = 0;
          int my_resultfields_count = 0;
          int current_snajdarg = 1;
          
          while (my_resultfields_count < resultfields_count)
          {
            if (Request.Form["resultcolumn-field_" + current_snajdarg.ToString()] != null) 
            {
              string field = Request.Form["resultcolumn-field_" + current_snajdarg.ToString()];
              string value = Request.Form["resultcolumn-value_" + current_snajdarg.ToString()];
              if (!String.IsNullOrEmpty(value))
                value = Models.Hlp.GenerateSlug(value) ;//value.Replace(" ", "_");
              string the_field = xmlDoc.SelectSingleNode(string.Format("/sqlbuilder/entities/entity/attributes/attribute[@id='{0}']", field.Split('.')[1])).Attributes.GetNamedItem("sql_column").Value.Trim();

              string sql = string.Format("{0} {1}", the_field, String.IsNullOrEmpty(value) ? "" : string.Format(" as {0}", value));
              strSelect.AppendFormat(" {0} {1} ", (my_resultfields_count>0?", ":""), sql);
              my_resultfields_count++;
            }
            current_snajdarg++;
            
            index++;
          }

          strSelect.AppendFormat(" FROM ");
          Dictionary<string, string> relations = new Dictionary<string, string>();
          int fromIndex = 0;
          foreach (string key in entities.Keys)
          {
            string entity = entities[key];
            string sql = xmlDoc.SelectSingleNode(string.Format("/sqlbuilder/entities/entity[@name='{0}']/sql", entity)).InnerText.Trim();
            foreach (XmlNode relation in xmlDoc.SelectNodes(string.Format("/sqlbuilder/entities/entity[@name='{0}']/relations/relation", entity)))
            { 
              string target = relation.Attributes.GetNamedItem("target").Value.Trim();
              if (!relations.ContainsKey(target))
                relations.Add(target, relation.ChildNodes[0].InnerText.Trim());
            }

            if (fromIndex == 0)
            {
              strSelect.AppendFormat(" {0} ",sql);
            }
            else
            {
              strSelect.AppendFormat(" {0} ", relations[entity]);
            }
            fromIndex++;
          }
          
          // Order.
          int orderfields_count = Convert.ToInt32(Request.Form["orderfields_count"]);

          StringBuilder strOrder = new StringBuilder();
          
          index = 0;
          int my_orderfields_count = 0;
          current_snajdarg = 1;

          while (my_orderfields_count < orderfields_count)
          {
            if (Request.Form["ordercolumn-field_" + current_snajdarg.ToString()] != null) { }
            {
              string field = Request.Form["ordercolumn-field_" + current_snajdarg.ToString()];
              string sort = Request.Form["ordercolumn-value_" + current_snajdarg.ToString()];

              string the_field = xmlDoc.SelectSingleNode(string.Format("/sqlbuilder/entities/entity/attributes/attribute[@id='{0}']", field.Split('.')[1])).Attributes.GetNamedItem("sql_column").Value.Trim();

              if(index==0)
                strOrder.AppendFormat(" ORDER BY ");
              strOrder.AppendFormat(" {0} {1} {2} ", (my_orderfields_count > 0 ? "," : ""), the_field, sort);
              my_orderfields_count++;
            }
            current_snajdarg++;

            index++;
          }

          closeXml();
          xmlDoc = null;
          System.GC.Collect(); 
          
          string reporte_sql = strSelect.ToString() + strConditions.ToString() + strOrder.ToString();
          ViewData["response"] = reporte_sql;
          
          // Parametros que van derecho al datastore.
          string serialized_form = Request.Form["serialized_form"];
          string html_form = Request.Form["html_form"];
          string json_form = Request.Form["json_form"]; 
          string nombre_reporte = Request.Form["nombre_reporte"];

          List<object> res = null;
          int lastReportId = editing_reporte_id;
          if (editing_reporte_id > 0)
            res = DaoLib.reporte_actualizar(editing_reporte_id, nombre_reporte, nombre_reporte, 1, reporte_sql, serialized_form, html_form, json_form);
          else
          {
            res = DaoLib.reporte_insertar(nombre_reporte, nombre_reporte, 1, reporte_sql, serialized_form, html_form, json_form);
            Dictionary<string, string> resDict = ((res[0]) as Dictionary<string, string>);
            lastReportId = Convert.ToInt32(resDict[resDict.Keys.ElementAt(0)]);
          }
          

          List<int> reporte_id = new List<int>();
          List<int> indice = new List<int>();
          List<int> tipo_dato = new List<int>();
          List<string> nombre = new List<string>();

          index = 1;
          foreach (KeyValuePair<string, Dictionary<string, string>> data in reporteParams)
          {
            reporte_id.Add(lastReportId);
            indice.Add(index);
            tipo_dato.Add(Convert.ToInt32(data.Value["data_type"]));
            nombre.Add(data.Value["name"]);
            index++;
          }

          if (editing_reporte_id > 0)
          {
            DaoLib.reporte_eliminar_params(editing_reporte_id);
          } 
          
          if (nombre.Count > 0)
          {
            List<object> res2 = DaoLib.reporte_insertar_params(reporte_id.ToArray(), indice.ToArray(), nombre.ToArray(), tipo_dato.ToArray());
          }

          return this.RedirectToAction("editar", "Reporte", new { id = lastReportId.ToString() });
          //return View();
        }

        public enum ReporteParamDataType
        {
          DATE, INTEGER, DECIMAL, STRING
        }

        /* Visual Query Builder **************************************************/
        /* ***********************************************************************/
        
        public ActionResult Ver(int reporte_id, int count, string print_me)
        {
          var rep     = DaoLib.reporte_obtener(reporte_id) as Dictionary<string, string>;
          var _params = DaoLib.reporte_obtener_parametros(reporte_id);

          var lparams = new List<OracleParameter>();

          for (int i = 0; i < count; i++)
          {
            var param = _params.Find( o => (o as Dictionary<string,string>)["INDICE"] == (i+1).ToString() ) as Dictionary<string,string>;

            object value = Request.Params["param" + (i + 1).ToString()];

            string pname = ":p" + (i + 1).ToString();

            string tmp=rep["CONSULTA_SQL"];
            int qcount = tmp.Select((c, j) => tmp.Substring(j)).Count(sub => sub.StartsWith(pname));
            for (int k = 0; k < qcount; k++)
            {
              if (param["TIPO_DATO"] == "0")
                lparams.Add(new OracleParameter(pname, OracleDbType.Varchar2, value, System.Data.ParameterDirection.Input));

              if (param["TIPO_DATO"] == "1")
                lparams.Add(new OracleParameter(pname, OracleDbType.Varchar2, value, System.Data.ParameterDirection.Input));

              if (param["TIPO_DATO"] == "2")
                lparams.Add(new OracleParameter(pname, OracleDbType.Varchar2, value, System.Data.ParameterDirection.Input));

              if (param["TIPO_DATO"] == "3")
                lparams.Add(new OracleParameter(pname, OracleDbType.Varchar2, value, System.Data.ParameterDirection.Input));
            }
          }

          var cmd = new OracleCommand(rep["CONSULTA_SQL"]);
          cmd.Parameters.AddRange(lparams.ToArray());

          var rs = DaoLib.doSQL(cmd);

          //Print?
          if (print_me != null)
          {
            StringWriter sw = new StringWriter();

            //First line for column names
            var first = true;
            
            foreach(Dictionary<string, string> item in rs) 
            {
              if (first) 
              {
                string tmp = string.Empty;
                foreach(var kv in item) 
                {
                  if(kv.Key.EndsWith("_fmt")) continue;
                  tmp = tmp + "\"" + kv.Key + "\",";
                }

                first = false;
                sw.WriteLine(tmp.Substring(0,tmp.Length-1));
              }

              string tmp2 = string.Empty;
              foreach(var kv in item) 
              {
                if(kv.Key.EndsWith("_fmt")) continue;
                tmp2 = tmp2 + "\"" + kv.Value + "\",";
              }
              
              sw.WriteLine(tmp2.Substring(0,tmp2.Length-1));
            }

            Response.AddHeader("Content-Disposition", "attachment; filename=test.csv");
            Response.ContentType = "text/csv";
            Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            Response.Write(sw);
            Response.End();

            return null;
          }

          if (rs.Count == 0)
            return View("_result_empty");

          ViewData["result"]  = rs;
          ViewData["reporte"] = rep;

          return View("_result");
        }
    }
}
