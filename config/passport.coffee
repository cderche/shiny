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
    if err
      return next err
    if !user
      return next null, false, { message: 'Unknown Email' }

    user.comparePassword password, (err, res) ->
      if !res
        return next null, false, { message: 'Invalid Password' }
      output = {
        email: user.email,
        createdAt: user.createdAt,
        id: user.id
      }
      return next null, output, { message: 'Logged in' }
    return
  return
