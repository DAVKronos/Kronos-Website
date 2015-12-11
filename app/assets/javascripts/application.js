// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery-ui
//= require jquery_ujs
//= require jquery_nested_form
//= require jquery-ui-timepicker-addon
//= require tmpl
//= require load-image
//= require canvas-to-blob
//= require bootstrap-image-gallery
//= require jquery.iframe-transport
//= require jquery.fileupload
//= require jquery.fileupload-ip
//= require jquery.fileupload-ui
//= require jquery.tablesorter
//= require jquery.markitup
//= require rails.validations
//= require jwplayer
//= require selectize
//= require twitter/typeahead.min
//= require moment
//= require bootstrap-datetimepicker
//= require cookies_eu
//= require_tree .

KRNS = {
    fbshare: function(loc) {
      window.open(
        'https://www.facebook.com/sharer/sharer.php?u='+encodeURIComponent(loc), 
        'facebook-share-dialog', 
        'width=626,height=436'); 
    }
};

$(document).ready(function () {
  $(".fb-share").click(function(){KRNS.fbshare(location.href);});
  $(".markItUp").markItUp(myMarkdownSettings);
  $(".alert-message").alert();
  $(".alert").alert();
  setTimeout("$('.alert').fadeOut('slow');", 3000);
  $('.carousel').carousel();
  $('.dropdown-menu').find('form').click(function (e){e.stopPropagation();});
  $('.datumtijdprikker').datetimepicker({format: 'YYYY-MM-DD HH:mm'}); 
  $('.maandprikker').datetimepicker({format: 'MM'}); 
  $('.jaarprikker').datetimepicker({format: 'YYYY'}); 
  $('.datumprikker').datepicker({format: 'YY-MM-DD'});
  $('.tijdprikker').timepicker({format: 'HH:mm'});
  $('.monthpicker .collapser').hide();
  $('.monthpicker .collapser[data-date='+$('.monthpicker').data("selected")+']').show();
  $('.monthpicker .head').click(function (e){$('.monthpicker .collapser').filter(':visible').hide("slide", function(){$($(e.target).data("toggle")).show("slide");});});
  $("form").live("nested:fieldAdded", function(event){$(event.field).find('.tijdprikker').removeClass('hasDatepicker').timepicker({});});
});

$(function(){
  $("#hide-banner").click(function(){
    $.post('/hidebanner');
    $('#banner').collapse();
  })
});

