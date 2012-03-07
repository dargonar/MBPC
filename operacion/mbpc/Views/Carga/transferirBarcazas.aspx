<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<p><strong>Transferencia ok<strong><p>

<a id="dummy" href="<%= Url.Content("~/Home/RefrescarColumnas") %>"></a>
<script type="text/javascript">

  $.ajax({
    type: "GET",
    cache: false,
    url: $('#dummy').attr('href'),
    success: (function (data) {
      $("#columnas").html(data);
      $("#fullscreen").css("display", "none");
    }),
    error: (function (data) {
      $("#fullscreen").css("display", "none");
      var titletag = /<title\b[^>]*>.*?<\/title>/
      alert(titletag.exec(data.responseText));
    })
  });



</script>