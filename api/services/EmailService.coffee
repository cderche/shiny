mandrill = require('mandrill-api/mandrill')
client = new (mandrill.Mandrill)(process.env.MANDRILL_API_KEY)
async = require('async')
moment = require('moment')

console.log 'Mandrill API Loaded'

module.exports =
  welcome: (user, next) ->
    template = 'shiny-account-activation'
    message =
      to: [
        { email: user.email, type: 'to' }
        { email: 'orders@getshiny.ru', type: 'to' }
      ]
      global_merge_vars: [
        {
          name: 'URL'
          content: (process.env.HOST || (process.env.HEROKU_APP_NAME + '.herokuapp.com')) + '/clean'
        }
      ]
    EmailService.sendTemplate template, null, message, (err) ->
      # console.log 'Got a Mandrill response.'
      return next err
    return

  confirmation: (order, next) ->
    # console.log 'EmailService.confirmation'
    template = 'shiny-order-confirmation'

    User.findOne { id: order.user }, (err, user) ->
      throw err if err
      # console.log "user.email", user.email
      # console.log "order.address.email", order.address.email
      if order.address.email == user.email
        to = [
          { email: user.email, type: 'to' }
          { email: 'orders@getshiny.ru', type: 'to' }
        ]
      else
        to = [
          { email: user.email, type: 'to' }
          { email: order.address.email, type: 'to' }
          { email: 'orders@getshiny.ru', type: 'to' }
        ]
      items = {}

      # console.log 'order', order
      # mDate = moment(order.schedule.date)
      # strDate = mDate.format('ddd, MMM Do YYYY')
      # console.log 'moment', mDate
      # console.log 'strDate', strDate

      async.each ['BED','BAT','IRO','WIN'], (sku, done) ->
        order.getItem sku, (item) ->
          items[sku] = item
          return done()
        return
      , (err) ->
        throw err if err
        message =
          to: to
          global_merge_vars: [
            {
              name: 'BEDROOMS'
              content: items['BED'].quantity if items['BED']
            }
            {
              name: 'BATHROOMS'
              content: items['BAT'].quantity if items['BAT']
            }
            {
              name: 'IRON'
              content: items['IRO'].quantity if items['IRO']
            }
            {
              name: 'WINDOWS'
              content: items['WIN'].quantity if items['WIN']
            }
            {
              name: 'DATE'
              content: moment(order.schedule.date).format('ddd, MMM Do YYYY')
            }
            {
              name: 'TIME'
              content: moment(order.schedule.time).format('HH:mm')
            }
            {
              name: 'RULE'
              content: order.schedule.rule.name
            }
            {
              name: 'PRICE'
              content: order.total_price
            }
            {
              name: 'FULL_NAME'
              content: order.address.first_name + ' ' + order.address.last_name
            }
            {
              name: 'EMAIL'
              content: order.address.email
            }
            {
              name: 'TELEPHONE'
              content: order.address.telephone
            }
            {
              name: 'HOUSE'
              content: order.address.house || null
            }
            {
              name: 'HOUSING'
              content: order.address.housing || null
            }
            {
              name: 'BUILDING'
              content: order.address.building || null
            }
            {
              name: 'APARTMENT'
              content: order.address.apartment || null
            }
            {
              name: 'STREET'
              content: order.address.street || null
            }
            {
              name: 'NOTES'
              content: order.address.note
            }
          ]

        EmailService.sendTemplate template, null, message, (err, res) ->
          # console.log 'Got a Mandrill response.'
          return next err, res
        return
      return
    return

  sendTemplate: (name, content, message, next) ->
    # console.log 'EmailService.sendTemplate'
    ip_pool = 'Main Pool'
    try
      client.messages.sendTemplate
        'template_name': name
        'template_content': content
        'message': message
        'async': false
        'ip_pool': ip_pool
      , (res) ->
        # console.log 'Email', res.status
        return next(null, res)
      , (err) ->
        if err
          throw err
    catch error
      console.error error
      return next(error)
    return
