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
//= require bootstrap.min
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
//= require_tree .

$(document).ready(function () {

$( ".fb-share" ).click(function() {
  window.open(
    'https://www.facebook.com/sharer/sharer.php?u='+encodeURIComponent(location.href), 
    'facebook-share-dialog', 
    'width=626,height=436'); 
});

$(".markItUp").markItUp(myMarkdownSettings);
$(".alert-message").alert()
$(".alert").alert()
setTimeout("$('.alert').fadeOut('slow');", 3000);
$('.carousel').carousel()
$('.dropdown-menu').find('form').click(function (e) {
	e.stopPropagation();
})
$('.datumtijdprikker').datetimepicker({dateFormat: 'yy-mm-dd'});
$('.datumprikker').datepicker({dateFormat: 'yy-mm-dd'});
$('.tijdprikker').timepicker({});

$('.resulttable').tablesorter();
$('.ajaxuitslag').click(function () {
      // laad de uitslagen van deze wedstrijd in het uitslagenveld
      var identiteit = $(this).attr("ajaxid");
      $('#ajaxuitslagengebied').load('agendaitems/'+identiteit+'/results', function(data){
		$('html,body').animate({scrollTop: $('#ajaxuitslagengebied').offset().top, scrollLeft: $('#ajaxuitslagengebied').offset().left},'slow');
	  });
    });
$('a[ajaxtab="tab"]').on('click', function (e) {
    console.log("test");
  var pattern=/#.+/gi //use regex to get anchor(==selector)           
  var contentID = e.target.toString().match(pattern)[0]; //get anchor
  //load content for selected tab
  contentID = contentID.replace("#", '');
  $('#' + contentID).load('uitslagen?ajaxladen=' + contentID, function() {
    $('.resulttable').tablesorter();
    $('.ajaxuitslag').click(function () {
      // laad de uitslagen van deze wedstrijd in het uitslagenveld
      var identiteit = $(this).attr("ajaxid");
      $('#ajaxuitslagengebied').load('agendaitems/'+identiteit+'/results', function(data){
		$('html,body').animate({scrollTop: $('#ajaxuitslagengebied').offset().top, scrollLeft: $('#ajaxuitslagengebied').offset().left},'slow');
	  });
    });
  });
});

$('.monthpicker .collapser').hide();
$('.monthpicker .collapser[data-date='+$('.monthpicker').data("selected")+']').show();
$('.monthpicker .head').click(function (e) {
    $('.monthpicker .collapser').filter(':visible').hide("slide", function(){
		$($(e.target).data("toggle")).show("slide");
	});
});

$("form").live("nested:fieldAdded", function(event) {
$(event.field).find('.tijdprikker').removeClass('hasDatepicker').timepicker({});
});

$('#toggle-fullscreen').button().click(function () {
var button = $(this),
root = document.documentElement;
if (!button.hasClass('active')) {
$('#modal-gallery').addClass('modal-fullscreen');
if (root.webkitRequestFullScreen) {
root.webkitRequestFullScreen(
window.Element.ALLOW_KEYBOARD_INPUT
);
} else if (root.mozRequestFullScreen) {
root.mozRequestFullScreen();
}
} else {
$('#modal-gallery').removeClass('modal-fullscreen');
(document.webkitCancelFullScreen ||
document.mozCancelFullScreen ||
$.noop).apply(document);
}
}); 

});


KRNS = {

    fbshare: function(loc) {

      window.open(
        'https://www.facebook.com/sharer/sharer.php?u='+encodeURIComponent(loc), 
        'facebook-share-dialog', 
        'width=626,height=436'); 

    }
}
 

