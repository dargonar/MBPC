

$(document).ready(function () {

    $(this).bind('keydown', 'ctrl+v', function () {
        $('#nuevo_viaje').click();
        return false;
    });

    $(this).bind('keydown', 'alt+e', function () {
        $('.selectedbox .agregareventolink').click();
        return false;
    });

    $(this).bind('keydown', 'ctrl+l', function () {
        $('.selectedbox .pasarbarcolink').click();
        return false;
    });

    /*
    $(this).bind('keydown', 'ctrl+m', function () {
        $('.selectedbox .editaretapalink').click();
        return false;
    });
    */

    $(this).bind('keydown', 'ctrl+i', function () {
        $('.selectedbox .editarviajelink').click();
        return false;
    });

    $(this).bind('keydown', 'ctrl+d', function () {
        $('.agregarreportelink').click();
        return false;
    });



    $(this).bind('keydown', 'alt+1', function () {
        $('#tabs li:eq(0) a').click();
    });

    $(this).bind('keydown', 'alt+2', function () {
        $('#tabs li:eq(1) a').click();
    });

    $(this).bind('keydown', 'alt+3', function () {
        $('#tabs li:eq(2) a').click();
    });

    $(this).bind('keydown', 'alt+4', function () {
        $('#tabs li:eq(3) a').click();
    });

    $(this).bind('keydown', 'alt+5', function () {
        $('#tabs li:eq(4) a').click();
    });

    $(this).bind('keydown', 'alt+6', function () {
        $('#tabs li:eq(5) a').click();
    });

    $(this).bind('keydown', 'alt+7', function () {
        $('#tabs li:eq(6) a').click();
    });

    $(this).bind('keydown', 'alt+8', function () {
        $('#tabs li:eq(7) a').click();
    });

    $(this).bind('keydown', 'alt+9', function () {
        $('#tabs li:eq(8) a').click();
    });

    $(this).bind('keydown', 'alt+9', function () {
        $('#tabs li:eq(8) a').click();
    });

    $(this).bind('keydown', 'alt+0', function () {
        $('#tabs li:eq(9) a').click();
    });


    $(this).bind('keydown', 'ctrl+s', function () {
        $('#sbox').show();
        $('#searchbox').val('');
        $('#searchbox').focus();

        $('#sbox2').hide();
        return false;
    });

    $(this).bind('keydown', 'ctrl+m', function () {
        $('#sbox2').show();
        $('#searchbox2').val('');
        $('#searchbox2').focus();

        $('#sbox').hide();
        return false;
    });

    $('#searchbox2').bind('keydown', 'esc', function () {
        $('#sbox2').hide();
    });

    $("#searchbox2").autocomplete({
        source: function (request, response) {
            $.ajax({
                type: "POST",
                url: '/Autocomplete/autocomplete_viajes_grp',
                dataType: "json",
                data: { query: request.term },
                success: function (data) {
                    response($.map(data, function (item) {
                        return {
                            value: item.DESCRIPCION,
                            label: item.DESCRIPCION,
                            id: item.ID,
                            viaje: item.VIAJE
                        }
                    }));
                }
            });
        },
        minLength: 2,
        select: function (event, ui) {
            $('#sbox2').hide();
            cambiarZona('/Home/cambiarZona?id=' + ui.item.id + '&auto_select=' + ui.item.viaje);
            return false;
        }
    });



});
          
          
