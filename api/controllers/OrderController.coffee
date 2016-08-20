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
    # delete cart.$$hashKey
    try
      Order.create(cart).exec (err, order) ->
        throw err if err
        # If card_id, confirm order
        if order.card_id
          req.options.locals = req.options.locals or {}
          req.options.locals.order = order
          return res.status(201).view('status')
        # Else redirect to payture
        data =
          SessionType: 'Add'
          VWUserLgn: req.user.email
          VWUserPsw: req.user.payture_token
          Url: process.env.HOST + '/status?ref=' + order.id

        WalletService.init data, (err, data) ->
          throw err if err
          sessionId = data.Init.SessionId
          uri = process.env.PAYTURE_HOST + '/vwapi/Add?SessionId=' + sessionId
          return res.redirect uri
      return
    catch err
      console.error err
      return res.redirect 'clean'

  status: (req, res) ->
    try
      Order.findOne { id: req.query.ref }, (err, order) ->
        req.options.locals = req.options.locals or {}
        req.options.locals.order = order
        return res.render('status')
      return
    catch err
      console.error err
      return res.redirect 'dashboard'
