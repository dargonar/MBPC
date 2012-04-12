using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace mbpc_wsclient
{
  public partial class Form1 : Form
  {
    public Form1()
    {
      InitializeComponent();
    }

    private void btnGo_Click(object sender, EventArgs e)
    {
      label1.Enabled = false;
      btnGo.Enabled = false;
      dtFecha.Enabled = false;
      lblLoading.Visible = true;
      pgLoading.Visible = true;

      var rep = new mbpcws.reports();

      var _params = new List<mbpcws.ReportParam>();

      var p1 = new mbpcws.ReportParam();
      p1.nombre = "fecha";
      p1.valor  = string.Format("{0:dd-MM-yy}",dtFecha.Value);
      _params.Add(p1);

      rep.GetReportCompleted += new mbpcws.GetReportCompletedEventHandler(rep_GetReportCompleted);
      rep.GetReportAsync("", "Hidrovia", _params.ToArray());
    }

    void rep_GetReportCompleted(object sender, mbpcws.GetReportCompletedEventArgs e)
    {
      label1.Enabled = true;
      btnGo.Enabled = true;
      dtFecha.Enabled = true;
      lblLoading.Visible = false;
      pgLoading.Visible = false;

      var ds = e.Result;
      dataGrid.DataSource = ds.Tables[0];
    }

    private void Form1_Load(object sender, EventArgs e)
    {
      
    }


  }
}
