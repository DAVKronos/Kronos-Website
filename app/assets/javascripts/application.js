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
//= require jquery-ui-timepicker-addon
//= require bootstrap
//= require tmpl
//= require load-image
//= require canvas-to-blob
//= require bootstrap
//= require bootstrap-image-gallery
//= require jquery.iframe-transport
//= require jquery.fileupload
//= require jquery.fileupload-ip
//= require jquery.fileupload-ui
//= require_tree .
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

$("form").live("nested:fieldAdded", function(event) {
$(event.field).find('.tijdprikker').removeClass('hasDatepicker').timepicker({});
});

});
