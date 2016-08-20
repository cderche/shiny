$(document).ready ->
  $('#signupForm').submit (e) ->
    e.preventDefault()

    data = {}
    $.each $(this).serializeArray(), ->
      data[this.name] = this.value
      return
    auth '/user', data, ->
      auth '/login', data, ->
        $(location).attr 'href', '/clean'
        return
      return
    return

  $('#signinForm').submit (e) ->
    e.preventDefault()
    data = {}
    $.each $(this).serializeArray(), ->
      data[this.name] = this.value
      return
    auth '/login', data, ->
      $(location).attr 'href', '/clean'
      return
    return

  auth = (url, data, next) ->
    $.post url, data
      .done (data) ->
        return next()
      .fail (err) ->
        console.error 'err', err
        return
    return

  $('#signupForm #password, #password_confirmation, #agreeTerms').change ->
    agreeTerms = true
    validPassword = true
    lengthPassword = true

    if $('#agreeTerms')
      agreeTerms = $('#agreeTerms').prop('checked')
    if $('#password_confirmation')
      validPassword = $('#password').val() == $('#password_confirmation').val()
      lengthPassword = ($('#password').val().length >= 8)

    if agreeTerms && validPassword && lengthPassword
      $('.btn').removeClass('disabled')
    else
      $('.btn').addClass('disabled')
    return

  return
