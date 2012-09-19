# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
bindFormEvents = () =>
  $(".resultform").bind 'ajax:success', (evt, data, status, xhr) ->
    $form = $(this)
    $form.parent(".event").html(xhr.responseText)
    bindFormEvents()
		  
  .bind "ajax:error", (evt, xhr, status, error) ->
    alert(xhr.responseText)
    
  $(".new_event").bind 'ajax:success', (evt, data, status, xhr) ->
    $(".events").append($('<div>').attr('class', "row").html($('<div>').attr('class', "span12 event").html(xhr.responseText)))
    bindFormEvents()
      

$(document).ready ->
  bindFormEvents()

  

