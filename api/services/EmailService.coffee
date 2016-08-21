mandrill = require('mandrill-api/mandrill')
client = new (mandrill.Mandrill)(process.env.MANDRILL_API_KEY)
console.log 'Mandrill API Loaded'

module.exports =
  welcome: (user, next) ->
    template = 'shiny-account-activation'
    message =
      to: [ {
        email: user.email
        type: 'to'
      } ]
    EmailService.sendTemplate template, null, message, (err) ->
      console.log 'Got a Mandrill response.'
      return next err
    return

  sendTemplate: (name, content, message, next) ->
    ip_pool = 'Main Pool'

    try
      client.messages.sendTemplate
        'template_name': name
        'template_content': content
        'message': message
        'async': false
        'ip_pool': ip_pool
      , (res) ->
        return next(null, res)
      , (err) ->
        if err
          throw err
      return
    catch error
      console.error error
      return next()
    return
