<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<input autocomplete="off" type="text" class="autocompletetext" />
<div class="latabla">
<% Html.RenderPartial("_muelles"); %>
</div>
<input type="button" value="Agregar Muelle" onclick="nuevoMuelle('<%=Url.Content("~/Item/nuevoMuelle") %>');" />

<a id="autocompletelink" href="<%= Url.Content("~/Autocomplete/view_muelles/" +  ViewContext.RouteData.Values["Action"]) + "/" %>"></a>
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
        //onKeyUp="return autocomplete_pre('<%= Url.Content("~/Autocomplete/view_muelles")%>/' + this.value, $(this).next());"
    });