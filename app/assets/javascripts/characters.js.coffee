# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $(".rest-in-place").bind "ready.rest-in-place", (event, data) ->
    $(this).find("input").addClass("form-control small")

  roles = new Bloodhound(
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace("role")
    queryTokenizer: Bloodhound.tokenizers.whitespace
    local: [
      {role: "DPS"}
      {role: "Healer"}
      {role: "Tank"}
    ]
  )
  classes = new Bloodhound(
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace("klass")
    queryTokenizer: Bloodhound.tokenizers.whitespace
    local: [
      {klass: "Engineer"}
      {klass: "Warrior"}
      {klass: "Stalker"}
      {klass: "Medic"}
      {klass: "Spellslinger"}
      {klass: "Esper"}
    ]
  )
  teams = new Bloodhound(
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace("shorthand")
    queryTokenizer: Bloodhound.tokenizers.whitespace
    prefetch: '/teams/'
  )
  # initialize the bloodhound suggestion engine
  classes.initialize()
  roles.initialize()
  teams.initialize()

  # instantiate the typeahead UI
  $("#character_klass").typeahead
    hint: true
    highlight: true
  ,
    displayKey: "klass"
    source: classes.ttAdapter()

  $("#character_role").typeahead
    hint: true
    highlight: true
  ,
    displayKey: "role"
    source: roles.ttAdapter()
