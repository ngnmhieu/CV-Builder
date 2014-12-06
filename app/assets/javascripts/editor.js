ResumeEditor = (function() {
    return {
        init: function() {
          this.timetosave = 3; // seconds to wait before executing save operation
          this.mainForm = $('#ResumeEditorForm');

          this.initRichEditors();
          this.initEvents();
          this.openTab(1); // open the first tab by default
        },

        initRichEditors: function() {
            var editor_obj = this; // save editor_obj for later reference
            var options = {
              toolbar: { "font-styles": false, "image": false },
              events : {
                'change': function() { editor_obj.autoSave.call(editor_obj); }
              }
            }

            $('.textsection textarea').wysihtml5(options);
            $('.multilinelist textarea').wysihtml5(options);
            $('.simplelist textarea').wysihtml5(options);
        },

        initEvents: function() {
            var editor_obj = this; 
            $('.sec-tab').on('click', function() {
                var tabnum = $(this).attr('data-order');
                editor_obj.openTab(tabnum);
            });

            // register auto-save events for all text input
            $('input[type=text]').on('change', function() {
              editor_obj.autoSave.call(editor_obj);
            });


            // register form submit with asynchronous save operation
            this.mainForm.submit(function(e) {
              e.preventDefault();
              editor_obj.save.call(editor_obj);
            });
        },

        /**
         * trigger timeout [int] seconds before executing save
         */
        autoSave: function() {
          editor_obj = this;
          clearTimeout(this.timer);
          this.timer = setTimeout( function() {
            editor_obj.save.call(editor_obj); 
          }, this.timetosave*1000 );
        },

        /**
         * main save operation
         */
        save: function() {
          editor_obj = this;
          var form = this.mainForm;

          $.ajax({
            type: 'post',
            url: form.attr('action'),
            dataType: 'json',
            data: form.serialize(),
            success: function(response) {
              editor_obj.flashMessage(response.msg, response.status);
            },

            error: function() {
            }
          });
        },

        /**
         * @param string msg  | message to be flashed
         * @param string type | type of message ('success' or 'error')
         */
        flashMessage: function(msg, type) {
          var el        = $("#SystemMessage"),
              css_class = type == 'error' ? 'danger': 'success',
              msg_el    = $('<span class="alert alert-'+css_class+'">'+msg+'</span>');

          // replace content and adjust width of the container according to message
          el.html(msg_el).width(msg_el.outerWidth()); 

          // blink!
          el.show(function() {
            setTimeout(function() {
              el.fadeOut();
            }, 1000);
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
