passport = require('passport')
LocalStrategy = require('passport-local').Strategy

passport.serializeUser (user, next) ->
  return next null, user.id

passport.deserializeUser (id, next) ->
  User.findOne { id: id }, (err, user) ->
    return next err, user

passport.use new LocalStrategy {
  usernameField: 'email'
}, (email, password, next) ->
  User.findOne { email: email }, (err, user) ->
    return next err if err
    return next null, false, { message: 'Email error / Ошибка с email' } if !user

    user.comparePassword password, (err, res) ->
      return next null, false, { message: 'Password error / Ошибка с паролем' } if err
      return next null, false, { message: 'Password error / Ошибка с паролем' } if !res

      output = {
        email: user.email,
        createdAt: user.createdAt,
        id: user.id
      }

      return next null, output, { message: 'Logged in' }
    return
  return
