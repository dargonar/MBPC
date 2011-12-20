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
      var rep = new mbpcws.reports();

      var _params = new List<mbpcws.ReportParam>();

      //var p1 = new mbpcws.ReportParam();
      //p1.nombre = "Identificador de viaje";
      //p1.valor  = 662;
      //_params.Add(p1);

      var ds = rep.GetReport("secret_password", "Viajes activos", _params.ToArray());
      dataGrid.DataSource = ds.Tables[0];
    }
  }
}
