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
        public ActionResult conditionItem(string entity) {
          
          ViewData["entity"] = entity;
          string mpath = string.Format("/sqlbuilder/entities/entity[@name='{0}']/attributes/attribute", entity);

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

          closeXml();
          xmlDoc = null;
          System.GC.Collect();

          return View();
        }

        public ActionResult entityItem(string entity)
        {
          ViewData["entity"] = entity;
          return View();
        }

        public ActionResult resultColumnItem() {
          return View();
        }

        public ActionResult nuevoReporte()
        {
          Session["grupos"] = null;

          if (Session["logged"] == null || int.Parse(Session["logged"].ToString()) == 0)
          {
            if (Request.UrlReferrer == null)
              Session["toreports"] = "true";

            return this.RedirectToAction("ShowForm", "Auth");
          }

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
          ViewData["operators_json"] = getOperatorsJson(xmlDoc);

          closeXml();
          xmlDoc = null;
          System.GC.Collect(); 
          return View();

        }

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
