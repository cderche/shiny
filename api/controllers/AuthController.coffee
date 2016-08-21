 # AuthController
 #
 # @description :: Server-side logic for managing auths
 # @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers

passport = require('passport')

module.exports = {

  # _config: {
  #   actions: false,
  #   shortcuts: false,
  #   rest: false
  # }

  login: (req, res) ->
    passport.authenticate('local', (err, user, info) ->
      return res.send({ message: info.message, user: user }) if err or !user
      req.login user, (err) ->
        res.send({ message: err, user: user })
      return
      # return res.redirect(401,'/') if err or !user
      # req.login user, (err) ->
      #   return res.redirect(401,'/') if err
      #   return res.view 'clean'
      # return
    ) req, res
    return
    # successRedirect: '/'
    # failureRedirect: '/signin'
    # # console.log 'login', req.body
    # passport.authenticate('local', (err, user, info) ->
    #   if err || !user
    #     return res.send({ message: info.message, user: user })
    #   req.login user, (err) ->
    #     # console.log 'req.login', err
    #     if err
    #       return res.send({ message: err, user: user })
    #     if user.redirect
    #       return res.send({ message: info.message, user: user })
    #     return res.send({ message: info.message, user: user })
    # ) req, res

  logout: (req, res) ->
    req.logout()
    # req.session.destroy()
    res.redirect('/')

}
