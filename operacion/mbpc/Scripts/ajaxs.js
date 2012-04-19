	(function( $ ) {
		$.widget( "ui.combobox", {
			_create: function() {
				var self = this,
					select = this.element.hide(),
					selected = select.children( ":selected" ),
					value = selected.val() ? selected.text() : "";
				var input = this.input = $( "<input>" )
					.insertAfter( select )
					.val( value )
					.autocomplete({
						delay: 0,
						minLength: 0,
						source: function( request, response ) {
							var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
							response( select.children( "option" ).map(function() {
								var text = $( this ).text();
								if ( this.value && ( !request.term || matcher.test(text) ) )
									return {
										label: text.replace(
											new RegExp(
												"(?![^&;]+;)(?!<[^<>]*)(" +
												$.ui.autocomplete.escapeRegex(request.term) +
												")(?![^<>]*>)(?![^&;]+;)", "gi"
											), "<strong>$1</strong>" ),
										value: text,
										option: this
									};
							}) );
						},
						select: function( event, ui ) {
							ui.item.option.selected = true;
							self._trigger( "selected", event, {
								item: ui.item.option
							});
                            select.trigger( "autocompleteselect", [ui.item != null? ui.item.value : '-']);
                            //select.trigger("change");     
						},
						change: function( event, ui ) {
							if ( !ui.item ) {
								var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( $(this).val() ) + "$", "i" ),
									valid = false;
								select.children( "option" ).each(function() {
									if ( $( this ).text().match( matcher ) ) {
										this.selected = valid = true;
										return false;
									}
								});
								if ( !valid ) {
									// remove invalid value, as it didn't match anything
									$( this ).val( "" );
									select.val( "" );
									input.data( "autocomplete" ).term = "";
									return false;
								}
							}
						}
					})
					.addClass( "ui-widget ui-widget-content ui-corner-left" );

				input.data( "autocomplete" )._renderItem = function( ul, item ) {
					return $( "<li></li>" )
						.data( "item.autocomplete", item )
						.append( "<a>" + item.label + "</a>" )
						.appendTo( ul );
				};

				this.button = $( "<button type='button'>&nbsp;</button>" )
					.attr( "tabIndex", -1 )
					.attr( "title", "Show All Items" )
					.insertAfter( input )
					.button({
						icons: {
							primary: "ui-icon-triangle-1-s"
						},
						text: false
					})
					.removeClass( "ui-corner-all" )
					.addClass( "ui-corner-right ui-button-icon" )
					.click(function() {
						// close if already visible
						if ( input.autocomplete( "widget" ).is( ":visible" ) ) {
							input.autocomplete( "close" );
							return;
						}

						// work around a bug (likely same cause as #5265)
						$( this ).blur();

						// pass empty string as value to search for, displaying all results
						input.autocomplete( "search", "" );
						input.focus();
					});
			},

			destroy: function() {
				this.input.remove();
				this.button.remove();
				this.element.show();
				$.Widget.prototype.destroy.call( this );
			}
		});
	})( jQuery );

  function mostraretapaform() {
    if ($('#botonetapa').hasClass('megaestiloselectedb') && $('#editarEtapaForm').css('display') == 'block')
      return false;
    $('#botonetapa').addClass('megaestiloselectedb');
    $('#botonviaje').removeClass('megaestiloselectedb');
    $('#nuevoViaje').css('display','none');
    $('#editarEtapaForm').css('display','block');
  }

  function mostrarviajeform() {
    if ($('#botonviaje').hasClass('megaestiloselectedb') && $('#nuevoViaje').css('display') == 'block')
      return false;
    $('#botonviaje').addClass('megaestiloselectedb');
    $('#botonetapa').removeClass('megaestiloselectedb');
    $('#nuevoViaje').css('display','block');
    $('#editarEtapaForm').css('display','none');
  }

    function agregarevento(aelement) {

        $("#fullscreen").css("display", "block");

		      $.ajax({
		        type: "GET",
		        cache: false,
		        url: $(aelement).attr("href"),
		        success: (function (data) {
		          $('#dialogdiv').html(data);
              $('#dialogdiv').dialog({
                title: 'Cambiar Estado',
                height: 550,
                width: 300,
                modal: true
              });
              $("#fullscreen").css("display", "none");
		        }),
		        error: (function (data) {
		          $("#fullscreen").css("display", "none");
              var titletag = /<title\b[^>]*>.*?<\/title>/
              alert(titletag.exec(data.responseText));
		        })
		      });

          return false;
    }
    
    
    
    function agregarreporte(aelement) {

        $("#fullscreen").css("display", "block");

		      $.ajax({
		        type: "GET",
		        cache: false,
		        url: $(aelement).attr("href"),
		        success: (function (data) {
		          $('#dialogdiv').html(data);
              $('#dialogdiv').dialog({
                title: 'Agregar reporte',
                height: 430,
                width: 308,
                modal: true
              });
              $("#fullscreen").css("display", "none");
		        }),
		        error: (function (data) {
		          $("#fullscreen").css("display", "none");
              var titletag = /<title\b[^>]*>.*?<\/title>/
              alert(titletag.exec(data.responseText));
		        })
		      });

          return false;
      }


    function agregarposicion(aelement) {

        $("#fullscreen").css("display", "block");

		      $.ajax({
		        type: "GET",
		        cache: false,
		        url: $(aelement).attr("href"),
		        success: (function (data) {
		          $('#dialogdiv').html(data);
              $('#dialogdiv').dialog({
                title: 'Agregar posición a etapa',
                height: 400,
                width: 320,
                modal: true
              });
              $("#fullscreen").css("display", "none");
		        }),
		        error: (function (data) {
		          $("#fullscreen").css("display", "none");
              var titletag = /<title\b[^>]*>.*?<\/title>/
              alert(titletag.exec(data.responseText));
		        })
		      });

          return false;
      }



    function histrvp(aelement) {

        $("#fullscreen").css("display", "block");

		      $.ajax({
		        type: "GET",
		        cache: false,
		        url: $(aelement).attr("href"),
		        success: (function (data) {
		          $('#dialogdiv').html(data);
              $('#dialogdiv').dialog({
                title: 'Historia Rumbo / Velocidad / Posicion',
                height: 300,
                width: 780,
                modal: true
              });
              $("#fullscreen").css("display", "none");
		        }),
		        error: (function (data) {
		          $("#fullscreen").css("display", "none");
              var titletag = /<title\b[^>]*>.*?<\/title>/
              alert(titletag.exec(data.responseText));
		        })
		      });
		      
          return false;
      }


 function separarconvoy(aelement) {

       //if( !confirm("¿Esta seguro que desea separar el convoy?") )
		     // return false;
 
      $("#fullscreen").css("display", "block");

      $.ajax({
        type: "GET",
        cache: false,
        url: $(aelement).attr("href"),
        success: (function (data) {
              $("#fullscreen").css("display", "none");
		          $('#selector').html(data);
              $('#selector').dialog({
                title: "Transferencia de Barcazas",
                width: 524,
                height: 370,
                modal: true
              });
        }),
        error: (function (data) {
          $("#fullscreen").css("display", "none");
          var titletag = /<title\b[^>]*>.*?<\/title>/
          alert(titletag.exec(data.responseText));
        })
      });
      return false;
    }

 function elegiracompanante(aelement) {
 
      $("#fullscreen").css("display", "block");

      $.ajax({
        type: "GET",
        cache: false,
        url: $(aelement).attr("href"),
        success: (function (data) {
          $('#dialogdiv').html(data);
          $('#dialogdiv').dialog({
            height: 325,
            width: 337,
            modal: true,
            title: 'Editar Acompañantes'
          });
          $("#fullscreen").css("display", "none");
        }),
        error: (function (data) {
          $("#fullscreen").css("display", "none");
          var titletag = /<title\b[^>]*>.*?<\/title>/
          alert(titletag.exec(data.responseText));
        })
      });
      return false;
    }

 function preguntarfecha(aelement,vv) {
 
      $("#fullscreen").css("display", "block");

      $.ajax({
        type: "GET",
        cache: false,
        url: $(aelement).attr("href"),
        success: (function (data) {
          $('#dialogdiv').html(data);
          $('#dialogdiv').dialog({
            height: vv == 1 ? 150 : 250,
            width: 333,
            modal: true,
            title: 'Ingrese Fecha'
          });
          $("#fullscreen").css("display", "none");
        }),
        error: (function (data) {
          $("#fullscreen").css("display", "none");
          var titletag = /<title\b[^>]*>.*?<\/title>/
          alert(titletag.exec(data.responseText));
        })
      });
      return false;
    }



    function quitaracompanante(aelement) {

      if( !confirm("Esta seguro que desea quitar al acompañante este viaje?") )
		      return false;

      $("#fullscreen").css("display", "block");

      $.ajax({
        type: "GET",
        cache: false,
        url: $(aelement).attr("href"),
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
      return false;
    }

 function reactivar(aurl)
 {
        $("#fullscreen").css("display", "block");

        $.ajax({
          type: "GET",
          cache: false,
          url: aurl,
          success: (function (data) {
            if(data=="nop")
              $('#list').trigger( 'reloadGrid' );
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
        return false;
      }





 function viajesterminados(aelement) {
 
      $("#fullscreen").css("display", "block");

      $.ajax({
        type: "GET",
        cache: false,
        url: $(aelement).attr("href"),
        success: (function (data) {
          $('#dialogdiv').html(data);
          $('#dialogdiv').dialog({
            height: 300,
            width: 800,
            modal: true,
            title: 'Viajes Terminados'
          });
          $("#fullscreen").css("display", "none");
        }),
        error: (function (data) {
          $("#fullscreen").css("display", "none");
          var titletag = /<title\b[^>]*>.*?<\/title>/
          alert(titletag.exec(data.responseText));
        })
      });
      return false;
    }




    function reportediario(URL) {

      $("#fullscreen").css("display", "block");

      $.ajax({
        type: "GET",
        cache: false,
        url: URL,
        success: (function (data) {
          $('#dialogdiv').html(data);
          $('#dialogdiv').dialog({
            height: 526,
            width: 956,
            modal: true,
            title: 'Reporte Diario'
          });
          $("#fullscreen").css("display", "none");
        }),
        error: (function (data) {
          $("#fullscreen").css("display", "none");
          var titletag = /<title\b[^>]*>.*?<\/title>/
          alert(titletag.exec(data.responseText));
        })
      });
      return false;
    
    }

    
    function practico(aelement) {

      $("#fullscreen").css("display", "block");

      $.ajax({
        type: "GET",
        cache: false,
        url: $(aelement).attr("href"),
        success: (function (data) {
          $('#dialogdiv').html(data);
          $('#dialogdiv').dialog({
            height: 250,
            width: 529,
            modal: true,
            title: 'Listado de Practicos/Baqueanos',
          });
          $("#fullscreen").css("display", "none");
        }),
        error: (function (data) {
          $("#fullscreen").css("display", "none");
          var titletag = /<title\b[^>]*>.*?<\/title>/
          alert(titletag.exec(data.responseText));
        })
      });
      return false;
    
    }

    function pbip (aelement, title) {
      return pbip2($(aelement).attr("href"), title);
    }
    
    function pbip2(href, title) {
      $("#fullscreen").css("display", "block");

      $.ajax({
        type: "GET",
        cache: false,
        url: href,
        success: (function (data) {
          $('#dialogdiv').html(data);
          $('#dialogdiv').dialog({
            height: 600,
            width: 705,
            modal: true,
            title: title/*'Formulario PBIP'*/,
          });
          $("#fullscreen").css("display", "none");
        }),
        error: (function (data) {
          $("#fullscreen").css("display", "none");
          var titletag = /<title\b[^>]*>.*?<\/title>/
          alert(titletag.exec(data.responseText));
        })
      });
      return false;
    
    }


    function editarnotas(aelement) {

      $("#fullscreen").css("display", "block");

      $.ajax({
        type: "GET",
        cache: false,
        url: $(aelement).attr("href"),
        success: (function (data) {
          $('#dialogdiv').html(data);
          $('#dialogdiv').dialog({
            height: 430,
            width: 478,
            modal: true,
            title: 'Editar Notas',
          });
          $("#fullscreen").css("display", "none");
        }),
        error: (function (data) {
          $("#fullscreen").css("display", "none");
          var titletag = /<title\b[^>]*>.*?<\/title>/
          alert(titletag.exec(data.responseText));
        })
      });
      return false;
    
    }



    $(document).ready( function(){
      buildButtons();
    });

    function buildButtons()
    {
      $(".rerun")
        .button()
        .click(function() {
          //var xx = $(this).parent().parent();
        })
        .next()
        .button({
          text: false,
          icons: {
            primary: "ui-icon-triangle-1-s"
            /*secondary: "ui-icon-triangle-1-n"*/
          }
        })
        .parent()
        .buttonset();
    }

    function toggle_menu(el, ship)
    {
        var pos = $(el).offset();

//      pos.left -= 100;
//      pos.top  += 20;
        $('#Item'+ship).css('top',pos.top+20);
//      
//      .toggle();

      $('#Item'+ship).toggle(200,
        function() {
        if($('#Item'+ship).is(":visible"))
        {  
          showMask(ship);
          $('#select_'+ship).button("option", "icons",{primary: "ui-icon-triangle-1-n"});
          
        }
        else 
        {
          $('#select_'+ship).button("option", "icons",{primary: "ui-icon-triangle-1-s"});
          hideMask();
        }
        });

    }

    function fx(elem)
    {
      var par = $(elem).parent().parent().parent();
      //par.hide(200);
      //$(par).siblings().children($(':first')).children($(':first')).text($(elem).text()); // ();
    }
  
     //parametro, url, llena div especifico
     function traer_instport(puerto, url) {

      $.ajax({
        type: "POST",
        cache: false,
        url: url,
        data: 'puerto=' + puerto,
        success: (function (data) {
          $('#instport').html(data);
        }),
        error: (function (data) {
          var titletag = /<title\b[^>]*>.*?<\/title>/
          alert(titletag.exec(data.responseText));
        })
      });

      return false;

      }

    // url, cierra dialogdiv3
    function crearBuque(url)
    {

      $.ajax({
        type: "POST",
        cache: false,
        url: url,
        success: (function (data) {
          $('#dialogdiv3').dialog('close');
        }),
        error: (function (data) {
          var titletag = /<title\b[^>]*>.*?<\/title>/
          alert(titletag.exec(data.responseText));
        })
      });

      return false;
    }

    var g_campo_destino;

    // url, llena dialogdiv3
    function nuevoBuque(url, defa)
    {
      if( defa==null )
        defa = '3';

      g_campo_destino = 1;

      $.ajax({
        type: "GET",
        cache: false,
        url: url,
        success: (function (data) {
          $('#dialogdiv' + defa).html(data);
          $('#dialogdiv' + defa).dialog({
            height: 405,
            width: 240,
            modal: true,
            title: defa == 3 ? 'Nuevo Buque' : 'Nueva Barcaza',
          });
        }),
        error: (function (data) {
          var titletag = /<title\b[^>]*>.*?<\/title>/
          alert(titletag.exec(data.responseText));
        })
      });

      return false;
    }

    //url, llena dialogdiv3
    function nuevoMuelle(url, campo_destino)
    {
      g_campo_destino = campo_destino;
      $.ajax({
        type: "GET",
        cache: false,
        url: url,
        success: (function (data) {
          $('#dialogdiv3').html(data);
          $('#dialogdiv3').dialog({
            title: 'Nuevo Muelle',
            height: 200,
            width: 300,
            modal: true
          });
        }),
        error: (function (data) {
          var titletag = /<title\b[^>]*>.*?<\/title>/
          alert(titletag.exec(data.responseText));
        })
      });

      return false;
    }
    
    

    //$(document).ready(function () {
    //});
    //Funcion que se llama cuando se hace click en algun TR para seleccionarlo
    //TODO: ver la forma de pasar el registro o alguna convencion en el orden de las columnas
    function pegar_y_cerrar(nombre, id, internacional) 
    {
      if (typeof internacional == "undefined") {
        internacional = 0;
      }

      var element;
      switch (g_campo_destino) {
        case 1:
          $('#buque_id').val(id);
          $('#internacional').val(internacional);
          element = $('#buquetext').val(nombre);
          break;
        case 2:
          $('#desde_id').val(id);
          element = $('#desdetext').val(nombre);
          break;
        case 3:
          $('#hasta_id').val(id);
          element = $('#hastatext').val(nombre);
          break;
      }

      $(element).nextAll('.nexttab:eq(0)').focus();
    }

    function pegar(obj, nombre, id) 
    {
      //Borro los selected y pongo el TR clickeado como selected
      $(obj).parent().find("tr").removeClass("selected");
      $(obj).addClass("selected");

      //$('#ok').html('&nbsp;&nbsp;Ok');
      $('#acompanante').val(nombre);
      $('#buque_id').val(id);
    }


    //Abre el segundo pop up para todos los botones "..." lo llama nuevoviaje.aspx
    //La url es seleccion/{vista} esta configurada en el onclick de cada boton
    function mostrarSelector(url, campo_destino) {

      //Campo donde se vuelca el dato seleccionado
      g_campo_destino = campo_destino;

      $.ajax({
        type: "GET",
        cache: false,
        url: url,
        success: (function (data) {
          $('#selector').html(data);
          $('#selector').dialog({
            height: 300, //puede venir como param
            width: 500,  //puede venir como param
            modal: true,
            title: 'Seleccionar ' + (campo_destino != 1 ? 'Muelle' : 'Buque')
          });
        }),
        error: (function (data) {
          var titletag = /<title\b[^>]*>.*?<\/title>/
          alert(titletag.exec(data.responseText));
        })
      });

      return false;
    }


    //Retardo de 300ms
    var timer_id = 0;
    var url_param = '';
    var divlatabla;

    function autocomplete_pre(url, divelement) {
      if (timer_id != 0) {
        clearTimeout(timer_id);
      }
      url_param = url;

      divlatabla = divelement;
      timer_id = setTimeout(autocomplete, 300);
    }
    
    function autocomplete() {
      
      latabla = divlatabla;
      url = url_param;


      $.ajax({
        type: "POST",
        cache: false,
        url: url,
        success: (function (data) {
          $(latabla).html(data);
          if( $(latabla).find('#noresults').length > 0 )
          {
            $('#ok').html('No hay resultados');
          }
          return true;
        }),
        error: (function (data) {
          $(latabla).html('<strong><p style="border: 3px solid;background-color:Gray" >Se ha producido un error<p></strong>');
        })
      });
       
      $(latabla).append( $('#loaderimg').clone() );

      return false;
    }

     
    //element como parametro, llena diaglogdiv
    //Primer popup desde nuevo viaje
    function nuevoviaje(aelement) {

      $("#fullscreen").css("display", "block");

      $.ajax({
        type: "GET",
        cache: false,
        url: $(aelement).attr("href"),
        success: (function (data) {
          $('#dialogdiv').html(data);
          $('#dialogdiv').dialog({
            height: 650 ,
            width: 350,
            modal: true,
            title: 'Nuevo Viaje',
          });
          $("#fullscreen").css("display", "none");
        }),
        error: (function (data) {
          $("#fullscreen").css("display", "none");
          var titletag = /<title\b[^>]*>.*?<\/title>/
          alert(titletag.exec(data.responseText));
        })
      });
      return false;
    }

    
    //element como parametro, llena diaglogdiv
    function editarviaje(aelement) {

      $("#fullscreen").css("display", "block");

      $.ajax({
        type: "GET",
        cache: false,
        url: $(aelement).attr("href"),
        success: (function (data) {
          $('#dialogdiv').html(data);
          $("#fullscreen").css("display", "none");
          $('#dialogdiv').dialog({
            height: 520,
            width: 335,
            modal: true,
            title: 'Editar Viaje'
          });

        }),
        error: (function (data) {
          $("#fullscreen").css("display", "none");
          var titletag = /<title\b[^>]*>.*?<\/title>/
          alert(titletag.exec(data.responseText));
        })
      });

      return false;
    }
    
    //element, url  como parametro, llena diaglogdiv
    function editaretapa(aelement) {

      $("#fullscreen").css("display", "block");

      $.ajax({
        type: "GET",
        cache: false,
        //url: url,
        url: $(aelement).attr("href"),
        success: (function (data) {
          $('#dialogdiv').html(data);
          $("#fullscreen").css("display", "none");
          $('#dialogdiv').dialog({
            height: 415,
            width: 690,
            modal: true,
            title: 'Editar Etapa/Viaje'
          });
          $("#caladoproa").focus();


        }),
        error: (function (data) {
          $("#fullscreen").css("display", "none");
          var titletag = /<title\b[^>]*>.*?<\/title>/
          alert(titletag.exec(data.responseText));
        })
      });

      return false;
    }

    //element como parametro, llena diaglogdiv
    function editarcargas(aelement) {

      $("#fullscreen").css("display", "block");

      $.ajax({
        type: "GET",
        cache: false,
        url: $(aelement).attr("href"),
        success: (function (data) {
          $('#dialogdiv').html(data);
          $("#fullscreen").css("display", "none");
          $('#dialogdiv').dialog({
            height: 400,
            width: 580,
            modal: true,
            title: 'Editar Cargas'
          });

        }),
        error: (function (data) {
          $("#fullscreen").css("display", "none");
          var titletag = /<title\b[^>]*>.*?<\/title>/
          alert(titletag.exec(data.responseText));
        })
      });

      return false;
    }

    //element como parametro, llena diaglogdiv
    function dialogozonas(aelement, title) {
      dialogozonas(aelement, title, false);
    }

    function dialogozonas(aelement, title, setcombo) {

      $("#fullscreen").css("display", "block");

      $.ajax({
        type: "GET",
        cache: false,
        url: $(aelement).attr("href"),
        success: (function (data) {
          $('#dialogdiv').html(data);
          $('#dialogdiv').dialog({
            /*height: setcombo ? 300 : 160,*/
            height: setcombo ? 375 : 160,
            width: 333,
            title: title,
            modal: true
          });
          $("#fullscreen").css("display", "none");

          //Selecciono el proximo destino si ya estaba puesto
          if( setcombo )
            $('#listadezonas').val( $(aelement).attr('nextdest') );

        }),
        error: (function (data) {
          $("#fullscreen").css("display", "none");
          var titletag = /<title\b[^>]*>.*?<\/title>/
          alert(titletag.exec(data.responseText));
        })
      });

      return false;
    }

    //element como parametro, llena diaglogdiv
    function detallestecnicos(aelement) {

        $("#fullscreen").css("display", "block");

		      $.ajax({
		        type: "GET",
		        cache: false,
		        url: $(aelement).attr("href"),
		        success: (function (data) {
		          $('#dialogdiv').html(data);
              $('#dialogdiv').dialog({
                title: 'Detalles Tecnicos',
                height: 240,
                modal: true,
              });
              $("#fullscreen").css("display", "none");
		        }),
		        error: (function (data) {
		          $("#fullscreen").css("display", "none");
              var titletag = /<title\b[^>]*>.*?<\/title>/
              alert(titletag.exec(data.responseText));
		        })
		      });
		      
          return false;
      }

    //element como parametro, llena diaglogdiv
    function transferirbarcazas(aelement) {

        $("#fullscreen").css("display", "block");
		      $.ajax({
		        type: "GET",
		        cache: false,
		        url: $(aelement).attr("href"),
		        success: (function (data) {
		          $('#dialogdiv').html(data);
              $('#dialogdiv').dialog({
                title: "Seleccionar barco destino",
                height: 155,
                width: 305,
                modal: true
              });
              $("#fullscreen").css("display", "none");
		        }),
		        error: (function (data) {
		          $("#fullscreen").css("display", "none");
              var titletag = /<title\b[^>]*>.*?<\/title>/
              alert(titletag.exec(data.responseText));
		        })
		      });
		      
          return false;
      }

    //element como parametro, llena diaglogdiv
    function editarBarcazas(url) {

		      $.ajax({
		        type: "GET",
		        cache: false,
		        url: url,
		        success: (function (data) {
		          $('#selector').html(data);
              $('#selector').dialog({
                title: "Transferencia de Barcazas",
                width: 524,
                height: 370,
                modal: true
              });
		        }),
		        error: (function (data) {
              var titletag = /<title\b[^>]*>.*?<\/title>/
              alert(titletag.exec(data.responseText));
		        })
		      });
		      
          return false;
      }

      
    //element como parametro, llena columnas, tiene confirm
    function terminarviaje(aelement) {

      if( !confirm("Esta seguro que desea terminar este viaje?") )
		      return false;

      $("#fullscreen").css("display", "block");

      $.ajax({
        type: "GET",
        cache: false,
        url: $(aelement).attr("href"),
        success: (function (data) {
          if(data=="nop")
            $('#list').trigger( 'reloadGrid' );
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
      return false;
    }
      
      //url como parametro, llena columnas
      function pasarbarco(aurl) {

        $("#fullscreen").css("display", "block");

        $.ajax({
          type: "POST",
          cache: false,
          url: aurl,
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

        $('#dialogdiv').dialog('close');
        return false;
      }

    //element como parametro, llena columnas
    function cambiarZona(aelement) {
      $("#fullscreen").css("display", "block");
        $.ajax({
          type: "GET",
          cache: false,
          url: $(aelement).attr("href"),
          success: (function (data) {
            $("#columnas").html(data);
            $("#fullscreen").css("display", "none");
          }),
          error: function (data, textStatus, errorThrown) {
            $("#fullscreen").css("display", "none");
            var titletag = /<title\b[^>]*>.*?<\/title>/
            alert('cambiarZona:'+titletag.exec(data.responseText));
          }
        });
        return false;
      }


function validatedate(inputelement) {
    thedate = dateFromStr($(inputelement).val());
}

function dateFromStr(datestring)
{
    var dia = parseInt(datestring.substring(0, 2).replace(/^[0]+/g,""));
    var mes = parseInt(datestring.substring(3, 5).replace(/^[0]+/g,""));
    var ano = parseInt('20' + datestring.substring(6, 8));
    var hora   = parseInt(datestring.substring(9, 11).replace(/^[0]+/g,""));
    var minuto = parseInt(datestring.substring(12,14).replace(/^[0]+/g,""));

    hora = !isNaN(hora)?hora:0;
    minuto = !isNaN(minuto )?minuto :0;
    
//    console.log( "#1 VarByVar -> dia:" + dia + "mes:" + mes + "ano:" + ano + "hora:" + hora + "minuto:" + minuto );

    var fecha = new Date(ano, mes - 1, dia, hora, minuto);
//    console.log("#2 recv: ["+datestring+"] -- generado: ["+fecha+"}");

    var temp = { fecha: fecha, ano:ano, mes:mes, dia:dia, hora:hora, minuto:minuto };
    return temp;
    
}

function isDate(datestring) /* is NOT date*/
{
    return isNaN( dateFromStr(datestring).fecha.getTime() );
}


function validpos(pos) {

    console.log( pos.substring(0, 2) + "." + pos.substring(2, 4));
    console.log(pos.substring(5, 8) + "." + pos.substring(8, 10));
    lat = parseFloat(pos.substring(0, 2) + "." +pos.substring(2, 4));
    lon = parseFloat(pos.substring(5, 8) + "." +pos.substring(8, 10));

    if (lat > 90 || lon > 180) {
        console.log('no ok');
        return false;
    }
    else {
    console.log('ok');
    return true;
    }
}
      
    //});
