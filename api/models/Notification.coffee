 # Notification.coffee
 #
 # @description :: TODO: You might write a short summary of how this model works and what it represents here.
 # @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models

CustomerAddSuccess    = 'CustomerAddSuccess'
CustomerPaySuccess    = 'CustomerPaySuccess'
CustomerRefundSuccess = 'CustomerRefundSuccess'

module.exports =

  attributes: {}

  afterCreate: (data, next) ->
    # Update order to contain cardId
    switch data.Notification
      when CustomerAddSuccess
        NotificationService.CustomerAddSuccess data, (err, res) ->
          return next()
      when CustomerPaySuccess
        NotificationService.CustomerPaySuccess data, (err, res) ->
          return next()
      when CustomerRefundSuccess
        NotificationService.CustomerRefundSuccess data, (err, res) ->
          return next()
    return
