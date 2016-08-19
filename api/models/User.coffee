 # User.coffee
 #
 # @description :: TODO: You might write a short summary of how this model works and what it represents here.
 # @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models

bcrypt    = require('bcrypt-nodejs')
randtoken = require('rand-token')
async     = require('async')

module.exports =

  attributes: {
    email:          { type: 'email', required: true, unique: true }
    password:       { type: 'string', minLength: 6, required: true }
    payture_token:  { type: 'string', required: true }

    toJSON: ->
      obj = this.toObject()
      delete obj.password
      delete obj.payture_token
      return obj

    comparePassword: (pwd, next) ->
      bcrypt.compare pwd, this.password, next
      return

  },

  beforeValidate: (user, next) ->
    user.payture_token = randtoken.generate(32)
    next()

  beforeCreate: (user, next) ->
    bcrypt.genSalt null, (err, salt) ->
      bcrypt.hash user.password, salt, null, (err, hash) ->
        if err
          return next(err)
        user.password = hash
        next()
      return
    return

  afterCreate: (user, next) ->
    try
      async.parallel [
        (done) ->
          WalletService.register
            VWUserLgn: user.email
            VWUserPsw: user.payture_token
          , (err, data) ->
            if err
              throw err
            console.log 'Registered', data.Register.Success
            return done()
          return
        (done) ->
          EmailService.welcome user, (err) ->
            if err
              throw err
            console.log 'Sent welcome email.'
            return done()
          return
      ], (err) ->
        if err
          throw err
        console.log 'completed tasks'
        return next()
    catch error
      console.error error
      return next()
