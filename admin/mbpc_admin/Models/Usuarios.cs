using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace mbpc_admin.Models
{


  public class Usuario
  {

    public Usuario map(Dictionary<string, string> data)
    {
      this.NDOC = data["NDOC"];
      this.PASSWORD = data["PASSWORD"];
      this.APELLIDO = data["APELLIDO"];
      this.NOMBRES = data["NOMBRES"];
      this.DESTINO = data["DESTINO"];
      this.FECHAVENC = data["FECHAVENC"];
      this.TEDIRECTO = data["TEDIRECTO"];
      this.TEINTERNO = data["TEINTERNO"];
      this.EMAIL = data["EMAIL"];
      this.ESTADO = data["ESTADO"];
      this.SECCION = data["SECCION"];
      this.NDOC_ADMIN = data["NDOC_ADMIN"];
      this.FECHA_AUDIT = data["FECHA_AUDIT"];
      this.NOMBREDEUSUARIO = data["NOMBREDEUSUARIO"];
      this.USUARIO_ID = data["USUARIO_ID"];
      return this;
    }



    public string NDOC { get; set; }

    [Required(ErrorMessage="Se requiere este campo")]
    public string PASSWORD { get; set; }


    [Required(ErrorMessage = "Se requiere este campo")]
    public string APELLIDO { get; set; }

    [Required(ErrorMessage = "Se requiere este campo")]
    public string NOMBRES { get; set; }
    [Required(ErrorMessage = "Se requiere este campo")]


  
    [StringLength(4, ErrorMessage="el codigo destino son 4 caracteres")]
    public string DESTINO { get; set; }

    [DataType(DataType.DateTime)]
    public string FECHAVENC { get; set; }

    public string TEDIRECTO { get; set; }

    public string TEINTERNO { get; set; }

    [DataType(DataType.EmailAddress)]
    public string EMAIL { get; set; }

    public string ESTADO { get; set; }

    public string SECCION { get; set; }

    public string NDOC_ADMIN { get; set; }

    [DataType(DataType.DateTime)]
    public string FECHA_AUDIT { get; set; }


    [Required(ErrorMessage = "Se requiere este campo")]
    public string NOMBREDEUSUARIO { get; set; }


    [Required(ErrorMessage = "Se requiere este campo")]
    public string USUARIO_ID { get; set; }    

  }
}