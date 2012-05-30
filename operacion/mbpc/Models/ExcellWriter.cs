using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;

using NPOI.HSSF.UserModel;
using NPOI.HPSF;
using NPOI.POIFS.FileSystem;
using NPOI.SS.UserModel;

namespace mbpc.Models
{
  public class ExcellWriter
  {

    public void Proccess(string nombre, List<object> rs, HttpResponseBase Response)
    {

            string filename=nombre;
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("Content-Disposition", string.Format("attachment;filename={0}",filename));
            Response.Clear();

            InitializeWorkbook();
            GenerateData(rs);            
            
            Response.BinaryWrite(WriteToStream().GetBuffer());
            Response.End();
        }

        HSSFWorkbook hssfworkbook;

        MemoryStream WriteToStream()
        { 
            //Write the stream data of workbook to the root directory
            MemoryStream file = new MemoryStream();
            hssfworkbook.Write(file);
            return file;
        }

        void GenerateData(List<object> rs)
        {
            ISheet sheet1 = hssfworkbook.CreateSheet("Hoja1");

            int x=0;

            bool first = true;
            foreach (Dictionary<string, string> item in rs)
            {
              var row=sheet1.CreateRow(x);
              int i = 0;
              x = x + 1;
              if (first)
              {
                foreach (var kv in item)
                {
                  if (kv.Key.EndsWith("_fmt")) continue;
                  row.CreateCell(i).SetCellValue(kv.Key);
                  i = i + 1;
                }

                first = false;
                row = sheet1.CreateRow(x);
                x = x + 1;
                i = 0;
              }

              foreach (var kv in item)
              {
                if (kv.Key.EndsWith("_fmt")) continue;
                row.CreateCell(i).SetCellValue(kv.Value);
                i = i + 1;
              }

            }
        }

        void InitializeWorkbook()
        {
            hssfworkbook = new HSSFWorkbook();

            ////create a entry of DocumentSummaryInformation
            DocumentSummaryInformation dsi = PropertySetFactory.CreateDocumentSummaryInformation();
            dsi.Company = "MBPC Reporte";
            hssfworkbook.DocumentSummaryInformation = dsi;

            ////create a entry of SummaryInformation
            SummaryInformation si = PropertySetFactory.CreateSummaryInformation();
            si.Subject = "MBPC";
            hssfworkbook.SummaryInformation = si;
        }
  
  }
}