/*
 * jQuery Hoverbox 1.0
 * http://koteako.com/hoverbox/
 *
 * Copyright (c) 2009 Eugeniy Kalinin
 * Dual licensed under the MIT and GPL licenses.
 * http://koteako.com/hoverbox/license/
 */
jQuery.fn.hoverbox = function(options) {
    var settings = jQuery.extend({
        id: 'tooltip',
        top: 0,
        left: 15
    }, options);

    var handle;

    function tooltip(event) {
        if ( ! handle) {
            // Create an empty div to hold the tooltip
            handle = $('<div style="position:absolute" onmouseover="retener()" onmouseout="esconderconretardo()" id="'+settings.id+'"></div>').appendTo(document.body).hide();
        }

        if (event) {
            // Make the tooltip follow a cursor
            handle.css({
                top: (event.pageY - settings.top) + "px",
                left: (event.pageX + settings.left) + "px"
            });
        }

        return handle;
    }

    var elem = $(this);
    var text;
    
    this.each(function() {
        $(this).hover(
            function(e) {
                if (this.title) {
                    // Remove default browser tooltips
                    this.t = this.title;
                    this.title = '';
                    this.alt = '';

                    tooltip(e).html(this.t).fadeIn('fast');
                }
            },
            function() {
                if (this.t) {
                    
                    elem = this
                    text = this.t
                    retardo()
                    //this.title = this.t;
                    //tooltip().hide();
                }
            }
        );
        
        $(this).mousemove(tooltip);
    });
    
    var timer_id = 0;    
    
    function retener() {
      alert('');
      clearTimeout(timer_id);
    }
    
    
    function retardo() {
      if (timer_id != 0) {
        clearTimeout(timer_id);
      }
      timer_id = setTimeout(escondertt, 1000);
    }       
    
    
    function escondertt() {
      elem.title = text ;
      tooltip().hide();
      return true;
    }    
    
};

