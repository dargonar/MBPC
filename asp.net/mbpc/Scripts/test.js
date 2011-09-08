$('#nacional').click()

function nacion() {
  $('#bandera').attr('disabled', 'disabled');
  $('#bandera').val('100');
  $('#matlabel').html('Matricula');

  return false;
}


function internacional() {

  $('#bandera').removeAttr('disabled');
  $('#bandera').val('');
  $('#matlabel').html('MMSI');
  return false;
}

$("#nuevoBuque").submit(function () {

  if ($("#matriculaN").val() == "") {
    alert("Debe ingresar la matricula");
    return false;
  }
  if ($("#nombreN").val() == "") {
    alert("Debe ingresar un nombre");
    return false;
  }
  if ($("#sdist").val() == "") {
    alert("Debe ingresar la señal distintiva");
    return false;
  }


  $.ajax({
    type: "POST",
    cache: false,
    url: $(this).attr('action'),
    data: $(this).serialize(),
    success: (function (data) {
      $('#dialogdiv3').dialog('close');
      pegar_y_cerrar($('#nombreN').val(), $("#matriculaN").val());
    }),
    error: (function (data) {
      alert(data.responseXML);
      //            var xmlDoc;
      //            xmlDoc = data.responseXml;
      //            x = xmlDoc.getElementsByTagName("title")[0].childNodes[0];
      //            alert(x.nodeValue);
      //<TAG\b[^>]*>(.*?)</TAG>
    })
  });
  return false;
});
