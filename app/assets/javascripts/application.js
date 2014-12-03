// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

ResumeEditor = (function() {
    return {
        /**
         * initialize object
         *
         */
        init: function() {
            // hide all the edit sections
            $('.sec').hide();

            this.initEvents();
        },

        initEvents: function() {
            $('.sec-tab').on('click', function() {
                var tab = $(this);
                var order = tab.attr('data-order');
                $('.sec-tab').removeClass('active');
                tab.addClass('active');
                $('.sec').hide();
                $('.sec[data-order='+order+']').show();
            });
        },
    }
})();

(function($) {
    $(document).ready(function(){
        ResumeEditor.init();
    });
})(jQuery);
