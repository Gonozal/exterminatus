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
//= require bootstrap-sprockets
//= require bootstrap-editable
//= require bootstrap-editable-rails
//= require twitter/typeahead
//= require_tree .
$(document).ready(function() {
$('.editable').editable({
  mode: 'inline',
  showbuttons: false,
  format: 'yyyy-mm-dd',
  viewformat: 'dd/mm/yyyy',

  success: function(data, config) {
    if(data && data.id) {  //record created, response like {"id": 2}
      var container;
      if(data.css){
        if($(this).prop('tagName') != "TD") {
            container = $(this).closest("td");
        } else {
            container = $(this);
        }
        container.removeClass('available unavailable tentative not-signed');
        container.addClass(data.css);
      }
    } else if(data && data.errors){
      config.error.call(this, data.errors);
    }
  },
  error: function(errors) {
    var msg = '';
    if(errors && errors.responseText) { //ajax error, errors = xhr object
        msg = errors.responseText;
    } else { //validation error (client-side or server-side)
        $.each(errors, function(k, v) { msg += k+": "+v+"<br>"; });
    }
    $('#msg').removeClass('alert-success').addClass('alert-error').html(msg).show();
  }
});


$('.note-editable').editable({
  mode: 'popup',
  showbuttons: true,
  emptytext: "No note",
  success: function(data, config) {
    if(data && data.id) {  //record created, response like {"id": 2}
      console.log("step 1");
    } else if(data && data.errors){
      config.error.call(this, data.errors);
    }
  },
  error: function(errors) {
    var msg = '';
    if(errors && errors.responseText) { //ajax error, errors = xhr object
        msg = errors.responseText;
    } else { //validation error (client-side or server-side)
        $.each(errors, function(k, v) { msg += k+": "+v+"<br>"; });
    }
    $('#msg').removeClass('alert-success').addClass('alert-error').html(msg).show();
  }
});
});
