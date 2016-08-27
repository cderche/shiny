$(document).ready ->
  $('a, button').hover (e) ->
    e.stopPropagation()
    return

  $('.modal-trigger').leanModal()

  return
