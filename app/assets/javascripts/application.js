// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery_nested_form
//= require_tree .
//= require bootstrap
<<<<<<< HEAD
$(document).ready(function () {
$(".alert-message").alert()
$(".alert").alert()
setTimeout("$('.flash').fadeOut('slow');", 3000);
$('.carousel').carousel()
$('.dropdown-menu').find('form').click(function (e) {
	e.stopPropagation();
})
$('.datumtijdprikker').datetimepicker({ dateFormat: 'yy-mm-dd' });
$('.datumprikker').datepicker({ dateFormat: 'yy-mm-dd' });
$('.tijdprikker').timepicker({});
});
=======

$(document).ready(function() {
  // Handler for .ready() called.
  $(".alert-message").alert();
  $(".alert").alert();
  setTimeout("$('.flash').fadeOut('slow');", 3000);
  $('.carousel').carousel();

  $('.datumtijdprikker').datetimepicker({ dateFormat: 'yy-mm-dd' });
  $('.datumprikker').datepicker({ dateFormat: 'yy-mm-dd' });
  $('.tijdprikker').timepicker({});
});
>>>>>>> 33cbbb9756f87bdb7f7285f03a436cf77a2dfb1f
