 # OrderController
 #
 # @description :: Server-side logic for managing orders
 # @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers

module.exports =

  create: (req, res) ->
    if typeof req.body.cart is 'string'
      cart = JSON.parse req.body.cart
    else
      cart = req.body.cart

    if !req.user
      return res.redirect 'clean'

    cart.user = req.user.id

    try
      Order.create cart, (err, order) ->
        throw err if err
        # If cardId is false, redirect to payture
        if order.cardId == false or order.cardId == 'false'
          uri = process.env.HOST || (process.env.HEROKU_APP_NAME + '.herokuapp.com')
          uri += '/status?ref=' + order.id

          data =
            OrderId: order.id
            SessionType: 'Add'
            VWUserLgn: req.user.email
            VWUserPsw: req.user.payture_token
            Url: uri

          WalletService.init data, (err, data) ->
            throw err if err
            sessionId = data.Init.SessionId
            uri = process.env.PAYTURE_HOST + '/vwapi/Add?SessionId=' + sessionId
            return res.redirect uri
        # Else confirm order
        else
          req.options.locals = req.options.locals or {}
          req.options.locals.order = order
          return res.status(201).view('status')
        return
      return
    catch err
      console.error err
      return res.redirect 'clean'

  status: (req, res) ->
    try
      Order.findOne { id: req.query.ref }, (err, order) ->
        req.options.locals = req.options.locals or {}
        req.options.locals.order = order
        return res.status(201).view('status')
      return
    catch err
      console.error err
      return res.redirect 'dashboard'
