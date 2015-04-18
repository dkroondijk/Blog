# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.btn').on "click", ->
    $(@).addClass('btn-primary')

  $('.complete').on "change", ->
    if @.checked
      $(@).parent().addClass("strikeit")
    else
      $(@).parent().removeClass("strikeit")
