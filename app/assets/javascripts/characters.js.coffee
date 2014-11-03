# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  teams = new Bloodhound(
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace("shorthand")
    queryTokenizer: Bloodhound.tokenizers.whitespace
    prefetch: '/teams/'
  )
  # initialize the bloodhound suggestion engine
  teams.initialize()
  $ ->
    $("span").tooltip content: ->
      $(this).attr "title"
