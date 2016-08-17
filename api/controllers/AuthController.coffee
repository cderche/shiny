 # AuthController
 #
 # @description :: Server-side logic for managing auths
 # @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers

passport = require('passport')

module.exports = {

  _config: {
    actions: false,
    shortcuts: false,
    rest: false
  }

  login: (req, res) ->
    console.log 'login'
    passport.authenticate('local', (err, user, info) ->
      if err || !user
        return res.send({ message: info.message, user: user })
      req.login user, (err) ->
        # console.log 'req.login', err
        if err
          return res.send({ message: err, user: user })
        if user.redirect
          return res.send({ message: info.message, user: user })
        return res.send({ message: info.message, user: user })
    ) req, res

  logout: (req, res) ->
    req.logout()
    req.session.destroy()
    res.redirect('/')

}
