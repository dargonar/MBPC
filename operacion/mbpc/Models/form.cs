using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace mbpc.Models
{
  public class formfield
  {

    public formfield(string columna, string valor, string msg)
    {
      this.columna = columna;
      this.value = valor;
      this.msg = msg;
    }

    public string msg { get; set; }
    public string columna { get; set; }
    public string value { get; set; }
  }



 

}