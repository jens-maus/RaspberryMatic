/*
* File: jquery.simplePopup.js
* Version: 1.0.0
* Description: Create a simple popup to display content
* Author: 9bit Studios
* Copyright 2012, 9bit Studios
* http://www.9bitstudios.com
* Free to use and abuse under the MIT license.
* http://www.opensource.org/licenses/mit-license.php
*/

(function ($) {

    $.fn.simplePopup = function (options) {

	var defaults = $.extend({
            centerPopup: true,
            open: function() {},
            closed: function() {}
	}, options);
        
	/******************************
	Private Variables
	*******************************/         
        
	var object = $(this);
	var settings = $.extend(defaults, options);
        
	/******************************
	Public Methods
	*******************************/         
        
	var methods = {

	    init: function() {
		return this.each(function () {
		    methods.appendHTML();
		    methods.setEventHandlers();
		    methods.showPopup();
		});
	    },

	    /******************************
	    Append HTML
	    *******************************/			

	    appendHTML: function() {

		// if this has already been added we don't need to add it again
		if ($('.simplePopupBackground').length === 0) {
		    var background = '<div class="simplePopupBackground"></div>';
		    $('body').prepend(background);
		}

		if(object.find('.simplePopupClose').length === 0) {
		    var close = '<div class="simplePopupClose">X</div>';
		    object.prepend(close);
		}
	    },

	    /******************************
	    Set Event Handlers
	    *******************************/			

	    setEventHandlers: function() {

		$(".simplePopupClose, .simplePopupBackground").on("click", function (event) {
		    methods.hidePopup();
		});

		$(window).on("resize", function(event){
                    
                    if(settings.centerPopup) {
                        methods.positionPopup();
                    }
		});				

	    },

            removeEventListners: function() {
		$(".simplePopupClose, .simplePopupBackground").off("click");                
            },

	    showPopup: function() {
		$(".simplePopupBackground").css({
		    "opacity": "0.7"
		});
		
                $(".simplePopupBackground").fadeIn("fast");
                
		object.fadeIn("slow", function(){
                    settings.open();
                });
                
                if(settings.centerPopup) {
                    methods.positionPopup();
                }
	    },

	    hidePopup: function() {
		$(".simplePopupBackground").fadeOut("fast");
		object.fadeOut("fast", function(){
                    methods.removeEventListners();
                    settings.closed();
                });
	    },			

	    positionPopup: function() {
		var windowWidth = $(window).width();
		var windowHeight = $(window).height();
		var popupWidth = object.width();				
		var popupHeight = object.height();

		var topPos = (windowHeight / 2) - (popupHeight / 2);
		var leftPos = (windowWidth / 2) - (popupWidth / 2);
		if(topPos < 30) topPos = 30;
		
		object.css({
		    "position": "absolute",
		    "top": topPos,
		    "left": leftPos
		});
	    },			

	};
        
	if (methods[options]) { // $("#element").pluginName('methodName', 'arg1', 'arg2');
	    return methods[options].apply(this, Array.prototype.slice.call(arguments, 1));
	} else if (typeof options === 'object' || !options) { 	// $("#element").pluginName({ option: 1, option:2 });
	    return methods.init.apply(this);  
	} else {
	    $.error( 'Method "' +  method + '" does not exist in simple popup plugin!');
	} 
    };

})(jQuery);