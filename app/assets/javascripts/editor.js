ResumeEditor = (function() {
    return {

        init: function() {
            this.initRichEditors();
            this.initEvents();
            this.openTab(1); // open the first tab by default
        },

        initRichEditors: function() {
            $('.textsection textarea').wysihtml5({
                toolbar: {
                    "font-styles": false, //Font styling, e.g. h1, h2, etc. Default true
                    "emphasis": true, //Italics, bold, etc. Default true
                    "lists": true, //(Un)ordered lists, e.g. Bullets, Numbers. Default true
                    "html": false, //Button which allows you to edit the generated HTML. Default false
                    "link": true, //Button to insert a link. Default true
                    "image": false, //Button to insert an image. Default true,
                    "color": false, //Button to change color of font  
                    "blockquote": false, //Blockquote  
                    "Indent": false
                }
            });

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
