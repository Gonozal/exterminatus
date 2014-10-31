# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  selectFields = $("#status-select").children("select")
  $(".signup.rest-in-place").bind "success.rest-in-place", (event, data) ->
    $(this).removeClass().addClass(data.css)
