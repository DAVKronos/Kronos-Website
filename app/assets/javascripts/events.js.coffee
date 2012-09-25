# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
bindFormEvents = () =>
  $(".new_result").bind 'ajax:success', (evt, data, status, xhr) ->
    $form = $(this)
    $form.siblings(".results").html(xhr.responseText)
		  
  .bind "ajax:error", (evt, xhr, status, error) ->
    alert(xhr.responseText)
    
  $(".new_result").live 'ajax:beforeSend', (evt, xhr, status) ->
    $form = $(this)
    $form.find('#result_username').val('')
    $form.find('#result_result').val('')
    
    
  $(".new_event").bind 'ajax:success', (evt, data, status, xhr) ->
    $(".events").append($('<div>').attr('class', "row").html($('<div>').attr('class', "span12 event").html(xhr.responseText)))
    bindFormEvents()
      

$(document).ready ->
  bindFormEvents()

  

