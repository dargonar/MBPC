

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

    $(this).bind('keydown', 'ctrl+m', function () {
        $('.selectedbox .editaretapalink').click();
        return false;
    });

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
        return false;
    });



});
          
          
