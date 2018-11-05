# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $ ->
    $('#users_search').change ->
      $.get $('#users_search').attr('action'), $('#users_search').serialize(), null, 'script'
      false
    return
  return