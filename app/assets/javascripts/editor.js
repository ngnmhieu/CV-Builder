ResumeEditor = (function() {
    return {

        init: function() {
            this.initRichEditors();
            this.initEvents();
            this.openTab(1); // open the first tab by default
        },

        initRichEditors: function() {
            $('.textsection textarea').wysihtml5();
            $('.multilinelist textarea').wysihtml5();
            $('.simplelist textarea').wysihtml5();
        },

        initEvents: function() {
            $('.sec-tab').on('click', function() {
                var tabnum = $(this).attr('data-order');
                ResumeEditor.openTab(tabnum);
            });
        },

        /**
         * @param int | tab number
         */
        openTab: function(num) {
          var section = $('.sec[data-order='+num+']');
          var tab     = $('.sec-tab[data-order='+num+']');
          $('.sec-tab').removeClass('active');
          $('.sec').hide();

          tab.addClass('active');
          section.show();
        }

    }
})();

(function($) {
    $(document).ready(function(){
        ResumeEditor.init();
    });
})(jQuery);
