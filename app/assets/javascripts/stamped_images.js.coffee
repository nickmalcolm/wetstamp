# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

  if $stampPreviewEl = $(".js-stamp-preview")
    $.ajax
      url: $stampPreviewEl.data().url,
      success: (data, status, jqXHR) ->
        html = HandlebarsTemplates['stamped_images/stamped_images'](data);
        $stampPreviewEl.html(html)
        