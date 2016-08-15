$(document).ready ->
  $('.lang').click (e) ->
    e.preventDefault()
    Cookies.set('preferredLanguage', $(this).attr('lang'), { expires: 365 })
    location.reload();
    return
  return
