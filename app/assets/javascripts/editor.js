var ResumeEditor = (function() {
    return {
        init: function() {
          this.timetosave = 3; // seconds to wait before executing save operation
          this.mainForm = $('#ResumeEditorForm');
          this.tabSections = $("#TabSections");
          this.sections = $("#Sections");
          this.page = $("#PageWrap");

          this.initTabs();
          this.initSections();
          this.initRichEditors();
          this.initEvents();

          if ((last_tab = this.lastTab()) !== null) {
            this.openTab(last_tab);
          } else {
            this.openTab(0); // open the first tab by default
          }
        },

        /**
         * check last tab saved in url hash 
         */
        lastTab: function() {
          var order = parseInt(window.location.hash.substr(1));
          var section_count = this.tabSections.find('li').length;

          // order must be a number and in range (0; section_count)
          if (isNaN(order) || order < 0 || order >= section_count) {
            order = null;
          }

          return order;
        },

        /*
         * Drag-and-Drop behavior for tabs 
         */
        initTabs: function() {
          var editor_obj = this; 

          this.tabSections.sortable({
            items: "li:not(.ui-sort-disabled)",
            placeholder: {
              element: function(clone, ui) {
                return $('<li class="ui-state-highlight">'+clone[0].innerHTML+'</li>');
              },
              update: function() { return; },
            },
            update: function() {
              editor_obj.refreshSectionPosition.call(editor_obj);
              editor_obj.autoSave.call(editor_obj);
            }
          });

          this.tabSections.disableSelection();
        },

        /**
         * TODO: initialize Drag-and-Drop behavior for list items
         */
        initSections: function() {
          var editor_obj = this;

          $('.multilinelist').sortable({
            activate: function(event, ui) {
              // $(ui.item[0]).css('height', '10px');
              $(this).find('.collapse').collapse('hide');
            },
            stop: function(event, ui) {
              // $('textarea').wysihtml5();
            }
          });

          $('.simplelist').sortable({
            // cancel: '[contenteditable]', // reserved for contenteditable - later
            placeholder: {
              element: function(clone, ui) {
                var value = $(clone[0]).find('input[type=text]').val();
                return $('<div class="item ui-state-highlight">'+value+'</div>');
              },
              update: function() { return; },
            },
            update: function() {
              editor_obj.refreshItemPosition.call(editor_obj, $(this));
              editor_obj.autoSave.call(editor_obj);
            }
          });
        },

        initRichEditors: function() {
          this.attachRichEditor($('.textsection textarea'));
          this.attachRichEditor($('.multilinelist textarea'));
        },

        /**
         * @param jQuery-wrapped element
         */
        attachRichEditor: function(element) {
            var editor_obj = this; // save editor_obj for later reference

            var options = {
              toolbar: { 
                "font-styles": false, "image": false, "link": false
              },
              events : {
                'change': function() { editor_obj.autoSave.call(editor_obj); }
              }
            }

            element.wysihtml5(options);
        },

        initEvents: function() {
            var editor_obj = this; 

            // open tab events
            this.tabSections.on('click', '.sec-tab', function() {
              var tabnum = $(this).attr('data-order');
              editor_obj.openTab(tabnum);
            });

            // register auto-save events for all input (also for new created ones)
            this.page.on('change','input, select',  function() {
              editor_obj.autoSave.call(editor_obj);
            });

            // register form submit with asynchronous save operation
            this.mainForm.submit(function(e) {
              e.preventDefault();
              editor_obj.save.call(editor_obj);
            });

            // Choose template
            $("#ChooseTemplateButton").on('click', function() {
              editor_obj.mainForm.submit();
              $("#ChooseTemplateModal").modal('hide');
            });
            // End Choose template

            /****************************
             * section name edit toggle *
             ****************************/
                var name_edit_click_callback = function() {
                  var section_name = $(this).parent('.section_name').hide();
                  var edit_section = section_name.siblings('.section_name_edit').show();
                  edit_section.find('input[type=text]').focus();
                };

                var name_save_click_callback = function(e) {
                  var edit_form = $(this).parent('.section_name_edit').hide();
                  edit_form.siblings('.section_name').show();
                };

                this.page.on('click', '.name_edit', name_edit_click_callback);
                this.page.on('click', '.name_save', name_save_click_callback);

                // bind tab-name and section-name with the edit textbox
                this.sections.on('keyup', '.section_name_edit input[type=text]', function(e) {
                  if (e.keyCode === 13) { // Enter key, hide the textbox
                    $(this).siblings('.name_save').trigger('click');
                    return false;
                  }

                  var value = $(this).val(),
                      section_order = $(this).parents('.sec').attr('data-order'),
                      tab = $('.sec-tab[data-order='+section_order+'] a'),
                      section_name = $(this).parent().siblings('.section_name').find('label');

                  section_name.html(value);
                  tab.html(value);
                });

                $("#ResumeTitle").on('keyup', '.section_name_edit input[type=text]', function(e) {
                  if (e.keyCode == 13) { // Enter key, hide the textbox
                    $(this).siblings('.name_save').trigger('click');
                    return false;
                  }

                  var value = $(this).val(),
                  section_name = $(this).parent().siblings('.section_name').find('a');
                  section_name.html(value);
                });
            /*************************
             * end section name edit *
             *************************/

          /*****************************
           * Add and Delete Components *
           *****************************/
              // ajax add section 
              $('#AddSectionModal .add_section').on('click', function(e) {
                var url = $(this).attr('href');

                editor_obj.addSection.call(editor_obj, url);

                e.preventDefault();
              });

              // ajax add item
              this.sections.on('click', '.item_add', function(e) {
                var url = $(this).attr('href'),
                    list = $(this).parents('.sec').find('.list');

                editor_obj.addItem.call(editor_obj, url, list);

                e.preventDefault();
              });

              // ajax delete section
              this.sections.on('click', '.delete_section', function(e) {
                var url = $(this).attr('href');

                editor_obj.deleteSection.call(editor_obj, url);

                return false;
              });


              // ajax delete item
              this.sections.on('click', '.item_delete', function(e) {
                var url = $(this).attr('href'),
                    item = $(this).parents('.item');

                editor_obj.deleteItem.call(editor_obj, url, item);

                e.preventDefault();
              });
          /*********************************
           * END Add and Delete Components *
           *********************************/

              this.sections.on('change', '.ordered_list_toggle', function() {
                var list = $(this).parents('.sec').find('.list'); // find the corresponding list
                if (this.checked) {
                  list.removeClass('unordered').addClass('ordered');
                } else {
                  list.removeClass('ordered').addClass('unordered');
                }

              });

        },

        /**
         * trigger timeout [int] seconds before executing save
         */
        autoSave: function() {
          editor_obj = this;
          clearTimeout(this.autosave_timer);
          this.autosave_timer = setTimeout( function() {
            editor_obj.save.call(editor_obj); 
          }, this.timetosave*1000 );
        },

        /**
         * main save operation
         */
        save: function() {
          clearTimeout(this.autosave_timer); // clear autosave

          var editor_obj = this;
          $.ajax({
            type: 'post',
            url: this.mainForm.attr('action'),
            dataType: 'json',
            data: this.mainForm.serialize(),
            success: function(response) {
              editor_obj.flashMessage(response.msg, response.status);
            },
            error: function(response) {
              editor_obj.flashMessage("Cannot save", "error");
            }
          });
        },

        /**
         * @param string msg  | message to be flashed
         * @param string type | type of message ('success' or 'error')
         */
        flashMessage: function(msg, type) {
          var el        = $("#SystemMessage"),
              css_class = type === 'error' ? 'danger': 'success',
              msg_el    = $('<span class="alert alert-'+css_class+'">'+msg+'</span>');

          // blink!
          el.show(function() {
            el.html(msg_el);
            el.css('margin-left', -(msg_el.outerWidth() / 2)); 

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

          // save the tab order in url hash  
          window.location.hash = num;
          // make the tab active
          tab.addClass('active');
          section.show();
        },

        /**
         * reassign the correct order of tabs and sections
         */
        refreshSectionPosition: function() {
          var tabs = this.tabSections;

          // make and array of pairs [section, new_order]
          var sections = $.map(tabs.find('li'), function(tab, index) {
            var order = $(tab).attr('data-order'); // old tab order
            var section = $('.sec[data-order='+order+']'); // find the corresponding section
            return [[$(tab),section,index]];
          });

          // set new order for sections and tabs
          $.each(sections, function(i,data) {
            var tab = data[0];
            var sec = data[1];
            var new_order = data[2];
            
            tab.attr('data-order', new_order);
            sec.attr('data-order', new_order);
            sec.find('input.section_order').val(new_order);
          })

        },

        /**
         * reassign the correct order of list items
         * @param list | jQuery object
         */
        refreshItemPosition: function(list) {
          list.find('.item').each(function(index) {
            $(this).find('input.item_order').val(index+1);
          });
        },

        addSection: function(url) {
          var editor_obj = this; 
          var tabs = this.tabSections;

          $.ajax({
            type: "POST",
            url: url,
            dataType: 'json',
            success: function(response) {
              // add new section to DOM
              var sec = $('<div class="sec" data-order="'+response.section_order+'"></div>').html(response.html)
                        .appendTo(editor_obj.sections);

              sec.find('textarea').each(function() {
                editor_obj.attachRichEditor($(this));
              });

              // add a new tab to DOME
              $('<li class="sec-tab" data-order="'+response.section_order+'"><a>'+response.section_name+'</a></li>')
              .appendTo(editor_obj.tabSections);

              // refresh sortable items (tabs)
              editor_obj.tabSections.sortable("refresh");
              editor_obj.openTab(response.section_order);
            },
            error: function(response) {
              editor_obj.flashMessage("Cannot add new section", "error");
            }
          });
        },

        addItem: function(url, list) {

          $.ajax({
            type: "POST",
            url: url,
            dataType: 'json',
            success: function(response) {
              list.append(response.html);
              var new_item = list.children(':last-child');

              // attach rich editors
              new_item.find('textarea').each(function() {
                editor_obj.attachRichEditor($(this));
              });
            },
            error: function(response) {
              editor_obj.flashMessage("Cannot add new item", "error");
            }
          });

        },

        deleteItem: function (url, item) {
          var editor_obj = this;

          $.ajax({
            type: "POST",
            url: url,
            dataType: 'json',
            data: {"_method":"delete"},
            success: function(response) {
              item.remove();
              editor_obj.flashMessage(response.msg, "success");
            },
            error: function(response) {
              editor_obj.flashMessage("Cannot delete item","error");
            }
          });

        },

        deleteSection: function(url) {
          var editor_obj = this; 

          $.ajax({
            type: "POST",
            url: url,
            dataType: 'json',
            data: {"_method":"delete"},
            success: function(response) {
              var order = response.section_order;
              editor_obj.tabSections.find('.sec-tab[data-order='+order+']').remove();
              editor_obj.sections.find('.sec[data-order='+order+']').remove();

              editor_obj.refreshSectionPosition();
              editor_obj.openTab(order-1);
              editor_obj.flashMessage("Section deleted", "success");
              
            },
            error: function(response) {
              editor_obj.flashMessage("Cannot delete section", "error");
            }
          });
        }
    };
})();

(function($) {
    $(document).ready(function(){
        ResumeEditor.init();
    });
})(jQuery);
