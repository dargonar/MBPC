<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<input autocomplete="off" class="autocompletetext" type="text" style="width: 375px;margin-bottom: 9px" />


<div class="latabla">
  <%Html.RenderPartial("_buques");%>
</div>

<input type="button" value="Agregar Nuevo Buque" onclick="nuevoBuque('<%= Url.Content("~/Item/nuevoBuque") %>');"  />

<a id="autocompletelink" href="<%= Url.Content("~/Autocomplete/view_buques/" +  ViewContext.RouteData.Values["Action"]) + "/" %>"></a>

<script type="text/javascript">

    $('.autocompletetext').bind('keydown', 'down', function () {
        movercursor('abajo');
    });

    $('.autocompletetext').bind('keydown', 'up', function () {
        movercursor('arriba');
    });

    $('.autocompletetext').bind('keydown', 'tab', function () {
        movercursor('abajo');
        return false;
    });

    $('.autocompletetext').bind('keydown', 'return', function () {
        $('.selected').click();
        return false;
    });


    $('.autocompletetext').keyup(function (event) {

        if (event.which == 38 ||
            event.which == 40 ||
            event.which == 9 ||
            event.which == 13) {
            return false;
        }


        return autocomplete_pre($('#autocompletelink').attr('href') + $(this).val(), $(this).next());
        //onkeyup="return autocomplete_pre('<%= Url.Content("~/Autocomplete/view_buques") %>/' + this.value + '/<%= ViewContext.RouteData.Values["Action"] %>', $(this).next());"
    });



</script>