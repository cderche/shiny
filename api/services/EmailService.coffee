mandrill = require('mandrill-api/mandrill')
client = new (mandrill.Mandrill)(process.env.MANDRILL_API_KEY)

module.exports =
  welcome: (user, next) ->
    console.log 'EmailService.welcome', user

    template = 'shiny-account-activation'
    message =
      to: [ {
        email: user.email
        type: 'to'
      } ]
    EmailService.sendTemplate template, null, message, (err) ->
      return next err
    return

  sendTemplate: (name, content, message, next) ->
    ip_pool = 'Main Pool'
    client.messages.sendTemplate {
      'template_name': name
      'template_content': content
      'message': message
      'async': false
      'ip_pool': ip_pool
    }, ((res) ->
      console.log 'sendTemplate', res
      return next()
    ), (err) ->
      return next err
    return
