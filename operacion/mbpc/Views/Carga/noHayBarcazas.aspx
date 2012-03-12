<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<p><strong>No hay barcazas para transferir<strong><p>
<a id="dummy" href="<%= Url.Content("~/Home/RefrescarColumnas") %>"></a>
<script type="text/javascript">

  $.ajax({
    type: "GET",
    cache: false,
    url: $('#dummy').attr('href'),
    success: (function (data) {
      if (data == "nop")
        $('#list').trigger('reloadGrid');
      else
        $("#columnas").html(data);

      $("#fullscreen").css("display", "none");
    }),
    error: (function (data) {
      $("#fullscreen").css("display", "none");
      var titletag = /<title\b[^>]*>.*?<\/title>/
      alert(titletag.exec(data.responseText));
    })
  });


  $('#dialogdiv').dialog('close');

</script>