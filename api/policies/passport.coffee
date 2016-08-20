# http = require('http')
# methods = [
#   'login'
#   'logIn'
#   'logout'
#   'logOut'
#   'isAuthenticated'
#   'isUnauthenticated'
# ]

passport = require('passport')

module.exports = (req, res, next) ->
  return next()
  # console.log 'Policy: passport'
  # passport.initialize() req, res, ->
  #   passport.session() req, res, ->
  #     return next()
  #   return
  # return
  # console.log 'passport'
  # passport = require('passport')
  # # Initialize Passport
  # passport.initialize() req, res, ->
  #   # Use the built-in sessions
  #   passport.session() req, res, ->
  #     # Make the request's passport methods available for socket
  #     if req.isSocket
  #       _.each methods, (method) ->
  #         req[method] = http.IncomingMessage.prototype[method].bind(req)
  #         return
  #     # Make the user available throughout the frontend (for views)
  #     # console.log 'passport req.user', req.user
  #     res.locals.user = req.user
  #     # console.log 'passport res.locals.user', res.locals.user
  #     return next()
  #   return
  # return
