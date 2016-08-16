 # User.coffee
 #
 # @description :: TODO: You might write a short summary of how this model works and what it represents here.
 # @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models

bcrypt = require('bcrypt-nodejs');

module.exports =

  attributes: {
    email:    { type: 'email', required: true, unique: true }
    password: { type: 'string', minLength: 6, required: true }

    toJSON: ->
      obj = this.toObject()
      delete obj.password
      return obj

    comparePassword: (pwd, next) ->
      bcrypt.compare pwd, this.password, next
      return

  },

  beforeCreate: (user, next) ->
  	bcrypt.genSalt null, (err, salt) ->
  		bcrypt.hash user.password, salt, null, (err, hash) ->
  			if err
          return next err
        user.password = hash
        return next()

  afterCreate: (user, next) ->
    EmailService.welcome(user, next)
    return
